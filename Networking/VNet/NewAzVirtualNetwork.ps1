# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
} #>
<# Functions Description: {
    NewAzVirtualNetwork:        Creates a new azure virtual network
    GetAzResourceGroup:         Gets a resource group object
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :NewAzureVNet               Outer loop for managing function
    :SetAzureVNetName           Inner loop for setting the vnet name
    :SetAzureVnetAddress        Inner loop for setting the address prefix
    $CallingFunction:           Name of this function or the one that called it
    $RGObject:                  Resource group object
    $LocationObject:            Location object
    $VNetName:                  Operator input for the VNet name
    $OpConfirm:                 Operator confirmation of values
    $AddressPrefix:             Operator input for the VNet address prefix
    GetAzResourceGroup{}        Gets $RGObject
    GetAzLocation{}             Gets $LocationObject
} #>
<# Process Flow {
    Function
        Call NewAzVirtualNetwork > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGoup
                Return NewAzVirtualNetwork Object
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzVirtualNetwork > Send $LocationObject 
        End NewAzVirtualNetwork
  Return Function > Send $null
}#>
function NewAzVirtualNetwork {                                                              # Function to create a new Vnet
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzVirtualNetwork'                                        # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureVNet while ($true) {                                                       # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureVNet                                                          # Breaks :NewAzureVnet
            }                                                                               # End if (!$RGObject)
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureVNet                                                          # Breaks :NewAzureVnet
            }                                                                               # End if (!$LocationObject)
            :SetAzureVNetName while ($true) {                                               # Inner loop for setting the vnet name
                $VNetName = Read-Host 'Virtual network name'                                # Operator input for the vnet name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$VNetName' as the VNet name'                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureVNetName                                                  # Breaks :SetAzureVNetName
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureVNetName while ($true)
            :SetAzureVnetAddress while ($true) {                                            # Inner loop for setting the vnet prefix
                $AddressPrefix = Read-Host 'Address Prefix (E.X. 10.0.0.0/16)'              # Operator input for the Vnet prefix
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$AddressPrefix' as the Vnet address prefix'                # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureVnetAddress                                               # Breaks :SetAzureVnetAddress
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureVnetAddress while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the virtual network'                                   # Write message to screen
                Write-Host 'This may take a momement'                                       # Write message to screen
                New-AzVirtualNetwork -Name $VNetName -ResourceGroupName `
                $RGObject.ResourceGroupName -Location $LocationObject.location `
                -AddressPrefix $AddressPrefix -ErrorAction 'Stop'                           # Creats the new Vnet
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
                Break NewAzureVNet                                                          # Breaks :NewAzureVNet
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The virtual network has been created'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureVNet                                                              # Breaks :NewAzureVNet
        }                                                                                   # End :NewAzureVNet while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVirtualNetwork