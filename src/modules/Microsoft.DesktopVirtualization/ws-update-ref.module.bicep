import { avdWorkspaceParameterType } from '../../types/parameter.types.bicep'

// *********************************************************
//
// Type: Module
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Virtual Desktop - Update application group references
//
// *********************************************************

// Target scope
targetScope = 'resourceGroup'

// Parameters
// ******************************

param deploymentLocation string
param workspaceName string
param appGroupReferences array

// Resources
// ******************************

resource ws 'Microsoft.DesktopVirtualization/workspaces@2023-09-05' = {
  name: workspaceName
  location: deploymentLocation
  properties: {
    applicationGroupReferences: flatten(appGroupReferences)
  }
}
