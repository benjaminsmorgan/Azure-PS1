# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzNetworkSecurityGroup:              https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
} #>
<# Required Functions Links: {
    ManageAzLBNSG:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
} #>
<# Functions Description: {
    RemoveNSG:                  Function to remove a network security group
    ManageAzLBNSG:              Function to get a network security group
} #>
<# Variables: {      
    :RemoveAzureNSG             Outer loop for managing function
    $NSGObject:                 Network security group object
    $OpConfirm:                 Operator confirmation to remove $NSGObject
    GetAzNSG{}                  Gets $NSGObject
} #>
<# Process Flow {
    function
        Call RemoveNSG > Get $null
            Call GetAzNSG > Get $NSGObject
            End GetAzNSG
                Return RemoveNSG > Send $NSGObject
        End RemoveNSG
            Return function > Send $null
}#>
function RemoveNSG {                                                                        # Function to remove a network security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveNSG'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureNSG while ($true) {                                                     # Outer loop for managing function
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break RemoveAzureNSG                                                        # Breaks RemoveAzureNSG
            }                                                                               # End if (!$NSGObject)
            Write-Host 'Remove the following network security group'                        # Write message to screen
            Write-Host 'NSG Name:'$NSGObject.name                                           # Write message to screen
            Write-Host 'NSG RG:  '$NSGObject.ResourceGroupName                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the network security group
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the network security group'                            # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzNetworkSecurityGroup -Name $NSGObject.Name -ResourceGroupName `
                        $NSGObject.ResourceGroupName -Force -ErrorAction 'Stop' | Out-Null  # Removes the network securit group
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSG                                                    # Breaks RemoveAzureNSG
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The network security group has been removed'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSG                                                        # Breaks RemoveAzureNSG
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other input for $OpConfirm
                Write-Host 'No changes made'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSG                                                        # Breaks RemoveAzureNSG
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveNSG