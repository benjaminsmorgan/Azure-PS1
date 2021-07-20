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
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
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
            :SetAzureNSGRuleProtocol while ($true) {                                        # Inner loop to set the rule protocol
                Write-Host 'Select the rule protocol'                                       # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] TCP'                                                        # Write message to screen
                Write-Host '[3] UPD'                                                        # Write message to screen
                Write-Host '[4] ICMP'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the rule port
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleProtocol = '*'                                                  # Sets $NSGRuleProtocol
                    Break SetAzureNSGRuleProtocol                                           # Breaks :SetAzureNSGRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGRuleProtocol = 'TCP'                                                # Sets $NSGRuleProtocol
                    Break SetAzureNSGRuleProtocol                                           # Breaks :SetAzureNSGRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleProtocol = 'UDP'                                                # Sets $NSGRuleProtocol
                    Break SetAzureNSGRuleProtocol                                           # Breaks :SetAzureNSGRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $NSGRuleProtocol = 'ICMP'                                               # Sets $NSGRuleProtocol
                    Break SetAzureNSGRuleProtocol                                           # Breaks :SetAzureNSGRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGRuleProtocol while ($true)
            :SetAzureNSGRuleAccess while ($true) {                                          # Inner loop to set the rule access
                Write-Host 'Select the rule access'                                         # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Allow'                                                      # Write message to screen
                Write-Host '[2] Deny'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the rule access
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleAccess = 'Allow'                                                # Sets $NSGRuleAccess
                    Break SetAzureNSGRuleAccess                                             # Breaks :SetAzureNSGRuleAccess
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGRuleAccess = 'Deny'                                                 # Sets $NSGRuleAccess
                    Break SetAzureNSGRuleAccess                                             # Breaks :SetAzureNSGRuleAccess
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGRuleAccess while ($true)
            :SetAzureNSGRuleDirection while ($true) {                                       # Inner loop to set the rule direction
                Write-Host 'Select the rule direction'                                      # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Inbound'                                                    # Write message to screen
                Write-Host '[2] Outbound'                                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the rule direction
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleDirection = 'Inbound'                                           # Sets $NSGRuleDirection
                    Break SetAzureNSGRuleDirection                                          # Breaks :SetAzureNSGRuleDirection
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGRuleDirection = 'Outbound'                                          # Sets $NSGRuleDirection
                    Break SetAzureNSGRuleDirection                                          # Breaks :SetAzureNSGRuleDirection
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))                
            }                                                                               # End :SetAzureNSGRuleDirection while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGRulePriority while ($true) {                                        # Inner loop to set the rule priority
                Write-Host 'NSG Rule priority'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Rule priority must be between the values of 100 and 4096'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($CRules.Direction -eq $NSGRuleDirection) {                              # If $CRules.Direction equals $NSGRuleDirection
                    Write-Host 'The following priorities are'                               # Write message to screen
                    Write-Host 'already in use for'$NSGRuleDirection' traffic'              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $CRules) {                                               # For each item in $CRules
                        if ($_.Direction -eq $NSGRuleDirection) {                           # If current item .Direction equals $NSGRuleDirection
                            Write-Host $_.Priority                                          # Write message to screen
                        }                                                                   # if ($_.Direction -eq $NSGRuleDirection)
                    }                                                                       # End foreach ($_ in $CRules)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CRules.Direction -eq $NSGRuleDirection)
                $NSGRulePriority = Read-Host 'Rule priority'                                # Operator input for the rule priority
                Clear-Host                                                                  # Clears screen
                $NSGRuleArray = $NSGRulePriority.ToCharArray()                              # Converts $NSGRulePriority into array
                foreach ($_ in $NSGRuleArray) {                                             # For each item in $NSGRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $NSGRulePriority = $null                                            # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $NSGRuleArray)                                                                       
                $NSGRuleArray = $null                                                       # Clears $var
                $NSGRuleInt = [INT]$NSGRulePriority                                         # Converts $NSGRulePriority to integer
                if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096) {                         # if $NSGRuleInt is not between 100 and 4096
                    Write-Host 'Rule priority must be between the values of 100 and 4096'   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    $NSGRulePriority = $null                                                # Clears $var
                    $NSGRuleInt = $null                                                     # Clears $var
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096)                                                                    
                else {                                                                      # Else if $NSGRuleInt is between 100 and 4096
                    $NSGRuleInt = $null                                                     # Clears $var
                    Write-Host 'Use:'$NSGRulePriority' as the rule priority'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule priority
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureNSGRulePriority                                       # Breaks :SetAzureNSGRulePriority
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureNSGRule                                               # Breaks :NewAzureNSGRule
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                    else {                                                                  # All other inputs for $OpConfirm
                        $NSGRulePriority = $null                                            # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'y'))
                }                                                                           # End else (if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096))
            }                                                                               # End :SetAzureNSGRulePriority while ($true)
            :SetAzureNSGRuleSPRange while ($true) {                                         # Inner loop to set the rule source port range
                
            }                                                                               # End :SetAzureNSGRuleSPRange while ($true) 
            :SetAzureNSGRuleSAPrefix while ($true) {                                        # Inner loop to set the rule source address prefix
                
            }                                                                               # End :SetAzureNSGRuleSAPrefix while ($true)
            :SetAzureNSGRuleDPRange while ($true) {                                         # Inner loop to set the rule destination port range
                
            }                                                                               # End :SetAzureNSGRuleDPRange while ($true) 
            :SetAzureNSGRuleDAPrefix while ($true) {                                        # Inner loop to set the rule destination address prefix
                
            }                                                                               # End :SetAzureNSGRuleDAPrefix while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the NSG Rule'                                          # Write message to screen
                Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                -Name $NSGRuleName `
                -Protocol $NSGRuleProtocol `
                -Access $NSGRuleAccess `
                -Direction $NSGRuleDirection `
                -Priority $NSGRulePriority `
                -SourcePortRange $NSGRuleSPRange  `
                -DestinationPortRange $NSGRuleDPRange `
                -SourceAddressPrefix $NSGRuleSAPrefix  `
                -DestinationAddressPrefix $NSGRuleDAPrefix  `
                | Set-AzNetworkSecurityGroup
            }                                                                               # End Try
            Catch {                                                                         # If Try fails

            }                                                                               # End Catch
        }                                                                                   # End :NewAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End NewAzNSGRule
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