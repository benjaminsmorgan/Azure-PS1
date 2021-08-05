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
    GetAzFWPRuleCollection:     Function to get firewall policy rule collection
} #>
<# Variables: {      
    :GetAzureFWPRuleCol         Outer loop for managing function
    :SelectAzureFWPRuleCol      Inner loop for selecting the firewall policy rule collection
    $ObjectList:                List of all firewall polices
    $ObjectArray:               Array holding object info
    $ObjectNumber:              $var used for listing and selecting objects
    $FWPolicy:                  Firewall policy object
    $FirewallObject:            Firewall object
    $RuleCollectGroups:         $FWPolicy.RuleCollectionGroups     
    $RCGName:                   Current item rule collection group name
    $FWPolicyRCG:               Rule collection group
    $ObjectInput:               $var used to load items into $ObjectArray
    $Number:                    Current item .number
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input to select the rule collection
    $FWPolicyRCGObject:         Firewall policy rule collection group object
    $FWPolicyObject:            Firewall policy object
    $FWPRuleCObject:            Firewall policy rule collection object
} #>
<# Process Flow {
    function
        Call GetAzFWPRuleCollection > Get $FWPRuleCObject, $FWPolicyRCGObject, $FWPolicyObject           
        End GetAzFWPRuleCollection
            Return function > Send $FWPRuleCObject, $FWPolicyRCGObject, $FWPolicyObject   
}#>
function GetAzFWPRuleCollection {                                                           # Function to get firewall policy rule collection 
    Begin {                                                                                 # Begin function
        :GetAzureFWPRuleCol while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Gathering firewall policy rule collections'                         # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPRuleCol                                                    # Breaks :GetAzureFWPRuleCol
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
                Break GetAzureFWPRuleCol                                                    # Breaks :GetAzureFWPRuleCol
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            :SelectAzureFWPRuleCol while ($true) {                                          # Inner loop for selecting the firewall policy rule collection
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]  Collection Name:  "$_.Name                   # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number] Collection Name:  "$_.Name                    # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Collection Priority:   '$_.Priority                         # Write message to screen
                    Write-Host 'Collection Rule Count: '$_.RuleCount                        # Write message to screen
                    Write-Host 'Collection Rule Names {'                                    # Write message to screen
                    foreach ($RuleC in $_.RuleNames) {                                      # For each item in current item .RuleNames
                        Write-Host '                       '$RuleC                          # Write message to screen
                    }                                                                       # End foreach ($RuleC in $_.RuleNames)
                    Write-Host '                      }'                                    # Write message to screen
                    Write-Host 'RCG Name:              '$_.RCGName                          # Write message to screen
                    Write-Host 'RCG Priority:          '$_.RCGPriority                      # Write message to screen
                    Write-Host 'Policy Name:           '$_.PolicyName                       # Write message to screen
                    Write-Host 'Policy RG:             '$_.RG                               # Write message to screen
                    Write-Host 'Policy Loc:            '$_.Location                         # Write message to screen
                    if ($_.FWName) {                                                        # If current item .FWName has a value
                        Write-Host 'Firewall Name:         '$_.FWName                       # Write message to screen
                    }                                                                       # End if ($_.FWName) 
                    else {                                                                  # Else if current item .FWName is $null
                        Write-Host 'Firewall Name:          Not Assigned'                   # Write message to screen
                    }                                                                       # End else (if ($_.FWName))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the rule collection for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the firewall policy
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureFWPRuleCol                                                # Breaks :GetAzureFWPRuleCol
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $FWPolicyRCGObject = Get-AzFirewallPolicyRuleCollectionGroup -Name `
                        $OpSelect.RCGName -ResourceGroupName $OpSelect.RG `
                        -AzureFirewallPolicyName $OpSelect.PolicyName                       # Pulls the full policy rule collection group object
                    $FWPolicyObject = Get-AzFirewallPolicy -Name $OpSelect.PolicyName `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full policy object
                    $FWPRuleCObject = $FWPolicyRCGObject.Properties.RuleCollection | `
                        Where-Object {$_.Name -eq $OpSelect.Name}                           # Isolates the rule collection
                    Return $FWPRuleCObject, $FWPolicyRCGObject, $FWPolicyObject             # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureFWPRuleCol while ($true)
        }                                                                                   # End :GetAzureFWPRuleCol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzFWPRuleCollection