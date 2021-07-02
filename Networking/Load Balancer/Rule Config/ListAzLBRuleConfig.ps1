# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzLBRuleConfig:         Function to list all load balancer rule configs
} #>
<# Variables: {      
    :ListAzureLBRuleConfig      Outer loop for managing function
    $ObjectList:                List of all load balanacers
    $ObjectNumber:              $var used for selecting and listing items
    $ObjectArray:               Array used to hold item info
    $LBObject:                  Current load balancer
    $RuleConfigList:            List of all probes on $LBObject
    $ObjectInput:               $var used to load info into $ObjectArray
    $FEndName:                  Current item front end name if present
    $BPoolName:                 Current item back end name if present
    $ProbeName:                 Current item probe name if present
} #>
<# Process Flow {
    function
        Call ListAzLBRuleConfig > Get $null
        End ListAzLBRuleConfig
            Return function > Send $null
}#>
function ListAzLBRuleConfig {                                                               # Function to list all load balancer rule configs
    Begin {                                                                                 # Begin function
        :ListAzureLBRuleConfig while ($true) {                                              # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBRuleConfig                                                 # Breaks ListAzureLBRuleConfig
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $RuleConfigList = Get-AzLoadBalancerRuleConfig -LoadBalancer $_             # Gets a list of all rules on $LBObject
                foreach ($_ in $RuleConfigList) {                                           # For each item in $RuleConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Rule protocol
                        'FEPort'=$_.FrontendPort;                                           # Front end port
                        'BEPort'=$_.BackendPort;                                            # Back end port
                        'Idle'=$_.IdleTimeoutInMinutes;                                     # Idle timeout
                        'LD'=$_.LoadDistribution;                                           # Load distribution
                        'EFIP'=$_.EnableFloatingIP;                                         # Floating IP enabled
                        'FEIP'=$_.FrontendIPConfiguration.ID;                               # Front end ID
                        'BEPool'=$_.BackendAddressPool.ID;                                  # Back end pool ID
                        'Probe'=$_.Probe.ID                                                 # Probe ID
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                }                                                                           # End foreach ($_ in $RuleConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer rule configs exist in this subscription'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBRuleConfig                                                 # Breaks :ListAzureLBRuleConfig
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Rule Name:     '$_.Name                                         # Write message to screen
                Write-Host 'LB Name:       '$_.LBName                                       # Write message to screen
                Write-Host 'LB RG:         '$_.RGName                                       # Write message to screen
                Write-Host 'Rule Protocol: '$_.Proto                                        # Write message to screen
                Write-Host 'Front End Port:'$_.FEPort                                       # Write message to screen
                Write-Host 'Back End Port: '$_.BEPort                                       # Write message to screen
                Write-Host 'TO In Minutes: '$_.Idle                                         # Write message to screen
                Write-Host 'Load Distro:   '$_.LD                                           # Write message to screen
                Write-Host 'Floating IP:   '$_.EFIP                                         # Write message to screen
                if ($_.FEIP) {                                                              # If current item .FEIP has a value
                    $FEndName = $_.FEIP                                                     # Isolates the current item
                    $FEndName = $FEndName.Split('/')[-1]                                    # Isolates the front end name
                    Write-Host 'Front End Name:'$FEndName                                   # Write message to screen
                }                                                                           # End if ($_.FEIP)
                else {                                                                      # Else if current item .FEIP does not have value
                    Write-Host 'Front End Name: N/A'                                        # Write message to screen       
                }                                                                           # End else (if ($_.BEPool))
                if ($_.BEPool) {                                                            # If current item .BEPool has a value
                    $BPoolName = $_.BEPool                                                  # Isolates the current item
                    $BPoolName = $BPoolName.Split('/')[-1]                                  # Isolates the back end name
                    Write-Host 'Back End Name: '$BPoolName                                  # Write message to screen
                }                                                                           # End if ($_.BEPool)
                else {                                                                      # Else if current item .BEPool does not have value
                    Write-Host 'Back End Name:  N/A'                                        # Write message to screen       
                }                                                                           # End else (if ($_.BEPool))
                if ($_.Probe) {                                                             # If current item .Probe has a value
                    $ProbeName = $_.Probe                                                   # Isolates the current item
                    $ProbeName = $ProbeName.Split('/')[-1]                                  # Isolates the front end name
                    Write-Host 'Probe Name:    '$ProbeName                                  # Write message to screen
                }                                                                           # End if ($_.Probe)
                else {                                                                      # Else if current item .Probe does not have value
                    Write-Host 'Probe Name:     N/A'                                        # Write message to screen       
                }                                                                           # End else (if ($_.Probe))
                Write-Host ''                                                               # Write message to screen         
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBRuleConfig                                                     # Breaks :ListAzureLBRuleConfig
        }                                                                                   # End :ListAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBRuleConfig