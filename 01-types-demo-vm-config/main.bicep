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

@allowed(['westeurope', 'switzerlandnorth'])
param deploymentLocation string

param rgName string


// Resources
// ******************************

// Azure Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: rgName
  location: deploymentLocation
}

// Modules
// ******************************
