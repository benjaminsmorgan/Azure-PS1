function GetAzContainerGroup {
    Begin {
        :GetAzureContainerGroup while ($true) {
            $ContainerList = Get-AzContainerGroup
            $ContainerListNumber = 1
            [System.Collections.ArrayList]$ContainerArray = @()                             # Creates the array used for selection
            foreach ($_ in $ContainerList) {                                                     # For each item in $ContainerList
                $ArrayInput = [PSCustomObject]@{                                            # Creates the array input
                    'Number' = $ContainerListNumber; 'Name' = $_.Name; 'RG' = `
                        $_.ResourceGroupName                                                # Adds items to the array input
                }                                                                           # End $ArrayInput = [PSCustomObject]
                $ContainerArray.Add($ArrayInput) | Out-Null                                 # Adds the array input to array
                $ContainerListNumber = $ContainerListNumber + 1                                       # Increments $ContainerListNumber by 1
            }                                                                               # End foreach ($_ in $ContainerList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ContainerArray) {
                Write-Host $_.Number
                Write-Host $_.name
                Write-Host $_.RG
            }
            :SelectAzureContainer while ($true) {                                                # Inner loop for selecting the Container
                $ContainerSelect = Read-Host 'Container selection number'                             # Operator input for the Container selection
                if ($ContainerSelect -eq '0') {                                                  # If $ContainerSelect equals 0
                    Break GetAzureContainerGroup                                                      # Breaks :GetAzureContainer
                }                                                                           # End if ($ContainerSelect -eq '0')
                elseif ($ContainerSelect -in $ContainerArray.Number) {                                # If $ContainerSelect is in $ContainerArray.Number
                    $ContainerSelect = $ContainerArray | Where-Object {$_.Number -eq $ContainerSelect}     # $ContainerSelect is equal to the array item where $ContainerSelect equals the array number
                    $ContainerObject = Get-AzContainerGroup -ResourceGroupName `
                        $ContainerSelect.RG -Name $ContainerSelect.name      # Pulls the full ContainerObject
                    if ($ContainerObject) {                                                      # If the Container object is pulled
                        Return $ContainerObject                                                  # Return to calling function with $ContainerObject
                    }                                                                       # End if ($ContainerObject)
                    else {                                                                  # If the Container object not pulled
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureContainer                                                  # Breaks :GetAzureContainer
                    }                                                                       # End else (if ($ContainerObject))
                }                                                                           # End elseif ($ContainerSelect -in $ContainerArray.Number)
                else {                                                                      # If $ContainerSelect is not 0 or in the array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($ContainerSelect -eq '0') )
            }                                                                               # End :SelectAzureContainer while ($true)
        }
    }
}
function RemoveAzContainerGroup {
    Begin{
        :RemoveAzureContainerGroup while ($true) {
            if (!$ContainerObject) {
                $ContainerObject = GetAzContainerGroup
                if (!$ContainerObject) {
                    Break RemoveAzureContainerGroup
                }
            }
            Write-Host 'Remove container ' $ContainerObject.name
            $OperatorConfirm = Read-Host '[Y] or [N]'
            if ($OperatorConfirm -eq 'y') {
                Remove-AzContainerGroup -ResourceGroupName $ContainerObject.ResourceGroupName -Name $ContainerObject.Name 
            }
            else {
                Break RemoveAzContainerGroup
            }
        }
    }
}