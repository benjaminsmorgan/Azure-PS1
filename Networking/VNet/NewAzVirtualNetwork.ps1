# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
    AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    NewAzVirtualNetwork:        Creates a new azure virtual network
    NewAzSubnet:                Creates a new subnet in an Azure virtual network
    GetAzResourceGroup:         Gets a resource group object
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :NewAzureVNet               Outer loop for managing function
    :SetAzureVNetName           Inner loop for setting the vnet name
    :SetAzureVnetAddress        Inner loop for setting the address prefix
    $RGObject:                  Resource group object
    $LocationObject:            Location object
    $VNetName:                  Name for the new vnet
    $OperatorConfirm:           Operator confirmation for the vnet name and address prefix
    $AddressPrefix:             Address prefix for the new network
    $VNetObject:                Object containing the new virtual network
    $OperatorSelect:            Operator selection of adding subnets to new vnet
    GetAzResourceGroup{}        Gets $RGObject
    GetAzLocation{}             Gets $LocationObject
    AddAzVNetSubnetConfig{}     Adds subnets to $VNetObject
} #>
<# Process Flow {
    Function
        Call NewAzVirtualNetwork tObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGoup
                Return NewAzVirtualNetwork Object
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzVirtualNetwork cationObject
            Call AddAzVNetSubnetConfig > Get $VNetObject
            End AddAzVNetSubnetConfig
                Return NewAzVirtualNetwork etObject 
        End NewAzVirtualNetwork
  Return Function > Send $VNetObject
}#>
function NewAzVirtualNetwork { # Creates a new Vnet
    Begin {
        :NewAzureVNet while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # If $RGObject is $null
                    Break NewAzureVNet # Breaks :NewAzureVnet
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$LocationObject) { # If $LocationObject is $null
                $LocationObject = GetAzLocation # Calls function and assigns output to $var
                if (!$LocationObject) { # If $LocationObject is $null
                    Break NewAzureVNet # Breaks :NewAzureVnet
                } # End if (!$LocationObject)
            } # End if (!$LocationObject)
            :SetAzureVNetName while ($true) { # Inner loop for setting the vnet name
                $VNetName = Read-Host "Virtual network name" # Operator input for the vnet name
                if ($VNetName -eq 'exit') { # If $VnetName is 'exit'
                    Break NewAzureVNet # Breaks :NewAzureVnet
                } # End if ($VNetName -eq 'exit')
                $OperatorConfirm = Read-Host "Set" $VNetName "as the VNet name [Y] or [N]" # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetAzureVNetName # Breaks :SetAzureVNetName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureVNetName while ($true)
            :SetAzureVnetAddress while ($true) { # Inner loop for setting the vnet prefix
                $AddressPrefix = Read-Host "Address Prefix (E.X. 10.0.0.0/16)" # Operator input for the Vnet prefix
                $OperatorConfirm = Read-Host "Use" $AddressPrefix "as the Vnet address prefix [Y] or [N]" # Operator confirmation of the address prefix
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetAzureVnetAddress # Breaks :SetAzureVnetAddress
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureVnetAddress while ($true)
            $VNetObject = New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $RGObject.ResourceGroupName -Location $LocationObject.location -AddressPrefix $AddressPrefix # Creats the new Vnet
            $OperatorSelect = Read-Host "Add subnets [Y] or [N]" # Operator prompt for creating subnets
            if ($OperatorSelect -eq 'y') { # If $OperatorSelect equals yes
                AddAzVNetSubnetConfig ($VNetObject, $RGObject, $LocationObject) # Calls function and passes new $VNetObject
            } # End if ($OperatorSelect -eq 'y')
            Return $VNetObject # Returns to calling function with $VNetObject
        } # End :NewAzureVNet while ($true) 
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzVirtualNetwork
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        $RGList = Get-AzResourceGroup # Gets all resource groups and assigns to $RGList
        if (!$RGList) { # If $RGList returns empty
            Write-Host "No resource groups found" # Message write to screen
            Return # Returns to calling function with $null
        } # End if (!$RGList)
        $RGListNumber = 1 # Sets the base value of the list
        Write-Host "0. Exit" # Adds exit option to beginning of list
        foreach ($_ in $RGList) { # For each item in list
            Write-Host $RGListNumber"." $_.ResourceGroupName # Writes the option number and resource group name
            $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
        } # End foreach ($_ in $RGList)
        :GetAzureResourceGroup while ($true) { # Loop for selecting the resource group object
            $RGListNumber = 1 # Resets list number to 1
            $RGListSelect = Read-Host "Please enter the number of the resource group" # Operator input for selecting which resource group
            if ($RGListSelect -eq '0') { # If $RGListSelect is equal to 0
                Return # Returns to calling function with $null
            } # End if ($RGListSelect -eq '0')
            foreach ($_ in $RGList) { # For each item in list
                if ($RGListSelect -eq $RGListNumber) { # If the operator input matches the current $RGListNumber
                    $RGObject = $_ # Currently selected item in $RGList is assigned to $RGObject
                    Return $RGObject # Returns $RGObject to calling function
                } # End if ($RGListSelect -eq $RGListNumber)
                else { # If user input does not match the current $RGListNumber
                    $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
                } # End else (if ($RGListSelect -eq $RGListNumber))
            } # End foreach ($_ in $RGList)
            Write-Host "That was not a valid selection, please try again" # Write message to screen
        } # End :GetAzureResourceGroup while ($true)
        Return $RGObject # Returns $RGObject to calling function
    } # End of begin statement
} # End of function
function GetAzLocation { # Gets azure location
    Begin {
        :GetAzureLocation while ($true) { # Outer loop for managing function
            $LocationList = Get-AzLocation # Gets a list of all Azure locations
            $LocationListNumber = 1 # $Var for selecting the location
            Write-Host "0. Exit" # Write message to screen
            foreach ($Location in $LocationList) { # For each item in $LocationList
                Write-Host $LocationListNumber"." $Location.DisplayName # Writes list to screen
                $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
            } # End foreach ($Location in $LocationList)
            :GetAzureLocationName while ($true) { # Inner loop for selecting location from list
                $LocationSelect = Read-Host "Please enter the number of the location" # Operator input for the selection
                if ($LocationSelect -eq '0') { # If $LocationSelect is 0
                    Break GetAzureLocation # Breaks :GetAzureLocation
                } # End if ($LocationSelect -eq '0')
                $LocationListNumber = 1 # Resets $LocationListNumber
                foreach ($Location in $LocationList) { # For each item in $locationList
                    if ($LocationSelect -eq $LocationListNumber) { # If $LocationSelect equals $LocationListNumber
                        $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $Location.Location} # Collects the current location and assigns to $Location
                        Break GetAzureLocationName # Breaks :GetAzureLocationName 
                    } # End if ($LocationSelect -eq $LocationListNumber)
                    else { # If $locationSelect does not equal $LocationListNumber
                        $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
                    } # End else if ($LocationSelect -eq $LocationListNumber)
                } # End foreach ($Location in $LocationList)
                Write-Host "That was not a valid selection" # Write message to screen
            } # End :GetAzureLocationName while ($true)
            Return $LocationObject # Returns $Location to calling function
        } # End :GetAzureLocation while ($true)
        Return # Returns with $null 
    } # End Begin
} # End function GetAzLocation
function AddAzVNetSubnetConfig {
    begin {
        :AddAzureSubnet while ($true) { # Outer loop for managing function
            if (!$VNetObject) { # if $VNetObject is $null
                $VNetObject = GetAzVirtualNetwork # Calls function and assigns output to $Var
                if (!$VNetObject) { # if $VNetObject is $null
                    Break AddAzureSubnet # Breaks :AddAzureSubnet
                } # End if (!$VNetObject)
            } # End if (!$VNetObject)
            :SetAzureSubNetName while ($true) { # Inner loop for setting the subnet name
                $SubnetName = Read-Host "Subnet name" # Operator input for the subnet name
                if ($SubnetName -eq 'exit') { # If $SubnetName is 'exit'
                    Break AddAzureSubnet # Breaks :AddAzureSubnet
                } # End if ($SubnetName -eq 'exit')
                $OperatorConfirm = Read-Host "Set" $SubnetName "as the subnet name [Y] or [N]" # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetAzureSubNetName # Breaks :SetAzureSubNetName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureSubNetName while ($true)
            :SetAzureSubnetAddress while ($true) { # Inner loop for setting the subnet prefix
                $AddressPrefix = Read-Host "Address Prefix (E.X. 10.0.0.0/16)" # Operator input for the subnet prefix
                $OperatorConfirm = Read-Host "Use" $AddressPrefix "as the subnet address prefix [Y] or [N]" # Operator confirmation of the address prefix
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetAzureSubnetAddress # Breaks :SetAzureSubnetAddress
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureSubnetAddress while ($true)
            Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VNetObject -AddressPrefix $AddressPrefix | Set-AzVirtualNetwork # Creates the new subnet config and adds to $VNetObject
            $OperatorSelect = Read-Host "Add another subnet" # Operator input to add more subnets
            if (!($OperatorSelect -eq 'y')) { # if $OperatorSelect does not equal 'y'
                Break AddAzureSubnet # Breaks :AddAzureSubnetAgain
            } # End if (!($OperatorSelect -eq 'y'))
        } # End :AddAzureSubnet while ($true)
        Return # Returns to calling function with $Null
    } # End Begin
} # End function AddAzVNetSubnetConfig