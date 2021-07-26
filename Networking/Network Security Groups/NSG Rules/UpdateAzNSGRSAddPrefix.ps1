# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzNetworkSecurityRuleConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworksecurityruleconfig?view=azps-6.2.1
    Add-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/add-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.2.1
} #>
<# Required Functions Links: {
    UpdateAzNSGRuleConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRuleConfig.ps1
    GetAzASG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/NSG%20Rules/GetAzASG.ps1
    GetAzAllNSGsRule:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzAllNSGsRule.ps1
    GetAzNSGRule:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzNSGRule.ps1
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
    SetIPAddress:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Other/SetIPAddress.ps1
    SetCIDRAddress:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Other/SetCIDRAddress.ps1
} #>
<# Functions Description: {
    UpdateAzNSGRSAddPrefix:     Function to update a network security group rule source application security group
    UpdateAzNSGRuleConfig:      Function for updating network security group rule configs
    GetAzASG:                   Function to get a application security group
    GetAzAllNSGsRule:           Function to get a rule from all network security groups
    GetAzNSGRule:               Function to get a network security group rule
    GetAzNSG:                   Function to get a network security group
    SetIPAddress:               Function to add an IP address to $var
    SetCIDRAddress:             Function to add a CIDR address to $var
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
    $ASGObject:                 Network security group rule source application security group
    $AppSecGroupName:           Name of $ASGObject
    $CurrentAppSecGroup:        Name of $RSASGr
    $OpConfirm:                 Operator confirmation to update the NSG rule object
    GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
        GetAzNSG{}                  Gets $NSGObject
    GetAzNSGRule{}              Gets $NSGRuleObject
    SetAzNSGRuleAddPrefix{}     Gets $NSGRuleAddPrefix
        SetIPAddress{}              Gets $IPAddress
        SetCIDRAddress{}            Gets $CIDRAddress
    UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject
} #>
<# Process Flow {
    function
        Call UpdateAzNSGRSAddPrefix > Get $null
            Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
            End GetAzAllNSGsRule
                Return UpdateAzNSGRSAddPrefix > Send $NSGRuleObject, $NSGObject
            Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                Call GetAzNSG > Get $NSGObject
                End GetAzNSG
                    Return GetAzNSGRule > Send $NSGObject
            End GetAzNSGRule
                Return UpdateAzNSGRSAddPrefix > Send $NSGRuleObject, $NSGObject
            Call SetAzNSGRuleAddPrefix > Get $NSGRuleAddPrefix
                Call SetIPAddress > Get $IPAddress
                End SetIPAddress
                    Return SetAzNSGRuleAddPrefix > Send $IPAddress
                Call SetCIDRAddress > Get $CIDRAddress
                End SetCIDRAddress
                    Return SetAzNSGRuleAddPrefix > Send $CIDRAddress
            End SetAzNSGRuleAddPrefix
                Return UpdateAzNSGRSAddPrefix > Send $NSGRuleAddPrefix                
            Call UpdateAzNSGRuleConfig > Get $null
            End UpdateAzNSGRuleConfig
                Return UpdateAzNSGRSAddPrefix > Send $null
        End UpdateAzNSGRSAddPrefix
            Return function > Send $null
}#>
function UpdateAzNSGRSAddPrefix {                                                           # Function to update a network security group rule source address prefix
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRSAddPrefix'                                     # Sets $CallingFunction
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
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups.ID
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups.ID
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleAddPrefix = SetAzNSGRuleAddPrefix ($CallingFunction)                # Calls function and assigns output to $var
                if (!$NSGRuleAddPrefix) {                                                   # If $NSGRuleAddPrefix is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleAddPrefix)
                else {                                                                      # Else if $NSGRuleAddPrefix has a value
                    $RSAddre = $NSGRuleAddPrefix                                            # Updates $RSAddre
                    $RSASGr = $null                                                         # clears $var    
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleAddPrefix))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            if (!$NSGRuleObject.SourceAddressPrefix) {                                      # If $NSGRuleObject.SourceAddressPrefix is $null
                Write-Host 'Powershell tools cannot convert source'                         # Write message to screen
                Write-Host 'application secruity groups to address prefixes'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Executing this change will remove the'                          # Write message to screen
                Write-Host 'and rebuild it using the existing settings'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Update the following'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Rule Name:'$RName                                               # Write message to screen
                Write-Host 'Setting:   Source Address Prefix'                               # Write message to screen
                Write-Host 'Current:   N/A'                                                 # Write message to screen
                Write-Host 'New:      '$RSAddre                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to rebuild the rule
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Try {                                                                   # Try the following
                        Write-Host 'Removing the rule'                                      # Write message to screen
                        Remove-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                            $NSGObject -Name $NSGRuleObject.Name -ErrorAction 'Stop' `
                            | Out-Null                                                      # Removes the rule
                        Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                            -ErrorAction 'Stop' | Out-Null                                  # Saves the updated network security group    
                    }                                                                       # End Try
                    Catch {                                                                 # If try fails
                        Clear-Host                                                          # Clears screen
                        Write-Host 'There was an error removing the NSG rule'               # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break ChangeAzureNSRGConfig                                         # Breaks :ChangeAzureNSRGConfig
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'Rebuilding the rule'                                        # Write message to screen
                    Try {                                                                   # Try the following
                        if ($RDAddre) {                                                     # If $RDAddre has a value
                            Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                                $NSGObject -Name $RName -Description $RDescri -Protocol `
                                $RProto -Access $RAccess -Priority $RPriori -Direction `
                                $RDirect -SourcePortRange $RSPRang -SourceAddressPrefix `
                                $RSAddre -DestinationPortRange $RDPRang `
                                -DestinationAddressPrefix $RDAddre -ErrorAction 'Stop' `
                                | Out-Null                                                  # Rebuilds the rule
                        }                                                                   # End if ($RDAddre)
                        else {                                                              # Else if $RDAddre is $null
                            Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                                $NSGObject -Name $RName -Description $RDescri -Protocol `
                                $RProto -Access $RAccess -Priority $RPriori -Direction `
                                $RDirect -SourcePortRange $RSPRang -SourceAddressPrefix `
                                $RSAddre -DestinationPortRange $RDPRang `
                                -DestinationApplicationSecurityGroupId $RDASGr `
                                -ErrorAction 'Stop' | Out-Null                              # Rebuilds the rule
                        }                                                                   # End else (if ($RDAddre))   
                        Write-Host 'Saving the network security group'                      # Write message to screen             
                        Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Saves the updated network security group
                    }                                                                       # End Try
                    Catch {                                                                 # End catch
                        Clear-Host                                                          # Clears screen
                        Write-Host 'An error occured rebuilding the rule'                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break ChangeAzureNSRGConfig                                         # Breaks :ChangeAzureNSRGConfig
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'The rule has been rebuilt with the new address prefix'      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig
                }                                                                           # End if ($OpConfirm -eq 'y') 
                else {                                                                      # All other inputs for $OpConfim
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End if (!$NSGRuleObject.SourceAddressPrefix)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Source Address Prefix'                                   # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.SourceAddressPrefix                       # Write message to screen
            Write-Host 'New:      '$RSAddre                                                 # Write message to screen
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
}                                                                                           # End function UpdateAzNSGRSAddPrefix
function UpdateAzNSGRuleConfig {                                                            # Function for updating network security group rule configs
    Begin {                                                                                 # Begin function
        Write-Host 'Updating network security group rule'                                   # Write message to screen
            Try {                                                                           # Try the following
                if ($RSAddre -and $RDAddre) {                                               # If $RSAddre -and $RDAddre have values
                    Read-Host 'c1'
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -SourceAddressPrefix $RSAddre -DestinationPortRange `
                        $RDPRang -DestinationAddressPrefix $RDAddre `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                                                                           # End if ($RSAddre -and $RDAddre)
                elseif ($RSAddre -and $RDASGr) {                                            # Else if $RSAddre -and $RDASGr have values
                    Read-Host 'c2'
                    Write-Host $RSAddre
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -SourceAddressPrefix $RSAddre -DestinationPortRange `
                        $RDPRang -DestinationApplicationSecurityGroupID $RDASGr `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                                                                           # End elseif ($RSAddre -and $RDASGr)
                elseif ($RSASGr -and $RDAddre) {                                            # Else if $RSASGr -and $RDAddre have values
                    Read-Host 'c3'
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -DestinationPortRange $RDPRang -DestinationAddressPrefix `
                        $RDAddre -SourceApplicationSecurityGroupID $RSASGr `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                               
                elseif ($RSASGr -and $RDASGr) {                                             # Else if $RSASGr -and $RDASGr have values    
                    Read-Host 'c4'  
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                    -Name $RName -Description $RDescri -Protocol $RProto -Access `
                    $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                    $RSPRang -DestinationPortRange $RDPRang `
                    -SourceApplicationSecurityGroupID $RSASGr `
                    -DestinationApplicationSecurityGroupID $RDASGr `
                    -ErrorAction 'Stop' | Out-Null                                          # Updates the rule protocol
                }                                                                           # End elseif ($RSASGr -and $RDASGr)
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
Function SetAzNSGRuleAddPrefix {                                                            # Function to set a network security rule address prefix
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleAddPrefix while ($true) {                                           # Outer loop for managing function
            Write-Host 'NSG Rule Address Prefix'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Any'                                                            # Write message to screen
            Write-Host '[2] Single IP Address'                                              # Write message to screen
            Write-Host '[3] Multiple IP Addresses'                                          # Write message to screen
            Write-Host '[4] CIDR Block'                                                     # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the address prefix method
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleAddPrefix                                              # Breaks :SetAzureNSGRuleAddPrefix
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleAddPrefix = '*'                                                     # Sets $NSGRuleAddPrefix
                Return $NSGRuleAddPrefix                                                    # Returns to calling function with $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for settings a single IP address prefix
                    $IPAddress = SetIPAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if (!$IPAddress) {                                                      # If $IPAddress does not have a value
                        Break SetAzureNSGAddPreConfig                                       # Breaks :SetAzureNSGAddPreConfig
                    }                                                                       # End if (!$IPAddress)
                    else {                                                                  # If $IPAddress has a value
                        $NSGRuleAddPrefix = $IPAddress                                      # $NSGRuleAddPrefix is equal to $IPAddress
                        Return $NSGRuleAddPrefix                                            # Returns to calling function with $var
                    }                                                                       # End else (if (!$IPAddress))
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                $NSGRuleAddPrefix = @()                                                     # Creates $NSGRuleAddPrefix        
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for setting multiple address prefix values
                    $IPAddress = SetIPAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if ($IPAddress) {                                                       # If $IPAddress haa a value
                        Clear-Host                                                          # Clears screen
                        Write-Host 'Add:'$IPAddress' Address prefix list'                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the address
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpSelect -eq 'y'
                            $NSGRuleAddPrefix += $IPAddress                                 # Adds $IPAddres to $NSGRuleAddPrefix
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpSelect -eq 'e'
                            Break SetAzureNSGAddPreConfig                                   # Breaks :SetAzureNSGAddPreConfig
                        }                                                                   # End elseif ($OpConfirm -eq 'e')    
                    }                                                                       # End if ($IPAddress)
                    :ConfirmAddressPrefixList while ($true) {                               # Inner loop for confirming the IP address list
                        Write-Host 'Current IP addres prefix list'                          # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        foreach ($_ in $NSGRuleAddPrefix) {                                 # For each item in $NSGRuleAddPrefix
                            Write-Host $_                                                   # Write message to screen
                        }                                                                   # End foreach ($_ in $NSGRuleAddPrefix)
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Add another IP address'                                 # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                     # Operator input to add another IP
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            Break ConfirmAddressPrefixList                                  # Breaks :ConfirmAddressPrefixList
                        }                                                                   # End if ($OpSelect -eq 'y')
                        elseif ($OpSelect -eq 'n') {                                        # Else if $OpSelect equals 'n'
                            Return $NSGRuleAddPrefix                                        # Returns to calling function with $var
                        }                                                                   # End elseif ($OpSelect -eq 'n')   
                        elseif ($OpSelect -eq 'e') {                                        # Else if $OpSelect equals 'e'        
                            Break SetAzureNSGAddPreConfig                                   # Breaks :SetAzureNSGAddPreConfig
                        }                                                                   # End elseif ($OpSelect -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End :ConfirmAddressPrefixList while ($true)
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for getting a CIDR address
                $CIDRAddress = SetCIDRAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if (!$CIDRAddress) {                                                    # If $CIDRAddress is $null
                        Break SetAzureNSGAddPreConfig                                       # Breaks :SetAzureNSGAddPreConfig
                    }                                                                       # End if (!$CIDRAddress)
                    else {                                                                  # If $CIDRAddress has a value
                        $NSGRuleAddPrefix = $CIDRAddress                                    # $NSGRuleAddPrefix is equal to $CIDRAddress
                        Return $NSGRuleAddPrefix                                            # Returns to calling function with $var
                    }                                                                       # End else (if (!$CIDRAddress))
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :SetAzureNSGRuleAddPrefix while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleAddPrefix
function SetIPAddress {                                                                     # Function to add an IP address to $var
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContine'                                          # Turns off error reporting
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetIPAddressLoop while ($true) {                                                   # Outer loop for managing function
            if ($CallingFunction) {                                                         # If $CallingFunction has a value
                Write-Host 'You are setting the IP for:'$CallingFunction                    # Write message to screen
            }                                                                               # End if ($CallingFunction)
            Write-Host 'Enter the IP address (Must be x.x.x.x)'                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $IPAddress = Read-Host 'IP Address'                                             # Operator input for the starting IP address
            Clear-Host                                                                      # Clears screen
            if ($IPAddress -notlike '*.*.*.*') {                                            # If $IPAddress is not like '*.*.*.*'
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = $null                                                          # Clears $var
            }                                                                               # End if ($IPAddress -notlike '*.*.*.*') 
            if ($IPAddress) {                                                               # If $IPAddress has a value
                if ($IPAddress.Split('.')[4]) {                                             # If $IPAddress .Split 4th position has a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress.Split('.')[4])
            }                                                                               # End  if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                $IPAddressArray = $IPAddress.ToCharArray()                                  # Converts $IPAddress to array
                foreach ($_ in $IPAddressArray) {                                           # For each item in $IPAddressArray
                    if ($_ -notin $ValidArray) {                                            # If current item not in $ValidArray
                        Write-Host $_' is not a valid character'                            # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $IPAddressArray)
                $IPAddressArray = $null                                                     # Clears $var
            }                                                                               # End if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                $OctetCheck = $IPAddress.Split('.')                                         # $OctetCheck is equal to $IPAdress.Split '.'
                foreach ($_ in $OctetCheck) {                                               # For each item in $OctetCheck
                    $OctetInt = [INT]$_                                                     # $OctetInt is equal to current item converted to integer
                    if ($OctetInt -lt 0 -or $OctetInt -gt 255) {                            # If $OctetInt less than 0 or  $OctetInt greater than 255
                        Write-Host $_' is not a valid octet'                                # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($OctetInt -lt 0 -or $OctetInt -gt 255)
                    $OctetInt = $null                                                       # Clears $var
                }                                                                           # End foreach ($_ in $OctetCheck)
            }                                                                               # End if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                Write-Host 'Use'$IPAddress' as the IP'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the IP address
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break SetIPAddressLoop                                                  # Breaks :SetIPAddressLoop
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Return $IPAddress                                                       # Returns to calling function with $var  
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End if ($IPAddress)
            else {                                                                          # If $IPAddress is $null
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($IPAddress))
        }                                                                                   # Outer loop for managing function
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetIPAddress
function SetCIDRAddress {                                                                   # Function to add a CIDR address to $var
    Begin {                                                                                 # Begin function
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetCIDRAddressLoop while ($true) {                                                 # Outer loop for managing function
            :SetIPAddress while ($true) {                                                   # Inner loop for setting the starting IP
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are setting the IP for:'$CallingFunction                # Write message to screen
                }                                                                           # End if ($CallingFunction)
                Write-Host 'Enter the starting IP address (Must be x.x.x.0)'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = Read-Host 'IP Address'                                         # Operator input for the starting IP address
                Clear-Host                                                                  # Clears screen
                if ($IPAddress -notlike '*.*.*.0') {                                        # If $IPAddress is not like '*.*.*.0'
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress -notlike '*.*.*.0') 
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    if ($IPAddress.Split('.')[4]) {                                         # If $IPAddress .Split 4th position has a value
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($IPAddress.Split('.')[4])
                }                                                                           # End  if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    $IPAddressArray = $IPAddress.ToCharArray()                              # Converts $IPAddress to array
                    foreach ($_ in $IPAddressArray) {                                       # For each item in $IPAddressArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $IPAddressArray)
                    $IPAddressArray = $null                                                 # Clears $var
                }                                                                           # End if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    $OctetCheck = $IPAddress.Split('.')                                     # $OctetCheck is equal to $IPAdress.Split '.'
                    foreach ($_ in $OctetCheck) {                                           # For each item in $OctetCheck
                        $OctetInt = [INT]$_                                                 # $OctetInt is equal to current item converted to integer
                        if ($OctetInt -lt 0 -or $OctetInt -gt 255) {                        # If $OctetInt less than 0 or  $OctetInt greater than 255
                            Write-Host $_' is not a valid octet'                            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                        }                                                                   # End if ($OctetInt -lt 0 -or $OctetInt -gt 255)
                        $OctetInt = $null                                                   # Clears $var
                    }                                                                       # End foreach ($_ in $OctetCheck)
                }                                                                           # End if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    Write-Host 'Use'$IPAddress' as the starting IP'                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetCIDRAddressLoop                                            # Breaks :SetCIDRAddressLoop
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetIPAddress                                                  # Breaks :SetIPAddress  
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End if ($IPAddress)
                else {                                                                      # If $IPAddress is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($IPAddress))
            }                                                                               # End :SetIPAddress while ($true) 
            $ValidArray = '0123456789'                                                      # Creates $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to array
            :SetCIDRBlock while ($true) {                                                   # Inner loop for setting the CIDR block
                Write-Host 'Enter the CIDR Block (0-32)'                                    # Write message to screen
                Write-Host  ''                                                              # Write message to screen
                $CIDRBlock = Read-Host 'CIDR Block'                                         # Operator input for the CIDR block
                Clear-Host                                                                  # Clears screen
                $CIDRBlockArray = $CIDRBlock.ToCharArray()                                  # Converts $CIDRBlock to array
                foreach ($_ in $CIDRBlockArray) {                                           # For each item in $CIDRBlockArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $CIDRBlockArray)
                $CIDRBlockArray = $null                                                     # Clears $var
                if ($CIDRBlock) {                                                           # If $CIDRBlock has a value
                    $CIDRBlockInt = [INT]$CIDRBlock                                         # Converts $CIDRBlock to integer
                    if ($CIDRBlockInt -lt 0 -or $CIDRBlockInt -gt 32) {                     # If $CIDRBlockInt is less than 0 or greater than 32)
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End if ($CIDRBlockInt -lt 0 -or $CIDRBlockInt -gt 32)
                    $CIDRBlockInt = $null                                                   # Clears $var
                }                                                                           # End if ($CIDRBlock)
                if ($CIDRBlock) {                                                           # If $CIDRBlock has a value
                    Write-Host 'Use'$CIDRBlock' as the CIDR block'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the CIDR block
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetCIDRAddressLoop                                            # Breaks :SetCIDRAddressLoop
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        $CIDRAddress = $IPAddress+'/'+$CIDRBlock                            # $CIDRAddress is equal to $IPAddress and $CIDRBlock
                        Return $CIDRAddress                                                 # Returns to calling function with $var
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End if ($CIDRBlock)
                else {                                                                      # Else if $CIDRBlock is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($CIDRBlock))
            }                                                                               # End :SetCIDRBlock while ($true)
        }                                                                                   # Outer loop for managing function
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetCIDRAddress