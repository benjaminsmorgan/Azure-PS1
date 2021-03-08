function GetAzVmSS {                                                                        # Function to get a Vmss
    Begin {                                                                                 # Begin function
        :GetAzureVmss while ($true) {                                                       # Outer loop for managing function
            $VmssList = Get-AzVmss                                                          # Gets a list of all Vmss's
            $VmssListNumber = 1                                                             # Creates the array selection number
            [System.Collections.ArrayList]$VmssArray = @()                                   # Creates the array used for selection
            foreach ($_ in $VmssList) {                                                     # For each item in $VmssList
                $ArrayInput = [PSCustomObject]@{                                            # Creates the array input
                    'Number' = $VmssListNumber; 'Name' = $_.Name; 'RG' = `
                        $_.ResourceGroupName; 'Loc' = $_.Location; 'Sku' = $_.Sku.Name; `
                        'Cap' = $_.Sku.Capacity                                             # Adds items to the array input
                }                                                                           # End $ArrayInput = [PSCustomObject]
                $VmssArray.Add($ArrayInput) | Out-Null                                      # Adds the array input to array
                $VmssListNumber = $VmssListNumber + 1                                       # Increments $VmssListNumber by 1
            }                                                                               # End foreach ($_ in $VmssList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Foreach ($_ in $VmssArray) {
                Write-Host "["$_.Number']'                                                  # Write message to screen
                Write-Host 'Name: '$_.Name                                                  # Write message to screen
                Write-Host 'RG:   '$_.RG                                                    # Write message to screen
                Write-Host 'Loc:  '$_.Loc                                                   # Write message to screen
                Write-Host 'Sku:  '$_.Sku                                                   # Write message to screen
                Write-Host 'Cap:  '$_.Cap                                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End Foreach ($_ in $VmssArray)
            :SelectAzureVmss while ($true) {                                                # Inner loop for selecting the Vmss
                $VmssSelect = Read-Host 'Vmss selection number'                             # Operator input for the vmss selection
                if ($VmssSelect -eq '0') {                                                  # If $VmssSelect equals 0
                    Break GetAzureVmss                                                      # Breaks :GetAzureVMSS
                }                                                                           # End if ($VmssSelect -eq '0')
                elseif ($VmssSelect -in $VmssArray.Number) {                                # If $VmssSelect is in $VmssArray.Number
                    $VmssSelect = $VmssArray | Where-Object {$_.Number -eq $VmssSelect}     # $VmssSelect is equal to the array item where $VmssSelect equals the array number
                    $VmssObject = Get-AzVmss -ResourceGroupName `
                        $VmssSelect.ResourceGroupName -VMScaleSetName $VmssSelect.name      # Pulls the full VmssObject
                    if ($VmssObject) {                                                      # If the vmss object is pulled
                        Return $VmssObject                                                  # Return to calling function with $VmssObject
                    }                                                                       # End if ($VmssObject)
                    else {                                                                  # If the vmss object not pulled
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVmss                                                  # Breaks :GetAzureVmss
                    }                                                                       # End else (if ($VmssObject))
                }                                                                           # End elseif ($VmssSelect -in $VmssArray.Number)
                else {                                                                      # If $VmssSelect is not 0 or in the array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($VmssSelect -eq '0') )
            }                                                                               # End :SelectAzureVmss while ($true)
        }                                                                                   # End :GetAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVmSS
function RemoveAzVmss {
    Begin {
        :RemoveAzureVmss while ($true) {
            if (!$VmssObject) {
                $VmssObject = GetAzVmSS
                if (!$VmssObject) {
                    Break RemoveAzureVmss                                                   # Breaks :RemoveAzureVmss
                }                                                                           # End if (!$VmssObject)
            }                                                                               # End if (!$VmssObject)
            Write-Host 'Remove' $VmssObject.name                                            # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation for deletion
            if (!($OperatorConfirm -eq 'y')) {                                              # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureVmss                                                       # Breaks :RemoveAzureVmss
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            else {
                Try {                                                                       # Try the following
                    Remove-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                        -VMScaleSetName $VmssObject.name -Force                             # Removes the VMSS
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the required permissions'                  # Write message to screen
                }                                                                           # End catch
                Break RemoveAzureVmss                                                       # Breaks :RemoveAzureVmss
            }                                                                               # End else (if (!($OperatorConfirm -eq 'y')))
        }                                                                                   # End :RemoveAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVmss