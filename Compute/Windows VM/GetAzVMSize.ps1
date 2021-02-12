<#:SetAzureVMSize while ($true) {                                                 # Inner loop to select the VM machine size
    $VMSizeList = Get-AzVMSize -Location $LocationObject.DisplayName            # Collects list of all VM sizes in $LocationObject
    $VMSizeListNumber = 1                                                       # $Var used for selecting the VM size
    Write-Host "0. Exit"                                                        # Write message to screen
    foreach ($Name in $VMSizeList) {                                            # For each $Name in $VMSizeList
        Write-Host $VMSizeListNumber"." $Name.Name $Name.NumberOfCores `
            $Name.MemoryInMB $Name.MaxDataDiskCount                             # Writes each VM and number in list to screen 
        $VMSizeListNumber = $VMSizeListNumber + 1                               # Incremends $VMSizeListNumber by 1
    }                                                                           # End foreach ($Name in $VMSizeList)
    :SetAzureVMSizeName while ($true) {                                         # Inner loop for selecting the VM size
        $VMSizeListNumber = 1                                                   # Resets $VMSizeListNumber
        $VMSizeListSelect = Read-Host "Please enter the number of the VM size"  # Operator input for the VM size
        if ($VMSizeListSelect -eq '0') {                                        #
            Break NewAzureWinVM                                                 # Breaks :NewAzureWinVM 
        }                                                                       # End if ($VMSizeListSelect -eq '0') 
        foreach ($Name in $VMSizeList) {                                        # For each loop for match $VMSizeListSelect to $VMSizeListNumber
            if ($VMSizeListSelect -eq $VMSizeListNumber) {                      # If $VMSizeListSelect equals $VMSizeListNumber
                $VMSizeObject = Get-AzVMSize -Location `
                    $LocationObject.DisplayName | Where-Object {$_.Name `
                    -eq $Name.Name}                                             # Assigns the current selection to $VMSizeObject
                Break SetAzureVMSize                                            # Breasks :SetAzureVMSize
            }                                                                   # End if ($VMSizeListSelect -eq $VMSizeListNumber)
            else {                                                              # If $VMSizeListSelect does not equal $VMSizeListNumber
                $VMSizeListNumber = $VMSizeListNumber + 1                       # Incremends $VMSizeListNumber by 1
            }                                                                   # End else (if ($VMSizeListSelect -eq $VMSizeListNumber))
        }                                                                       # End foreach ($Name in $VMSizeList)
        Write-Host "That was not a valid entry"                                 # Write message to screen
    }                                                                           # End :SetAzureVMSizeName while ($true) {
} #>
function GetAzVMSize {
    Begin {
        :GetAzureDiskSize while ($true) {
            $VMSizeList = Get-AzVMSize -Location $LocationObject.DisplayName
            :SetAzureVMCoreCount while ($true) {
                $CoreCountList = $VMSizeList
                $CoreCountList = $CoreCountList.NumberOfCores | Sort-Object | Get-Unique
                [System.Collections.ArrayList]$ValidCore = @()
                $CoreNumber = 1
                Write-Host "[ 0 ] to exit"
                foreach ($_ in $CoreCountList) {
                    $CoreInput = [PSCustomObject]@{'Count' = $_;'Number' = $CoreNumber}            # Creates the item to loaded into array
                    $ValidCore.Add($CoreInput) | Out-Null                                         # Loads item into array, out-null removes write to screen
                    $CoreNumber = $CoreNumber + 1
                }
                foreach ($_ in $ValidCore) {
                    Write-Host "["$_.Number"]" $_.Count"Cores"
                }
                $CoreCount = Read-Host "Enter the list number for VM core count"
                if ($CoreCount -eq '0') {
                    Break GetAzureDiskSize
                }
                elseif ($CoreCount -in $ValidCore.Number) {
                    $CoreCount = $ValidCore | Where-Object {$_.Number -eq $CoreCount}
                    $CoreCount = $CoreCount.Count
                    $OperatorConfirm = Read-Host "Confirm"$CoreCount" cores? [Y] or [N]"
                    if ($OperatorConfirm -eq 'y') {
                        Break SetAzureVMCoreCount
                    }
                }
                else {
                    Write-Host "That was not a valid option"
                } # End else
            } # End :SetAzureVMCoreCount while ($true)
            :SetAzureVMRamCount while ($true) {
                $RamCountList = $VMSizeList
                $RamCountList = $RamCountList.MemoryInMB | Sort-Object | Get-Unique
                [System.Collections.ArrayList]$ValidRam = @()
                $RamNumber = 1
                Write-Host "[ 0 ] to exit"
                foreach ($_ in $RamCountList) {
                    $RamInput = [PSCustomObject]@{'Count' = $_;'Number' = $RamNumber}            # Creates the item to loaded into array
                    $ValidRam.Add($RamInput) | Out-Null                                         # Loads item into array, out-null removes write to screen
                    $RamNumber = $RamNumber + 1
                }
                foreach ($_ in $ValidRam) {
                    Write-Host "["$_.Number"]" $_.Count"MB"
                }
                $RamCount = Read-Host "Enter the list number for VM Ram"
                if ($RamCount -eq '0') {
                    Break GetAzureDiskSize
                }
                elseif ($RamCount -in $ValidRam.Number) {
                    $RamCount = $ValidRam | Where-Object {$_.Number -eq $RamCount}
                    $RamCount = $RamCount.Count
                    $OperatorConfirm = Read-Host "Confirm"$RamCount" MB of Ram? [Y] or [N]"
                    if ($OperatorConfirm -eq 'y') {
                        Break SetAzureVMRamCount
                    }
                }
                else {
                    Write-Host "That was not a valid option"
                } # End else
            } # End :SetAzureVMCoreCount while ($true)
            $VMSizeList = Get-AzVMSize -Location $LocationObject.DisplayName | Where-Object {$_.NumberOfCores -eq $CoreCount -and $_.MemoryInMB -eq $RamCount}
            :SetAzureVMName while ($true) {
                [System.Collections.ArrayList]$ValidVMSize = @()
                $VMSizeNumber = 1
                Write-Host "[ 0 ] to exit"
                foreach ($_ in $VMSizeList) {
                    $VMSizeInput = [PSCustomObject]@{'Name' = $_.Name;'Number' = $VMSizeNumber; `
                        'MaxDisks' = $_.MaxDataDiskCount;'OSDiskSize' = $_.OSDiskSizeInMB; `
                    'RSDiskSize' = $_.ResourceDiskSizeInMB}            # Creates the item to loaded into array
                    $ValidVMSize.Add($VMSizeInput) | Out-Null                                         # Loads item into array, out-null removes write to screen
                    $VMSizeNumber = $VMSizeNumber + 1
                }
                if ($ValidVMSize.Count -eq 0) {
                    Write-Host "No VM sizes match the listed specs"
                    Break SetAzureVMName
                }
                foreach ($_ in $ValidVMSize) {
                    Write-Host "["$_.Number"]" $_.Name "MaxDisks:"$_.MaxDisks "OS disk size:"$_.OSDiskSize "Resource Disk size:"$_.RSDiskSize
                }
                $VMSizeCount = Read-Host "Enter the list number for VM size"
                if ($VMSizeCount -eq '0') {
                    Break GetAzureDiskSize
                }
                elseif ($VMSizeCount -in $ValidVMSize.Number) {
                    $VMSizeCount = $ValidVMSize | Where-Object {$_.Number -eq $VMSizeCount}
                    $VMSizeObject = Get-AzVMSize -Location $LocationObject.DisplayName | Where-Object {$_.Name -eq $VMSizeCount.Name}
                    
                    if ($VMSizeObject) {
                        Return $VMSizeObject
                    }
                }
                else {
                    Write-Host "That was not a valid option"
                } # End else
            } # End :SetAzureVMName while ($true)
        } # End outer loop
        Return
    } # End Begin
} # End Function
