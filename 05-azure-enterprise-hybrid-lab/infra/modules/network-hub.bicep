// Module: network-hub.bicep
// Nguồn: export thật từ rg-hub-prod-jap qua aztfexport (không phải đoán từ doc)

@description('Region deploy, mặc định Japan East theo lab gốc')
param location string = 'japaneast'

@description('Tên VNet hub')
param vnetName string = 'vnet-hub-prod-jap'

@description('Address space của VNet hub')
param vnetAddressSpace array = [
  '10.0.0.0/16'
]

@description('Bật outbound access mặc định cho subnet. Lab gốc để FALSE (private subnet) -- đây chính là nguyên nhân gây lỗi outbound network đã gặp khi làm Log Analytics. Khuyến nghị đổi sang TRUE hoặc thêm NAT Gateway trước khi dùng subnet này cho VM cần ra Internet.')
param defaultOutboundAccessEnabled bool = false

@description('Resource ID của remote VNet spoke-dev để tạo peering. Để rỗng nếu spoke-dev chưa deploy trong lần chạy này.')
param spokeDevVnetId string = ''

@description('Resource ID của remote VNet spoke-prod để tạo peering. Để rỗng nếu spoke-prod chưa deploy trong lần chạy này.')
param spokeProdVnetId string = ''

resource nsgHub 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: 'vm-hub-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'RDP'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: 300
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'
        }
      }
    ]
  }
}

resource publicIpBastion 'Microsoft.Network/publicIPAddresses@2023-11-01' = {
  name: '${vnetName}-IPv4'
  location: location
  sku: {
    name: 'Standard'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource vnetHub 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: vnetAddressSpace
    }
    subnets: [
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.254.0/26'
          defaultOutboundAccess: defaultOutboundAccessEnabled
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.0.255.0/27'
          defaultOutboundAccess: defaultOutboundAccessEnabled
        }
      }
      {
        name: 'snet-shared'
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: nsgHub.id
          }
          defaultOutboundAccess: defaultOutboundAccessEnabled
        }
      }
    ]
  }
}

resource bastionHub 'Microsoft.Network/bastionHosts@2023-11-01' = {
  name: 'bastion-hub'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: '${vnetHub.id}/subnets/AzureBastionSubnet'
          }
          publicIPAddress: {
            id: publicIpBastion.id
          }
        }
      }
    ]
  }
}

// Peering hub -> spoke-dev (chỉ tạo nếu đã truyền spokeDevVnetId)
resource peeringHubToDev 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = if (!empty(spokeDevVnetId)) {
  parent: vnetHub
  name: 'hub-to-dev'
  properties: {
    allowForwardedTraffic: true
    remoteVirtualNetwork: {
      id: spokeDevVnetId
    }
  }
}

// Peering hub -> spoke-prod (chỉ tạo nếu đã truyền spokeProdVnetId)
resource peeringHubToProd 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = if (!empty(spokeProdVnetId)) {
  parent: vnetHub
  name: 'hub-to-prod'
  properties: {
    allowForwardedTraffic: true
    remoteVirtualNetwork: {
      id: spokeProdVnetId
    }
  }
}

output vnetId string = vnetHub.id
output vnetName string = vnetHub.name
output nsgId string = nsgHub.id
