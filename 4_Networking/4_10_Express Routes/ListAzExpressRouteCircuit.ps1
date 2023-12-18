function ListAzExpressRouteCircuit {                                                        # Function to list all express routes
    Begin {                                                                                 # Begin function
        :ListAzureExpressRouteCircuit while ($true) {                                       # Outer loop for managing function
            $EXList = Get-AzExpressRouteCircuit                                             # Gets a list of all virtual networks
            if (!$EXList) {                                                                 # If $EXList is $null
                Write-Host 'No express routes in this subscription'                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureExpressRouteCircuit                                          # Breaks ListAzureExpressRouteCircuit
            }                                                                               # End if (!$EXList)
            foreach ($_ in $EXList) {                                                       # For each item in $EXList
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Name:       '$_.Name                                            # Write message to screen
                Write-Host 'RG:         '$_.ResourceGroupName                               # Write message to screen
                Write-Host 'Loc:        '$_.Location                                        # Write message to screen
                Write-Host 'Circuit PS: '$_.CircuitProvisioningState                        # Write message to screen
                Write-Host 'SVC Pro PS: '$_.ServiceProviderProvisioningState                # Write message to screen
                Write-Host 'PS:         '$_.ProvisioningState                               # Write message to screen
                Write-Host 'Glo Reach:  '$_.GlobalReachEnabled                              # Write message to screen
                Write-Host 'SKU Name:   '$_.Sku.Name                                        # Write message to screen
                Write-Host 'SKU Tier:   '$_.Sku.Tier                                        # Write message to screen
                Write-Host 'SKU Family: '$_.Sku.Family                                      # Write message to screen
                Write-Host 'Band Mbps:  '$_.ServiceProviderProperties.BandwidthInMbps       # Write message to screen
            }                                                                               # End foreach ($_ in $EXList)
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureExpressRouteCircuit                                              # Breaks ListAzureExpressRouteCircuit
        }                                                                                   # End :ListAzureExpressRouteCircuit while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzExpressRouteCircuit