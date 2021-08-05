# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicyrulecollectiongroup?view=azps-6.3.0
    New-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/new-azfirewallpolicyrulecollectiongroup?view=azps-6.3.0
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
    Remove-AzFirewallPolicyRuleCollectionGroup: https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azfirewallpolicyrulecollectiongroup?view=azps-6.3.0
    Set-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/set-azfirewallpolicyrulecollectiongroup?view=azps-6.3.0
} #>
<# Required Functions Links: {
    NewAzFWPolRCGRule:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/NewAzFWPolRCGRule.ps1
    ListAzFWPolRCGRule:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/ListAzFWPolRCGRule.ps1
    RemoveAzFWPolRCGRule:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/RemoveAzFWPolRCGRule.ps1
    SetAzFWPolRCGRulePri:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/SetAzFWPolRCGRulePri.ps1    
    GetAzFWPolRCGRule:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/GetAzFWPolRCGRule.ps1
    GetAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/GetAzFWPolicy.ps1
} #>
<# Functions Description: {
    ManageAzFWPRuleCollections: Function to manage firewall policy rule collections     
} #>
<# Variables: {      
    :ManageAzureFWPolicyRCG     Outer loop for managing function
    $OpSelect:                  Operator input to select management function
    NewAzFWPolRCGRule{}         Creates $FWPolRCGRuleObject
        GetAzFWPolicy{}             Gets $FWPolRCGRuleObject
    ListAzFWPolRCGRule{}         Lists $FWPolRCGRuleObjects
    RemoveAzFWPolRCGRule{}       Removes $FWPolRCGRuleObject
        GetAzFWPolRCGRule{}          Gets $FWPolRCGRuleObject, $FWPolicyRCGObject, $FWPolicyObject
    SetAzFWPolRCGRulePri{}       Updates $FWPolRCGRuleObject
        GetAzFWPolRCGRule{}          Gets $FWPolRCGRuleObject,$FWPolicyRCGObject, $FWPolicyObject
} #>
<# Process Flow {
    function
        Call ManageAzFWPRuleCollections > Get $null
            
        
        End ManageAzFWPRuleCollections
            Return function > Send $null
}#>
function ManageAzFWPRuleCollections {                                                       # Function to manage firewall policy rule collection
    Begin {                                                                                 # Begin function
        :ManageAzureFWPolicyRCG while ($true) {                                             # Outer loop for managing function
            Write-Host 'Manage Firewall Policy Rule Collection'                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Firewall Rule Collection (In Dev)'                                   # Write message to screen
            Write-Host '[2] List Firewall Rule Collections (In Dev)'                                 # Write message to screen
            Write-Host '[3] Remove Firewall Rule Collection (In Dev)'                                # Write message to screen
            Write-Host '[4] Update Firewall Rule Collection Priority'                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureFWPolicyRCG                                                # Breaks :ManageAzureFWPolicyRCG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Firewall Rule Collection (In Dev)'                                   # Write message to screen
                #Functiongohere                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Firewall Rule Collections (In Dev)'                                 # Write message to screen
                #Functiongohere                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Firewall Rule Collection (In Dev)'                                # Write message to screen
                #Functiongohere                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Update Firewall Rule Collection Priority'                       # Write message to screen
                SetAzFWPRuleCollPri                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzFWPRuleCollections
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
                        Write-Host 'Firewall Name:         Not Assigned'                    # Write message to screen
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
function SetAzFWPRuleCollPri {                                                              # Function to set a firewall policy rule collection priority
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzFWPRuleCollPri'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPRuleCollection while ($true) {                                          # Outer loop for managing function
            $FWPRuleCObject, $FWPolicyRCGObject, $FWPolicyObject = `
                GetAzFWPRuleCollection ($CallingFunction)                                   # Calls function and assigns output to $var
            if (!$FWPRuleCObject) {                                                         # If $FWPolicyRCGObject does not have a value
                Break SetAzureFWPRuleCollection                                             # Breaks :SetAzureFWPRuleCollection
            }                                                                               # End if (!$FWPolicyRCGObject) 
            $ObjectArray = @()                                                              # Creates $ObjectArray
            foreach ($Pri in $FWPolicyRCGObject.Properties.RuleCollection.Priority) {       # For each item in $FWPolicyRCGObject.Properties.RuleCollection.Priority
                $ObjectArray += $Pri                                                        # Adds current item to $ObjectArray
            }                                                                               # End foreach ($Pri in $FWPolicyRCGObject.Properties.RuleCollection.Priority)
            $ValidArray = '1234567890'                                                      # Changes $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to Array
            :SetAzureFWPRuleCollPri while ($true) {                                         # Inner loop for setting the policy rule collection priority
                Write-Host 'Please enter the rule collection priority'                      # Write message to screen
                Write-Host 'The value must be between 100 and 65000'                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The following priorities are already in use'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    Write-Host $_                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                Write-Host ''                                                               # Write message to screen
                $RuleCollectionPri = Read-Host 'Priority [#]'                               # Operator input for the rule collection priority
                Clear-Host                                                                  # Clears screen
                if ($RuleCollectionPri -in $ObjectArray) {                                  # If $RuleCollectionPri in $ObjectArray
                    $RuleCollectionPri = $null                                              # Clears $var
                    Write-Host 'That priority is already in use'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($RuleCollectionPri -in $ObjectArray)
                if ($RuleCollectionPri) {                                                   # If $RuleCollectionPri has a value
                    $RuleCPriArray = $RuleCollectionPri.ToCharArray()                       # Converts $RuleCollectionPri to array
                    foreach ($_ in $RuleCPriArray) {                                        # For each item in $RuleCPriArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $RuleCollectionPri = $null                                      # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $RuleCPriArray) 
                }                                                                           # End if ($RuleCollectionPri)                                                                     
                if ($RuleCollectionPri) {                                                   # If $RuleCollectionPri has a value
                    $RuleCPriInt = [Int]$RuleCollectionPri                                  # Converts $RuleCollectionPri to Int
                    if ($RuleCPriInt -lt 100 -or $RuleCPriInt -gt 65000) {                  # If $RuleCPriInt is not between 100 and 65000
                        Write-Host 'The value must be between 100 and 65000'                # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                        $RuleCollectionPri = $null                                          # Clears $var
                    }                                                                       # End if ($RuleCPriInt -lt 100 -or $RuleCPriInt -gt 65000)            
                    $RuleCPriInt = $null                                                    # Clears $var
                }                                                                           # End if ($RuleCollectionPri)
                if ($RuleCollectionPri) {                                                   # If $RuleCollectionPri has a value
                    :ConfirmSetting while ($true) {                                         # Inner loop for confirming the RCG priority
                        Write-Host 'Rule Col Name:   '$FWPRuleCObject.Name                  # Write message to screen
                        Write-Host 'Current priority:'$FWPRuleCObject.priority              # Write message to screen
                        Write-Host 'New priority:    '$RuleCollectionPri                    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Make this change'                                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the RCG priority
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureFWPRuleCollPri                                    # Breaks SetAzureFWPRuleCollPri
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            $RuleCollectionPri = $null                                      # Clears $var
                            Break ConfirmSetting                                            # Breaks :ConfirmSetting
                        }                                                                   # End elseif ($OpConfirm -eq 'n')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureFWPRuleCollection                                 # Breaks :SetAzureFWPRuleCollection
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :ConfirmSetting while ($true)
                }                                                                           # End if ($RuleCollectionPri)
                else {                                                                      # Else if $RuleCollectionPri is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($RuleCollectionPri))
            }                                                                               # End :SetAzureFWPRuleCollPri while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Updating the rule collection priority'                          # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                $FWPRuleCObject.Priority = $RuleCollectionPri                               # Updates the rule collection priority
                $FWPolicyRCGObject | Set-AzFirewallPolicyRuleCollectionGroup -ErrorAction `
                    'Stop' | Out-Null                                                       # Saves the changes to the RCG
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                $MSG = $Error[0]                                                            # Gets the error message
                $MSG = $MSG.Exception.InnerException.Body.Message                           # Isolates the error message
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Warning $MSG                                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPRuleCollection                                                   # Breaks :SetAzureFWPRuleCollection    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The policy rule collection has been updated'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureFWPRuleCollection                                                       # Breaks :SetAzureFWPRuleCollection
        }                                                                                   # End :SetAzureFWPRuleCollection while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzFWPRuleCollPri