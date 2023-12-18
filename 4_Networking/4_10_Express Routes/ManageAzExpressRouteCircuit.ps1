function ManageAzExpressRouteCircuit {                                                      # Function for managing azure express routes
    Begin {                                                                                 # Begin function
        :ManageAzureExpressRouteCircuit while($true) {                                      # Outer loop for managing function
            Write-Host 'Azure Express Route Management'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Express Route (Disbled)'                                    # Write message to screen
            Write-Host '[2] List Express Routes'                                            # Write message to screen
            Write-Host '[3] List Express Route ARP Table'                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the management option
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If OpSelect equals '0'
                Break ManageAzureExpressRouteCircuit                                         # End Break ManageAzureExpressRouteCircuit
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Express Route'                                              # Write message to screen
                #FunctionGoHere                                                             # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Express Routes'                                            # Write message to screen
                ListAzExpressRouteCircuit                                                   # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List Express Route ARP Table'                                   # Write message to screen
                ListAzExpressRouteCircuitARPTable                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureExpressRouteCircuit while($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzExpressRouteCircuit
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
# End ManageAzExpressRouteCircuit