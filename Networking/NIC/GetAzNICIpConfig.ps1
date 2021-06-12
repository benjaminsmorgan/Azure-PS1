# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-6.0.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzNICIpConfig:           Gets a NIC IP configuration
} #>
<# Variables: {      
    :GetAzureNICIpConfig        Outer loop for managing function
    :SelectAzureNICIpConfig     Inner loop for selecting the IP config
    $ObjectList:                List of all NICs
    $ObjectNumber:              $var used for listing and selecting
    $NICName:                   Current item .Name
    $NicRG:                     Current item .ResourceGroupName
    $NicVM:                     Current item .VirtualMachine.ID
    $VMObject:                  Virtual machine object if present
    $IPConfigList:              Current item .IPConfigurations
    $ObjectArray:               Array holding all NIC IP configs 
    $ObjectInput:               $var used to load items into $ObjectArray
    $Number:                    Current item .Number
    $PubID:                     Current item .PubIP.ID
    $PubIP:                     IP currently used by attached public IP sku
    $OpSelect:                  Operator input to select the IP config
} #>
<# Process Flow {
    function
        Call GetAzNICIpConfig > Get $NicIPConfigObject
        End GetAzNICIpConfig
            Return function > Send $NicIPConfigObject, $NicObject
}#>
function GetAzNICIpConfig {                                                                 # Function to get network interface config
    Begin {                                                                                 # Begin function
        :GetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $ObjectList = Get-AzNetworkInterface                                            # Gets a list of all NICs
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $NICName = $_.Name                                                          # $NICName is equal to current item .Name
                $NicRG = $_.ResourceGroupName                                               # Gets the NIC resource group
                $NicVM = $_.VirtualMachine.ID                                               # Gets the NIC VM if attached
                if ($NicVM) {                                                               # If $NicVM has a value 
                    $VMObject = Get-AzVM | Where-Object {$_.ID -eq $NICVM}                  # Gets the currently attached VM
                }                                                                           # End if ($NicVM)
                $IPConfigList = $_.IPConfigurations                                         # IPConfigList is equal to current item .IPConfigurations
                foreach ($_ in $IPConfigList) {                                             # For each item in $IPConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates $ObjectInput            
                        'Number'=$ObjectNumber;'Name'=$_.Name;`
                        'PrivIP'=$_.PrivateIPAddress;`
                        'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                        'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                        'NICName'=$NICName;'NICRG'=$NicRG;'NICVM'=$VMObject.Name            # Collects the information for the array
                    }                                                                       # End $ObjectInput = [PSCustomObject]
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber +1                                        # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $IPConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureNICIpConfig while ($true) {                                         # Inner loop for selecting the NIC IP config
                Write-Host '[0]   Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .Number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                   "$_.Name                    # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number]                  "$_.Name                     # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Private IP Address:   '$_.PrivIP                            # Write message to screen 
                    Write-Host 'Private IP Allocation:'$_.PrivIPAllo                        # Write message to screen
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        $PubID = $_.PubIP.ID                                                # Isolates the public IP sku ID
                        $PubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubID}    # Gets the public IP sku
                        Write-Host 'Public IP Address:    '$PubIP.IpAddress                 # Write message to screen
                        Write-Host 'Public IP Allocation: '$PubIP.PublicIpAllocationMethod  # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    Write-Host 'Is primary:           '$_.Pri                               # Write message to screen
                    Write-Host 'Nic Name:             '$_.NicName                           # Write message to screen
                    if ($_.NICVM) {                                                         # If current item .NICVM has a value
                        Write-Host 'Attached VM:          '$_.NicVM                         # Write message to screen
                    }                                                                       # End if ($_.NICVM)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the IP config for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the network config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNICIpConfig                                               # Breaks :GetAzureNICIpConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName `
                        -ResourceGroupName $OpSelect.NicRG                                  # Gets the $NicObject
                    $NicIPConfigObject = Get-AzNetworkInterfaceIpConfig -NetworkInterface `
                        $NicObject -Name $OpSelect.Name                                     # Gets the NicIPConfigObject
                    Return $NicIPConfigObject,$NicObject                                    # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNICIpConfig while ($true)
        }                                                                                   # End :GetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNICIpConfig