import { avdWorkspaceParameterType } from '../../types/parameter.types.bicep'

// *********************************************************
//
// Type: Module
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Virtual Desktop - Workspace deployment
//
// *********************************************************

// Target scope
targetScope = 'resourceGroup'

// Parameters
// ******************************

param deploymentLocation string

param avdWorkspaceProperties avdWorkspaceParameterType

// Modules
// ******************************

module hp 'hp.module.bicep' = [
  for pool in avdWorkspaceProperties.hostPools: {
    name: 'deploy-avd-${pool.name}'
    params: {
      avdHostPools: pool
      deploymentLocation: deploymentLocation
    }
  }
]

// Resources
// ******************************

resource ws 'Microsoft.DesktopVirtualization/workspaces@2023-09-05' = {
  name: avdWorkspaceProperties.name
  location: deploymentLocation
  properties: {
    friendlyName: avdWorkspaceProperties.friendlyName
    description: avdWorkspaceProperties.friendlyName
  }
}

output appIdArray array = [for (pool, i) in avdWorkspaceProperties.hostPools: hp[i].outputs.appgIds]
