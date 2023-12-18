function ListAzExpressRouteCircuitARPTable {                                                # Function to list an express route ARP table
    Begin {                                                                                 # Begin function
        $CallingFunction = "ListAzExpressRouteCircuitARPTable"                              # Creates function
        :ListAzureExpressRouteCircuit while ($true) {                                       # Outer loop for managing function
            $ExRouteObject = GetAzExpressRouteCircuit ($CallingFunction)                    # Calls function and assigns output to $var
            if(!$ExRouteObject) {                                                           # If $ExRouteObject is $null
                Break ListAzureExpressRouteCircuit                                          # Breaks :ListAzureExpressRouteCircuit
            }                                                                               # End if(!$ExRouteObject)                                                             
            Write-Host 'Gathering the requested info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ExRouteArpPri = Get-AzExpressRouteCircuitARPTable -ResourceGroupName `
                $ExRouteObject.ResourceGroupName -ExpressRouteCircuitName `
                $ExRouteObject.Name -PeeringType $ExRouteObject.Peerings.PeeringType `
                -DevicePath Primary                                                         # Creates $ExRouteArpPri
            $ExRouteArpSec = Get-AzExpressRouteCircuitARPTable -ResourceGroupName `
                $ExRouteObject.ResourceGroupName -ExpressRouteCircuitName `
                $ExRouteObject.Name -PeeringType $ExRouteObject.Peerings.PeeringType `
                -DevicePath Secondary                                                       # Creates $ExRouteArpSec
            $EXRouteObjectMbps = $ExRouteObject.ServiceProviderProperties.BandwidthInMbps   # Isolates selected express route speed in Mbps
            Clear-Host                                                                      # Clears screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Name:       '$ExRouteObject.Name                                    # Write message to screen
            Write-Host 'RG:         '$ExRouteObject.ResourceGroupName                       # Write message to screen
            Write-Host 'Loc:        '$ExRouteObject.Location                                # Write message to screen
            Write-Host 'Circuit PS: '$ExRouteObject.CircuitProvisioningState                # Write message to screen
            Write-Host 'SVC Pro PS: '$ExRouteObject.ServiceProviderProvisioningState        # Write message to screen
            Write-Host 'PS:         '$ExRouteObject.ProvisioningState                       # Write message to screen
            Write-Host 'Glo Reach:  '$ExRouteObject.GlobalReachEnabled                      # Write message to screen
            Write-Host 'SKU Name:   '$ExRouteObject.Sku.Name                                # Write message to screen
            Write-Host 'SKU Tier:   '$ExRouteObject.Sku.Tier                                # Write message to screen
            Write-Host 'SKU Family: '$ExRouteObject.Sku.Family                              # Write message to screen
            Write-Host 'Band Mbps:  '$ExRouteObjectMbps                                     # Write message to screen
            Write-Host 'Primary'                                                            # Write message to screen
            Write-Host '    Age:         '$ExRouteArpPri.Age                                # Write message to screen
            Write-Host '    Interface:   '$ExRouteArpPri.InterfaceProperty                  # Write message to screen
            Write-Host '    IP Address:  '$ExRouteArpPri.IpAddress                          # Write message to screen
            Write-Host '    MAC Address: '$ExRouteArpPri.MacAddress                         # Write message to screen        
            Write-Host 'Secondary'                                                          # Write message to screen
            Write-Host '    Age:         '$ExRouteArpSec.Age                                # Write message to screen
            Write-Host '    Interface:   '$ExRouteArpSec.InterfaceProperty                  # Write message to screen
            Write-Host '    IP Address:  '$ExRouteArpSec.IpAddress                          # Write message to screen
            Write-Host '    MAC Address: '$ExRouteArpSec.MacAddress                         # Write message to screen        
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureExpressRouteCircuit                                              # Breaks ListAzureExpressRouteCircuit
        }                                                                                   # End :ListAzureExpressRouteCircuit while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzExpressRouteCircuitARPTable