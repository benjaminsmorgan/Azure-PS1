# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
} #>
<# Required Functions Links: {
    UpdateAzNSGRuleConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRuleConfig.ps1
    SetAzNSGRulePriority:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRulePriority.ps1
    GetAzAllNSGsRule:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzAllNSGsRule.ps1
    GetAzNSGRule:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzNSGRule.ps1
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
} #>
<# Functions Description: {
    UpdateAzNSGRPriority:       Function to update a network security group rule priority
    UpdateAzNSGRuleConfig:      Function for updating network security group rule configs
    SetAzNSGRulePriority:       Function to set a network security group rule priority
    GetAzAllNSGsRule:           Function to get a rule from all network security groups
    GetAzNSGRule:               Function to get a network security group rule
    GetAzNSG:                   Function to get a network security group
} #>
<# Variables: {      
    :ChangeAzureNSRGConfig      Outer loop for managing function
    :GetAzureNSGRule            Inner loop for selecting the network security group rule
    :GetAzureNSGRSetting        Inner loop for setting the new netwrok security group rule config
    $OpSelect:                  Operator selection for getting the NSG rule
    $NSGRuleObject:             Network security group rule object
    $NSGObject:                 Network security group object
    $RName:                     $NSGRuleObject.Name        
    $RProto:                    $NSGRuleObject.Protocol         
    $RAccess:                   $NSGRuleObject.Access                  
    $RDirect:                   $NSGRuleObject.Direction           
    $RPriori:                   $NSGRuleObject.Priority          
    $RDescri:                   $NSGRuleObject.Description                                
    $RSPRang:                   $NSGRuleObject.SourcePortRange                  
    $RSAddre:                   $NSGRuleObject.SourceAddressPrefix        
    $RSASGr:                    $NSGRuleObject.SourceApplicationSecurityGroups.ID  
    $RDPRang:                   $NSGRuleObject.DestinationPortRange          
    $RDAddre:                   $NSGRuleObject.DestinationAddressPrefix              
    $RDASGr:                    $NSGRuleObject.DestinationApplicationSecurityGroups.ID 
    $NSGRuleDirection:          $NSGRuleObject.Direction
    $NSGRulePriority:           New NSG rule priority
    $OpConfirm:                 Operator confirmation to update the NSG rule object
    GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
    GetAzNSG{}                  Gets $NSGObject
    GetAzNSGRule{}              Gets $NSGRuleObject
    SetAzNSGRulePriority{}      Gets $NSGRulePriority
    UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject
} #>
<# Process Flow {
    function
        Call UpdateAzNSGRPriority > Get $null
            Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
            End GetAzAllNSGsRule
                Return UpdateAzNSGRPriority > Send $NSGRuleObject, $NSGObject
            Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                Call GetAzNSG > Get $NSGObject
                End GetAzNSG
                    Return GetAzNSGRule > Send $NSGObject
            End GetAzNSGRule
                Return UpdateAzNSGRPriority > Send $NSGRuleObject, $NSGObject
            Call SetAzNSGRulePriority > Get $NSGRulePriority
            End SetAzNSGRulePriority
                Return UpdateAzNSGRPriority > Send $NSGRulePriority
            Call UpdateAzNSGRuleConfig > Get $null
            End UpdateAzNSGRuleConfig
                Return UpdateAzNSGRPriority > Send $null
        End UpdateAzNSGRPriority
            Return function > Send $null
}#>
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