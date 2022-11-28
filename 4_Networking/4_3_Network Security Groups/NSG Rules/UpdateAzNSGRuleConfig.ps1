# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecuritygroup?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    UpdateAzNSGRuleConfig:      Function for updating network security group rule configs
} #>
<# Variables: {      
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
} #>
<# Process Flow {
    function
        Call UpdateAzNSGRuleConfig > Get $null
        End UpdateAzNSGRuleConfig
            Return function > Send $null
}#>
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