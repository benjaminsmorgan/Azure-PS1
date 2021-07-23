# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
} #>
<# Required Functions Links: {
    UpdateAzNSGRuleConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRuleConfig.ps1
    SetAzNSGRuleDPortRange:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleDPortRange.ps1
    GetAzAllNSGsRule:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzAllNSGsRule.ps1
    GetAzNSGRule:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzNSGRule.ps1
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
} #>
<# Functions Description: {
    UpdateAzNSGRDPRange:        Function to update a network security group rule destination port range
    UpdateAzNSGRuleConfig:      Function for updating network security group rule configs
    SetAzNSGRuleDPortRange:     Function to set a network security rule destination port range
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
    $NSGRuleDPRange:            Network security group rule source port range
    $OpConfirm:                 Operator confirmation to update the NSG rule object
    GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
    GetAzNSG{}                  Gets $NSGObject
    GetAzNSGRule{}              Gets $NSGRuleObject
    SetAzNSGRuleDPortRange{}    Gets $NSGRuleDPRange
    UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject
} #>
<# Process Flow {
    function
        Call UpdateAzNSGRDPRange > Get $null
            Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
            End GetAzAllNSGsRule
                Return UpdateAzNSGRDPRange > Send $NSGRuleObject, $NSGObject
            Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                Call GetAzNSG > Get $NSGObject
                End GetAzNSG
                    Return GetAzNSGRule > Send $NSGObject
            End GetAzNSGRule
                Return UpdateAzNSGRDPRange > Send $NSGRuleObject, $NSGObject
            Call SetAzNSGRuleDPortRange > Get $NSGRuleDPRange
            End SetAzNSGRuleDPortRange
                Return UpdateAzNSGRDPRange > Send $NSGRuleDPRange
            Call UpdateAzNSGRuleConfig > Get $null
            End UpdateAzNSGRuleConfig
                Return UpdateAzNSGRDPRange > Send $null
        End UpdateAzNSGRDPRange
            Return function > Send $null
}#>
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