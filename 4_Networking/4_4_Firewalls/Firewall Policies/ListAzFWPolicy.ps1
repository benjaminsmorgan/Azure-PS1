# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzFWPolicy:             Function to list all firewall policies
} #>
<# Variables: {      
    :ListAzureFWPolicy          Outer loop for managing function
    $ObjectList:                List of all resources with the type of 'Microsoft.Network/firewallPolicies'
    $ObjectArray:               Array used to collect and list firewall policy object
    $FWPolicy:                  Firewall matching current item .resourceID
    $FirewallObject:            Firewall object
    $RCGList:                   Array of firewall policy rule collection groups
    $RuleCollectGroups:         $FWPolicy.RuleCollectionGroups                        
    $RCGName:                   Current item .ID.Split('/')[-1]   
} #>
<# Process Flow {
    function
        Call ListAzFWPolicy > Get $null            
        End ListAzFWPolicy
            Return function > Send $null
}#>
function ListAzFWPolicy {                                                                   # Function to list all firewall policies
    Begin {                                                                                 # Begin function
        :ListAzureFWPolicy while ($true) {                                                  # Outer loop for managing function
            Write-Host 'Gathering firewall policies'                                        # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPolicy                                                     # Breaks :ListAzureFWPolicy
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $FWPolicy = Get-AzFirewallPolicy -ResourceId $_.ResourceID                  # Pulls the full firewall policy
                $FirewallObject = Get-AzFirewall | Where-Object `
                    {$_.FirewallPolicy.ID -eq $FWPolicy.ID}                                 # Pulls the firewall object if attached
                $RCGList = @()                                                              # Creates $RCGList
                $RuleCollectGroups = $FWPolicy.RuleCollectionGroups                         # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $RCGList += $RCGName                                                    # Adds $RCGName to $RCGList
                    $RCGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$FWPolicy.Name;                                                  # Policy name
                    'RG'=$FWPolicy.ResourceGroupName;                                       # Policy resource group name
                    'Location'=$FWPolicy.Location;                                          # Policy location
                    'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                            # Policy threat intel mode
                    'FWName'=$FirewallObject.Name;                                          # Firewall name
                    'RCGList'=$RCGList;                                                     # Rule collection group names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Policy Name:  '$_.Name                                          # Write message to screen
                if ($_.FWName) {                                                            # If current item .FWName has a value
                    Write-Host 'Firewall Name:'$_.FWName                                    # Write message to screen
                }                                                                           # End if ($_.FWName) 
                else {                                                                      # Else if current item .FWName is $null
                    Write-Host 'Firewall Name: Not Assigned'                                # Write message to screen
                }                                                                           # End else (if ($_.FWName))
                Write-Host 'Policy RG:    '$_.RG                                            # Write message to screen
                Write-Host 'Policy Loc:   '$_.Location                                      # Write message to screen
                Write-Host 'Policy TIM:   '$_.ThreatIntelMode                               # Write message to screen
                if ($_.RCGList) {                                                           # If current item .RCGList has a value
                    $RCGList = $_.RCGList                                                   # $RCGList is equal to current item.RCGList
                    Write-Host 'Policy RCG {'                                               # Write message to screen
                    foreach ($Name in $RCGList) {                                           # For each item in $RCGList
                        Write-Host '              '$Name                                    # Write message to screen
                    }                                                                       # End foreach ($Name in $RCGList)
                    Write-Host '           }'                                               # Write message to screen
                    $RCGList = $null                                                        # Clears $var
                }                                                                           # End if ($_.RCGList)
                else {                                                                      # Else if current item .RCGList is $null
                    Write-Host 'Policy RCG:    N/A'                                         # Write message to screen
                }                                                                           # End else (if ($_.RCGList))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Paues all actions for operator input
            Break ListAzureFWPolicy                                                         # Breaks :ListAzureFWPolicy
        }                                                                                   # End :ListAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzFWPolicy