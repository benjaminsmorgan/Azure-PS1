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