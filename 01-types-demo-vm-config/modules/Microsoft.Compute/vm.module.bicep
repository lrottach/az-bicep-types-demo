import { vmParameterType } from '../../types/parameter.types.bicep'

// *********************************************************
//
// Type: Module
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Bicep user-defined data types - VM module
//
// *********************************************************

// Target scope
targetScope = 'resourceGroup'

// Parameters
// ******************************

// Deployment parameter
param deploymentLocation string

// Virtual Machine parameter
param adminUsername string

@secure()
param adminPassword string
param vmProperties vmParameterType
param targetSubnetId string

// Resources
// ******************************

// Azure Virtual Machine - Network Interface
resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: '${vmProperties.vmName}-nic'
  location: deploymentLocation
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: targetSubnetId
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: vmProperties.vmName
  location: deploymentLocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    hardwareProfile: {
      vmSize: vmProperties.vmSize
    }
    storageProfile: {
      osDisk: {
        name: '${vmProperties.vmName}-osDisk'
        diskSizeGB: vmProperties.osDiskSize
        createOption: 'FromImage'
        managedDisk: {
           storageAccountType: 'StandardSSD_LRS'
        }
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: vmProperties.vmOs
        version: 'latest'
      }
      dataDisks: [
        for (disk,i) in vmProperties.dataDisks: {
          lun: i
          name: '${vmProperties.vmName}-dataDisk-${i}'
          diskSizeGB: disk.diskSize
          managedDisk: {
            storageAccountType: disk.diskTier
          }
          createOption: 'Empty'
        }
      ]
    }
    osProfile: {
      computerName: vmProperties.vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    securityProfile:{
      securityType: 'TrustedLaunch'
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
    }
  }
}

// Deploy Azure Monitoring Agent if "enableMonitoring" is set to true
resource vmExtension 'Microsoft.Compute/virtualMachines/extensions@2024-03-01' = if (vmProperties.enableMonitoring) {
  parent: vm
  name: 'AzureMonitorWindowsAgent'
  location: deploymentLocation
  properties: {
    publisher: 'Microsoft.Azure.Monitor'
    type: 'AzureMonitorWindowsAgent'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    enableAutomaticUpgrade: true
  }
}
