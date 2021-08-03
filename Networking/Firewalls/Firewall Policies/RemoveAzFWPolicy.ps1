# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
    Remove-AzFirewallPolicy:                    https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azfirewallpolicy?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/GetAzFWPolicy.ps1
} #>
<# Functions Description: {
    RemoveAzFWPolicy:           Function to remove a firewall policy
    GetAzFWPolicy:              Function to get firewall policy
} #>
<# Variables: {      
    :RemoveAzureFWPolicy        Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $FWPolicyObject:            Firewall policy object
    $FirewallObject:            Firewall object
    $VNetName:                  Vnet name that $FirewallObject is attached to
    $OpConfirm:                 Operator confirmation to remove the firewall
    $MSG:                       Last powershell error message
    GetAzFWPolicy{}             Gets $FWPolicyObject:
} #>
<# Process Flow {
    function
        Call RemoveAzFWPolicy > Get $null
            Call GetAzFWPolicy > Get $FWPolicyObject            
            End GetAzFWPolicy
                Return RemoveAzFWPolicy > Send $FWPolicyObject
        End RemoveAzFWPolicy > Send $null
}#>
function RemoveAzFWPolicy {                                                                 # Function to remove a firewall policy
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFWPolicy'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureFWPolicy while ($true) {                                                # Outer loop for managing function
            $FWPolicyObject = GetAzFWPolicy ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FWPolicyObject) {                                                         # If $FWPolicyObject does not have a value
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy
            }                                                                               # End if (!$FWPolicyObject) 
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