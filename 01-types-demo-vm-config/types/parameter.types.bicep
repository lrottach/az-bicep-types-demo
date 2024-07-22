// *********************************************************
//
// Type: Data Types
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: User-defined data types
//
// *********************************************************

// Virtual Machine - Configuration
@export()
@sealed()
type vmParameterType = {
  @minLength(1)
  @maxLength(15)
  vmName: string
  vmSize: 'Standard_B4as_v2' | 'Standard_B8as_v2'
  vmOs: '2022-datacenter-azure-edition-hotpatch' | '2019-datacenter-gensecond'

  @description('Deploy Azure Monitoring Agent if set to true')
  enableMonitoring: bool

  osDiskSize: 128 | 256 | 512
  dataDisks: dataDisksType
}

// Virtual Machine - Data disk config
@sealed()
type dataDiskType = {
  @description('Size of the data disk')
  diskSize: 128 | 256 | 512
  @description('Performance tier of the data disk')
  diskTier: 'Premium_LRS' | 'Standard_LRS' | 'StandardSSD_LRS'
}

// Virtual Machine - Data disks array
type dataDisksType = dataDiskType[]
