# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancer:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0  
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzLoadBalancer:         Lists all existing load balancers
} #>
<# Variables: {      
    :ListAzureLoadBalancer      Outer loop for managing function
    $LoadBalancerList:          List of all load balancers
    $PubIPID:                   $var used to hold the current item .FrontendIpConfigurations.publicIPaddress.id 
    $PublicIPObject:            An attached public IP sku
    $LoadBalancerArray:         Array used for the selection of the load balancer
    $LoadBalancerInput:         $var used to load items into $LoadBalancerArray
} #>
<# Process Flow {
    function
        Call ListAzLoadBalancer > Get $null    
        End ListAzLoadBalancer
            Return function > Send $null
}#>
function ListAzLoadBalancer {                                                               # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :ListAzureLoadBalancer while ($true) {                                              # Outer loop to manage function
            $LoadBalancerList = Get-AzLoadBalancer                                          # Generates the load balancer list
            [System.Collections.ArrayList]$LoadBalancerArray = @()                          # Creates the load balancer array
            foreach ($_ in $LoadBalancerList) {                                             # For each item in $LoadBalancerList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id  has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                $LoadBalancerInput = [PSCustomObject]@{'Name'= $_.Name;'RGName'=`
                    $_.ResourceGroupName;'Loc'=$_.Location;'Sku'=$_.Sku.Name;`
                    'PubAllocation'=$PublicIPObject.PublicIpAllocationMethod;`
                    'PubAddress'=$PublicIPObject.IpAddress;'Pubname'=`
                    $PublicIPObject.Name}                                                   # Creates the item to loaded into array
                $LoadBalancerArray.Add($LoadBalancerInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                $PubIPID = $null                                                            # Clears $var
                $PublicIPObject = $null                                                     # Clears $var
            }                                                                               # End foreach ($_ in $LoadBalancerList)
            foreach ($_ in $LoadBalancerArray) {                                            # For each $_ in $LoadBalancerArray
                Write-Host 'Balancer name: '$_.Name                                         # Write message to screen
                Write-Host 'Balancer loc:  '$_.loc                                          # Write message to screen
                Write-Host 'Balancer RG:   '$_.RGName                                       # Write message to screen
                Write-Host 'Balancer sku:  '$_.Sku                                          # Write message to screen
                if ($_.Pubname) {                                                           # If $_.Pubname exists
                    Write-Host 'Public IP name:'$_.Pubname                                  # Write message to screen
                    Write-Host 'Public IP add: '$_.PubAddress                               # Write message to screen
                    Write-Host 'Public IP allo:'$_.PubAllocation                            # Write message to screen
                }                                                                           # End if ($_.Pubname)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $LoadBalancerArray)
            Break ListAzureLoadBalancer                                                     # Breaks :ListAzureLoadBalancer
        }                                                                                   # End :ListAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLoadBalancer    