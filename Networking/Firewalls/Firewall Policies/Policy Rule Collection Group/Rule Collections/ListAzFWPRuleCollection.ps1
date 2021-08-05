# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicyrulecollectiongroup?view=azps-6.2.1
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzFWPRuleCollection:    Function to list firewall policy rule collections 
} #>
<# Variables: {      
    :ListAzureFWPRuleCol        Outer loop for managing function
    $ObjectList:                List of all firewall polices
    $ObjectArray:               Array holding object info
    $FWPolicy:                  Firewall policy object
    $FirewallObject:            Firewall object
    $RuleCollectGroups:         $FWPolicy.RuleCollectionGroups     
    $RCGName:                   Current item rule collection group name
    $FWPolicyRCG:               Rule collection group
    $ObjectInput:               $var used to load items into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzFWPRuleCollection > Get $null           
        End ListAzFWPRuleCollection
            Return function > Send $null  
}#>
function ListAzFWPRuleCollection {                                                          # Function to list firewall policy rule collections 
    Begin {                                                                                 # Begin function
        :ListAzureFWPRuleCol while ($true) {                                                # Outer loop for managing function
            Write-Host 'Gathering firewall policy rule collections'                         # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPRuleCol                                                   # Breaks :ListAzureFWPRuleCol
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $FWPolicy = Get-AzFirewallPolicy -ResourceId $_.ResourceID                  # Pulls the full firewall policy
                $FirewallObject = Get-AzFirewall | Where-Object `
                    {$_.FirewallPolicy.ID -eq $FWPolicy.ID}                                 # Pulls the firewall object if attached
                $RuleCollectGroups = $FWPolicy.RuleCollectionGroups                         # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $FWPolicyRCG = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicy.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicy.Name                             # Gets the current item rule collection group object
                    foreach ($RuleC in $FWPolicyRCG.Properties.RuleCollection) {            # For each item $FWPolicyRCG.Properties.RuleCollection
                        $ObjectInput = [PSCustomObject]@{                                   # custom object to add info to $ObjectArray
                            'Number'=$ObjectNumber;                                         # Object number
                            'Name'=$RuleC.name;                                             # Rule collection name
                            'Priority'=$RuleC.Priority;                                     # Rule collection priority
                            'RuleNames'=$RuleC.Rules.Name;                                  # Rule names
                            'RuleCount'=$RuleC.Rules.Count;                                 # Rule collection rules count
                            'RCGName'=$FWPolicyRCG.Name;                                    # Policy RCG name
                            'RCGPriority'=$FWPolicyRCG.Properties.Priority;                 # Policy RCG priority
                            'PolicyName'=$FWPolicy.Name;                                    # Policy name
                            'RG'=$FWPolicy.ResourceGroupName;                               # Policy resource group name
                            'Location'=$FWPolicy.Location;                                  # Policy location
                            'FWName'=$FirewallObject.Name;                                  # Firewall name
                        }                                                                   # End $ObjectInput = [PSCustomObject]@
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Adds $ObjectInput to $ObjectArray
                        $ObjectNumber = $ObjectNumber + 1                                   # Increments $ObjectNumber up by 1
                    }                                                                       # End foreach ($RuleC in $FWPolicyRCG.Properties.RuleCollection)
                    $RCGName = $null                                                        # Clears $var
                    $FWPolicyRCG = $null                                                    # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No firewall policy rule collections exist'                      # Write messag to screen
                Write-Host ''                                                               # Write messag to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPRuleCol                                                   # Breaks :ListAzureFWPRuleCol
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Collection Name:       '$_.Name                                 # Write message to screen
                Write-Host 'Collection Priority:   '$_.Priority                             # Write message to screen
                Write-Host 'Collection Rule Count: '$_.RuleCount                            # Write message to screen
                Write-Host 'Collection Rule Names {'                                        # Write message to screen
                foreach ($RuleC in $_.RuleNames) {                                          # For each item in current item .RuleNames
                    Write-Host '                       '$RuleC                              # Write message to screen
                }                                                                           # End foreach ($RuleC in $_.RuleNames)
                Write-Host '                      }'                                        # Write message to screen
                Write-Host 'RCG Name:              '$_.RCGName                              # Write message to screen
                Write-Host 'RCG Priority:          '$_.RCGPriority                          # Write message to screen
                Write-Host 'Policy Name:           '$_.PolicyName                           # Write message to screen
                Write-Host 'Policy RG:             '$_.RG                                   # Write message to screen
                Write-Host 'Policy Loc:            '$_.Location                             # Write message to screen
                if ($_.FWName) {                                                            # If current item .FWName has a value
                    Write-Host 'Firewall Name:         '$_.FWName                           # Write message to screen
                }                                                                           # End if ($_.FWName) 
                else {                                                                      # Else if current item .FWName is $null
                    Write-Host 'Firewall Name:          Not Assigned'                       # Write message to screen
                }                                                                           # End else (if ($_.FWName))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
        Pause                                                                               # Pauses all actions for operator input
        Break ListAzureFWPRuleCol                                                           # Breaks :ListAzureFWPRuleCol
        }                                                                                   # End :ListAzureFWPRuleCol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzFWPRuleCollection