# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVMSize:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmsize?view=azps-5.5.0     
} #>
<# Required Functions Links: {
    None:                       In order for this function to work, another function will need to pass $LocationObject.DisplayName
} #>
<# Functions Description: {
    GetAzVMSize:                Function for setting the VM size
} #>
<# Variables: {      
    :GetAzureVMSize             Outer loop for managing function
    :SetAzureVMCoreCount        Inner loop for setting the core count
    :SetAzureVMRamCount         Inner loop for setting the ram count
    :SetAzureVMDiskCount        Inner loop for setting the max disk count
    :SetAzureVMName             Inner loop for selecting the VM
    $VMSizeList:                List of all VM sizes in location
    $CoreCountList:             List of all VM sizes core counts
    $ValidCore:                 Array used for selecting a valid core count
    $CoreNumber:                List number
    $CoreInput:                 Loads items into array
    $CoreCount:                 Operator input for the core count
    $RamCountList:              List of all vm sizes ram counts
    $ValidRam:                  Array used for selecting a valid ram count
    $RamNumber:                 List number
    $RamInput:                  Loads items into array
    $RamCount:                  Operator input for the ram count
    $DiskCountList:             List of all vm size max disk counts
    $ValidDisk:                 Array used for selecting a valid max disk count
    $DiskNumber:                List number
    $DiskInput:                 Loads items into array
    $DiskCount:                 Operator input for the max disk count
    $OperatorConfirm:           Operator confirmation of selected values
    $ValidVMSize:               Array used for selecting the VM name
    $VMSizeInput:               Loads items into array
    $VMSizeNumber:              List number
    $VMSizeCount:               Operator input for the VM size selection
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
            $VMSizeList = Get-AzVMSize -Location $LocationObject.Location                   # Gets a list of all VM sizes in location
            :SetAzureVMCoreCount while ($true) {                                            # Inner loop for setting the core count
                $CoreCountList = $VMSizeList                                                # Passes original list to loop list
                $CoreCountList = $CoreCountList.NumberOfCores | Sort-Object | Get-Unique    # Retains only the core count values, sorts them and only keeps unique 
                [System.Collections.ArrayList]$ValidCore = @()                              # Creates array for list to be loaded into
                $CoreNumber = 1                                                             # Creates #var used for list selection
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $CoreCountList) {                                            # For each item in list
                    $CoreInput = [PSCustomObject]@{'Count' = $_;'Number' = $CoreNumber}     # Creates the item to loaded into array
                    $ValidCore.Add($CoreInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $CoreNumber = $CoreNumber + 1                                           # Increments $var up by 1
                }                                                                           # End foreach ($_ in $CoreCountList)
                foreach ($_ in $ValidCore) {                                                # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"Cores"                              # Write message to screen
                }                                                                           # End foreach ($_ in $ValidCore) 
                $CoreCount = Read-Host "Enter the list number for VM core count"            # Operator input for the core count value
                if ($CoreCount -eq '0') {                                                   # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($CoreCount -eq '0')
                elseif ($CoreCount -in $ValidCore.Number) {                                 # If $CoreCoint in $ValidCore.Number list
                    $CoreCount = $ValidCore | Where-Object {$_.Number -eq $CoreCount}       # $CoreCount is equal to $ValidCore where $ValidCore.Number equals $CoreCount
                    $CoreCount = $CoreCount.Count                                           # CoreCount is equal to $CoreCount.Count
                    $OperatorConfirm = Read-Host "Confirm:"$CoreCount" cores? [Y] or [N]"   # Operator confirmation of core count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMCoreCount                                           # Breaks :SetAzureVMCoreCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y') 
                }                                                                           # End elseif ($CoreCount -in $ValidCore.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($CoreCount -eq '0'))
            }                                                                               # End :SetAzureVMCoreCount while ($true)
            :SetAzureVMRamCount while ($true) {                                             # Inner loop for setting the VM ram count
                $RamCountList = $VMSizeList | Where-Object {$_.NumberOfCores `
                        -eq $CoreCount}                                                     # Creates loop list using $VMSizeList with $CoreCount filter
                $RamCountList = $RamCountList.MemoryInMB | Sort-Object | Get-Unique         # Retains only the ram count values, sorts them and only keeps unique
                [System.Collections.ArrayList]$ValidRam = @()                               # Creates array list is loaded into
                $RamNumber = 1                                                              # Creates list count $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $RamCountList) {                                             # For each item in list
                    $RamInput = [PSCustomObject]@{'Count' = $_;'Number' = $RamNumber}       # Creates the item to be loaded into array
                    $ValidRam.Add($RamInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $RamNumber = $RamNumber + 1                                             # Increments list number up by 1
                }                                                                           # End foreach ($_ in $RamCountList)
                foreach ($_ in $ValidRam) {                                                 # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"MB"                                 # Write message to screen
                }                                                                           # End foreach ($_ in $ValidRam)
                $RamCount = Read-Host "Enter the list number for VM Ram"                    # Operator input for the ram count selection
                if ($RamCount -eq '0') {                                                    # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($RamCount -eq '0')
                elseif ($RamCount -in $ValidRam.Number) {                                   # If $Ramcount is in $ValidRam.Number list
                    $RamCount = $ValidRam | Where-Object {$_.Number -eq $RamCount}          # $RamCount equals $ValidRam where $ValidRam.Number equals $RamCount 
                    $RamCount = $RamCount.Count                                             # $RamCount equals $RamCount.Count
                    $OperatorConfirm = Read-Host "Confirm:" `
                    $RamCount" MB of Ram? [Y] or [N]"                                       # Operator confirmation on ram count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMRamCount                                            # Breaks :SetAzureRamCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($RamCount -in $ValidRam.Number) 
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RamCount -eq '0'))
            }                                                                               # End :SetAzureVMRamCount while ($true)
            :SetAzureVMDiskCount while ($true) {                                            # Inner loop for setting the max disk count
                $DiskCountList = $VMSizeList | Where-Object {$_.NumberOfCores -eq `
                    $CoreCount -and $_.MemoryInMB -eq $RamCount}                            # Creates loop list using $VMsizelist and filters
                $DiskCountList = $DiskCountList.MaxDataDiskCount | Sort-Object | Get-Unique # Filters list keeping only maxdatadiskcount and sorts and keeps only unique
                [System.Collections.ArrayList]$ValidDisk = @()                              # Creates array for list to be loaded into
                $DiskNumber = 1                                                             # Creates list number $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $DiskCountList) {                                            # For each item in list
                    $DiskInput = [PSCustomObject]@{'Count' = $_;'Number' = $DiskNumber}     # Creates the item to loaded into array
                    $ValidDisk.Add($DiskInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $DiskNumber = $DiskNumber + 1                                           # Increments list number up by 1
                }                                                                           # End foreach ($_ in $DiskCountList)                                            
                foreach ($_ in $ValidDisk) {                                                # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"Max disks"                          # Write message to screen
                }                                                                           # End foreach ($_ in $ValidDisk)
                $DiskCount = Read-Host "Enter the list number for VM max disks"             # Operator input for the max disk count
                if ($DiskCount -eq '0') {                                                   # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($DiskCount -eq '0')
                elseif ($DiskCount -in $ValidDisk.Number) {                                 # Else if $DiskCount is in $ValidDisk.Number list
                    $DiskCount = $ValidDisk | Where-Object {$_.Number -eq $DiskCount}       # $DiskCount equals $ValidDisk where $ValidDisk.Number equals $DiskCount
                    $DiskCount = $DiskCount.Count                                           # $DiskCount equals $DiskCount.Count
                    $OperatorConfirm = Read-Host `
                        "Confirm"$DiskCount" max disks? [Y] or [N]"                          # Operator confirmation of the disk count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMDiskCount                                           # Breaks :SetAzureVMDiskCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($DiskCount -in $ValidDisk.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($DiskCount -eq '0'))
            }                                                                               # End :SetAzureVMDiskCount while ($true)
            $VMSizeList = $VMSizeList | Where-Object {$_.NumberOfCores -eq $CoreCount `
                -and $_.MemoryInMB -eq $RamCount -and $_.MaxDataDiskCount -eq $DiskCount}   # Refilters $VMSizeList
            :SetAzureVMName while ($true) {                                                 # Inner loop for selecting the VM size
                [System.Collections.ArrayList]$ValidVMSize = @()                            # Creates array to load list into
                $VMSizeNumber = 1                                                           # Creates list number $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                Write-Host ""                                                               # Write message to screen
                foreach ($_ in $VMSizeList) {                                               # For each item in list
                    $VMSizeInput = [PSCustomObject]@{'Name' = $_.Name;'Number' = `
                        $VMSizeNumber;'OSDiskSize' = $_.OSDiskSizeInMB; `
                        'RSDiskSize' = $_.ResourceDiskSizeInMB}                             # Creates the item to loaded into array
                    $ValidVMSize.Add($VMSizeInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $VMSizeNumber = $VMSizeNumber + 1                                       # Increments list number up by 1
                }                                                                           # End foreach ($_ in $VMSizeList)
                foreach ($_ in $ValidVMSize) {                                              # For each item in list
                    Write-Host "["$_.Number"]" $_.Name                                      # Write message to screen
                    Write-Host "OS disk size:"$_.OSDiskSize"MB"                             # Write message to screen
                    Write-Host "Resource Disk size:"$_.RSDiskSize"MB"                       # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ValidVMSize)
                $VMSizeCount = Read-Host "Enter the list number for VM size"                # Operator input for the VM size
                if ($VMSizeCount -eq '0') {                                                 # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($VMSizeCount -eq '0')
                elseif ($VMSizeCount -in $ValidVMSize.Number) {                             # If $VMSizeCoint is in $ValidVMSize.Number
                    $VMSizeCount = $ValidVMSize | Where-Object {$_.Number -eq $VMSizeCount} # $VMsizeCount is equal to $ValidVMSize where $ValidVMSize.Number equals $VMSizeCount
                    $VMSizeObject = Get-AzVMSize -Location $LocationObject.DisplayName | `
                        Where-Object {$_.Name -eq $VMSizeCount.Name}                        # $VMSizeNumber is pulled using $VMSizeCount.Name
                    if ($VMSizeObject) {                                                    # If $VMSizeObject exists
                        Return $VMSizeObject                                                # Returns to calling function with $VMSizeObject
                    }                                                                       # End if ($VMSizeObject)
                }                                                                           # End elseif ($VMSizeCount -in $ValidVMSize.Number)
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($VMSizeCount -eq '0'))
            }                                                                               # End :SetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVMSize while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVMSize