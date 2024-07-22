using 'main.bicep'

// *********************************************************
//
// Type: Parameter
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Bicep user-defined data types - Parameter file
//
// *********************************************************

// Deployment parameter
param deploymentLocation = 'westeurope'
param rgName = 'rg-demo1-vmDb1-we'

// Virtual Machine parameter
param adminUsername = 'admindeploy'
param adminPassword = 'Password1234!' // Don't do this in production :P

// Virtual Machine properties
param vmProperties = {
  vmName: 'vm-vmDb1-we'
  vmSize: 'Standard_B4as_v2'
  enableMonitoring: true
  osDiskSize: 128
  vmOs: '2022-datacenter-azure-edition-hotpatch'
  dataDisks: [
    {
      diskSize: 128
      diskTier: 'Standard_LRS'
    }
    {
      diskSize: 256
      diskTier: 'Premium_LRS'
    }
  ]
}

// Virtual Network parameter
// *** Simple Azure VNET to make this example work
param vnetName = 'vnet-demo1-vmDb1-we'
param vnetRange = '10.100.0.0/16'
param subnetRange = '10.100.1.0/24'
