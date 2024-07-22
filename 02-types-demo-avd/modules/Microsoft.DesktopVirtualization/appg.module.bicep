import { avdAppGroupParameterType } from '../../types/parameter.types.bicep'

// *********************************************************
//
// Type: Module
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Virtual Desktop - Application Group deployment
//
// *********************************************************

// Target scope
targetScope = 'resourceGroup'

// Parameters
// ******************************

param deploymentLocation string

param avdAppGroups avdAppGroupParameterType

param hpId string

// Resources
// ******************************

resource appg 'Microsoft.DesktopVirtualization/applicationGroups@2023-09-05' = {
  name: avdAppGroups.name
  location: deploymentLocation
  properties: {
    applicationGroupType: avdAppGroups.type
    hostPoolArmPath: hpId
    description: avdAppGroups.description
    friendlyName: avdAppGroups.friendlyName
  }
}

output appgId string = appg.id
