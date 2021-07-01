# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzLBProbeConfig:        Function to list all load balancer probe configs
} #>
<# Variables: {      
    :ListAzureLBProbeConfig     Outer loop for managing function
    $ObjectList:                List of all load balanacers
    $ObjectArray:               Array used to hold item info
    $LBObject:                  Current load balancer
    $ProbeConfigList:           List of all probes on $LBObject
    $ObjectInput:               $var used to load info into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzLBProbeConfig > Get $null
        End ListAzLBProbeConfig
            Return function > Send $null
}#>
function ListAzLBProbeConfig {                                                              # Function to list all load balancer probe configs
    Begin {                                                                                 # Begin function
        :ListAzureLBProbeConfig while ($true) {                                             # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBProbeConfig                                                 # Breaks ListAzureLBProbeConfig
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $ProbeConfigList = Get-AzLoadBalancerProbeConfig -LoadBalancer $_           # Gets a list of all probes on $LBObject
                foreach ($_ in $ProbeConfigList) {                                          # For each item in $ProbeConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Probe protocol
                        'Port'=$_.Port;                                                     # Probe port
                        'Int'=$_.IntervalInSeconds;                                         # Probe interval
                        'Count'=$_.NumberOfProbes;                                          # Probe count
                        'RPath'=$_.RequestPath;                                             # Request path
                        'Rule'=$_.LoadBalancingRules.ID                                     # Probe rules if any
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                }                                                                           # End foreach ($_ in $ProbeConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer probe configs exist in this subscription'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBProbeConfig                                                # Breaks :ListAzureLBProbeConfig
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Probe Name:    '$_.Name                                         # Write message to screen
                Write-Host 'LB Name:       '$_.LBName                                       # Write message to screen
                Write-Host 'LB RG:         '$_.RGName                                       # Write message to screen
                Write-Host 'Probe Protocol:'$_.Proto                                        # Write message to screen
                Write-Host 'Probe Port:    '$_.Port                                         # Write message to screen
                Write-Host 'Probe Interval:'$_.Int                                          # Write message to screen
                Write-Host 'Probe Count:   '$_.Count                                        # Write message to screen
                if ($_.RPath) {                                                             # If current item .RPath has a value
                    Write-Host 'Probe RPath:   '$_.Rpath                                    # Write message to screen
                }                                                                           # End if ($_.RPath)
                else {                                                                      # Else if current item .RPath does not have value
                    Write-Host 'Probe RPath:    N/A'                                        # Write message to screen         
                }                                                                           # End else (if ($_.RPath))
                Write-Host 'Rule count:    '$_.Rule.Count                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen         
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBProbeConfig                                                    # Breaks :ListAzureLBProbeConfig
        }                                                                                   # End :ListAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBProbeConfig