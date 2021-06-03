# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVMSize:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmsize?view=azps-5.5.0    
    Get-AzComputeResourceSku:   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azcomputeresourcesku?view=azps-6.0.0 
} #>
<# Required Functions Links: {
    None:                       In order for this function to work, another function will need to pass $LocationObject.DisplayName
} #>
<# Functions Description: {
    GetAzVMSize:                Function for setting the VM size
} #>
<# Variables: {      
    :GetAzureVMSize             Outer loop for managing function
    :SetAzureVMCoreCount        Inner loop for getting the core count
    :SelectAzureVMCoreCount     Inner loop for selecting the core count
    :SetAzureVMRamCount         Inner loop for getting the ram count
    :SelectAzureVMRamCount      Inner loop for selecting the ram count
    :SetAzureVMDiskCount        Inner loop for getting the max disk count
    :SelectAzureVMDiskCount     Inner loop for selecting the max disk count
    :SetAzureVMName             Inner loop for gelecting the VM
    :SelectAzureVMName          Inner loop for selecting the VM
    $HVGen:                     VM image generation
    $NotAvailable:              List of all compute objects not available in region
    $GenSupported:              List of all compute objects supporting the selected generation
    $VMSizeList:                List of all VM sizes in region
    $CoreCountList:             List of all VM sizes core counts
    $ValidCore:                 Array used for selecting a valid core count
    $CoreNumber:                List number
    $CoreInput:                 Loads items into array
    $CoreCount:                 Selected core count
    $Number:                    Currrent item .number, used for formatting
    $Count:                     Currrent item .count, used for formatting
    $OpSelect:                  Operator input for selecting values
    $OpConfirm:                 Operator confirmation of selected values
    $RamCountList:              List of all vm sizes ram counts
    $ValidRam:                  Array used for selecting a valid ram count
    $RamNumber:                 List number
    $RamInput:                  Loads items into array
    $RamCount:                  Selected ram count
    $DiskCountList:             List of all vm size max disk counts
    $ValidDisk:                 Array used for selecting a valid max disk count
    $DiskNumber:                List number
    $DiskInput:                 Loads items into array
    $DiskCount:                 Selected for the max disk count
    $ValidVMSize:               Array used for selecting the VM name
    $VMSizeInput:               Loads items into array
    $VMSizeNumber:              List number
    $OSDiskSize:                Current item .OSDiskSize, used for formatting
    $RSDiskSize:                Current item .RSDiskSize, used for formatting
    $VMSizeObject:              VM size object
} #>
<# Process Flow {
    function
        Call GetAzVMSize > Get $VMSizeObject
        End GetAzVMSize
            Return Function > Send $VMSizeObject
}#>
function GetAzVMSize {                                                                      # Function for setting the VM size
    Begin {                                                                                 # Begin function
        :GetAzureVMSize while ($true) {                                                     # Outer loop for managing function
            if (!$HVGen) {                                                                  # IF $HVGen is $null
                :SetHyperVGen while ($true) {                                               # Inner loop for setting the hyper v generation
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Gen 1'                                                  # Write message to screen
                    Write-Host '[2] Gen 2'                                                  # Write message to screen
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input to select the generation
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Else if $OpSelect equals '1'
                        $HVGen = '*V1*'                                                     # Sets $HVGen
                        Break SetHyperVGen                                                  # Breaks :SetHyperVGen
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Else if $OpSelect equals '2'
                        $HVGen = '*V2*'                                                     # Sets $HVGen
                        Break SetHyperVGen                                                  # Breaks :SetHyperVGen
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SetHyperVGen while ($true)
            }                                                                               # End if (!$HVGen)
            $NotAvailable = Get-AzComputeResourceSku -Location $LocationObject.Location `
                | Where-Object {$_.Restrictions.Reasoncode  -eq `
                'NotAvailableForSubscription'}                                              # Gets a list of all unavailble compute objects
            $GenSupported  = Get-AzComputeResourceSku -Location $LocationObject.Location `
                | Where-Object {$_.Capabilities[4].Value -like $HVGen}                      # Gets a list of all VMs with the supported gen value
            $VMSizeList = Get-AzVMSize -Location $LocationObject.Location `
                | Where-Object {$_.Name -notin $NotAvailable.Name}                          # Gets a list of all available VM sizes in location
            $VMSizeList = $VMSizeList | Where-Object {$_.Name -in $GenSupported.Name}
            :SetAzureVMCoreCount while ($true) {                                            # Inner loop for setting the core count
                $CoreCountList = $VMSizeList                                                # Passes original list to loop list
                $CoreCountList = $CoreCountList.NumberOfCores | Sort-Object | Get-Unique    # Retains only the core count values, sorts them and only keeps unique 
                [System.Collections.ArrayList]$ValidCore = @()                              # Creates array for list to be loaded into
                $CoreNumber = 1                                                             # Creates #var used for list selection
                foreach ($_ in $CoreCountList) {                                            # For each item in list
                    $CoreInput = [PSCustomObject]@{'Count' = $_;'Number' = $CoreNumber}     # Creates the item to loaded into array
                    $ValidCore.Add($CoreInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $CoreNumber = $CoreNumber + 1                                           # Increments $var up by 1
                }                                                                           # End foreach ($_ in $OpSelectList)
                :SelectAzureVMCoreCount while ($true) {                                     # Inner loop for selecting the vm core count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidCore) {                                            # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        $Count = $_.Count                                                   # Count is equal to current item .count
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            if ($Count -le 9) {                                             # If $Count is 9 or less
                                Write-Host "[$Number] "$_.Count'  Cores'                    # Write message to screen
                            }                                                               # End if ($Count -le 9)
                            elseif ($Count -ge 10 -and $Count -le 99) {                     # If $Count is between 10 and 99
                                Write-Host "[$Number] "$_.Count' Cores'                     # Write message to screen
                            }                                                               # End elseif ($Count -ge 10 -and $Count -le 99) 
                            elseif ($Count -ge 100) {                                       # If $Count is 100 or more
                                Write-Host "[$Number] "$_.Count'Cores'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 100)
                        }                                                                   # End if ($Number -ge 9)
                        else {                                                              # If $number is greater than 9
                            if ($Count -le 9) {                                             # If $Count is 9 or less
                                Write-Host "[$Number]"$_.Count'  Cores'                     # Write message to screen
                            }                                                               # End if ($Count -le 9)
                            elseif ($Count -ge 10 -and $Count -le 99) {                     # If $Count is between 10 and 99
                                Write-Host "[$Number]"$_.Count' Cores'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 10 -and $Count -le 99) 
                            elseif ($Count -ge 100) {                                       # If $Count is 100 or more
                                Write-Host "[$Number]"$_.Count'Cores'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 100)
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the core count for:'$CallingFunction  # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidCore.Number) {                              # If $CoreCoint in $ValidCore.Number list
                        $OpSelect = $ValidCore | Where-Object {$_.Number -eq $OpSelect}     # $OpSelect is equal to $ValidCore where $ValidCore.Number equals $OpSelect
                        $OpSelect = $OpSelect.Count                                         # CoreCount is equal to $OpSelect.Count
                        Write-Host 'Confirm:'$OpSelect' cores'                              # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation of core count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OperatorConfrim equals 'y'
                            $CoreCount = $OpSelect                                          # CoreCount is equal to $OpSelect
                            Break SetAzureVMCoreCount                                       # Breaks :SetAzureVMCoreCount
                        }                                                                   # End if ($OperatorConfirm -eq 'y') 
                    }                                                                       # End elseif ($OpSelect -in $ValidCore.Number)
                    else {                                                                  # All other values
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMCoreCount while ($true)
            }                                                                               # End :SetAzureVMCoreCount while ($true)
            :SetAzureVMRamCount while ($true) {                                             # Inner loop for setting the VM ram count
                $RamCountList = $VMSizeList | Where-Object {$_.NumberOfCores `
                        -eq $CoreCount}                                                     # Creates loop list using $VMSizeList with $CoreCount filter
                $RamCountList = $RamCountList.MemoryInMB | Sort-Object | Get-Unique         # Retains only the ram count values, sorts them and only keeps unique
                [System.Collections.ArrayList]$ValidRam = @()                               # Creates array list is loaded into
                $RamNumber = 1                                                              # Creates list count $var
                foreach ($_ in $RamCountList) {                                             # For each item in list
                    $RamInput = [PSCustomObject]@{'Count' = $_;'Number' = $RamNumber}       # Creates the item to be loaded into array
                    $ValidRam.Add($RamInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $RamNumber = $RamNumber + 1                                             # Increments list number up by 1
                }                                                                           # End foreach ($_ in $RamCountList)
                :SelectAzureVMRamCount while ($true) {                                      # Inner loop for selecting the ram count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidRam) {                                             # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        $Count = $_.Count                                                   # Count is equal to current item .Count
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            if ($Count -le 999) {                                           # If $Count is 999 or less
                                Write-Host "[$Number] "$_.Count'     MB'                    # Write message to screen
                            }                                                               # End if ($Count -le 999)
                            elseif ($Count -ge 1000 -and $Count -le 9999) {                 # If $Count is between 1000 an 9999
                                Write-Host "[$Number] "$_.Count'    MB'                     # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000 -and $Count -le 9999)
                            elseif ($Count -ge 10000 -and $Count -le 99999) {               # If $Count is between 10000 an 99999
                                Write-Host "[$Number] "$_.Count'   MB'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 10000 -and $Count -le 99999)
                            elseif ($Count -ge 100000 -and $Count -le 999999) {             # If $Count is between 100000 an 999999
                                Write-Host "[$Number] "$_.Count'  MB'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 100000 -and $Count -le 999999) 
                            elseif ($Count -ge 1000000 -and $Count -le 9999999) {           # If $Count is between 1000000 an 9999990
                                Write-Host "[$Number] "$_.Count' MB'                        # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000000 -and $Count -le 9999999)
                            else {                                                          # All other values for $Count
                                Write-Host "[$Number] "$_.Count'MB'                         # Write message to screen
                            }                                                               # End if ($Count -le 999)
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $number is greater than 9
                            if ($Count -le 999) {                                           # If $Count is 999 or less
                                Write-Host "[$Number]"$_.Count'    MB'                      # Write message to screen
                            }                                                               # End if ($Count -le 999)
                            elseif ($Count -ge 1000 -and $Count -le 9999) {                 # If $Count is between 1000 an 9999
                                Write-Host "[$Number]"$_.Count'   MB'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000 -and $Count -le 9999)
                            elseif ($Count -ge 10000 -and $Count -le 99999) {               # If $Count is between 10000 an 99999
                                Write-Host "[$Number]"$_.Count'  MB'                        # Write message to screen
                            }                                                               # End elseif ($Count -ge 10000 -and $Count -le 99999)
                            elseif ($Count -ge 100000 -and $Count -le 999999) {             # If $Count is between 100000 an 999999
                                Write-Host "[$Number]"$_.Count' MB'                         # Write message to screen
                            }                                                               # End elseif ($Count -ge 100000 -and $Count -le 999999) 
                            elseif ($Count -ge 1000000 -and $Count -le 9999999) {           # If $Count is between 1000000 an 9999990
                                Write-Host "[$Number]"$_.Count' MB'                         # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000000 -and $Count -le 9999999)
                            else {                                                          # All other values for $Count
                                Write-Host "[$Number]"$_.Count'MB'                          # Write message to screen
                            }                                                               # End if ($Count -le 999)
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the RAM count for:'$CallingFunction   # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidRam.Number) {                               # If $OpSelect is in $ValidRam.Number list
                        $OpSelect = $ValidRam | Where-Object {$_.Number -eq $OpSelect}      # $OpSelect equals $ValidRam where $ValidRam.Number equals $OpSelect 
                        $OpSelect = $OpSelect.Count                                         # $OpSelect equals $OpSelect.Count
                        Write-Host  'Confirm:'$OpSelect' MB of Ram'                         # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation on ram count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfrim equals 'y'
                            $RamCount = $OpSelect                                           # $RamCount is equal to $OpSelect
                            Break SetAzureVMRamCount                                        # Breaks :SetAzureRamCount
                        }                                                                   # End if ($OprConfirm -eq 'y')
                    }                                                                       # End elseif ($OpSelect -in $ValidRam.Number) 
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMRamCount while ($true)
            }                                                                               # End :SetAzureVMRamCount while ($true)
            :SetAzureVMDiskCount while ($true) {                                            # Inner loop for setting the max disk count
                $DiskCountList = $VMSizeList | Where-Object {$_.NumberOfCores -eq `
                    $CoreCount -and $_.MemoryInMB -eq $RamCount}                            # Creates loop list using $VMsizelist and filters
                $DiskCountList = $DiskCountList.MaxDataDiskCount | Sort-Object | Get-Unique # Filters list keeping only maxdatadiskcount and sorts and keeps only unique
                [System.Collections.ArrayList]$ValidDisk = @()                              # Creates array for list to be loaded into
                $DiskNumber = 1                                                             # Creates list number $var
                foreach ($_ in $DiskCountList) {                                            # For each item in list
                    $DiskInput = [PSCustomObject]@{'Count' = $_;'Number' = $DiskNumber}     # Creates the item to loaded into array
                    $ValidDisk.Add($DiskInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $DiskNumber = $DiskNumber + 1                                           # Increments list number up by 1
                }                                                                           # End foreach ($_ in $DiskCountList)                                            
                :SelectAzureVMDiskCount while ($true) {                                     # Inner loop for selecting the max disk count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidDisk) {                                            # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] "$_.Count' Max disks'                     # Write message to screen
                        }                                                                   # End if ($Number -ge 9)
                        else {                                                              # If $number is greater than 9
                            Write-Host "[$Number]"$_.Count' Max disks'                      # Write message to screen
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the max disks for:'$CallingFunction   # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidDisk.Number) {                              # If $OpSelect is in $ValidDisk.Number list
                        $OpSelect = $ValidDisk | Where-Object {$_.Number -eq $OpSelect}     # $OpSelect equals $ValidDisk where $ValidDisk.Number equals $OpSelect 
                        $OpSelect = $OpSelect.Count                                         # $OpSelect equals $OpSelect.Count
                        Write-Host  'Confirm:'$OpSelect' Max disks'                         # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation on ram count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfrim equals 'y'
                            $DiskCount = $OpSelect                                          # $DiskCount is equal to $OpSelect
                            Break SetAzureVMDiskCount                                       # Breaks :SetAzureVMDiskCount
                        }                                                                   # End if ($OprConfirm -eq 'y')
                    }                                                                       # End elseif ($OpSelect -in $ValidDisk.Number) 
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMDiskCount while ($true)
            }                                                                               # End :SetAzureVMDiskCount while ($true)
            $VMSizeList = $VMSizeList | Where-Object {$_.NumberOfCores -eq $CoreCount `
                -and $_.MemoryInMB -eq $RamCount -and $_.MaxDataDiskCount -eq $DiskCount}   # Refilters $VMSizeList
            :SetAzureVMName while ($true) {                                                 # Inner loop for selecting the VM size
                [System.Collections.ArrayList]$ValidVMSize = @()                            # Creates array to load list into
                $VMSizeNumber = 1                                                           # Creates list number $var
                foreach ($_ in $VMSizeList) {                                               # For each item in list
                    $VMSizeInput = [PSCustomObject]@{'Name' = $_.Name;'Number' = `
                        $VMSizeNumber;'OSDiskSize' = $_.OSDiskSizeInMB; `
                        'RSDiskSize' = $_.ResourceDiskSizeInMB}                             # Creates the item to loaded into array
                    $ValidVMSize.Add($VMSizeInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $VMSizeNumber = $VMSizeNumber + 1                                       # Increments list number up by 1
                }                                                                           # End foreach ($_ in $VMSizeList)
                :SelectAzureVMName while ($true) {                                          # Inner loop for selecting the VM size
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ValidVMSize) {                                          # For each item in $ValidVMSize
                        $Number = $_.Number                                                 # $Number is equal to current item .number
                        $OSDiskSize = $_.OSDiskSize                                         # $OSDiskSize is equal to current item .OSDiskSize
                        $RSDiskSize = $_.RSDiskSize                                         # $RSDiskSize is equal to current item .RSDiskSize
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number]"  $_.Name                                 # Write message to screen    
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is more than 9
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else if ($Number -le 9)
                        if ($OSDiskSize -le 99999) {                                        # if $OSDiskSize is 99999 or less
                            Write-Host 'OS disk size: '$_.OSDiskSize'   MB'                 # Write message to screen
                        }                                                                   # End if ($OSDiskSize -le 99999)
                        elseif ($OSDiskSize -ge 100000 -and $OSDiskSize -le 999999) {       # Else if $OSDiskSize is between 100000 and 999999
                            Write-Host 'OS disk size: '$_.OSDiskSize'  MB'                  # Write message to screen
                        }                                                                   # End elseif ($OSDiskSize -ge 100000 -and $OSDiskSize -le 999999)
                        elseif ($OSDiskSize -ge 1000000 -and $OSDiskSize -le 9999999) {     # Else if $OSDiskSize is between 1000000 and 9999999
                            Write-Host 'OS disk size: '$_.OSDiskSize' MB'                   # Write message to screen
                        }                                                                   # End elseif ($OSDiskSize -ge 1000000 -and $OSDiskSize -le 9999999)
                        elseif ($OSDiskSize -ge 10000000 -and $OSDiskSize -le 99999999) {   # Else if $OSDiskSize is between 10000000 and 99999999
                            Write-Host 'OS disk size: '$_.OSDiskSize'MB'                    # Write message to screen
                        }                                                                   # End elseif ($OSDiskSize -ge 10000000 -and $OSDiskSize -le 99999999)
                        if ($RSDiskSize -le 99999) {                                        # if $RSDiskSize is 99999 or less
                            Write-Host 'Res disk size:'$_.RSDiskSize'   MB'                 # Write message to screen
                        }                                                                   # End if ($RSDiskSize -le 99999)
                        elseif ($RSDiskSize -ge 100000 -and $RSDiskSize -le 999999) {       # Else if $RSDiskSize is between 100000 and 999999
                            Write-Host 'Res disk size:'$_.RSDiskSize'  MB'                  # Write message to screen
                        }                                                                   # End elseif ($RSDiskSize -ge 100000 -and $RSDiskSize -le 999999)
                        elseif ($RSDiskSize -ge 1000000 -and $RSDiskSize -le 9999999) {     # Else if $RSDiskSize is between 1000000 and 9999999
                            Write-Host 'Res disk size:'$_.RSDiskSize' MB'                   # Write message to screen
                        }                                                                   # End elseif ($RSDiskSize -ge 1000000 -and $RSDiskSize -le 9999999)
                        elseif ($RSDiskSize -ge 10000000 -and $RSDiskSize -le 99999999) {   # Else if $RSDiskSize is between 10000000 and 99999999
                            Write-Host 'Res disk size:'$_.RSDiskSize'MB'                    # Write message to screen
                        }                                                                   # End elseif ($RSDiskSize -ge 10000000 -and $RSDiskSize -le 99999999)
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ValidVMSize)
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the VM size for:'$CallingFunction     # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidVMSize.Number) {                            # If $OpSelect is in $ValidVMSize.Number
                        $OpSelect = $ValidVMSize | Where-Object {$_.Number -eq $OpSelect}   # $OpSelect is equal to $ValidVMSize where $ValidVMSize.Number equals $OpSelect
                        $VMSizeObject = Get-AzVMSize -Location `
                            $LocationObject.location | Where-Object `
                            {$_.Name -eq $OpSelect.Name}                                    # $VMSizeObject is pulled using $OpSelect.Name
                        Return $VMSizeObject                                                # Returns to calling function with $VMSizeObject
                    }                                                                       # End elseif ($VMSizeCount -in $ValidVMSize.Number)
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($VMSizeCount -eq '0'))
                }                                                                           # End :SelectAzureVMName while ($true)
            }                                                                               # End :SetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVMSize while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVMSize