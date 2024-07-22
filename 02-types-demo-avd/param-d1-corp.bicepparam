using 'main.bicep'

param deploymentLocation = 'westeurope'
param rgName = 'rg-demo-corp1-we'

param avdWorkspaceProperties = {
  name: 'avd-dev1-corp-ws1-sn'
  description: 'Dark Contoso Lab - Corporate'
  friendlyName: 'Dark Contoso Lab - Corporate'
  hostPools: [
    {
      name: 'avd-dev1-corp-hp1-sn'
      description: 'Business applications'
      friendlyName: 'Dark Contoso - Business'
      loadBalancerType: 'BreadthFirst'
      preferredAppGroupType: 'Desktop'
      type: 'pooled'
      appGroups: [
        {
          name: 'avd-dev1-corp-hp1-apg1-sn'
          friendlyName: 'Dark Contoso - Desktop'
          description: 'Dark Contoso - Desktop'
          type: 'Desktop'
        }
        {
          name: 'avd-dev1-corp-hp1-apg2-sn'
          friendlyName: 'Dark Contoso - Remote'
          description: 'Dark Contoso - Remote'
          type: 'RemoteApp'
        }
      ]
    }
    {
      name: 'avd-dev1-corp-hp2-sn'
      description: 'Business applications'
      friendlyName: 'Dark Contoso - Business'
      loadBalancerType: 'BreadthFirst'
      preferredAppGroupType: 'Desktop'
      type: 'personal'
      appGroups: [
        {
          name: 'avd-dev1-corp-hp2-apg1-sn'
          friendlyName: 'Dark Contoso - Desktop'
          description: 'Dark Contoso - Desktop'
          type: 'Desktop'
        }
      ]
    }
  ]
}
