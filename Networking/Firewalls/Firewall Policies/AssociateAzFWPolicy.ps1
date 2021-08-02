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
    AssociateAzFWPolicy:        Function to associate a firewall policy to a firewall
    GetAzFWPolicy:              Function to get firewall policy
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
        Call AssociateAzFWPolicy > Get $null
            Call GetAzFWPolicy > Get $FWPolicyObject            
            End GetAzFWPolicy
                Return AssociateAzFWPolicy > Send $FWPolicyObject
            Call GetAzFirewall > Get $FirewallObject            
            End GetAzFirewall
                Return AssociateAzFWPolicy > Send $FirewallObject
        End AssociateAzFWPolicy
            Return function > Send $null
}#>
function AssociateAzFWPolicy {                                                              # Function to associate a firewall policy to a firewall
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AssociateAzFWPolicy'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPolicy while ($true) {                                                   # Outer loop for managing function
            $FWPolicyObject = GetAzFWPolicy ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FWPolicyObject) {                                                         # If $FWPolicyObject does not have a value
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy
            }                                                                               # End if (!$FirewallObject) 
            $CurrentFWObject = Get-AzFirewall | Where-Object `
                {$_.FirewallPolicy.ID -eq $FWPolicyObject.ID}                               # Pulls the firewall object if attached
            if ($CurrentFWObject) {                                                         # If $CurrentFWObject has a value
                $VNetName = $CurrentFWObject.IPConfigurations.Subnet.ID.Split('/')[8]       # Isolates the Vnet name
                Write-Host 'This policy is currently associated to the following'           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Firewall:'$CurrentFWObject.name                                 # Write message to screen
                Write-Host 'VNet:    '$VNetName                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please dissociate this policy from the firewall'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy 
            }                                                                               # End if ($CurrentFWObject)
            $FirewallObject = GetAzFirewall ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FirewallObject) {                                                         # If $FirewallObject is $null
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy
            }                                                                               # End if (!$FirewallObject)
            Write-Host 'Update Firewall:'$FirewallObject.name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($FirewallObject.FirewallPolicy) {                                           # If $FirewallObject.FirewallPolicy has a value
                $CurrentPolicy = $FirewallObject.FirewallPolicy.ID.Split('/')[-1]           # Isolates the current policy name
                Write-Host 'Current Policy: '$CurrentPolicy                                 # Write message to screen
            }                                                                               # End if ($FirewallObject.FirewallPolicy)
            Write-Host 'New Policy:     '$FWPolicyObject.Name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Updating the firewall policy'                                   # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    $FirewallObject.FirewallPolicy.ID = $FWPolicyObject.ID                  # Updates the firewall policy
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
                Write-Host 'The firewall policy has been associated'                        # Write message to screen
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
}                                                                                           # End function AssociateAzFWPolicy