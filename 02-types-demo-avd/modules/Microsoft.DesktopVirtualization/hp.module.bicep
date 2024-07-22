import { avdHostPoolParameterType } from '../../types/parameter.types.bicep'

// *********************************************************
//
// Type: Module
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Virtual Desktop - Host Pool deployment
//
// *********************************************************

// Target scope
targetScope = 'resourceGroup'

// Parameters
// ******************************

param deploymentLocation string

param avdHostPools avdHostPoolParameterType

// Modules
// ******************************

module appg 'appg.module.bicep' = [
  for group in avdHostPools.appGroups: {
    name: 'deploy-avd-${group.name}'
    params: {
      avdAppGroups: group
      deploymentLocation: deploymentLocation
      hpId: hp.id
    }
  }
]

// Resources
// ******************************

resource hp 'Microsoft.DesktopVirtualization/hostPools@2023-09-05' = {
  name: avdHostPools.name
  location: deploymentLocation
  properties: {
    hostPoolType: avdHostPools.type
    loadBalancerType: avdHostPools.loadBalancerType
    preferredAppGroupType: avdHostPools.preferredAppGroupType
  }
}

// Outputs
// ******************************
output appgIds array = [for (group, i) in avdHostPools.appGroups: appg[i].outputs.appgId]
