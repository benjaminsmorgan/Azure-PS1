# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzNetworkInterface:      Gets an azure network interface
} #>
<# Variables: {
    :GetAzureNic                Outer loop for managing function
    $NicList:                   List of all network interfaces
    $NicListtNumber:            $Var used for $NicObject list selection
    $NicListtSelect:            Operator input for for $NicObject selection
    $NicObject:                 Network interface object
} #>
<# Process Flow {
    Function
        Call GetAzNetworkInterface > Get $NicObject
        End GetAzNetworkInterface
            Return function > Send $NicObject
}#>
function GetAzNetworkInterface { # Gets a network interface
    Begin {
        :GetAzureNic while ($true) { # Outer loop for managing function
            $NicList = Get-AzNetworkInterface # pulls all items into list for selection
            $NicListNumber = 1 # $var used for selecting the NIC
            foreach ($_ in $NicList) { # For each item in $NicList
                $_ | Add-Member -NotePropertyName 'Number' -NotePropertyValue $NicListNumber # Adds number property to each item in list
                $NicListNumber = $NicListNumber + 1 # Increments $NicListNumber by 1
            } # End foreach ($_ in $NicList)
            Write-Host "0 Exit" # Write message to screen
            Write-Host "" # Write message to screen
            foreach ($_ in $NicList) { # Writes all objects to screen
                Write-Host "NIC: " $_.Number # Write message to screen
                Write-Host "Name:"$_.Name # Write message to screen
                Write-Host "IP:  " $_.IpConfigurations.PrivateIpAddress # Writes list to screen
                Write-Host "RG : " $_.ResourceGroupName # Write message to screen
                if ($_.VirtualMachine) { # $_.VirtualMachine has a value
                    Write-Host "VM: "$_.VirtualMachine.ID.split("/")[0,-1] # Write message to screen
                } # End if ($_.VirtualMahine) 
                Write-Host "" # Write message to screen
            } # End foreach ($_ in $NicList)
            :GetAzureNicName while ($true) { # Inner loop for selecting the NIC
                $NicListNumber = 1 # Resets $NicListNumber
                $NicListSelect = Read-Host "Please enter the number of the network interface" # Operator input for the NIC selection
                if ($NicListSelect -eq 0) { # IF $NicListSelect equals 0
                    Break GetAzureNic # Breaks :GetAzureNic 
                } # End if ($NicListSelect -eq 0)
                foreach ($Name in $NicList) { # For each name in $NicList
                    if ($NicListSelect -eq $Name.Number) { # If $NicListSelect equals current $NicListNumber
                        $NicObject = Get-AzNetworkInterface | Where-Object {$_.Name -eq $Name.Name} # Pulls the selected object and assigns to $var
                        Break GetAzureNicName # Breaks :GetAzureNicName
                    } # End if ($NicListSelect -eq $NicListNumber)
                    else { # If $NicListSelect does not equal the current $NicListNumber
                        $NicListNumber = $NicListNumber + 1 # Increments $var up by 1
                    } # End else (if ($NicListSelect -eq $NicListNumber))
                } # End foreach ($Name in $NicList)
                Write-Host "That was not a valid option" # Write message to screen
            } # End :GetAzureNicName while ($true)
            Return $NicObject # Returns to calling function with $var
        } # End :GetAzureNic while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzNetworkInterface