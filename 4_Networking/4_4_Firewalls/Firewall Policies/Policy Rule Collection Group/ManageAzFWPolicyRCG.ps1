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
    NewAzFWPolicyRCG:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/NewAzFWPolicyRCG.ps1
    ListAzFWPolicyRCG:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/ListAzFWPolicyRCG.ps1
    RemoveAzFWPolicyRCG:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/RemoveAzFWPolicyRCG.ps1
    SetAzFWPolicyRCGPri:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/SetAzFWPolicyRCGPri.ps1    
    GetAzFWPolicyRCG:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/GetAzFWPolicyRCG.ps1
    GetAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/GetAzFWPolicy.ps1
} #>
<# Functions Description: {
    ManageAzFWPolicyRCG:        Function to manage firewall policy Rule Collection groups
    NewAzFWPolicyRCG:           Function to create a new firewall policy rule collection group
    ListAzFWPolicyRCG:          Function to list all firewall policy rule collection group
    RemoveAzFWPolicyRCG:        Function to remove a firewall policy rule collection group
    SetAzFWPolicyRCGPri:        Function to set a firewall policy rule collection group priority
    GetAzFWPolicyRCG:           Function to get firewall policy rule collection group    
} #>
<# Variables: {      
    :ManageAzureFWPolicyRCG     Outer loop for managing function
    $OpSelect:                  Operator input to select management function
    NewAzFWPolicyRCG{}          Creates $FWPolicyRCGObject
        GetAzFWPolicy{}             Gets $FWPolicyObject
    ListAzFWPolicyRCG{}         Lists $FWPolicyRCGObjects
    RemoveAzFWPolicyRCG{}       Removes $FWPolicyRCGObject
        GetAzFWPolicyRCG{}          Gets $FWPolicyRCGObject, $FWPolicyObject
    SetAzFWPolicyRCGPri{}       Updates $FWPolicyRCGObject
        GetAzFWPolicyRCG{}          Gets $FWPolicyRCGObject, $FWPolicyObject
} #>
<# Process Flow {
    function
        Call ManageAzFWPolicyRCG > Get $null
            Call NewAzFWPolicyRCG > Get $null
                Call GetAzFWPolicy > Get $FWPolicyObject            
                End GetAzFWPolicy
                    Return NewAzFWPolicyRCG > Send $FWPolicyObject        
            End NewAzFWPolicyRCG
                Return ManageAzFWPolicyRCG > Send $null
            Call ListAzFWPolicyRCG > Get $null            
            End ListAzFWPolicyRCG
                Return ManageAzFWPolicyRCG > Send $null
            Call RemoveAzFWPolicyRCG > Get $null
                Call GetAzFWPolicyRCG > Get $FWPolicyRCGObject, $FWPolicyObject           
                End GetAzFWPolicyRCG
                    Return RemoveAzFWPolicyRCG > Send $FWPolicyRCGObject, $FWPolicyObject 
            End RemoveAzFWPolicyRCG
                Return ManageAzFWPolicyRCG > Send $null
            Call SetAzFWPolicyRCGPri > Get $null
                Call GetAzFWPolicyRCG > Get $FWPolicyRCGObject, $FWPolicyObject           
                End GetAzFWPolicyRCG
                    Return SetAzFWPolicyRCGPri > Send $FWPolicyRCGObject, $FWPolicyObject 
            End SetAzFWPolicyRCGPri
                Return ManageAzFWPolicyRCG > Send $null                
        
        End ManageAzFWPolicyRCG
            Return function > Send $null
}#>
function ManageAzFWPolicyRCG {                                                              # Function to manage firewall policy Rule Collection groups
    Begin {                                                                                 # Begin function
        :ManageAzureFWPolicyRCG while ($true) {                                             # Outer loop for managing function
            Write-Host 'Manage Firewall Policy Rule Collection Groups'                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Firewall Policy RCG'                                        # Write message to screen
            Write-Host '[2] List Firewall Policies RCG'                                     # Write message to screen
            Write-Host '[3] Remove Firewall Policy RCG'                                     # Write message to screen
            Write-Host '[4] Update Firewall Policy RCG priority'                            # Write message to screen
            Write-Host '[5] Manage Firewall Policy Rule Collections'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureFWPolicyRCG                                                # Breaks :ManageAzureFWPolicyRCG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Firewall Policy RCG'                                        # Write message to screen
                NewAzFWPolicyRCG                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Firewall Policies RCG'                                     # Write message to screen
                ListAzFWPolicyRCG                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Firewall Policy'                                         # Write message to screen
                RemoveAzFWPolicyRCG                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Update Firewall Policy RCG priority'                            # Write message to screen
                SetAzFWPolicyRCGPri                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4') 
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Manage Firewall Policy Rule Collections'                        # Write message to screen
                ManageAzFWPRuleCollections                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5') 
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
}                                                                                           # End function ManageAzFWPolicyRCG
function NewAzFWPolicyRCG {                                                                 # Function to create a new firewall policy rule collection group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzFWPolicyRCG'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureFWPolicyRCG while ($true) {                                                # Outer loop for managing function
            $FWPolicyObject = GetAzFWPolicy ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FWPolicyObject) {                                                         # If $FWPolicyObject is $null
                Break NewAzureFWPolicyRCG                                                   # Breaks :NewAzureFWPolicyRCG
            }                                                                               # End if (!$FWPolicyObject)
            if ($FWPolicyObject.RuleCollectionGroups) {                                     # If $FWPolicyObject.RuleCollectionGroups has a value
                $ObjectArray =@()                                                           # Creates $ObjectArray
                $ObjectArray2 = @()                                                         # Creates $ObjectArray2
                $RuleCollectGroups = $FWPolicyObject.RuleCollectionGroups                   # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $ObjectArray += $RCGName                                                # Addes $RCGName to $ObjectArray
                    $RCGObject = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicyObject.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicyObject.Name                       # Gets current item RCGObject
                    $RCGPriority = $RCGObject.Properties.Priority                           # Gets the $RCGObject priority
                    $ObjectArray2 += $RCGPriority                                           # Adds $RCGPriority to $ObjectArray2
                    $RCGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
            }                                                                               # End if ($FWPolicyObject.RuleCollectionGroups)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureFWPolicyRCGName while ($true) {                                        # Inner loop for setting the firewall name
                if ($ObjectArray) {                                                         # If $ObjectArray has a value
                    Write-Host 'The following policy rule collection '                      # Write message to screen
                    Write-Host 'group names are already in use:'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each item in $ObjectArray
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                Write-Host 'Enter the policy rule collection group name'                    # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $PolicyRCGName = Read-Host 'Name'                                           # Operator input for the firewall policy name
                $PolicyRCGNameArray = $PolicyRCGName.ToCharArray()                          # Loads $PolicyRCGName into array
                Clear-Host                                                                  # Clears screen
                if ($PolicyRCGName.Length -lt 0 -or $PolicyRCGName.Length -ge 80) {         # If $PolicyRCGName.Length is less than 1 or greater than 80 characters
                    Write-Host 'The policy rule collection group name '                     # Write message to screen
                    Write-Host 'must be between 1 and 80 characters'                        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRCGName = $null                                                  # Clears $PolicyRCGName
                }                                                                           # End if ($PolicyRCGName.Length -ge 80)
                if ($PolicyRCGNameArray[0] -notin $Valid1stChar) {                          # If 0 position of $PolicyRCGNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRCGName = $null                                                  # Clears $PolicyRCGName
                }                                                                           # End if ($PolicyRCGNameArray[0] -notin $Valid1stChar)
                if ($PolicyRCGNameArray[-1] -notin $ValidLastChar) {                        # If last position of $PolicyRCGNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRCGName = $null                                                  # Clears $PolicyRCGName
                }                                                                           # End if ($PolicyRCGNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $PolicyRCGNameArray) {                                       # For each item in $PolicyRCGNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Rule collection name cannot include any spaces'     # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $PolicyRCGName = $null                                              # Clears $PolicyRCGName
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $PolicyRCGNameArray)
                if ($PolicyRCGName -in $ObjectArray) {                                      # If $PolicyRCGName in $ObjectArray
                    Write-Host 'That name is already in use'                                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRCGName = $null                                                  # Clears $var
                }                                                                           # End if ($PolicyRCGName -in $ObjectArray) 
                if ($PolicyRCGName) {                                                       # If $PolicyRCGName has a value
                    Write-Host 'Use:'$PolicyRCGName' as the rule collection group name'     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the firewall name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureFWPolicyRCG                                           # Breaks :NewAzureFWPolicyRCG
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureFWPolicyRCGName                                       # Breaks :SetAzureFWPolicyRCGName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($PolicyRCGName)
                else {                                                                      # If $PolicyRCGName does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PolicyRCGName))
            }                                                                               # End :SetAzureFWPolicyRCGName while ($true)
            $ValidArray = '1234567890'                                                      # Changes $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to Array
            :SetAzureFWPolicyRCGPri while ($true) {                                         # Inner loop for setting the policy rule collection group priority
                Write-Host 'Please enter the rule collection group priority'                # Write message to screen
                Write-Host 'The value must be between 100 and 65000'                        # Write message to screen
                if ($ObjectArray2) {                                                        # If $ObjectArray2 has a value
                    Write-Host 'The following priorities are already in use'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray2) {                                         # For each item in $ObjectArray2
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray2)
                }                                                                           # End if ($ObjectArray2)
                Write-Host ''                                                               # Write message to screen
                $PolicyRCGPri = Read-Host 'Priority [#]'                                    # Operator input for the RCG priority
                Clear-Host                                                                  # Clears screen
                if ($PolicyRCGPri -in $ObjectArray2) {                                      # If $PolicyRCGPri in $ObjectArray2
                    $PolicyRCGPri = $null                                                   # Clears $var
                    Write-Host 'That priority is already in use'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($PolicyRCGPri -in $ObjectArray2)
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    $PolicyRCGPriArray = $PolicyRCGPri.ToCharArray()                        # Converts $PolicyRCGPri to array
                    foreach ($_ in $PolicyRCGPriArray) {                                    # For each item in $PolicyRCGPriArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $PolicyRCGPri = $null                                           # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $PolicyRCGPriArray) 
                }                                                                           # End if ($PolicyRCGPri)                                                                     
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    $PolicyRCGPriInt = [Int]$PolicyRCGPri                                   # Converts $PolicyRCGPri to Int
                    if ($PolicyRCGPriInt -lt 100 -or $PolicyRCGPriInt -gt 65000) {          # If $PolicyRCGPriInt is not between 100 and 65000
                        Write-Host 'The value must be between 100 and 65000'                # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                        $PolicyRCGPri = $null                                               # Clears $var
                    }                                                                       # End if ($PolicyRCGPriInt -lt 100 -or $PolicyRCGPriInt -gt 65000)            
                    $PolicyRCGPriInt = $null                                                # Clears $var
                }                                                                           # End if ($PolicyRCGPri)
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    :ConfirmSetting while ($true) {                                         # Inner loop for confirming the RCG priority
                        Write-Host 'Use:'$PolicyRCGPri' as the rule collection priority'    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the RCG priority
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureFWPolicyRCGPri                                    # Breaks SetAzureFWPolicyRCGPri
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            $PolicyRCGPri = $null                                           # Clears $var
                            Break ConfirmSetting                                            # Breaks :ConfirmSetting
                        }                                                                   # End elseif ($OpConfirm -eq 'n')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break NewAzureFWPolicyRCG                                       # Breaks :NewAzureFWPolicyRCG
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :ConfirmSetting while ($true)
                }                                                                           # End if ($PolicyRCGPri)
                else {                                                                      # Else if $PolicyRCGPri is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PolicyRCGPri))
            }                                                                               # End :SetAzureFWPolicyRCGPri while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Building the policy rule collection group'                      # Write message to screen   
                Write-Host 'This may take a moment'                                         # Write message to screen
                New-AzFirewallPolicyRuleCollectionGroup -Name $PolicyRCGName -Priority `
                    $PolicyRCGPri -FirewallPolicyName $FWPolicyObject.Name `
                    -ResourceGroupName $FWPolicyObject.ResourceGroupName `
                    -ErrorAction 'Stop' | Out-Null                                          # Builds the policy rule collection group
            }                                                                               # End try
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
                Break NewAzureFWPolicyRCG                                                   # Breaks :NewAzureFWPolicyRCG    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The policy rule collection group has been created'                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureFWPolicyRCG                                                       # Breaks :NewAzureFWPolicyRCG
        }                                                                                   # End :NewAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzFWPolicyRCG    
function ListAzFWPolicyRCG {                                                                # Function to list all firewall policy rule collection group
    Begin {                                                                                 # Begin function
        :ListAzureFWPolicyRCG while ($true) {                                               # Outer loop for managing function
            Write-Host 'Gathering firewall policy rule collection groups'                   # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPolicyRCG                                                  # Breaks :ListAzureFWPolicyRCG
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
                Break ListAzureFWPolicyRCG                                                  # Breaks :ListAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'RCG Name:     '$_.Name                                          # Write message to screen
                Write-Host 'RCG Priority: '$_.Priority                                      # Write message to screen
                if ($_.RuleColl) {                                                          # If current item .RuleColl has a value
                    $RuleList = $_.RuleColl                                                 # $RuleList is equal to current item.RuleColl
                    Write-Host 'Collections  {'                                             # Write message to screen
                    foreach ($Name in $RuleList) {                                          # For each item in $RuleList
                        Write-Host '              '$Name.Name                               # Write message to screen
                    }                                                                       # End foreach ($Name in $RuleList)
                    Write-Host '             } '                                            # Write message to screen
                    $RuleList = $null                                                       # Clears $var
                }                                                                           # End if ($_.RuleColl)
                else {                                                                      # Else if current item .RuleColl is $null
                    Write-Host 'Collections:   None'                                        # Write message to screen
                }                                                                           # End else (if ($_.RuleColl))
                Write-Host 'Policy Name:  '$_.PolicyName                                    # Write message to screen
                Write-Host 'Policy RG:    '$_.RG                                            # Write message to screen
                Write-Host 'Policy Loc:   '$_.Location                                      # Write message to screen
                Write-Host 'Policy TIM:   '$_.ThreatIntelMode                               # Write message to screen                    
                if ($_.FWName) {                                                            # If current item .FWName has a value
                    Write-Host 'Firewall Name:'$_.FWName                                    # Write message to screen
                }                                                                           # End if ($_.FWName) 
                else {                                                                      # Else if current item .FWName is $null
                    Write-Host 'Firewall Name: Not Assigned'                                # Write message to screen
                }                                                                           # End else (if ($_.FWName))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureFWPolicyRCG                                                      # Breaks :ListAzureFWPolicyRCG
        }                                                                                   # End :ListAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzFWPolicyRCG
function RemoveAzFWPolicyRCG {                                                              # Function to remove a firewall policy rule collection group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFWPolicyRCG'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureFWPolicyRCG while ($true) {                                             # Outer loop for managing function
            $FWPolicyRCGObject, $FWPolicyObject = GetAzFWPolicyRCG ($CallingFunction)       # Calls function and assigns output to $var
            if (!$FWPolicyRCGObject) {                                                      # If $FWPolicyRCGObject does not have a value
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG
            }                                                                               # End if (!$FWPolicyRCGObject) 
            $FirewallObject = Get-AzFirewall | Where-Object `
                {$_.FirewallPolicy.ID -eq $FWPolicyObject.ID}                               # Pulls the firewall object if attached
            Write-Host 'Remove Rule Collection Group:'$FWPolicyRCGObject.Name               # Write message to screen
            Write-Host 'From:'                                                              # Write message to screen
            Write-Host 'Firewall Policy:'$FWPolicyObject.name                               # Write message to screen
            if ($FirewallObject) {                                                          # If $FirewallObject has a value
                Write-Host 'Firewall Name:  '$FirewallObject.name                           # Write message to screen
                $VNetName = $FirewallObject.IPConfigurations.Subnet.ID.Split('/')[8]        # Isolates the Vnet name
                Write-Host 'VNet Name:      '$VNetName                                      # Write message to screen    
            }                                                                               # End if ($FirewallObject)
            else {                                                                          # Else if $FirewallObject is $null
                Write-Host 'Firewall Name:   N/A'                                           # Write message to screen
                Write-Host 'VNet Name:       N/A'                                           # Write message to screen        
            }                                                                               # End else (if ($FirewallObject))
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the firewall policy rule collection group'             # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzFirewallPolicyRuleCollectionGroup -Name `
                        $FWPolicyRCGObject.Name -ResourceGroupName `
                        $FWPolicyObject.ResourceGroupName -AzureFirewallPolicyName `
                        $FWPolicyObject.Name -Force -ErrorAction 'Stop' | Out-Null          # Removes the firewall policy rule collection group
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
                    Break RemoveAzureFWPolicyRCG                                            # Breaks :RemoveAzureFWPolicyRCG    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall policy rule collection group has been removed'     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzFWPolicyRCG
function SetAzFWPolicyRCGPri {                                                              # Function to set a firewall policy rule collection group priority
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzFWPolicyRCGPri'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPolicyRCG while ($true) {                                                # Outer loop for managing function
            $FWPolicyRCGObject, $FWPolicyObject = GetAzFWPolicyRCG ($CallingFunction)       # Calls function and assigns output to $var
            if (!$FWPolicyRCGObject) {                                                      # If $FWPolicyRCGObject does not have a value
                Break SetAzureFWPolicyRCG                                                   # Breaks :SetAzureFWPolicyRCG
            }                                                                               # End if (!$FWPolicyRCGObject) 
            if ($FWPolicyObject.RuleCollectionGroups) {                                     # If $FWPolicyObject.RuleCollectionGroups has a value
                $ObjectArray = @()                                                          # Creates $ObjectArray
                $RuleCollectGroups = $FWPolicyObject.RuleCollectionGroups                   # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $RCGObject = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicyObject.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicyObject.Name                       # Gets current item RCGObject
                    $RCGPriority = $RCGObject.Properties.Priority                           # Gets the $RCGObject priority
                    $ObjectArray += $RCGPriority                                            # Adds $RCGPriority to $ObjectArray
                    $RCGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
            }                                                                               # End if ($FWPolicyObject.RuleCollectionGroups)
            $CurrentPriority = $FWPolicyRCGObject.Properties.Priority
            $ValidArray = '1234567890'                                                      # Changes $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to Array
            :SetAzureFWPolicyRCGPri while ($true) {                                         # Inner loop for setting the policy rule collection group priority
                Write-Host 'Please enter the rule collection group priority'                # Write message to screen
                Write-Host 'The value must be between 100 and 65000'                        # Write message to screen
                if ($ObjectArray) {                                                         # If $ObjectArray has a value
                    Write-Host 'The following priorities are already in use'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each item in $ObjectArray
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray)
                }                                                                           # End if ($ObjectArray)
                Write-Host ''                                                               # Write message to screen
                $PolicyRCGPri = Read-Host 'Priority [#]'                                    # Operator input for the RCG priority
                Clear-Host                                                                  # Clears screen
                if ($PolicyRCGPri -in $ObjectArray) {                                       # If $PolicyRCGPri in $ObjectArray
                    $PolicyRCGPri = $null                                                   # Clears $var
                    Write-Host 'That priority is already in use'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($PolicyRCGPri -in $ObjectArray)
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    $PolicyRCGPriArray = $PolicyRCGPri.ToCharArray()                        # Converts $PolicyRCGPri to array
                    foreach ($_ in $PolicyRCGPriArray) {                                    # For each item in $PolicyRCGPriArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $PolicyRCGPri = $null                                           # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $PolicyRCGPriArray) 
                }                                                                           # End if ($PolicyRCGPri)                                                                     
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    $PolicyRCGPriInt = [Int]$PolicyRCGPri                                   # Converts $PolicyRCGPri to Int
                    if ($PolicyRCGPriInt -lt 100 -or $PolicyRCGPriInt -gt 65000) {          # If $PolicyRCGPriInt is not between 100 and 65000
                        Write-Host 'The value must be between 100 and 65000'                # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                        $PolicyRCGPri = $null                                               # Clears $var
                    }                                                                       # End if ($PolicyRCGPriInt -lt 100 -or $PolicyRCGPriInt -gt 65000)            
                    $PolicyRCGPriInt = $null                                                # Clears $var
                }                                                                           # End if ($PolicyRCGPri)
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    :ConfirmSetting while ($true) {                                         # Inner loop for confirming the RCG priority
                        Write-Host 'Current priority:'$CurrentPriority                      # Write message to screen
                        Write-Host 'New priority:    '$PolicyRCGPri                         # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Make this change'                                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the RCG priority
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureFWPolicyRCGPri                                    # Breaks SetAzureFWPolicyRCGPri
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            $PolicyRCGPri = $null                                           # Clears $var
                            Break ConfirmSetting                                            # Breaks :ConfirmSetting
                        }                                                                   # End elseif ($OpConfirm -eq 'n')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureFWPolicyRCG                                       # Breaks :SetAzureFWPolicyRCG
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :ConfirmSetting while ($true)
                }                                                                           # End if ($PolicyRCGPri)
                else {                                                                      # Else if $PolicyRCGPri is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PolicyRCGPri))
            }                                                                               # End :SetAzureFWPolicyRCGPri while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Updating the policy rule collection group'                      # Write message to screen   
                Write-Host 'This may take a moment'                                         # Write message to screen
                $FWPolicyRCGObject.Properties.Priority = $PolicyRCGPri
                $FWPolicyRCGObject | Set-AzFirewallPolicyRuleCollectionGroup `
                    -ErrorAction 'Stop' | Out-Null                                          # Updates the policy rule collection group
            }                                                                               # End try
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
                Break SetAzureFWPolicyRCG                                                   # Breaks :SetAzureFWPolicyRCG    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The policy rule collection group has been updated'                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureFWPolicyRCG                                                       # Breaks :SetAzureFWPolicyRCG
        }                                                                                   # End :SetAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzFWPolicyRCGPri  
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
                        Write-Host 'Collections  {'                                         # Write message to screen
                        foreach ($Name in $RuleList) {                                      # For each item in $RuleList
                            Write-Host '              '$Name.Name                           # Write message to screen
                        }                                                                   # End foreach ($Name in $RuleList)
                        Write-Host '             } '                                        # Write message to screen
                        $RuleList = $null                                                   # Clears $var
                    }                                                                       # End if ($_.RuleColl)
                    else {                                                                  # Else if current item .RuleColl is $null
                        Write-Host 'Collections:   None'                                    # Write message to screen
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
# Functions for ManageAzFWPRuleCollections
function ManageAzFWPRuleCollections {                                                       # Function to manage firewall policy rule collection
    Begin {                                                                                 # Begin function
        :ManageAzureFWPolicyRCG while ($true) {                                             # Outer loop for managing function
            Write-Host 'Manage Firewall Policy Rule Collection'                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Firewall Rule Collection (Unavailable at this time)'        # Write message to screen
            Write-Host '[2] List Firewall Rule Collections'                                 # Write message to screen
            Write-Host '[3] Remove Firewall Rule Collection (Unavailable at this time)'     # Write message to screen
            Write-Host '[4] Update Firewall Rule Collection Priority'                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureFWPolicyRCG                                                # Breaks :ManageAzureFWPolicyRCG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'This function is not available at this time'                    # Write message to screen
                Write-Host 'Please visit the Azure portal to complete this action'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Firewall Rule Collections'                                 # Write message to screen
                ListAzFWPRuleCollection                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'This function is not available at this time'                    # Write message to screen
                Write-Host 'Please visit the Azure portal to complete this action'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
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
                            'RuleActionType'=$RuleC.Action.Type;                            # Rule collection action type
                            'RuleNames'=$RuleC.Rules.Name;                                  # Rule names
                            'RuleType'=$RuleC.RuleCollectionType;                           # Rule collection type
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
                Write-Host 'Collection Action Type:'$_.RuleActionType                       # Write message to screen
                Write-Host 'Collection Type:       '$_.RuleType                             # Write message to screen
                if ($_.RuleNames) {                                                         # If $_.RuleNames has a value
                    Write-Host 'Collection Rule Names {'                                    # Write message to screen
                    foreach ($RuleC in $_.RuleNames) {                                      # For each item in current item .RuleNames
                        Write-Host '                       '$RuleC                          # Write message to screen
                    }                                                                       # End foreach ($RuleC in $_.RuleNames)
                    Write-Host '                      }'                                    # Write message to screen
                }                                                                           # End if ($_.RuleNames)
                else {                                                                      # Else if $_.RuleNames is $null
                    Write-Host 'Collection Rule Names:  None'                               # Write message to screen
                }                                                                           # End else (if ($_.RuleNames))
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
                Write-Host '-------------------------------------------------------------'  # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureFWPRuleCol                                                       # Breaks :ListAzureFWPRuleCol
        }                                                                                   # End :ListAzureFWPRuleCol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzFWPRuleCollection
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
                Break SetAzureFWPRuleCollection                                             # Breaks :SetAzureFWPRuleCollection    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The policy rule collection has been updated'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureFWPRuleCollection                                                 # Breaks :SetAzureFWPRuleCollection
        }                                                                                   # End :SetAzureFWPRuleCollection while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzFWPRuleCollPri
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
                            'RuleActionType'=$RuleC.Action.Type;                            # Rule collection action type
                            'RuleNames'=$RuleC.Rules.Name;                                  # Rule names
                            'RuleType'=$RuleC.RuleCollectionType;                           # Rule collection type
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
                    Write-Host 'Collection Action Type:'$_.RuleActionType                   # Write message to screen
                    Write-Host 'Collection Type:       '$_.RuleType                         # Write message to screen
                    if ($_.RuleNames) {                                                     # If $_.RuleNames has a value
                        Write-Host 'Collection Rule Names {'                                # Write message to screen
                        foreach ($RuleC in $_.RuleNames) {                                  # For each item in current item .RuleNames
                            Write-Host '                       '$RuleC                      # Write message to screen
                        }                                                                   # End foreach ($RuleC in $_.RuleNames)
                        Write-Host '                      }'                                # Write message to screen
                    }                                                                       # End if ($_.RuleNames)
                    else {                                                                  # Else if $_.RuleNames is $null
                        Write-Host 'Collection Rule Names:  None'                           # Write message to screen
                    }                                                                       # End else (if ($_.RuleNames))
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
# End ManageAzFWPRuleCollections