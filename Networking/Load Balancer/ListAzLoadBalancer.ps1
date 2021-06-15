# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0  
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzLoadBalancer:         Lists all existing load balancers
} #>
<# Variables: {      
    :ListAzureLoadBalancer      Outer loop for managing function
    $ObjectList:                List of all load balancers
    $ObjectArray:               Array used for the selection of the load balancer
    $PubIPID:                   Attached public IP sku ID
    $PublicIPObject:            Attached public IP object
    $ObjectInput:               $var used to load items into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzLoadBalancer > Get $null    
        End ListAzLoadBalancer
            Return function > Send $null
}#>
function ListAzLoadBalancer {                                                               # Function to list all existing load balancers
    Begin {                                                                                 # Begin function
        :ListAzureLoadBalancer while ($true) {                                              # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLoadBalancer                                                 # Breaks :ListAzureLoadBalancer
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id  has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Name'= $_.Name;'RG'=$_.ResourceGroupName;'Loc'=$_.Location;`
                    'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;'PubAddress'=`
                    $PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name                # Creates the item to loaded into array
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'LB name:       '$_.Name                                         # Write message to screen
                Write-Host 'LB loc:        '$_.loc                                          # Write message to screen
                Write-Host 'LB RG:         '$_.RG                                           # Write message to screen
                Write-Host 'LB SKU:        '$_.Sku                                          # Write message to screen
                if ($_.Pubname) {                                                           # If $_.Pubname exists
                    Write-Host 'Pub IP name:   '$_.Pubname                                  # Write message to screen
                    Write-Host 'Pub IP address:'$_.PubAddress                               # Write message to screen
                    Write-Host 'Pub IP allocat:'$_.PubAllocation                            # Write message to screen
                }                                                                           # End if ($_.Pubname)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $LoadBalancerArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLoadBalancer                                                     # Breaks :ListAzureLoadBalancer
        }                                                                                   # End :ListAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLoadBalancer    