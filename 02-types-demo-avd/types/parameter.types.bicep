// *********************************************************
//
// Type: Data Types
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: User-defined data types
//
// *********************************************************

// AVD - Workspace data type
@sealed()
@export()
type avdWorkspaceParameterType = {
  name: string
  friendlyName: string
  description: string
  hostPools: avdHostPoolsParameterType
}

// AVD - Host Pool data type
@sealed()
@export()
type avdHostPoolParameterType = {
  name: string
  friendlyName: string
  description: string
  type: 'personal' | 'pooled'
  loadBalancerType: 'BreadthFirst' | 'DepthFirst'
  preferredAppGroupType: 'Desktop' | 'RailApplications'
  appGroups: avdAppGroupsParameterType
}

// AVD - Host Pool [] data type
type avdHostPoolsParameterType = avdHostPoolParameterType[]

// AVD - Application Group data type
@sealed()
@export()
type avdAppGroupParameterType = {
  name: string
  friendlyName: string
  description: string
  type: 'Desktop' | 'RemoteApp'
  hpId: string?
}

// AVD - Application Group [] data type
type avdAppGroupsParameterType = avdAppGroupParameterType[]
