# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancer:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0  
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzLoadBalancer:          Gets and existing load balancer
} #>
<# Variables: {      
    :GetAzureLoadBalancer       Outer loop for managing function
    :SelectAzureLoadBalancer    Inner loop for selecting the load balancer
    $LoadBalancerList:          List of all load balancers
    $LoadBalancerNumber:        List number used in array
    $LoadBalancerArray:         Array used for the selection of the load balancer
    $LoadBalancerInput:         $var used to load items into $LoadBalancerArray
    $OperatorSelect:            Operator input for selecting the load balancer
    $LoadBalancerObject:        Load balancer object   
} #>
<# Process Flow {
    function
        Call GetAzLoadBalancer > Get $LoadBalancerObject    
        End GetAzLoadBalancer
            Return function > Send $LoadBalancerObject
}#>
function GetAzLoadBalancer {                                                        # Function to get an existing load balancer
    Begin {                                                                         # Begin function
        :GetAzureLoadBalancer while ($true) {                                       # Outer loop to manage function
            $LoadBalancerList = Get-AzLoadBalancer                                  # Generates the load balancer list
            $LoadBalancerNumber = 1                                                 # Sets $LoadBalancerNumber to 1
            [System.Collections.ArrayList]$LoadBalancerArray = @()                  # Creates the load balancer array
            foreach ($_ in $LoadBalancerList) {                                     # For each $Offer in $LoadBalancerList
                $LoadBalancerInput = [PSCustomObject]@{'Name' = $_.Name; `
                    'Number' = $LoadBalancerNumber;'RGName'=$_.ResourceGroupName}   # Creates the item to loaded into array
                $LoadBalancerArray.Add($LoadBalancerInput) | Out-Null               # Loads item into array, out-null removes write to screen
                $LoadBalancerNumber = $LoadBalancerNumber + 1                       # Increments $LoadBalancerNumber by 1
            }                                                                       # End foreach ($_ in $LoadBalancerList)
            Write-Host "0 Exit"                                                     # Write message to screen
            Write-Host ""                                                           # Write message to screen
            foreach ($_ in $LoadBalancerArray) {                                    # For each $_ in $LoadBalancerArray
                Write-Host $_.Number                                                # Write message to screen
                Write-Host $_.Name                                                  # Write message to screen
                Write-Host $_.RGName                                                # Write message to screen
                Write-Host ""                                                       # Write message to screen
            }                                                                       # End foreach ($_ in $LoadBalancerArray)
            :SelectAzureLoadBalancer while ($true) {                                # Inner loop to select the load balancer
                $OperatorSelect = Read-Host "Enter the load balancer number"        # Operator input for the load balancer selection
                if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals 0
                    Break GetAzureLoadBalancer                                      # Breaks :GetAzureLoadBalancer
                }                                                                   # End if ($OperatorSelect -eq '0')
                $LoadBalancerObject = $LoadBalancerArray | Where-Object `
                    {$_.Number -eq $OperatorSelect}                                 # $LoadBalancerObject is equal to $LoadBalancerArray where $LoadBalancerArray.Number equals $OperatorSelect
                if ($LoadBalancerObject) {                                          # If $LoadBalancerObject has a value
                    $LoadBalancerObject = Get-AzLoadBalancer -Name `
                        $LoadBalancerObject.Name -ResourceGroupName `
                        $LoadBalancerObject.RGName                                  # Repulls the full load balancer object
                    Return $LoadBalancerObject                                      # Returns to calling function with $LoadBalancerObject
                }                                                                   # End if ($LoadBalancerObject)
                else {                                                              # If $LoadBalancerObject does not have a value
                    Write-Host "That was not a valid option"                        # Write message to screen
                }                                                                   # End else (if ($LoadBalancerObject))
            }                                                                       # End :SelectAzureLoadBalancer while ($true)
        }                                                                           # End :GetAzureLoadBalancer while ($true)
        Return                                                                      # Returns to calling function with $null
    }                                                                               # End Begin
}                                                                                   # End function GetAzLoadBalancer