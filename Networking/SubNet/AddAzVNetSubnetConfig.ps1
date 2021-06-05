# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
} #>
<# Functions Description: {
    AddAzVNetSubnetConfig:      Adds an azure virtual network subnet
    GetAzVirtualNetwork:        Gets an azure virtual network
} #>
<# Variables: {
    :AddAzureSubnet             Outer loop for managing function
    :SetAzureSubNetName         Inner loop for setting the subnet name
    :SetAzureSubnetAddress      Inner loop for setting the subnet address
    $CallingFunction:           Name of this function or the one that called it
    $VNetObject:                Virtual network object
    $SubnetName:                Operator input for the subnet name
    $AddressPrefix:             Operator input for the subnet prefix
    $OpConfirm:                 Operator confirmation of values
    GetAzVirtualNetwork{}       Gets $VNetObject
} #>
<# Process Flow {
    Function
        Call AddAzVNetSubnetConfig > Get $null
            Call GetAzVirtualNetwork > Get $VNetObject
            End GetAzVirtualNetwork
                Return AddAzVNetSubnetConfig > Send $VNetObject
        End AddAzVNetSubnetConfig
            Return Function > Send $null
}#>
function AddAzVNetSubnetConfig {                                                            # Function to create a subnet
    begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzVNetSubnetConfig'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureSubnet while ($true) {                                                     # Outer loop for managing function
            $VNetObject = GetAzVirtualNetwork ($CallingFunction)                            # Calls function and assigns output to $Var
            if (!$VNetObject) {                                                             # if $VNetObject is $null
                Break AddAzureSubnet                                                        # Breaks :AddAzureSubnet
            }                                                                               # End if (!$VNetObject)
            :SetAzureSubNetName while ($true) {                                             # Inner loop for setting the subnet name
                Write-Host 'Enter the subnet name'                                          # Write message to screen
                $SubnetName = Read-Host 'Name'                                              # Operator input for the subnet name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$SubnetName' as the subnet name'                           # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureSubNetName                                                # Breaks :SetAzureSubNetName
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureSubNetName while ($true)
            :SetAzureSubnetAddress while ($true) {                                          # Inner loop for setting the subnet prefix
                Write-Host 'Enter the address prefix (E.X. 10.0.1.0/24)'                    # Write message to screen
                $AddressPrefix = Read-Host 'Prefix'                                         # Operator input for the subnet prefix
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$AddressPrefix' as the subnet address prefix'              # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureSubnetAddress                                             # Breaks :SetAzureSubnetAddress
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureSubnetAddress while ($true)
            try {                                                                           # Try the following
                Write-Host 'Creating the subnet'                                            # Write message to screen
                Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork `
                $VNetObject -AddressPrefix $AddressPrefix | Set-AzVirtualNetwork `
                -ErrorAction 'Stop'                                                         # Creates the new subnet config and adds to $VNetObject
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The address prefix may not be valid'                            # Write message to screen
                Write-Host 'or the address prefix may already be in use'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The resource group may have a read only lock'                   # Write message to screen
                Write-Host 'or you may not have the permissions to do this'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureSubnet                                                        # Breaks :AddAzureSubnet
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The subnet has been created'                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureSubnet                                                            # Breaks :AddAzureSubnet
        }                                                                                   # End :AddAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $Null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVNetSubnetConfig