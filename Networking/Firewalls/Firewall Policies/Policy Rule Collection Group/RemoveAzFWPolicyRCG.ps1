# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzFirewallPolicyRuleCollectionGroup: https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azfirewallpolicyrulecollectiongroup?view=azps-6.3.0
    Get-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicyrulecollectiongroup?view=azps-6.2.1
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzFWPolicyRCG:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/GetAzFWPolicyRCG.ps1
} #>
<# Functions Description: {
    RemoveAzFWPolicyRCG:        Function to remove a firewall policy rule collection group
    GetAzFWPolicyRCG:           Function to get firewall policy rule collection group
} #>
<# Variables: {      
    :RemoveAzureFWPolicyRCG     Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $FWPolicyRCGObject:         Firewall policy rule collection group
    $FWPolicyObject:            Firewall policy object
    $FirewallObject:            Firewall object
    $VNetName:                  Virtual network name
    $OpConfirm:                 Operator confirmation to remove the RCG
    $MSG:                       Last powershell error message
    GetAzFWPolicyRCG{}          Gets $FWPolicyRCGObject, $FWPolicyObject
} #>
<# Process Flow {
    function
        Call RemoveAzFWPolicyRCG > Get $null
            Call GetAzFWPolicyRCG > Get $FWPolicyRCGObject, $FWPolicyObject           
            End GetAzFWPolicyRCG
                Return RemoveAzFWPolicyRCG > Send $FWPolicyRCGObject, $FWPolicyObject 
        End RemoveAzFWPolicyRCG
            Return function > Send $null
}#>
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