# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
    Add-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/add-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Remove-AzNetworkSecurityRuleConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworksecurityruleconfig?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
    SetAzNSGRuleProtocol:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleProtocol.ps1
    SetAzNSGRuleAccess:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleAccess.ps1
    SetAzNSGRuleDirection:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleDirection.ps1
    SetAzNSGRulePriority:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRulePriority.ps1
    SetAzNSGRuleSPortRange:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleSPortRange.ps1
    SetAzNSGRuleDPortRange:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleDPortRange.ps1
    ListAzNSGRule:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/ListAzNSGRule.ps1
    ListAzAllNSGsRule:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/ListAzAllNSGsRule.ps1
    GetAzAllNSGsRule:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzAllNSGsRule.ps1
    GetAzNSGRule:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzNSGRule.ps1
    RemoveAzNSGRule:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/RemoveAzNSGRule.ps1
} #>
<# Functions Description: {
    NewAzNSGRule:               Function to create a new network security group rule
    GetAzNSG:                   Function to get a network security group
    SetAzNSGRuleProtocol:       Function to set a network security group rule protocol
    SetAzNSGRuleAccess:         Function to set a network security group rule access
    SetAzNSGRuleDirection:      Function to set a network security group rule direction
    SetAzNSGRulePriority:       Function to set a network security group rule priority
    SetAzNSGRuleSPortRange:     Function to set a network security rule source port range
    SetAzNSGRuleDPortRange:     Function to set a network security rule destination port range
    ListAzNSGRule:              Function to list a network security group rules
    ListAzAllNSGsRule:          Function to list all rules from all network security groups
    GetAzAllNSGsRule:           Function to get a rule from all network security groups
    GetAzNSGRule:               Function to get a network security group rule
    RemoveAzNSGRule:            Function to remove a network security group rule
} #>
<# Variables: {      
    :ManageAzureNSGRule         Outer loop for managing function
    $OpSelect:                  Operator input to select the management function
    NewAzNSGRule{}              Creates $NSGRuleObject
        GetAzNSG{}                  Gets $NSGObject
        SetAzNSGRuleProtocol{}      Gets $NSGRuleProtocol
        SetAzNSGRuleAccess{}        Gets $NSGRuleAccess
        SetAzNSGRuleDirection{}     Gets $NSGRuleDirection
        SetAzNSGRulePriority{}      Gets $NSGRulePriority
        SetAzNSGRuleSPortRange{}    Gets $NSGRuleSPRange
        SetAzNSGRuleDPortRange{}    Gets $NSGRuleDPRange
    ListAzNSGRule{}             Lists $NSGRuleObject
        GetAzNSG{}                  Gets $NSGObject
    ListAzAllNSGsRule{}         Lists $NSGRuleObject
    RemoveAzNSGRule{}           Removes $NSGRuleObject
        GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
        GetAzNSGRule{}              Gets $NSGRuleObject
            GetAzNSG{}                  Gets $NSGObject
} #>
<# Process Flow {
    function
        Call ManageAzNSGRule > Get $null
            Call NewAzNSGRule > Get $null
                Call GetAzNSG > Get $NSGObject
                End GetAzNSG
                    Return NewAzNSGRule > Send $NSGObject
                Call SetAzNSGRuleProtocol > Get $NSGRuleProtocol
                End SetAzNSGRuleProtocol
                    Return NewAzNSGRule > Send $NSGRuleProtocol
                Call SetAzNSGRuleAccess > Get $NSGRuleAccess
                End SetAzNSGRuleAccess
                    Return NewAzNSGRule > Send $NSGRuleAccess
                Call SetAzNSGRuleDirection > Get $NSGRuleDirection
                End SetAzNSGRuleDirection
                    Return NewAzNSGRule > Send $NSGRuleDirection
                SetAzNSGRulePriority > Get $NSGRulePriority
                End SetAzNSGRulePriority
                    Return NewAzNSGRule > Send $NSGRulePriority
                Call SetAzNSGRuleSPortRange > Get $NSGRuleSPRange
                End SetAzNSGRuleSPortRange
                    Return NewAzNSGRule > Send $NSGRuleSPRange
                Call SetAzNSGRuleDPortRange > Get $NSGRuleDPRange
                End SetAzNSGRuleDPortRange
                    Return NewAzNSGRule > Send $NSGRuleDPRange
            End NewAzNSGRule
                Return function > Send $null
            Call ListAzNSGRule > Get $null
                Call GetAzNSG > Get $NSGObject
                End GetAzNSG
                    Return ListAzNSGRule > Send $NSGObject
            End ListAzNSGRule
                Return ManageAzNSGRule > Send $null
            Call ListAzAllNSGsRule > Get $null
            End ListAzAllNSGsRule
                Return ManageAzNSGRule > Send $null
            Call RemoveAzNSGRule > Get $null
                Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                End GetAzAllNSGsRule
                    Return RemoveAzNSGRule > Send $NSGRuleObject, $NSGObject
                Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                    Call GetAzNSG > Get $NSGObject
                    End GetAzNSG
                        Return GetAzNSGRule > Send $NSGObject
                End GetAzNSGRule
                    Return RemoveAzNSGRule > Send $NSGRuleObject, $NSGObject
            End RemoveAzNSGRule
                Return ManageAzNSGRule > Send $null


        End ManageAzNSGRule 
            Return function > Send $null
}#>
function ManageAzNSGRule {                                                                  # Function to manage network security group rules
    Begin {                                                                                 # Begin function
        :ManageAzureNSGRule while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Manage Network Security Group Rules'                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host '[1]  New NSG Rule'                                                  # Write message to screen
            Write-Host '[2]  List NSG Rules'                                                # Write message to screen
            Write-Host '[3]  List All NSG Rules'                                            # Write message to screen
            Write-Host '[4]  Remove NSG Rule'                                               # Write message to screen
            Write-Host '[5]  Update NSG Rule Access'                                        # Write message to screen
            Write-Host '[6]  Update NSG Rule Direction'                                     # Write message to screen
            Write-Host '[7]  Update NSG Rule Priority'                                      # Write message to screen
            Write-Host '[8]  Update NSG Rule Protocol'                                      # Write message to screen
            Write-Host '[9]  Update NSG Rule Source Port Range'                             # Write message to screen
            Write-Host '[10] Update NSG Rule Desination Port Range'                         # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureNSGRule                                                    # Breaks :ManageAzureNSGRule
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New NSG Rule'                                                   # Write message to screen
                NewAzNSGRule                                                                # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List NSG Rules'                                                 # Write message to screen
                ListAzNSGRule                                                               # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List All NSG Rules'                                             # Write message to screen
                ListAzAllNSGsRule                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove NSG Rule'                                                # Write message to screen
                RemoveAzNSGRule                                                             # Calls function
            }                                                                               # elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Update NSG Rule Access'                                         # Write message to screen
                UpdateAzNSGRAccess                                                          # Calls function
            }                                                                               # elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Update NSG Rule Direction'                                      # Write message to screen
                UpdateAzNSGRDirection                                                       # Calls function
            }                                                                               # elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Else if $OpSelect equals '7'
                Write-Host 'Update NSG Rule Priority'                                       # Write message to screen
                UpdateAzNSGRPriority                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '7')
            elseif ($OpSelect -eq '8') {                                                    # Else if $OpSelect equals '8'
                Write-Host 'Update NSG Rule Protocol'                                       # Write message to screen
                UpdateAzNSGRProtocol                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '8')
            elseif ($OpSelect -eq '9') {                                                    # Else if $OpSelect equals '9'
                Write-Host 'Update NSG Rule Source Port Range'                              # Write message to screen
                UpdateAzNSGRSPRange                                                         # Calls function
            }                                                                               # elseif ($OpSelect -eq '9')
            elseif ($OpSelect -eq '10') {                                                   # Else if $OpSelect equals '10'
                Write-Host 'Update NSG Rule Desination Port Range'                          # Write message to screen
                UpdateAzNSGRDPRange                                                         # Calls function
            }                                                                               # elseif ($OpSelect -eq '10')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNSGRule
function NewAzNSGRule {                                                                     # Function to create a new network security group rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzNSGRule'                                               # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule
            }                                                                               # End if (!$NSGObject)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules) 
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureNSGRuleName while ($true) {                                            # Inner loop to set the rule name
                Write-Host 'NSG name must be between 1 and 80 characters'                   # Write message to screen
                Write-Host 'NSG name must begin with a letter or number'                    # Write message to screen
                Write-Host 'NSG name must end with a letter, number, or -'                  # Write message to screen
                Write-Host 'NSG name body must be a letter, number, or _ . -'               # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                if ($CRules) {                                                              # If $CRules has a value
                    Write-Host 'The following names are already in use on:'$NSGObject.Name  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $CRules) {                                               # For each item in $CRules
                        Write-Host $_.name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $CRules)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CRules)
                Write-Host 'Enter the name of the new network security group rule'          # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                $NSGRuleName = Read-Host 'Name'                                             # Operator input for the NSG rule name
                Clear-Host                                                                  # Clears screen
                $NSGNameArray = $NSGRuleName.ToCharArray()                                  # Converts $NSGRuleName to array
                if ($NSGRuleName -in $CRules.Name) {                                        # If $NSGRuleName is in $CRules.Name
                    Write-Host $NSGRuleName' is already in use'                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGRuleName -in $CRules.Name)
                if ($NSGRuleName.Length -lt 1 -or $NSGRuleName.Length -gt 80) {             # If $NSGRuleName.Length less than 1 or $NSGRuleName.Length greater than 80
                    Write-Host 'NSG name must be between 1 and 80 characters'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGRuleName.Length -lt 1 -or $NSGRuleName.Length -gt 80)
                if ($NSGNameArray[0] -notin $VName1st) {                                    # If 0 position of $NSGNameArray is not in $VName1st
                    Write-Host  $NSGNameArray[0]' is not a valid start character'           # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGNameArray[0] -notin $VName1st)
                foreach ($_ in $NSGNameArray) {                                             # For each item in $NSGNameArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'NSG name cannot include any spaces'                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid body character'                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $NSGRuleName = $null                                                # Clears $NSGRuleName
                    }                                                                       # End if ($_ -notin $VNameElse)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($NSGNameArray[-1] -notin $VNameLast) {                                  # If last position of $NSGNameArray is not in $VNameLast
                    Write-Host  $NSGNameArray[-1]' is not a valid end character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGNameArray[-1] -notin $VNameLast)
                $NSGNameArray = $null                                                       # Clears $NSGNameArray
                if ($NSGRuleName) {                                                         # If $NSGRuleName has a value
                    Write-Host 'Use:'$NSGRuleName' as the NSG rule name'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the network security group name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureNSGRuleName                                           # Breaks :SetAzureNSGRuleName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureNSGRule                                               # Breaks :NewAzureNSGRule
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                }                                                                           # End if ($NSGRuleName)
                else {                                                                      # Else if $NSGRuleName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($NSGRuleName))
            }                                                                               # End :SetAzureNSGRuleName while ($true)
            $NSGRuleProtocol = SetAzNSGRuleProtocol                                         # Calls function and assigns output to $var
            if (!$NSGRuleProtocol) {                                                        # If $NSGRuleProtocol is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule    
            }                                                                               # End if (!$NSGRuleProtocol)
            $NSGRuleAccess = SetAzNSGRuleAccess                                             # Calls function and assigns output to $var
            if (!$NSGRuleAccess) {                                                          # If $NSGRuleAccess is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule    
            }                                                                               # End if (!$NSGRuleAccess)
            $NSGRuleDirection = SetAzNSGRuleDirection                                       # Calls function and assigns output to $var
            if (!$NSGRuleDirection) {                                                       # If $NSGRuleDirection is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleDirection)            
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            $NSGRulePriority = SetAzNSGRulePriority ($NSGObject, $NSGRuleDirection, $CRules)# Calls function and assigns output to $var
            if (!$NSGRulePriority) {                                                        # If NSGRulePriority is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                    
            }                                                                               # End if (!$NSGRulePriority)
            $NSGRuleSPRange = SetAzNSGRuleSPortRange                                        # Calls function and assigns output to $var
            if (!$NSGRuleSPRange) {                                                         # If $NSGRuleSPRange is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleSPRange)
            $NSGRuleDPRange = SetAzNSGRuleDPortRange                                        # Calls function and assigns output to $var
            if (!$NSGRuleDPRange) {                                                         # If $NSGRuleDPRange is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleDPRange)
            $NSGRuleSAPrefix = '*'                                                          # Sets $NSGRuleSAPrefix
            $NSGRuleDAPrefix = '*'                                                          # Sets $NSGRuleDAPrefix
            :ConfirmRule while ($true) {                                                    # Inner loop for confirming all inputs
                Write-Host 'Create the following rule:'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'NSG Name:        '$NSGObject.name                               # Write message to screen
                Write-Host 'Rule Name:       '$NSGRuleName                                  # Write message to screen
                Write-Host 'Protocol:        '$NSGRuleProtocol                              # Write message to screen
                Write-Host 'Access:          '$NSGRuleAccess                                # Write message to screen
                Write-Host 'Direction:       '$NSGRuleDirection                             # Write message to screen
                Write-Host 'Priority:        '$NSGRulePriority                              # Write message to screen
                Write-Host 'Source Port:     '$NSGRuleSPRange                               # Write message to screen
                Write-Host 'Destination Port:'$NSGRuleDPRange                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N]'                                        # Operator confirmation to build the rule
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break ConfirmRule                                                       # Breaks :ConfirmRule
                }                                                                           # End if ($OpConfirm -eq 'y') 
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End elseif ($OpConfirm -eq 'n')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y') )
            }                                                                               # End :ConfirmRule while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the NSG Rule'                                          # Write message to screen
                Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                    -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access $NSGRuleAccess `
                    -Direction $NSGRuleDirection -Priority $NSGRulePriority `
                    -SourcePortRange $NSGRuleSPRange -DestinationPortRange $NSGRuleDPRange `
                    -SourceAddressPrefix $NSGRuleSAPrefix -DestinationAddressPrefix `
                    $NSGRuleDAPrefix -ErrorAction 'Stop' | Out-Null                         # Creates the NSG rule
                Write-Host 'Saving the network security group'                              # Write message to screen
                Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                    -ErrorAction 'Stop' | Out-Null                                          # Saves NSG config
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'An error has occured'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureNSGRule                                                           # Breaks :NewAzureNSGRule
        }                                                                                   # End :NewAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End NewAzNSGRule
Function SetAzNSGRuleProtocol {                                                             # Function to set a network security group rule protocol
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleProtocol while ($true) {                                            # Inner loop to set the rule protocol
            Write-Host 'Select the rule protocol'                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Any'                                                            # Write message to screen
            Write-Host '[2] TCP'                                                            # Write message to screen
            Write-Host '[3] UPD'                                                            # Write message to screen
            Write-Host '[4] ICMP'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule port
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleProtocol                                               # Breaks :SetAzureNSGRuleProtocol
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleProtocol = '*'                                                      # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleProtocol = 'TCP'                                                    # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                $NSGRuleProtocol = 'UDP'                                                    # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                $NSGRuleProtocol = 'ICMP'                                                   # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
            if ($NSGRuleProtocol) {                                                         # If $NSGRuleProtocol has a value
                Return $NSGRuleProtocol                                                     # Returns to calling function with $NSGRuleProtocol
            }                                                                               # End if ($NSGRuleProtocol)
        }                                                                                   # End :SetAzureNSGRuleProtocol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End functon SetAzNSGRuleProtocol
Function SetAzNSGRuleAccess {                                                               # Function to set a network security group rule access
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleAccess while ($true) {                                              # Inner loop to set the rule access
            Write-Host 'Select the rule access'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Allow'                                                          # Write message to screen
            Write-Host '[2] Deny'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule access
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleAccess                                                 # Breaks :SetAzureNSGRuleAccess
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleAccess = 'Allow'                                                    # Sets $NSGRuleAccess
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleAccess = 'Deny'                                                     # Sets $NSGRuleAccess
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
            if ($NSGRuleAccess) {                                                           # If $NSGRuleAccess has a value
                Return $NSGRuleAccess                                                       # Returns to calling funtion with $NSGRuleAccess
            }                                                                               # End if ($NSGRuleAccess)
        }                                                                                   # End :SetAzureNSGRuleAccess while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function SetAzNSGRuleAccess
Function SetAzNSGRuleDirection {                                                            # Function to set a network security group rule direction
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleDirection while ($true) {                                           # Inner loop to set the rule direction
            Write-Host 'Select the rule direction'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Inbound'                                                        # Write message to screen
            Write-Host '[2] Outbound'                                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule direction
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleDirection                                              # Breaks :SetAzureNSGRuleDirection
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleDirection = 'Inbound'                                               # Sets $NSGRuleDirection
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleDirection = 'Outbound'                                              # Sets $NSGRuleDirection
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))   
            if ($NSGRuleDirection) {                                                        # If $NSGRuleDirection has a value
                Return $NSGRuleDirection                                                    # Returns to calling function with $NSGRuleDirection
            }                                                                               # End if ($NSGRuleDirection)
        }                                                                                   # End :SetAzureNSGRuleDirection while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function SetAzNSGRuleDirection
Function SetAzNSGRulePriority {                                                             # Function to set a network security group rule priority
    Begin {                                                                                 # Begin function
        if (!$CRules) {                                                                     # If $CRules is $null
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array 
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules) 
        }                                                                                   # End if (!$CRules)
        $ValidArray = '0123456789'                                                          # Creates a string of valid characters
        $ValidArray = $ValidArray.ToCharArray()                                             # Loads all valid characters into array    
        :SetAzureNSGRulePriority while ($true) {                                            # Inner loop to set the rule priority
            Write-Host 'NSG Rule priority'                                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule priority must be between the values of 100 and 4096'           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($CRules.Direction -eq $NSGRuleDirection) {                                  # If $CRules.Direction equals $NSGRuleDirection
                Write-Host 'The following priorities are'                                   # Write message to screen
                Write-Host 'already in use for'$NSGRuleDirection' traffic'                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $CRules) {                                                   # For each item in $CRules
                    if ($_.Direction -eq $NSGRuleDirection) {                               # If current item .Direction equals $NSGRuleDirection
                        Write-Host $_.Priority                                              # Write message to screen
                    }                                                                       # if ($_.Direction -eq $NSGRuleDirection)
                }                                                                           # End foreach ($_ in $CRules)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($CRules.Direction -eq $NSGRuleDirection)
            $NSGRulePriority = Read-Host 'Rule priority'                                    # Operator input for the rule priority
            Clear-Host                                                                      # Clears screen
            $NSGRuleArray = $NSGRulePriority.ToCharArray()                                  # Converts $NSGRulePriority into array
            foreach ($_ in $NSGRuleArray) {                                                 # For each item in $NSGRuleArray
                if ($_ -notin $ValidArray) {                                                # If current item is not in $ValidArray
                    $NSGRulePriority = $null                                                # Clears $var
                }                                                                           # End if ($_ -notin $ValidArray)
            }                                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
            $NSGRuleArray = $null                                                           # Clears $var
            $NSGRuleDirPri = $NSGRuleDirection+' '+$NSGRulePriority                         # $NSGRuleDirPri is equal to $NSGRuleDirection and $NSGRulePriority                     
            if ($NSGRuleDirPri -in $ObjectArray.DirPri) {                                   # If $NSGRuleDirPri is in $ObjectArray.DirPri
                Write-Host 'This priority is already in use for'$NSGRuleDirection           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please select a different priority'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $NSGRulePriority = $null                                                    # Clears $var
            }                                                                               # End if ($NSGRuleDirPri -in $ObjectArray.DirPri)
            $NSGRuleInt = [INT]$NSGRulePriority                                             # Converts $NSGRulePriority to integer
            if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096) {                             # if $NSGRuleInt is not between 100 and 4096
                Write-Host 'Rule priority must be between the values of 100 and 4096'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                $NSGRulePriority = $null                                                    # Clears $var
                $NSGRuleInt = $null                                                         # Clears $var
                $NSGRuleDirPri = $null                                                      # Clears $var
                Clear-Host                                                                  # Clears screen
            }                                                                               # End if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096)                                                                    
            else {                                                                          # Else if $NSGRuleInt is between 100 and 4096
                Write-Host 'Use:'$NSGRulePriority' as the rule priority'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the rule priority
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Return $NSGRulePriority                                                 # Returns to calling function with $NSGRulePriority
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End elseif ($OpConfirm -eq 'e')
                else {                                                                      # All other inputs for $OpConfirm
                    $NSGRulePriority = $null                                                # Clears $var
                    $NSGRuleInt = $null                                                     # Clears $var
                    $NSGRuleDirPri = $null                                                  # Clears $var
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End else (if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096))
        }                                                                                   # End :SetAzureNSGRulePriority while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End functon SetAzNSGRulePriority
Function SetAzNSGRuleSPortRange {                                                           # Function to set a network security rule source port range
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleSPRange while ($true) {                                             # Outer loop for managing function
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGPortRange while ($true) {                                           # Inner loop to set the rule source port range
                Write-Host 'NSG Rule Source Port Range'                                     # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] Single Port'                                                # Write message to screen
                Write-Host '[3] Multiple Ports'                                             # Write message to screen
                Write-Host '[4] Port Range'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the source port range
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureNSGRuleSPRange                                            # Breaks :SetAzureNSGRuleSPRange
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleSPRange = '*'                                                   # Sets $NSGRuleSPRange
                    Return $NSGRuleSPRange                                                  # Returns to calling function with $NSGRuleSPRange
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for settings a single source port
                        Write-Host 'Enter the source port'                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NSGRuleSPRange = Read-Host 'Port #'                                # Operator input for the source port number
                        $NSGRuleArray = $NSGRuleSPRange.ToCharArray()                       # Converts $NSGRuleSPRange into array
                        foreach ($_ in $NSGRuleArray) {                                     # For each item in $NSGRuleArray
                            if ($_ -notin $ValidArray) {                                    # If current item is not in $ValidArray
                                $NSGRuleSPRange = $null                                     # Clears $var
                            }                                                               # End if ($_ -notin $ValidArray)
                        }                                                                   # End foreach ($_ in $NSGRuleArray)                                                                       
                        $NSGRuleArray = $null                                               # Clears $var
                        if ($NSGRuleSPRange) {                                              # If $NSGRuleSPRange has a value
                            $NSGInt = [INT]$NSGRuleSPRange                                  # Converts $NSGRuleSPRange into interger
                            if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                      # IF $NSGInt is not between 0 and 65535
                                $NSGRuleSPRange = $null                                     # Clears $var
                            }                                                               # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                        }                                                                   # End if ($NSGRuleSPRange)
                        if ($NSGRuleSPRange) {                                              # If $NSGRuleSPRange has a value
                            Clear-Host                                                      # Clears screen
                            Write-Host 'Use:'$NSGRuleSPRange' as the source port'           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                # Operator confirmation of the source port
                            Clear-Host                                                      # Clears screen
                            if ($OpConfirm -eq 'y') {                                       # If $OpSelect -eq 'y'
                                Return $NSGRuleSPRange                                      # Returns to calling function with $NSGRuleSPRange
                            }                                                               # End if ($OpConfirm -eq 'y')
                            elseif ($OpConfirm -eq 'e') {                                   # Else if $OpSelect -eq 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End elseif ($OpConfirm -eq 'e')
                        }                                                                   # End if ($NSGRuleSPRange)
                        else {                                                              # Else if $NSGRuleSPRange is $null
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($NSGRuleSPRange))
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleSPList = @()                                                    # Creates $NSGRuleSPList
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting multiple source ports
                        :SetAzureNSGRulePortSingle while ($true) {                          # Inner loop for adding a port to the multiport list
                            Write-Host 'Enter the source port'                              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $NSGRuleSPAdd = Read-Host 'Port #'                              # Operator input for the source port number
                            $NSGRuleArray = $NSGRuleSPAdd.ToCharArray()                     # Converts $NSGRuleSPAdd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $NSGRuleSPAdd = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($NSGRuleSPAdd) {                                            # If $NSGRuleSPAdd has a value
                                $NSGInt = [INT]$NSGRuleSPAdd                                # Converts $NSGRuleSPAdd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $NSGRuleSPAdd = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($NSGRuleSPAdd)
                            if ($NSGRuleSPAdd) {                                            # If $NSGRuleSPAdd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Add:'$NSGRuleSPAdd' to source port list'        # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRulePortSingle                         # Breaks :SetAzureNSGRulePortSingle
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($NSGRuleSPRange)
                            else {                                                          # Else if $NSGRuleSPRange is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleSPRange))    
                        }                                                                   # End :SetAzureNSGRSPortSingle while ($true)
                        $NSGRuleSPList += $NSGRuleSPAdd                                     # Adds $NSGRuleSPAdd to $NSGRuleSPList
                        :ConfirmAzureNSGRulePorts while ($true) {                           # Inner loop to confirm the rule source ports
                            Write-Host 'Current source port list:'                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $NSGRuleSPList) {                                # For each item in $NSGRuleSPList
                                Write-Host $_                                               # Write message to screen
                            }                                                               # End foreach ($_ in $NSGRuleSPList) 
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Add another port'                                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                 # Operator selection to add more ports
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'e') {                                        # If $OpSelect equals 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End if ($OpSelect -eq 'e')
                            elseif ($OpSelect -eq 'n') {                                    # Else if $OpSelect equals 'n'
                                $NSGRuleSPRange = $NSGRuleSPList                            # $NSGRuleSPRange is equal to $NSGRuleSPList 
                                Return $NSGRuleSPRange                                      # Returns to calling function with $NSGRuleSPRange
                            }                                                               # End elseif ($OpSelect -eq 'n')
                            elseif ($OpSelect -eq 'y') {                                    # Else if $OpSelect equals 'y'
                                $NSGRuleSPAdd = $null                                       # Clears $var
                                Break ConfirmAzureNSGRulePorts                              # Breaks :ConfirmAzureNSGRulePorts
                            }                                                               # End elseif ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq 'e') )
                        }                                                                   # End :ConfirmAzureNSGRulePorts while ($true)
                    }                                                                       # End :SetAzureNSGRSPortMulti while ($true)
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting a source port range
                        :SetAzureNSGRSPortStart while ($true) {                             # Inner loop for settings a source port start
                            Write-Host 'Enter the source port range start '                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $SPRangeStart = Read-Host 'Starting Port #'                     # Operator input for the source port range start
                            $NSGRuleArray = $SPRangeStart.ToCharArray()                     # Converts $SPRangeStart into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $SPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($SPRangeStart) {                                            # If $SPRangeStart has a value
                                $NSGInt = [INT]$SPRangeStart                                # Converts $SPRangeStart into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $SPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($SPRangeStart)
                            if ($SPRangeStart) {                                            # If $SPRangeStart has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Use'$SPRangeStart' for source port range start' # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRSPortStart                            # Breaks :SetAzureNSGRSPortStart
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($SPRangeStart)
                            else {                                                          # Else if $SPRangeStart is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($SPRangeStart))
                        }                                                                   # End :SetAzureNSGRSPortStart while ($true)
                        :SetAzureNSGRSPortEnd while ($true) {                               # Inner loop for settings a source port end
                            Write-Host 'Enter the source port range end '                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $SPRangeEnd = Read-Host 'Ending Port #'                         # Operator input for the source port range end
                            $NSGRuleArray = $SPRangeEnd.ToCharArray()                       # Converts $SPRangeEnd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $SPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($SPRangeEnd) {                                              # If $SPRangeEnd has a value
                                $NSGInt = [INT]$SPRangeEnd                                  # Converts $SPRangeEnd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $SPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($SPRangeEnd)
                            if ($SPRangeEnd) {                                              # If $SPRangeEnd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Use'$SPRangeEnd' for source port range end'     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRSPortEnd                              # Breaks :SetAzureNSGRSPortEnd
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($SPRangeEnd)
                            else {                                                          # Else if $SPRangeEnd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($SPRangeEnd))
                        }                                                                   # End :SetAzureNSGRSPortEnd while ($true)
                        $NSGRuleSPRange = $SPRangeStart+'-'+$SPRangeEnd                     # $NSGRuleSPRange is equal to5 $SPRangeStart and $SPRangeEnd       
                        Write-Host 'Use'$NSGRuleSPRange' as the source port range'          # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the source port range
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Return $NSGRuleSPRange                                          # Returns to calling function with $NSGRuleSPRange
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureNSGRulePort                                       # Breaks :SetAzureNSGRulePort
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGPortRange while ($true)
        }                                                                                   # End :SetAzureNSGRuleSPRange while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleSPortRange
Function SetAzNSGRuleDPortRange {                                                           # Function to set a network security rule destination port range
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleDPRange while ($true) {                                             # Outer loop for managing function
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGPortRange while ($true) {                                           # Inner loop to set the rule destination port range
                Write-Host 'NSG Rule Destination Port Range'                                # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] Single Port'                                                # Write message to screen
                Write-Host '[3] Multiple Ports'                                             # Write message to screen
                Write-Host '[4] Port Range'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the destination port range
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureNSGRuleDPRange                                            # Breaks :SetAzureNSGRuleDPRange
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleDPRange = '*'                                                   # Sets $NSGRuleDPRange
                    Return $NSGRuleDPRange                                                  # Returns to calling function with $NSGRuleDPRange
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for settings a single destination port
                        Write-Host 'Enter the destination port'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NSGRuleDPRange = Read-Host 'Port #'                                # Operator input for the destination port number
                        $NSGRuleArray = $NSGRuleDPRange.ToCharArray()                       # Converts $NSGRuleDPRange into array
                        foreach ($_ in $NSGRuleArray) {                                     # For each item in $NSGRuleArray
                            if ($_ -notin $ValidArray) {                                    # If current item is not in $ValidArray
                                $NSGRuleDPRange = $null                                     # Clears $var
                            }                                                               # End if ($_ -notin $ValidArray)
                        }                                                                   # End foreach ($_ in $NSGRuleArray)                                                                       
                        $NSGRuleArray = $null                                               # Clears $var
                        if ($NSGRuleDPRange) {                                              # If $NSGRuleDPRange has a value
                            $NSGInt = [INT]$NSGRuleDPRange                                  # Converts $NSGRuleDPRange into interger
                            if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                      # IF $NSGInt is not between 0 and 65535
                                $NSGRuleDPRange = $null                                     # Clears $var
                            }                                                               # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                        }                                                                   # End if ($NSGRuleDPRange)
                        if ($NSGRuleDPRange) {                                              # If $NSGRuleDPRange has a value
                            Clear-Host                                                      # Clears screen
                            Write-Host 'Use:'$NSGRuleDPRange' as the destination port'      # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                # Operator confirmation of the destination port
                            Clear-Host                                                      # Clears screen
                            if ($OpConfirm -eq 'y') {                                       # If $OpSelect -eq 'y'
                                Return $NSGRuleDPRange                                      # Returns to calling function with $NSGRuleDPRange
                            }                                                               # End if ($OpConfirm -eq 'y')
                            elseif ($OpConfirm -eq 'e') {                                   # Else if $OpSelect -eq 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End elseif ($OpConfirm -eq 'e')
                        }                                                                   # End if ($NSGRuleDPRange)
                        else {                                                              # Else if $NSGRuleDPRange is $null
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($NSGRuleDPRange))
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleDPList = @()                                                    # Creates $NSGRuleDPList
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting multiple destination ports
                        :SetAzureNSGRulePortSingle while ($true) {                          # Inner loop for adding a port to the multiport list
                            Write-Host 'Enter the destination port'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $NSGRuleDPAdd = Read-Host 'Port #'                              # Operator input for the destination port number
                            $NSGRuleArray = $NSGRuleDPAdd.ToCharArray()                     # Converts $NSGRuleDPAdd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $NSGRuleDPAdd = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($NSGRuleDPAdd) {                                            # If $NSGRuleDPAdd has a value
                                $NSGInt = [INT]$NSGRuleDPAdd                                # Converts $NSGRuleDPAdd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $NSGRuleDPAdd = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($NSGRuleDPAdd)
                            if ($NSGRuleDPAdd) {                                            # If $NSGRuleDPAdd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Add:'$NSGRuleDPAdd' to destination port list'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRulePortSingle                         # Breaks :SetAzureNSGRulePortSingle
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($NSGRuleDPAdd)
                            else {                                                          # Else if $NSGRuleDPAdd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleDPAdd))    
                        }                                                                   # End :SetAzureNSGRSPortSingle while ($true)
                        $NSGRuleDPList += $NSGRuleDPAdd                                     # Adds $NSGRuleDPAdd to $NSGRuleDPList
                        :ConfirmAzureNSGRulePorts while ($true) {                           # Inner loop to confirm the rule destination ports
                            Write-Host 'Current destination port list:'                     # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $NSGRuleDPList) {                                # For each item in $NSGRuleDPList
                                Write-Host $_                                               # Write message to screen
                            }                                                               # End foreach ($_ in $NSGRuleDPList) 
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Add another port'                                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                 # Operator selection to add more ports
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'e') {                                        # If $OpSelect equals 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End if ($OpSelect -eq 'e')
                            elseif ($OpSelect -eq 'n') {                                    # Else if $OpSelect equals 'n'
                                $NSGRuleDPRange = $NSGRuleDPList                            # $NSGRuleDPRange is equal to $NSGRuleDPList 
                                Return $NSGRuleDPRange                                      # Returns to calling function with $NSGRuleDPRange
                            }                                                               # End elseif ($OpSelect -eq 'n')
                            elseif ($OpSelect -eq 'y') {                                    # Else if $OpSelect equals 'y'
                                $NSGRuleDPAdd = $null                                       # Clears $var
                                Break ConfirmAzureNSGRulePorts                              # Breaks :ConfirmAzureNSGRulePorts
                            }                                                               # End elseif ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq 'e') )
                        }                                                                   # End :ConfirmAzureNSGRulePorts while ($true)
                    }                                                                       # End :SetAzureNSGRSPortMulti while ($true)
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting a destination port range
                        :SetAzureNSGRDPortStart while ($true) {                             # Inner loop for settings a destination port start
                            Write-Host 'Enter the destination port range start '            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $DPRangeStart = Read-Host 'Starting Port #'                     # Operator input for the destination port range start
                            $NSGRuleArray = $DPRangeStart.ToCharArray()                     # Converts $DPRangeStart into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $DPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($DPRangeStart) {                                            # If $DPRangeStart has a value
                                $NSGInt = [INT]$DPRangeStart                                # Converts $DPRangeStart into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $DPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($DPRangeStart)
                            if ($DPRangeStart) {                                            # If $DPRangeStart has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host `
                                    'Use'$DPRangeStart' for destination port range start'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRDPortStart                            # Breaks :SetAzureNSGRDPortStart
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($DPRangeStart)
                            else {                                                          # Else if $DPRangeStart is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleDPRange))
                        }                                                                   # End :SetAzureNSGRDPortStart while ($true)
                        :SetAzureNSGRDPortEnd while ($true) {                               # Inner loop for settings a destination port end
                            Write-Host 'Enter the destination port range end '              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $DPRangeEnd = Read-Host 'Ending Port #'                         # Operator input for the destination port range end
                            $NSGRuleArray = $DPRangeEnd.ToCharArray()                       # Converts $DPRangeEnd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $DPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($DPRangeEnd) {                                              # If $DPRangeEnd has a value
                                $NSGInt = [INT]$DPRangeEnd                                  # Converts $DPRangeEnd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $DPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($DPRangeEnd)
                            if ($DPRangeEnd) {                                              # If $DPRangeEnd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host `
                                    'Use'$DPRangeEnd' for destination port range end'       # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRDPortEnd                              # Breaks :SetAzureNSGRDPortEnd
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($DPRangeEnd)
                            else {                                                          # Else if $DPRangeEnd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($DPRangeEnd))
                        }                                                                   # End :SetAzureNSGRDPortEnd while ($true)
                        $NSGRuleDPRange = $DPRangeStart+'-'+$DPRangeEnd                     # $NSGRuleDPRange is equal to5 $DPRangeStart and $DPRangeEnd       
                        Write-Host 'Use'$NSGRuleDPRange' as the destination port range'     # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the destination port range
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Return $NSGRuleDPRange                                          # Returns to calling function with $NSGRuleDPRange
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureNSGRulePort                                       # Breaks :SetAzureNSGRulePort
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGPortRange while ($true)
        }                                                                                   # End :SetAzureNSGRuleDPRange while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleDPortRange
function ListAzNSGRule {                                                                    # Function to list a network security group rules
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'ListAzNSGRule'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ListAzureNSGRule while ($true) {                                                   # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break ListAzureNSGRule                                                      # Breaks :ListAzureNSGRule
            }                                                                               # End if (!$NSGObject)
            $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject  # Gets a list of all non-default rules on $NSGObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$_.Name;                                                         # Rule config name
                    'Descript'=$_.Description;                                              # Rule config description
                    'Proto'=$_.Protocol;                                                    # Rule config protocol
                    'SPRange'=$_.SourcePortRange;                                           # Rule config source port range
                    'DPRange'=$_.DestinationPortRange;                                      # Rule config destination port range
                    'SAPrefix'=$_.SourceAddressPrefix;                                      # Rule config source address prefix
                    'DAPrefix'=$_.DestinationAddressPrefix;                                 # Rule config destination address prefix
                    'SASG'=$_.SourceApplicationSecurityGroups;                              # Rule config source application security groups
                    'DASG'=$_.DestinationApplicationSecurityGroups;                         # Rule config destination application security groups
                    'Access'=$_.Access;                                                     # Rule config access
                    'PRI'=$_.Priority;                                                      # Rule config priority
                    'Direction'=$_.Direction                                                # Rule config direction
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on this network security group'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSGRule                                                      # Breaks :ListAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:      '$_.Name                                        # Write message to screen
                Write-Host 'Protocol:       '$_.Proto                                       # Write message to screen
                Write-Host 'Source'                                                         # Write message to screen
                Write-Host ' Port Range:    '$_.SPRange                                     # Write message to screen
                Write-Host ' Address Prefix:'$_.SAPrefix                                    # Write message to screen
                if ($_.SASG) {                                                              # If $_.SASG has a value
                    Write-Host ' Security Group:'$_.SASG                                    # Write message to screen
                }                                                                           # End if ($_.SASG)
                Write-Host 'Destination'                                                    # Write message to screen
                Write-Host ' Port Range:    '$_.DPRange                                     # Write message to screen
                Write-Host ' Address Prefix:'$_.DAPrefix                                    # Write message to screen
                if ($_.DASG) {                                                              # If $_.DASG has a value
                    Write-Host ' Security Group:'$_.DASG                                    # Write message to screen
                }                                                                           # End if ($_.DASG)
                Write-Host 'Access:         '$_.Access                                      # Write message to screen
                Write-Host 'Priority:       '$_.PRI                                         # Write message to screen
                Write-Host 'Direction:      '$_.Direction                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNSGRule                                                          # Breaks :ListAzureNSGRule
        }                                                                                   # End :ListAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNSGRule
function ListAzAllNSGsRule {                                                                # Function to list all rules from all network security groupss
    Begin {                                                                                 # Begin function
        :GetAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            $NSGList = Get-AzNetworkSecurityGroup                                           # Gets a list of all network security groups
            if (!$NSGList) {                                                                # If $NSGList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No network security groups exist in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$NSGList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $NSGList) {                                                      # Foreach item in $NSGList
                $NSGObject = $_                                                             # $NSGObject is equal to current item
                $NSGName = $_.Name                                                          # $NSGName is equal to current item .name
                $NSGRG = $_.ResourceGroupName                                               # $NSGRG is equal to current item .ResourceGroupName
                $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                    $NSGObject                                                              # Gets a list of all non-default rules on $NSGObject
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Name'=$_.Name;                                                     # Rule config name
                        'NSGName'=$NSGName;                                                 # Network security group name
                        'NSGRG'=$NSGRG;                                                     # Network security group resource group
                        'Descript'=$_.Description;                                          # Rule config description
                        'Proto'=$_.Protocol;                                                # Rule config protocol
                        'SPRange'=$_.SourcePortRange;                                       # Rule config source port range
                        'DPRange'=$_.DestinationPortRange;                                  # Rule config destination port range
                        'SAPrefix'=$_.SourceAddressPrefix;                                  # Rule config source address prefix
                        'DAPrefix'=$_.DestinationAddressPrefix;                             # Rule config destination address prefix
                        'SASG'=$_.SourceApplicationSecurityGroups;                          # Rule config source application security groups
                        'DASG'=$_.DestinationApplicationSecurityGroups;                     # Rule config destination application security groups
                        'Access'=$_.Access;                                                 # Rule config access
                        'PRI'=$_.Priority;                                                  # Rule config priority
                        'Direction'=$_.Direction                                            # Rule config direction
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Addes $ObjectInput to $ObjectArray
                }                                                                           # End foreach ($_ in $ObjectList)
                $NSGObject = $null                                                          # Clears $var
                $NSGName = $null                                                            # Clears $var
                $NSGRG = $null                                                              # Clears $var
                $ObjectList = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on any network security groups'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:      '$_.Name                                        # Write message to screen
                Write-Host 'NSG Name:       '$_.NSGName                                     # Write message to screen
                Write-Host 'Rule RG:        '$_.NSGRG                                       # Write message to screen
                if ($_.Descript) {                                                          # If current item .Descript has a value
                    Write-Host 'Description:    '$_.Descript                                # Write message to screen
                }                                                                           # End if ($_.Descript)
                Write-Host 'Protocol:       '$_.Proto                                       # Write message to screen
                Write-Host 'Source'                                                         # Write message to screen
                Write-Host ' Port Range:    '$_.SPRange                                     # Write message to screen
                Write-Host ' Address Prefix:'$_.SAPrefix                                    # Write message to screen
                if ($_.SASG) {                                                              # If $_.SASG has a value
                    Write-Host ' Security Group:'$_.SASG                                    # Write message to screen
                }                                                                           # End if ($_.SASG)
                Write-Host 'Destination'                                                    # Write message to screen
                Write-Host ' Port Range:    '$_.DPRange                                     # Write message to screen
                Write-Host ' Address Prefix:'$_.DAPrefix                                    # Write message to screen
                if ($_.DASG) {                                                              # If $_.DASG has a value
                    Write-Host ' Security Group:'$_.DASG                                    # Write message to screen
                }                                                                           # End if ($_.DASG)
                Write-Host 'Access:         '$_.Access                                      # Write message to screen
                Write-Host 'Priority:       '$_.PRI                                         # Write message to screen
                Write-Host 'Direction:      '$_.Direction                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break GetAzureNSGRule                                                           # Breaks :GetAzureNSGRule
        }                                                                                   # End :GetAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzAllNSGsRule
function GetAzAllNSGsRule {                                                                 # Function to get a rule from all network security groups
    Begin {                                                                                 # Begin function
        :GetAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            $NSGList = Get-AzNetworkSecurityGroup                                           # Gets a list of all network security groups
            if (!$NSGList) {                                                                # If $NSGList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No network security groups exist in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$NSGList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $NSGList) {                                                      # Foreach item in $NSGList
                $NSGObject = $_                                                             # $NSGObject is equal to current item
                $NSGName = $_.Name                                                          # $NSGName is equal to current item .name
                $NSGRG = $_.ResourceGroupName                                               # $NSGRG is equal to current item .ResourceGroupName
                $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                    $NSGObject                                                              # Gets a list of all non-default rules on $NSGObject
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList  
                    if ($_.SourceApplicationSecurityGroups.ID) {                            # If ($_.SourceApplicationSecurityGroups.ID has a value
                        $SAppSecGID = $_.SourceApplicationSecurityGroups.ID                 # $SAppSecGID is equal to $_.SourceApplicationSecurityGroups.ID
                        $SAppSecGID = $SAppSecGID.Split('/')[-1]                            # Isolates the name of the application security group
                    }                                                                       # End if ($_.SourceApplicationSecurityGroups.ID)
                    if ($_.DestinationApplicationSecurityGroups.ID) {                       # If ($_.DestinationApplicationSecurityGroups.ID has a value
                        $DAppSecGID = $_.DestinationApplicationSecurityGroups.ID            # DSAppSecGID is equal to $_.DestinationApplicationSecurityGroups.ID
                        $DAppSecGID = $DAppSecGID.Split('/')[-1]                            # Isolates the name of the application security group
                    }                                                                       # End if ($_.DestinationApplicationSecurityGroups.ID)
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$_.Name;                                                     # Rule config name
                        'NSGName'=$NSGName;                                                 # Network security group name
                        'NSGRG'=$NSGRG;                                                     # Network security group resource group
                        'Descript'=$_.Description;                                          # Rule config description
                        'Proto'=$_.Protocol;                                                # Rule config protocol
                        'SPRange'=$_.SourcePortRange;                                       # Rule config source port range
                        'DPRange'=$_.DestinationPortRange;                                  # Rule config destination port range
                        'SAPrefix'=$_.SourceAddressPrefix;                                  # Rule config source address prefix
                        'DAPrefix'=$_.DestinationAddressPrefix;                             # Rule config destination address prefix
                        'SASG'=$SAppSecGID;                                                 # Rule config source application security groups
                        'DASG'=$DAppSecGID;                                                 # Rule config destination application security groups
                        'Access'=$_.Access;                                                 # Rule config access
                        'PRI'=$_.Priority;                                                  # Rule config priority
                        'Direction'=$_.Direction                                            # Rule config direction
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Addes $ObjectInput to $ObjectArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                    $SAppSecGID = $null                                                     # Clears $var
                    $DAppSecGID = $null                                                     # Clears $var
                }                                                                           # End foreach ($_ in $ObjectList)
                $NSGObject = $null                                                          # Clears $var
                $NSGName = $null                                                            # Clears $var
                $NSGRG = $null                                                              # Clears $var
                $ObjectList = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on any network security groups'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            :SelectAzNSGRule while ($true) {                                                # Inner loop for selecting the NSG rule
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is greater than 0
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'NSG Name:       '$_.NSGName                                 # Write message to screen
                    Write-Host 'Rule RG:        '$_.NSGRG                                   # Write message to screen
                    if ($_.Descript) {                                                      # If current item .Descript has a value
                        Write-Host 'Description:    '$_.Descript                            # Write message to screen
                    }                                                                       # End if ($_.Descript)
                    Write-Host 'Protocol:       '$_.Proto                                   # Write message to screen
                    Write-Host 'Source'                                                     # Write message to screen
                    Write-Host ' Port Range:    '$_.SPRange                                 # Write message to screen
                    Write-Host ' Address Prefix:'$_.SAPrefix                                # Write message to screen
                    if ($_.SASG) {                                                          # If $_.SASG has a value
                        Write-Host ' Security Group:'$_.SASG                                # Write message to screen
                    }                                                                       # End if ($_.SASG)
                    Write-Host 'Destination'                                                # Write message to screen
                    Write-Host ' Port Range:    '$_.DPRange                                 # Write message to screen
                    Write-Host ' Address Prefix:'$_.DAPrefix                                # Write message to screen
                    if ($_.DASG) {                                                          # If $_.DASG has a value
                        Write-Host ' Security Group:'$_.DASG                                # Write message to screen
                    }                                                                       # End if ($_.DASG)
                    Write-Host 'Access:         '$_.Access                                  # Write message to screen
                    Write-Host 'Priority:       '$_.PRI                                     # Write message to screen
                    Write-Host 'Direction:      '$_.Direction                               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the NSG rule for:'$CallingFunction        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureNSGRule                                                   # Breaks :GetAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.NSGName `
                        -ResourceGroupName $OpSelect.NSGRG
                    $NSGRuleObject = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                        $NSGObject -Name $OpSelect.name
                    Return $NSGRuleObject, $NSGObject                                       # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzNSGRule while ($true)
        }                                                                                   # End :GetAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzAllNSGsRule
function GetAzNSGRule {                                                                     # Function to get a network security group rule
    Begin {                                                                                 # Begin function
        :GetAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$NSGObject)
            $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject  # Gets a list of all non-default rules on $NSGObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule config name
                    'Descript'=$_.Description;                                              # Rule config description
                    'Proto'=$_.Protocol;                                                    # Rule config protocol
                    'SPRange'=$_.SourcePortRange;                                           # Rule config source port range
                    'DPRange'=$_.DestinationPortRange;                                      # Rule config destination port range
                    'SAPrefix'=$_.SourceAddressPrefix;                                      # Rule config source address prefix
                    'DAPrefix'=$_.DestinationAddressPrefix;                                 # Rule config destination address prefix
                    'SASG'=$_.SourceApplicationSecurityGroups;                              # Rule config source application security groups
                    'DASG'=$_.DestinationApplicationSecurityGroups;                         # Rule config destination application security groups
                    'Access'=$_.Access;                                                     # Rule config access
                    'PRI'=$_.Priority;                                                      # Rule config priority
                    'Direction'=$_.Direction                                                # Rule config direction
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on this network security group'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            :SelectAzNSGRule while ($true) {                                                # Inner loop for selecting the NSG rule
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is greater than 0
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    if ($_.Descript) {                                                      # If current item .Descript has a value
                        Write-Host 'Description:    '$_.Descript                            # Write message to screen
                    }                                                                       # End if ($_.Descript)
                    Write-Host 'Protocol:       '$_.Proto                                   # Write message to screen
                    Write-Host 'Source'                                                     # Write message to screen
                    Write-Host ' Port Range:    '$_.SPRange                                 # Write message to screen
                    Write-Host ' Address Prefix:'$_.SAPrefix                                # Write message to screen
                    if ($_.SASG) {                                                          # If $_.SASG has a value
                        Write-Host ' Security Group:'$_.SASG                                # Write message to screen
                    }                                                                       # End if ($_.SASG)
                    Write-Host 'Destination'                                                # Write message to screen
                    Write-Host ' Port Range:    '$_.DPRange                                 # Write message to screen
                    Write-Host ' Address Prefix:'$_.DAPrefix                                # Write message to screen
                    if ($_.DASG) {                                                          # If $_.DASG has a value
                        Write-Host ' Security Group:'$_.DASG                                # Write message to screen
                    }                                                                       # End if ($_.DASG)
                    Write-Host 'Access:         '$_.Access                                  # Write message to screen
                    Write-Host 'Priority:       '$_.PRI                                     # Write message to screen
                    Write-Host 'Direction:      '$_.Direction                               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the NSG rule for:'$CallingFunction        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureNSGRule                                                   # Breaks :GetAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.NSGName `
                        -ResourceGroupName $OpSelect.NSGRG
                    $NSGRuleObject = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                        $NSGObject -Name $OpSelect.name
                    Return $NSGRuleObject, $NSGObject                                       # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzNSGRule while ($true)
        }                                                                                   # End :GetAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNSGRule
function RemoveAzNSGRule {                                                                  # Function to remove a network security group rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'RemoveAzNSGRule'                                            # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureNSGRule while ($true) {                                                 # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break RemoveAzureNSGRule                                                # Breaks :RemoveAzureNSGRule    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)
            Write-Host 'Remove the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:       '$NSGRuleObject.Name                               # Write message to screen
            Write-Host 'Access:          '$NSGRuleObject.Access                             # Write message to screen
            Write-Host 'Protocol:        '$NSGRuleObject.Protocol                           # Write message to screen
            Write-Host 'Priority:        '$NSGRuleObject.Priority                           # Write message to screen
            Write-Host 'Direction:       '$NSGRuleObject.Direction                          # Write message to screen
            Write-Host 'Source Port:     '$NSGRuleObject.SourcePortRange                    # Write message to screen
            Write-Host 'Destination Port:'$NSGRuleObject.DestinationPortRange               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing network security group rule'                           # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleObject.Name -ErrorAction 'Stop' | Out-Null            # Removes the network security group rule
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen   
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSGRule                                                # Breaks :RemoveAzureNSGRule
                }                                                                           # End catch
                Write-Host 'Saving network security group config'                           # Write message to screen
                Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                    -ErrorAction 'Stop' | Out-Null                                          # Saves the updated network security group
                Clear-Host                                                                  # Clears screen
                Write-Host 'The network security group rule has been removed'               # Write message to screen   
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGRule                                                    # Breaks :RemoveAzureNSGRule
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGRule                                                    # Breaks :RemoveAzureNSGRule
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :RemoveAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNSGRule
function UpdateAzNSGRAccess {                                                               # Function to update a network security group rule access
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRAccess'                                         # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleAccess = SetAzNSGRuleAccess ($CallingFunction)                      # Calls function and assigns output to $var
                if (!$NSGRuleAccess) {                                                      # If $NSGRuleAccess is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleAccess)
                else {                                                                      # Else if $NSGRuleAccess has a value
                    $RAccess = $NSGRuleAccess                                               # Updates $RAccess     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleAccess))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Access'                                                  # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.Access                                    # Write message to screen
            Write-Host 'New:      '$RAccess                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRAccess
function UpdateAzNSGRDirection {                                                            # Function to update a network security group rule direction
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRDirection'                                      # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)     
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules)        
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleDirection = SetAzNSGRuleDirection ($CallingFunction)                # Calls function and assigns output to $var
                if (!$NSGRuleDirection) {                                                   # If $NSGRuleDirection is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleDirection)
                else {                                                                      # Else if $NSGRuleDirection has a value
                    $NSGRuleDirPri = $NSGRuleDirection+' '+$RPriori                         # $NSGRuleDirPri is equal to $NSGRuleDirection and $RPriori                     
                    if ($NSGRuleDirPri -in $ObjectArray.DirPri) {                           # If $NSGRuleDirPri is in $ObjectArray.DirPri
                        Write-Host 'The priority:'$RPriori' is already'                     # Write message to screen
                        Write-Host 'is already in use on an'$NSGRuleDirection' rule'        # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'You will need to change the priority'                   # Write message to screen
                        Write-Host 'of this rule before you can change'                     # Write message to screen
                        Write-Host 'the direction of this rule'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input    
                        Break ChangeAzureNSRGConfig                                         # Breaks :ChangeAzureNSRGConfig    
                    }                                                                       # End if ($NSGRuleDirPri -in $ObjectArray.DirPri)
                    $RDirect = $NSGRuleDirection                                            # Updates $RDirect     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleDirection))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Direction'                                               # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.Direction                                 # Write message to screen
            Write-Host 'New:      '$RDirect                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRDirection
function UpdateAzNSGRPriority {                                                             # Function to update a network security group rule priotiry
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRPriority'                                       # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            $NSGRuleDirection = $NSGRuleObject.Direction                                    # $NSGRuleDirection is equal to $NSGRuleObject.Direction       
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRulePriority = SetAzNSGRulePriority ($CallingFunction, $NSGObject, `
                    $NSGRuleObject, $NSGRuleDirection)                                      # Calls function and assigns output to $var
                if (!$NSGRulePriority) {                                                    # If $NSGRulePriority is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRulePriority)
                else {                                                                      # Else if $NSGRulePriority has a value
                    $RPriori = $NSGRulePriority                                             # Updates $RPriori     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRulePriority))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Priority'                                                # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.Priority                                  # Write message to screen
            Write-Host 'New:      '$RPriori                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRPriority
function UpdateAzNSGRProtocol {                                                             # Function to update a network security group rule protocol
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRProtocol'                                       # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleProtocol = SetAzNSGRuleProtocol ($CallingFunction)                  # Calls function and assigns output to $var
                if (!$NSGRuleProtocol) {                                                    # If $NSGRuleProtocol is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleProtocol)
                else {                                                                      # Else if $NSGRuleProtocol has a value
                    $RProto = $NSGRuleProtocol                                              # Updates $Rproto     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleProtocol))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Protocol'                                                # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.Protocol                                  # Write message to screen
            Write-Host 'New:      '$NSGRuleProtocol                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRProtocol
function UpdateAzNSGRSPRange {                                                              # Function to update a network security group rule source port range
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRSPRange'                                        # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleSPRange = SetAzNSGRuleSPortRange ($CallingFunction)                 # Calls function and assigns output to $var
                if (!$NSGRuleSPRange) {                                                     # If $NSGRuleSPRange is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleSPRange)
                else {                                                                      # Else if $NSGRuleSPRange has a value
                    $RSPRang = $NSGRuleSPRange                                              # Updates $RSPRang     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleSPRange))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Source Port Range'                                       # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.SourcePortRange                           # Write message to screen
            Write-Host 'New:      '$RSPRang                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRSPRange
function UpdateAzNSGRDPRange {                                                              # Function to update a network security group rule destination port range
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRDPRange'                                        # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleDPRange = SetAzNSGRuleDPortRange ($CallingFunction)                 # Calls function and assigns output to $var
                if (!$NSGRuleDPRange) {                                                     # If $NSGRuleDPRange is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleDPRange)
                else {                                                                      # Else if $NSGRuleDPRange has a value
                    $RDPRang = $NSGRuleDPRange                                              # Updates $RDPRang     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleDPRange))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Destination Port Range'                                  # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.DestinationPortRange                      # Write message to screen
            Write-Host 'New:      '$RDPRang                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRDPRange
function UpdateAzNSGRSAppSecG {                                                             # Function to update a network security group rule source application security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRSAppSecG'                                       # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $ASGObject = GetAzASG ($CallingFunction)                                    # Calls function and assigns output to $var
                if (!$ASGObject) {                                                          # If $ASGObject is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$ASGObject)
                else {                                                                      # Else if $ASGObject has a value
                    $RSASGr = $ASGObject.ID                                                 # Updates $RSASGr    
                    $AppSecGroupName = $ASGObject.ID.split('/')[-1]                         # Isolates the application security group name 
                    $RSAddre = $null                                                        # Clears $RSAddre
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$ASGObject))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            if ($NSGRuleObject.SourceApplicationSecurityGroups.ID) {                        # If $NSGRuleObject.SourceApplicationSecurityGroups.ID has a value
                $CurrentAppSecGroup = $NSGRuleObject.SourceApplicationSecurityGroups.ID     # $CurrentAppSecGroup is equal to $NSGRuleObject.SourceApplicationSecurityGroups.ID 
                $CurrentAppSecGroup = $CurrentAppSecGroup.Split('/')[-1]                    # Isolates the app security group name
            }                                                                               # End if ($NSGRuleObject.SourceApplicationSecurityGroups.ID)
            else {                                                                          # Else if $NSGRuleObject.SourceApplicationSecurityGroups.ID is $null
                $CurrentAppSecGroup = 'N/A'                                                 # $CurrentAppSecGroup is equal to 'N/A'
            }                                                                               # End else (if ($NSGRuleObject.SourceApplicationSecurityGroups.ID))
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Source App Sec Group'                                    # Write message to screen
            Write-Host 'Current:  '$CurrentAppSecGroup                                      # Write message to screen
            Write-Host 'New:      '$AppSecGroupName                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRSAppSecG
function UpdateAzNSGRuleConfig {                                                            # Function for updating network security group rule configs
    Begin {                                                                                 # Begin function
        Write-Host 'Updating network security group rule'                                   # Write message to screen
            Try {                                                                           # Try the following
                if ($RSAddre -and $RDAddre) {                                               # If $RSAddre -and $RDAddre have values
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -SourceAddressPrefix $RSAddre -DestinationPortRange `
                        $RDPRang -DestinationAddressPrefix $RDAddre `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                                                                           # End if ($RSAddre -and $RDAddre)
                elseif ($RSAddre -and $RDASGr) {                                            # Else if $RSAddre -and $RDASGr have values
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -SourceAddressPrefix $RSAddre -DestinationPortRange `
                        $RDPRang -DestinationApplicationSecurityGroupID $RDASGr `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                                                                           # End elseif ($RSAddre -and $RDASGr)
                elseif ($RSASGr -and $RDAddre) {                                            # Else if $RSASGr -and $RDAddre have values
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -DestinationPortRange $RDPRang -DestinationAddressPrefix `
                        $RDAddre -SourceApplicationSecurityGroupID $RSASGr `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                               
                elseif ($RSASGr -and $RDASGr) {                                             # Else if $RSASGr -and $RDASGr have values      
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                    -Name $RName -Description $RDescri -Protocol $RProto -Access `
                    $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                    $RSPRang -DestinationPortRange $RDPRang `
                    -SourceApplicationSecurityGroupID $RSASGr `
                    -DestinationApplicationSecurityGroupID $RDASGr `
                    -ErrorAction 'Stop' | Out-Null                                          # Updates the rule protocol
                }                                                                           # End elseif ($RSASGr -and $RDASGr)
                else {                                                                      # All other configurations
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                    -Name $RName -Description $RDescri -Protocol $RProto -Access `
                    $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                    $RSPRang -DestinationPortRange $RDPRang -ErrorAction 'Stop' | Out-Null  # Updates the rule protocol
                }                                                                           # End else (if ($RSAddre -and $RDAddre)
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen   
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Return $null                                                                # Returns to calling function with $null
            }                                                                               # End catch
            Write-Host 'Saving network security group config'                               # Write message to screen
            Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                -ErrorAction 'Stop' | Out-Null                                              # Saves the updated network security group
            Clear-Host                                                                      # Clears screen
            Write-Host 'The network security group rule has been updated'                   # Write message to screen   
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Return $null                                                                    # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End UpdateAzNSGRuleConfig

# Addition functions required for ManageAzNSGRule
function GetAzNSG {                                                                         # Function to get a network security group
    Begin {                                                                                 # Begin function
        :GetAzureNSG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network security group info'                              # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Gets a list of all network security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSG                                                           # Breaks :GetAzureNSG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'SrulesCount'=$_.SecurityRules.Count;                                   # Security rules count
                    'DrulesCount'=$_.DefaultSecurityRules.Count                             # Default security rules count
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureNSG while ($true) {                                                 # Inner loop for selecting the network security group
                Write-Host '[0]                  Exit'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                 "$_.Name                      # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]                "$_.Name                       # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule RG:            '$_.RG                                  # Write message to screen
                    Write-Host 'Rule Loc:           '$_.Location                            # Write message to screen
                    Write-Host 'Sec Rules Count:    '$_.SrulesCount                         # Write message to screen
                    Write-Host 'Default Rules Count:'$_.DRulesCount                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the network security group for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the network security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNSG                                                       # Breaks :GetAzureNSG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full network security group object
                    Return $NSGObject                                                       # Returns to calling function with network security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureNSG while ($true)
        }                                                                                   # End :GetAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzNSG
function GetAzASG {                                                                         # Function to get a application security group
    Begin {                                                                                 # Begin function
        :GetAzureASG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering application security group info'                          # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzApplicationSecurityGroup                                    # Gets a list of all application security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureASG                                                           # Breaks :GetAzureASG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGID = $_.ID                                                              # $ASGID is equal to current item .ID
                $NICList = Get-AzNetworkInterface | Where-Object `
                    {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGID}           # Gets a list of nics in $ASGID
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'NICCount'=$NICList.Count                                               # Count of nic associated to the current application security group
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGID = $null                                                              # Clears $var
                $NicList = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureASG while ($true) {                                                 # Inner loop for selecting the application security group
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule RG:        '$_.RG                                      # Write message to screen
                    Write-Host 'Rule Loc:       '$_.Location                                # Write message to screen
                    if ($_.NicCount) {                                                      # If $NicCount has a value
                        Write-Host 'Associated NICS:'$_.NICCount                            # Write message to screen
                    }                                                                       # End if ($_.NicCount)
                    else {                                                                  # Else if $NicCount is $null
                        Write-Host 'Associated NICS: N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.NicCount))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the app security group for:'$CallingFunction     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the application security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureASG                                                       # Breaks :GetAzureASG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $ASGObject = Get-AzApplicationSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full application security group object
                    Return $ASGObject                                                       # Returns to calling function with application security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureASG while ($true)
        }                                                                                   # End :GetAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzASG