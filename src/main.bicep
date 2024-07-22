import { avdWorkspaceParameterType } from './types/parameter.types.bicep'

// *********************************************************
//
// Type: Main
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Virtual Desktop - MgmtPlane Deployment
//
// *********************************************************

// Target scope
targetScope = 'subscription'

// Parameters
// ******************************

@allowed(['westeurope', 'switzerlandnorth'])
param deploymentLocation string
param rgName string
param avdWorkspaceProperties avdWorkspaceParameterType

// Resources
// ******************************

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: rgName
  location: deploymentLocation
}

// Modules
// ******************************

module ws './modules/Microsoft.DesktopVirtualization/ws.module.bicep' = {
  scope: rg
  name: 'deploy-${rg.name}'
  params: {
    avdWorkspaceProperties: avdWorkspaceProperties
    deploymentLocation: deploymentLocation
  }
}

module ws_update_ref './modules/Microsoft.DesktopVirtualization/ws-update-ref.module.bicep' = {
  scope: rg
  name: 'update-appg-ref-${avdWorkspaceProperties.name}'
  params: {
    appGroupReferences: ws.outputs.appIdArray
    deploymentLocation: deploymentLocation
    workspaceName: avdWorkspaceProperties.name
  }
}
