# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
    Set-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/set-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/GetAzFWPolicy.ps1
    GetAzFirewall:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/GetAzFirewall.ps1
} #>
<# Functions Description: {
    DissociateAzFWPolicy:       Function to dissociate a firewall policy to a firewall
    GetAzFirewall:              Function to get firewall
} #>
<# Variables: {      
    :SetAzureFWPolicy           Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $FWPolicyObject:            Firewall policy object
    $CurrentFWObject:           Firewall object attached to $FWPolicyObject
    $VNetName:                  Vnet name attached to $CurrentFWObject
    $FirewallObject:            Firewall object
    $CurrentPolicy:             Name of the current policy attached to $FirewallObject
    $OpConfirm:                 Operator confirmation to make the change
    $MSG:                       Last powershell error message
    GetAzFWPolicy{}             Gets $FWPolicyObject
    GetAzFirewall{}             Gets $FirewallObject
} #>
<# Process Flow {
    function
        Call DissociateAzFWPolicy > Get $null
            Call GetAzFWPolicy > Get $FWPolicyObject            
            End GetAzFWPolicy
                Return DissociateAzFWPolicy > Send $FWPolicyObject
            Call GetAzFirewall > Get $FirewallObject            
            End GetAzFirewall
                Return DissociateAzFWPolicy > Send $FirewallObject
        End DissociateAzFWPolicy
            Return function > Send $null
}#>
function DissociateAzFWPolicy {                                                             # Function to dissociate a firewall policy to a firewall
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'DissociateAzFWPolicy'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPolicy while ($true) {                                                   # Outer loop for managing function
            $FirewallObject = GetAzFirewall ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FirewallObject) {                                                         # If $FirewallObject is $null
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy
            }                                                                               # End if (!$FirewallObject)
            if (!$FirewallObject.FirewallPolicy.ID) {                                       # If $FirewallObject.FirewallPolicy.ID is $null
                Write-Host 'There is no policy associated to this firewall'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy    
            }                                                                               # End if (!$FirewallObject.FirewallPolicy.ID)
            Write-Host 'Update Firewall:'$FirewallObject.name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $CurrentPolicy = $FirewallObject.FirewallPolicy.ID.Split('/')[-1]               # Isolates the current policy name
            Write-Host 'Remove Policy:  '$CurrentPolicy                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Dissociating the firewall policy'                               # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    $FirewallObject.FirewallPolicy = $null                                  # Updates the firewall policy
                    $FirewallObject | Set-AzFirewall -ErrorAction 'Stop' | Out-Null         # Saves the firewall config
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
                    Break SetAzureFWPolicy                                                  # Breaks :SetAzureFWPolicy    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall policy has been dissociated'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function DissociateAzFWPolicy