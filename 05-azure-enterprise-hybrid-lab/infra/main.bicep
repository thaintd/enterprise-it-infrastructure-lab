// main.bicep
// Orchestrator - deploy ở scope Subscription vì resource Monitoring/Backup
// nằm ở RG khác (rg-spoke-prod-jap) so với Network (rg-hub-prod-jap)

targetScope = 'subscription'

@description('Region deploy chính')
param location string = 'japaneast'

@description('Tên resource group chứa hạ tầng network hub')
param hubResourceGroupName string = 'rg-hub-prod-jap'

@description('Tên resource group chứa VM/backup/patch của spoke-prod')
param spokeProdResourceGroupName string = 'rg-spoke-prod-jap'

@description('Email nhận cảnh báo IT-OnCall')
param onCallEmail string

@description('Resource ID VNet spoke-dev để peering -- để rỗng nếu chưa deploy spoke trong lần chạy này')
param spokeDevVnetId string = ''

@description('Resource ID VNet spoke-prod để peering -- để rỗng nếu chưa deploy spoke trong lần chạy này')
param spokeProdVnetId string = ''

@description('Resource ID của VM cần theo dõi CPU cao -- để rỗng nếu VM chưa deploy trong lần chạy này')
param vmProdResourceId string = ''

@description('Ngày trong tuần chạy patch -- XÁC NHẬN Monday hay Sunday trước khi deploy thật')
param maintenanceRecurEvery string = '1Week Monday'

@description('Ngày giờ bắt đầu cửa sổ bảo trì đầu tiên, PHẢI là tương lai. Ví dụ: 2026-10-05 02:00')
param maintenanceStartDateTime string

@description('Resource Group cần theo dõi sự kiện Deallocate VM -- XÁC NHẬN spoke-dev hay spoke-prod trước khi deploy thật')
param activityLogAlertScopeResourceGroup string = 'rg-spoke-dev-jap'

resource hubRg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: hubResourceGroupName
  location: location
}

resource spokeProdRg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: spokeProdResourceGroupName
  location: location
}

module network 'modules/network-hub.bicep' = {
  name: 'deploy-network-hub'
  scope: hubRg
  params: {
    location: location
    spokeDevVnetId: spokeDevVnetId
    spokeProdVnetId: spokeProdVnetId
  }
}

module monitoring 'modules/monitoring.bicep' = {
  name: 'deploy-monitoring'
  scope: hubRg
  dependsOn: [
    spokeProdRg
  ]
  params: {
    location: location
    onCallEmail: onCallEmail
    vmProdResourceId: vmProdResourceId
    activityLogAlertScopeResourceGroupId: subscriptionResourceId('Microsoft.Resources/resourceGroups', activityLogAlertScopeResourceGroup)
    maintenanceRecurEvery: maintenanceRecurEvery
    maintenanceStartDateTime: maintenanceStartDateTime
    spokeProdResourceGroupName: spokeProdResourceGroupName
  }
}

output hubVnetId string = network.outputs.vnetId
output logAnalyticsWorkspaceId string = monitoring.outputs.logAnalyticsWorkspaceId
