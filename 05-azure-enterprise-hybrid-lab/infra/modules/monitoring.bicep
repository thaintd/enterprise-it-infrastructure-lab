// Module: monitoring.bicep
// Nguồn: export thật từ rg-hub-prod-jap + rg-spoke-prod-jap qua aztfexport

@description('Region deploy chính, theo lab gốc')
param location string = 'japaneast'

@description('Region riêng của Action Group -- lab thật đang là centralindia, khác các resource khác. Giữ đúng thực tế, đổi lại nếu muốn đồng nhất về japaneast.')
param actionGroupLocation string = 'centralindia'

@description('Email nhận cảnh báo IT-OnCall')
param onCallEmail string = 'thaintdse172872@fpt.edu.vn'

@description('Resource ID của VM cần theo dõi CPU (vm-spoke-prod) -- để rỗng nếu VM chưa deploy trong lần chạy này')
param vmProdResourceId string = ''

@description('Resource Group cần theo dõi sự kiện Deallocate VM. Lab thật đang trỏ vào rg-spoke-dev-jap -- XÁC NHẬN LẠI có đúng ý định hay cần đổi sang rg-spoke-prod-jap.')
param activityLogAlertScopeResourceGroupId string

@description('Ngày trong tuần chạy patch tự động. Lab thật export ra "1Week Monday", doc gốc ghi Sunday -- XÁC NHẬN LẠI giá trị đúng trước khi deploy.')
param maintenanceRecurEvery string = '1Week Monday'

@description('Thời điểm bắt đầu cửa sổ bảo trì đầu tiên -- PHẢI là ngày trong tương lai tại thời điểm deploy, không dùng lại nguyên giá trị export cũ.')
param maintenanceStartDateTime string

@description('Resource Group chứa Maintenance Configuration và Recovery Services Vault (lab thật là rg-spoke-prod-jap, khác RG chứa Log Analytics/Action Group)')
param spokeProdResourceGroupName string = 'rg-spoke-prod-jap'

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'log-thaintd-prod'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 31
  }
}

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: 'ag-it-oncall'
  location: actionGroupLocation
  properties: {
    groupShortName: 'IT-OnCall'
    enabled: true
    emailReceivers: [
      {
        name: 'IT-OnCall_-EmailAction-'
        emailAddress: onCallEmail
        useCommonAlertSchema: true
      }
    ]
  }
}

resource metricAlertHighCpu 'Microsoft.Insights/metricAlerts@2018-03-01' = if (!empty(vmProdResourceId)) {
  name: 'alert-vmapp01-highcpu'
  location: 'global'
  properties: {
    description: 'alert-vmapp01-highcpu'
    severity: 2
    enabled: true
    scopes: [
      vmProdResourceId
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'HighCPU'
          metricName: 'Percentage CPU'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
  }
}

resource activityLogAlertDeallocate 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'alert-vm-unexpected-deallocate'
  location: 'global'
  properties: {
    enabled: true
    scopes: [
      activityLogAlertScopeResourceGroupId
    ]
    condition: {
      allOf: [
        {
          field: 'category'
          equals: 'Administrative'
        }
        {
          field: 'operationName'
          equals: 'Microsoft.Compute/virtualMachines/deallocate/action'
        }
      ]
    }
    actions: {
      actionGroups: [
        {
          actionGroupId: actionGroup.id
        }
      ]
    }
  }
}

resource recoveryVault 'Microsoft.RecoveryServices/vaults@2023-06-01' = {
  name: 'vault-mu8hvdzm'
  location: location
  scope: resourceGroup(spokeProdResourceGroupName)
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource maintenanceConfig 'Microsoft.Maintenance/maintenanceConfigurations@2023-04-01' = {
  name: 'mc-patch-weekly-sun2am'
  location: location
  scope: resourceGroup(spokeProdResourceGroupName)
  properties: {
    maintenanceScope: 'InGuestPatch'
    installPatches: {
      rebootSetting: 'IfRequired'
      windowsParameters: {
        classificationsToInclude: [
          'Critical'
          'Security'
        ]
      }
      linuxParameters: {
        classificationsToInclude: [
          'Critical'
          'Security'
        ]
      }
    }
    maintenanceWindow: {
      startDateTime: maintenanceStartDateTime
      duration: '03:55'
      timeZone: 'SE Asia Standard Time'
      recurEvery: maintenanceRecurEvery
    }
  }
}

output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
output actionGroupId string = actionGroup.id
