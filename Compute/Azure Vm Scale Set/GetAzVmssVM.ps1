
function GetAzVmssVM {                                                                      # Function for getting a vmss instance
    Begin {
        :GetAzureVmssVM while ($true) {                                                     #
            if (!$VmssObject) {                                                             #
                $VmssObject = GetAzVmss                                                     #
                if (!$VmssObject) {                                                         #
                    Break GetAzureVmssVM                                                    #
                }                                                                           # End if (!$VmssObject)
            }                                                                               # End if (!$VmssObject)
            $VmssVMList = Get-AzVmssVM -ResourceGroupName $VmssObject.ResourceGroupName `
                -VMScaleSetName $VmssObject.name                                            # Collects all instances and assigns to $var
            $ListNumber = 1                                                                 #
            [System.Collections.ArrayList]$VmssVMArray = @()                                #
            foreach ($_ in $VmssVMList) {                                                   #
                $VmssVMStatus = Get-AzVmssVM -ResourceGroupName `
                    $VmssObject.ResourceGroupName -VMScaleSetName $VmssObject.name `
                    -InstanceId $_.InstanceId -InstanceView                                 #
                $VmssVMStatus = ($VmssVMStatus.Statuses.Code).Split('/')[-1]                #
                $ArrayInput = [PSCustomObject]@{
                    'Number' = $ListNumber; 'Instance' = $_.InstanceID; `
                    'State' = $VmssVMStatus                                                 #
                }                                                                           #
                $VmssVMArray.Add($ArrayInput) | Out-Null                                    #
                $ListNumber = $ListNumber + 1                                               #
            }                                                                               # End foreach ($_ in $VmssVMList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen 
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $VmssVMArray) {
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'InstanceID: '$_.Instance                                        # Write message to screen
                Write-Host 'State:      '$_.State                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VmssVMArray)
            :SelectAzureVmssVM while ($true) {
                $OperatorSelect = Read-Host 'Enter the [ # ] of the Vmss VM instance'       #
                if ($OperatorSelect -eq '0') {
                    Break GetAzureVmssVM
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $VmssVMArray.Number) {
                    $OperatorSelect = $VmssVMArray | Where-Object `
                        {$_.Number -eq $OperatorSelect}                                     #
                    $VmssVMObject = Get-AzVmssVM -ResourceGroupName `
                        $VmssObject.ResourceGroupName -VMScaleSetName $VmssObject.Name `
                        -InstanceId $OperatorSelect.Instance
                    if ($VmssVMObject) {
                        Return $VmssVMObject, $VmssObject
                    }                                                                       # End if ($VmssVMObject) 
                    else {
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVmssVM
                    }                                                                       # End else (if ($VmssVMObject))
                }                                                                           # End elseif ($OperatorSelect -in $VmssVMArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid entry'                                 # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureVmssVM while ($true)
        }                                                                                   # End :GetAzureVmssVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVmssVM
function StartAzVmss {                                                                      # Function for starting vmss instances
    Begin {                                                                                 # Begin function
        :StartAzureVmssVM while ($true) {                                                   # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Start all instances in a Vmss'                                  # Write message to screen
            Write-Host '[2] Start a single instance in a Vmss'                              # Write message to screen
            $OperatorSelect = Read-Host 'Option [#]'                                        #
            if ($OperatorSelect -eq '0') {                                                  #
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              #
                if (!$VmssObject) {                                                         #
                    $VmssObject = GetAzVmss                                                 #
                    if (!$VmssObject) {                                                     #
                        Break StartAzureVmssVM                                              # Breaks :StartAzureVmssVM
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Start-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              #
                if (!$VmssObject) {                                                         #
                    $VmssVMObject, $VmssObject = GetAzVmssVM                                #
                    if (!$VmssVMObject) {                                                   #
                        Break StartAzureVmssVM                                              # Breaks :StartAzureVmssVM 
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Start-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name -InstanceId $VmssVMObject.InstanceId   #
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          #
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :StartAzureVmssVM while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVmss
function StopAzVmss {                                                                       # Function for Stoping vmss instances
    Begin {                                                                                 #
        :StopAzureVmssVM while ($true) {                                                    #
            Write-Host '[0] Exit'                                                           #
            Write-Host '[1] Stop all instances in a Vmss'                                   #
            Write-Host '[2] Stop a single instance in a Vmss'                               #
            $OperatorSelect = Read-Host 'Option [#]'                                        #
            if ($OperatorSelect -eq '0') {                                                  #

            } # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {
                if (!$VmssObject) {
                    $VmssObject = GetAzVmss
                    if (!$VmssObject) {
                        Break StopAzureVmssVM                                                  # Breaks :StopAzureVmssVM
                    }                                                                           # End if (!$VmssVMObject)
                }                                                                               # End if (!$VmssVMObject)
                Stop-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name
                Break StopAzureVmssVM                                                          # Breaks :StopAzureVmssVM
            } # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {
                if (!$VmssObject) {
                    $VmssVMObject, $VmssObject = GetAzVmssVM
                    if (!$VmssVMObject) {
                        Break StopAzureVmssVM                                                  # Breaks :StopAzureVmssVM 
                    }                                                                           # End if (!$VmssVMObject)
                }                                                                               # End if (!$VmssVMObject)
                Stop-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name -InstanceId $VmssVMObject.InstanceId
                Break StopAzureVmssVM                                                          # Breaks :StopAzureVmssVM
            } # End elseif ($OperatorSelect -eq '2')

            else {
                Write-Host 'That was not a valid option'
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
            
            Stop-azVmssVM
        }                                                                                   # End :StopAzureVmssVM while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVmss
function GetAzVmss {                                                                        # Function to get a Vmss
    Begin {                                                                                 # Begin function
        :GetAzureVmss while ($true) {                                                       # Outer loop for managing function
            $VmssList = Get-AzVmss                                                          # Gets a list of all Vmss's
            if (!$VmssList) {                                                               # If $VmssList is $null
                Write-Host '***No Vmss(s) exist***'                                         # Write message to screen
                Write-Host '***Returning to previous menu***'                               # Write message to screen
                Break GetAzureVmss                                                          # Breaks :GetAzureVmss
            }                                                                               # End if (!$VmssList)
            $VmssListNumber = 1                                                             # Creates the array selection number
            [System.Collections.ArrayList]$VmssArray = @()                                  # Creates the array used for selection
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
}                                                                                           # End function GetAzVmss