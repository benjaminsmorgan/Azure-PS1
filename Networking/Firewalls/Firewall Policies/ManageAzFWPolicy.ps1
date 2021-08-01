function ManageAzFWPolicy {                                                                 # Function to manage firewall policies
    Begin {                                                                                 # Begin function
        :ManageAzureFWPolicy while ($true) {                                                # Outer loop for managing function
            Write-Host 'Manage Firewall Policies'                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Firewall Policy'                                            # Write message to screen
            Write-Host '[2] List Firewall Policies'                                         # Write message to screen
            Write-Host '[3] Remove Firewall Policy'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureFWPolicy                                                   # Breaks :ManageAzureFWPolicy
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Firewall Policy'                                            # Write message to screen
                #Functiongohere                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Firewall Policies'                                         # Write message to screen
                ListAzFWPolicy                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Firewall Policy'                                         # Write message to screen
                RemoveAzFWPolicy                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzFWPolicy
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
                if ($_.RCGList) {                                                           # If current item .RCGLust has a value
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
function GetAzFWPolicy {                                                                    # Function to get firewall policy
    Begin {                                                                                 # Begin function
        :GetAzureFWPolicy while ($true) {                                                   # Outer loop for managing function
            Write-Host 'Gathering firewall policies'                                        # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPolicy                                                      # Breaks :GetAzureFWPolicy
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
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
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$FWPolicy.Name;                                                  # Policy name
                    'RG'=$FWPolicy.ResourceGroupName;                                       # Policy resource group name
                    'Location'=$FWPolicy.Location;                                          # Policy location
                    'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                            # Policy threat intel mode
                    'FWName'=$FirewallObject.Name;                                          # Firewall name
                    'RCGList'=$RCGList;                                                     # Rule collection group names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureFWPolicy while ($true) {                                            # Inner loop for selecting the firewall policy
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
                    if ($_.FWName) {                                                        # If current item .FWName has a value
                        Write-Host 'Firewall Name:'$_.FWName                                # Write message to screen
                    }                                                                       # End if ($_.FWName) 
                    else {                                                                  # Else if current item .FWName is $null
                        Write-Host 'Firewall Name: Not Assigned'                            # Write message to screen
                    }                                                                       # End else (if ($_.FWName))
                    Write-Host 'Policy RG:    '$_.RG                                        # Write message to screen
                    Write-Host 'Policy Loc:   '$_.Location                                  # Write message to screen
                    Write-Host 'Policy TIM:   '$_.ThreatIntelMode                           # Write message to screen
                    if ($_.RCGList) {                                                       # If current item .RCGLust has a value
                        $RCGList = $_.RCGList                                               # $RCGList is equal to current item.RCGList
                        Write-Host 'Policy RCG {'                                           # Write message to screen
                        foreach ($Name in $RCGList) {                                       # For each item in $RCGList
                            Write-Host '              '$Name                                # Write message to screen
                        }                                                                   # End foreach ($Name in $RCGList)
                        Write-Host '           }'                                           # Write message to screen
                        $RCGList = $null                                                    # Clears $var
                    }                                                                       # End if ($_.RCGList)
                    else {                                                                  # Else if current item .RCGList is $null
                        Write-Host 'Policy RCG:    N/A'                                     # Write message to screen
                    }                                                                       # End else (if ($_.RCGList))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the firewall policy for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the firewall policy
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureFWPolicy                                                  # Breaks :GetAzureFWPolicy
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $FWPolicyObject = Get-AzFirewallPolicy -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full policy object
                    Return $FWPolicyObject                                                  # Returns to calling function with $FWPolicyObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureFWPolicy while ($true)
        }                                                                                   # End :GetAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzFWPolicy
function RemoveAzFWPolicy {                                                                 # Function to remove a firewall policy
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFWPolicy'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureFWPolicy while ($true) {                                                # Outer loop for managing function
            $FWPolicyObject = GetAzFWPolicy ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FWPolicyObject) {                                                         # If $FWPolicyObject does not have a value
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy
            }                                                                               # End if (!$FirewallObject) 
            $FirewallObject = Get-AzFirewall | Where-Object `
                {$_.FirewallPolicy.ID -eq $FWPolicyObject.ID}                               # Pulls the firewall object if attached
            if ($FirewallObject) {                                                          # If $FirewallObject has a value
                $VNetName = $FirewallObject.IPConfigurations.Subnet.ID.Split('/')[8]        # Isolates the Vnet name
                Write-Host 'This policy is currently associated to the following'           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Firewall:'$FirewallObject.name                                  # Write message to screen
                Write-Host 'VNet:    '$VNetName                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please dissociate this policy from the firewall'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy 
            }                                                                               # End if ($FirewallObject)
            Write-Host 'Remove Firewall Policy :'$FWPolicyObject.name                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the firewall policy'                                   # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzFirewallPolicy -ResourceId $FWPolicyObject.ID -Force `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the firewall policy
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureFWPolicy                                               # Breaks :RemoveAzureFWPolicy    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall policy has been removed'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzFWPolicy