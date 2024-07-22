import { vmParameterType } from './types/parameter.types.bicep'

// *********************************************************
//
// Type: Main
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Bicep user-defined data types - VM example
//
// *********************************************************

// Target scope
targetScope = 'subscription'

// Parameters
// ******************************

// Deployment parameter
@allowed(['westeurope', 'switzerlandnorth'])
param deploymentLocation string
param rgName string

// Virtual Machine parameter
param adminUsername string
@secure()
param adminPassword string
param vmProperties vmParameterType // <-- Our user-defined data type

// Virtual Network parameter
param vnetName string
param vnetRange string
param subnetRange string

// Resources
// ******************************

// Azure Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: rgName
  location: deploymentLocation
}

// Modules
// ******************************

// Virtual Network module
// *** Simple Azure VNET to make this example work
module vnet './modules/Microsoft.Network/vnet.module.bicep' = {
  scope: rg
  name: 'deploy-${vnetName}'
  params: {
    deploymentLocation: deploymentLocation
    vnetName: vnetName
    vnetRange: vnetRange
    subnetRange: subnetRange
  }
}

// Virtual Machine module
module vm './modules/Microsoft.Compute/vm.module.bicep' = {
  scope: rg
  name: 'deploy-${vmProperties.vmName}'
  params: {
    deploymentLocation: deploymentLocation
    adminUsername: adminUsername
    adminPassword: adminPassword
    vmProperties: vmProperties
    targetSubnetId: vnet.outputs.defaultSubnetId
  }
}
