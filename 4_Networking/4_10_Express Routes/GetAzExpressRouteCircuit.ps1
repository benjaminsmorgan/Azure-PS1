function GetAzExpressRouteCircuit {                                                         # Function for getting an Azure express route
    Begin {                                                                                 # Begin function
        :GetAzureExpressRouteCircuit while ($true) {                                        # Outer loop for managing function
            $ObjectList = Get-AzExpressRouteCircuit                                         # pulls all items into list for selection
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No express routes in this subscription'                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureExpressRouteCircuit                                           # Breaks :GetAzureExpressRouteCircuit
            }                                                                               # End if (!$ObjectList)
            $ListNumber = 1                                                                 # $var used for selecting the virtual network
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $RGListList
                $ArrayInput = [PSCustomObject]@{                                            # Creates $ArrayInput
                    'Number'= $ListNumber;                                                  # Adds item to $ArrayInput
                    'Name'= $_.Name;                                                        # Adds item to $ArrayInput
                    'ResourceGroupName'= $_.ResourceGroupName;                              # Adds item to $ArrayInput
                    'Location' = $_.Location;                                               # Adds item to $ArrayInput
                    'CircuitProvisioningState'= $_.CircuitProvisioningState;                # Adds item to $ArrayInput
                    'ServiceProviderProvisioningState'= $_.ServiceProviderProvisioningState;# Adds item to $ArrayInput
                    'ProvisioningState'= $_.ProvisioningState;                              # Adds item to $ArrayInput
                    'GlobalReachEnabled'=  $_.GlobalReachEnabled;                           # Adds item to $ArrayInput
                    'SkuName'=   $_.Sku.Name;                                               # Adds item to $ArrayInput
                    'SkuTier'=   $_.Sku.Tier;                                               # Adds item to $ArrayInput
                    'SkuFamily'= $_.Sku.Family;                                             # Adds item to $ArrayInput
                    'BandwidthInMbps'=  $_.ServiceProviderProperties.BandwidthInMbps;       # Adds item to $ArrayInput
                }                                                                           # Creates the item to loaded into array
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            :SelectAzureER while ($true) {                                                  # Inner loop for selecting the Express Route
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]     "$_.Name                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Loc:        '$_.Location                                    # Write message to screen
                    Write-Host 'Circuit PS: '$_.CircuitProvisioningState                    # Write message to screen
                    Write-Host 'SVC Pro PS: '$_.ServiceProviderProvisioningState            # Write message to screen
                    Write-Host 'PS:         '$_.ProvisioningState                           # Write message to screen
                    Write-Host 'Glo Reach:  '$_.GlobalReachEnabled                          # Write message to screen
                    Write-Host 'SKU Name:   '$_.SkuName                                     # Write message to screen
                    Write-Host 'SKU Tier:   '$_.SkuTier                                     # Write message to screen
                    Write-Host 'SKU Family: '$_.SkuFamily                                   # Write message to screen
                    Write-Host 'Band Mbps:  '$_.BandwidthInMbps                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $Array)    
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'Selecting the express route for:'$CallingFunction           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the VNet selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureER                                                        # Breaks :GetAzureVNet
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $ExRouteObject = Get-AzExpressRouteCircuit -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.ResourceGroupName                      # Pulls the full object and assigns to $var
                        Return $ExRouteObject                                               # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureER while ($true)
        }                                                                                   # End :GetAzureExpressRouteCircuit while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzExpressRouteCircuit