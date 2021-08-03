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
    GetAzFWPolicyRCG:           Function to get firewall policy rule collection group
} #>
<# Variables: {      
    :GetAzureFWPolicyRCG        Outer loop for managing function
    :SelectAzureFWPolicyRCG     Inner loop for selecting the firewall policy rule collection group
    $ObjectList:                List of all resources with the type of 'Microsoft.Network/firewallPolicies'
    $ObjectNumber:              $var used for listing and selecting the firewall policy
    $ObjectArray:               Array used to collect and list firewall policy object
    $FWPolicy:                  Firewall matching current item .resourceID
    $FirewallObject:            Firewall object
    $RuleCollectGroups:         $FWPolicy.RuleCollectionGroups                        
    $RCGName:                   Current item .ID.Split('/')[-1]   
    $FWPolicyRCG:               Current item firewall policy rule collection group
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number
    $RuleList:                  Current item rule list
    $OpSelect:                  Operator input to select the firewall policy rule collection group
    $FWPolicyRCGObject:         Firewall policy rule collection group object
    $FWPolicyObject:            Firewall policy object
} #>
<# Process Flow {
    function
        Call GetAzFWPolicyRCG > Get $FWPolicyRCGObject, $FWPolicyObject           
        End GetAzFWPolicyRCG
            Return function > Send $FWPolicyRCGObject, $FWPolicyObject   
}#>
function GetAzFWPolicyRCG {                                                                 # Function to get firewall policy rule collection group
    Begin {                                                                                 # Begin function
        :GetAzureFWPolicyRCG while ($true) {                                                # Outer loop for managing function
            Write-Host 'Gathering firewall policy rule collection groups'                   # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPolicyRCG                                                   # Breaks :GetAzureFWPolicyRCG
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
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$FWPolicyRCG.Name;                                           # Policy RCG name
                        'Priority'=$FWPolicyRCG.Properties.Priority;                        # Policy RCG priority
                        'RuleColl'=$FWPolicyRCG.Properties.RuleCollection;                  # Policy RCG rule collection
                        'PolicyName'=$FWPolicy.Name;                                        # Policy name
                        'RG'=$FWPolicy.ResourceGroupName;                                   # Policy resource group name
                        'Location'=$FWPolicy.Location;                                      # Policy location
                        'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                        # Policy threat intel mode
                        'FWName'=$FirewallObject.Name;                                      # Firewall name
                        'RCGList'=$RCGList;                                                 # Rule collection group names
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                    $RCGName = $null                                                        # Clears $var
                    $FWPolicyRCG = $null                                                    # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No firewall policy rule collection groups exist'                # Write messag to screen
                Write-Host ''                                                               # Write messag to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPolicyRCG                                                   # Breaks :GetAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            :SelectAzureFWPolicyRCG while ($true) {                                         # Inner loop for selecting the firewall policy rule collection group
                Write-Host '[0]            Exit'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]          "$_.Name                             # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'RCG Priority: '$_.Priority                                  # Write message to screen
                    if ($_.RuleColl) {                                                      # If current item .RuleColl has a value
                        $RuleList = $_.RuleColl                                             # $RuleList is equal to current item.RuleColl
                        Write-Host 'Rules        {'                                         # Write message to screen
                        foreach ($Name in $RuleList) {                                      # For each item in $RuleList
                            Write-Host '              '$Name.Name                           # Write message to screen
                        }                                                                   # End foreach ($Name in $RuleList)
                        Write-Host '             } '                                        # Write message to screen
                        $RuleList = $null                                                   # Clears $var
                    }                                                                       # End if ($_.RuleColl)
                    else {                                                                  # Else if current item .RuleColl is $null
                        Write-Host 'Rules:         None'                                    # Write message to screen
                    }                                                                       # End else (if ($_.RuleColl))
                    Write-Host 'Policy Name:  '$_.PolicyName                                # Write message to screen
                    Write-Host 'Policy RG:    '$_.RG                                        # Write message to screen
                    Write-Host 'Policy Loc:   '$_.Location                                  # Write message to screen
                    Write-Host 'Policy TIM:   '$_.ThreatIntelMode                           # Write message to screen                    
                    if ($_.FWName) {                                                        # If current item .FWName has a value
                        Write-Host 'Firewall Name:'$_.FWName                                # Write message to screen
                    }                                                                       # End if ($_.FWName) 
                    else {                                                                  # Else if current item .FWName is $null
                        Write-Host 'Firewall Name: Not Assigned'                            # Write message to screen
                    }                                                                       # End else (if ($_.FWName))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the firewall policy RCG for:'$CallingFunction    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the firewall policy
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureFWPolicyRCG                                               # Breaks :GetAzureFWPolicyRCG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $FWPolicyRCGObject = Get-AzFirewallPolicyRuleCollectionGroup -Name `
                        $OpSelect.Name -ResourceGroupName $OpSelect.RG `
                        -AzureFirewallPolicyName $OpSelect.PolicyName                       # Pulls the full policy rule collection group object
                    $FWPolicyObject = Get-AzFirewallPolicy -Name $OpSelect.PolicyName `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full policy object
                    Return $FWPolicyRCGObject, $FWPolicyObject                              # Returns to calling function with $FWPolicyRCGObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureFWPolicyRCG while ($true)
        }                                                                                   # End :GetAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzFWPolicyRCG