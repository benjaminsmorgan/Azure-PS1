# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzFirewall:                          https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azfirewall?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzFirewall:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/GetAzFirewall.ps1
} #>
<# Functions Description: {
    RemoveAzFirewall:           Function to remove a firewall
    GetAzFirewall:              Function to get a firewall
} #>
<# Variables: {      
    :RemoveAzureFirewall        Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $FirewallObject:            Firewall object
    $VNetName:                  Virtual network name
    $OpConfirm:                 Operator confirmation to complete this action
    $MSG:                       Last error message
    GetAzFirewall{}             Gets $FirewallObject
} #>
<# Process Flow {
    function
        Call RemoveAzFirewall > Get $null
            Call GetAzFirewall > Get $FirewallObject            
            End GetAzFirewall
                Return RemoveAzFirewall > Send $FirewallObject
        End RemoveAzFirewall
            Return function > Send $null
}#>
function RemoveAzFirewall {                                                                 # Function to remove a firewall
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFirewall'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureFirewall while ($true) {                                                # Outer loop for managing function
            $FirewallObject = GetAzFirewall ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FirewallObject) {                                                         # If $FirewallObject does not have a value
                Break RemoveAzureFirewall                                                   # Breaks :RemoveAzureFirewall
            }                                                                               # End if (!$FirewallObject)
            $VNetName = $FirewallObject.IPConfigurations.Subnet.ID.Split('/')[8]            # Isolates the Vnet name
            Write-Host 'Remove Firewall:'$FirewallObject.name                               # Write message to screen
            Write-Host 'From VNet:      '$VNetName                                          # Write message to screen
            Write-Host 'From RG:        '$FirewallObject.ResourceGroupName                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the firewall'                                          # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzFirewall -Name $FirewallObject.Name -ResourceGroupName `
                        $FirewallObject.ResourceGroupName -Force -ErrorAction 'Stop' `
                        | Out-Null                                                          # Removes the firewall
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
                    Break RemoveAzureFirewall                                               # Breaks :RemoveAzureFirewall    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall has been removed'                                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFirewall                                                   # Breaks :RemoveAzureFirewall    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFirewall                                                   # Breaks :RemoveAzureFirewall    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureFirewall while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzFirewall