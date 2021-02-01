# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
} #>
<# Functions Description: {
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
    GetAzVirtualNetwork:        Gets an azure virtual network
} #>
<# Variables: {
    :GetAzureSubnet             Outer loop for managing function
    $VNetObject:                Virtual network object
    $SubNetList:                List of all subnets within $VnetObject
    $SubNetListtNumber:         $Var used for $SubnetObject list selection
    $SubNetListtSelect:         Operator input for for $SubnetObject selection
    $SubnetObject:              Subnet object
    GetAzVirtualNetwork{}       Gets $VNetObject
} #>
<# Process Flow {
    Function
        Call GetAzVNetSubnetConfig > Get $SubnetObject
            Call GetAzVirtualNetwork > Get $VNetObject
            End GetAzVirtualNetwork
                Return GetAzVNetSubnetConfig > Send $VNetObject
        End GetAzVNetSubnetConfig
            Return Function > Send $SubnetObject
}#>
function GetAzVNetSubnetConfig {
    Begin {
        :GetAzureSubnet while ($true) {
            if (!$VnetObject) {
                $VnetObject = GetAzVirtualNetwork
                if (!$VnetObject) {
                    Break GetAzureSubnet # Breaks :GetAzureSubnet
                } # End if (!$VnetObject)
            } # End if (!$VnetObject)
            $SubNetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VnetObject # pulls all items into list for selection
            $SubNetListNumber = 1 # $var used for selecting the subnet
            foreach ($Name in $SubNetList) { # For each name in $SubNetList
                Write-Host $SubNetListNumber"." $Name.Name $Name.AddressPrefix # Writes items from list to screen
                $SubNetListNumber = $SubNetListNumber + 1 # Increments $var up by 1
            } # End foreach ($Name in $SubNetList)
            :GetAzureSubnetName while ($true) { # Inner loop for selecting the Subnet
                $SubNetListNumber = 1 # Resets $SubNetListNumber
                $SubNetListSelect = Read-Host "Please enter the number of the subnet" # Operator input for the Subnet selection
                foreach ($Name in $SubNetList) { # For each name in $SubnetList
                    if ($SubNetListSelect -eq $SubNetListNumber) { # If $SubnetListSelect equals current $SubnetListNumber
                        $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VnetObject -Name $Name.Name # Pulls the selected object and assigns to $var
                        Break GetAzureSubnetName # Breaks :GetAzureSubnetName
                    } # End if ($SubNetListSelect -eq $SubNetListNumber)
                    else { # If $SubnetListSelect does not equal the current $SubnetListNumber
                        $SubNetListNumber = $SubNetListNumber + 1 # Increments $var up by 1
                    } # End else (if ($SubNetListSelect -eq $SubNetListNumber))
                } # End foreach ($Name in $SubNetList)
                Write-Host "That was not a valid option" # Write message to screen
            } # End :GetAzureSubnetName while ($true)
            Return $SubnetObject # Returns to calling function with $var
        } # End :GetAzureSubnet while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzVNetSubnetConfig