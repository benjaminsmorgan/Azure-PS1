# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.3.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-6.3.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzVM:                    Function to get a virtual machine
} #>
<# Variables: {
    :GetAzureVM                 Outer loop for managing function
    :SelectAzureVM              Inner loop for selecting the VM
    $VMList:                    List of all VMs
    $ListNumber:                $Var used to select $VMObject
    $VMArray:                   Array used to list VM info
    $ArrayInput:                $Var used to load items into array
    $NicArray:                  Array to hold current VM network interfaces
    $NicIDs:                    Current item network interface IDs
    $Number:                    Current item .Number
    $PriIP:                     Private IP address on interface primary config
    $PriIPAll:                  Private IP address allocation on interface primary config
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input for selecting $VMObject
    $VMObject:                  VM Object
} #>
<# Process Flow {
    GetAzVM > Get $VMObject
}#>
function GetAzVM {                                                                          # Function to get a virtual machine
    Begin {                                                                                 # Begin function
        :GetAzureVM while ($true) {                                                         # Outer loop for managing function
            Write-Host 'Gathering VM info, this may take a momement'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureVM                                                            # Breaks :GetAzureVM
            }                                                                               # End if (!$VMList)
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $NicArray = @()                                                             # Creates $NicArray
                $NicIDs = $_.NetworkProfile.NetworkInterfaces.ID                            # Isolates the IDs
                foreach ($ID in $NicIDs) {                                                  # For each item in $NicIDs
                    $NicObject = Get-AzNetworkInterface | Where-Object {$_.ID -eq $ID}      # Pulls the full NIC object
                    $NicArray += $NicObject                                                 # Adds $NicObject to $NicArray
                    $NicObject = $null                                                      # Clears $var
                }                                                                           # End foreach ($ID in $NicIDs) 
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number'=$ListNumber;                                                   # List number
                    'Name'=$_.Name;                                                         # VM name
                    'RG'=$_.ResourceGroupName;                                              # Resource group name
                    'Status' = $_.PowerState;                                               # VM power state
                    'LOC'=$_.Location;                                                      # VM location
                    'OS'=$_.OsProfile;                                                      # Os profile
                    'NIC'=$NicArray                                                         # VM Nic info
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
                $NicArray = $null                                                           # Clears $var
                $NicIDs = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $VMList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureVM while ($true) {                                                  # Inner loop for selecting VM from list
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $VMArray) {                                                  # For each item in $VMArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]     "$_.Name                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))                     
                    Write-Host 'RG:      '$_.RG                                             # Write message to screen
                    Write-Host 'Location:'$_.LOC                                            # Write message to screen
                    if ($_.OS.WindowsConfiguration) {                                       # If current item .OS.WindowsConfiguration has a value
                        Write-Host 'OS Type:  Windows'                                      # Write message to screen
                    }                                                                       # End if ($_.OS.WindowsConfiguration)
                    elseif ($_.OS.LinuxConfiguration) {                                     # If current item .OS.LinuxConfiguration has a value
                        Write-Host 'OS Type:  Linux'                                        # Write message to screen
                    }                                                                       # End elseif ($_.OS.LinuxConfiguration)
                    Write-Host 'Status:  '$_.Status                                         # Write message to screen
                    foreach ($NIC in $_.Nic) {                                              # For each item in current item .nic
                        Write-Host 'Nic Name:'$NIC.Name                                     # Write message to screen
                        foreach ($Config in $Nic.IPConfigurations) {                        # For each item in $Nic.IPConfigurations
                            Write-Host '  Config Name:  '$Config.Name                       # Write message to screen
                            Write-Host '    Private IP: '$Config.PrivateIPAddress           # Write message to screen
                            Write-Host '    Pri IP All: '$Config.PrivateIpAllocationMethod  # Write message to screen
                            if ($Config.PublicIPAddress.ID) {                               # If $Config.PublicIPAddress.ID has a value
                                $PubIP = Get-AzPublicIpAddress | Where-Object `
                                    {$_.ID -eq $Config.PublicIPAddress.ID}                  # Pulls the full public IP address object
                                Write-Host '    Public IP:  '$PubIP.IpAddress               # Write message to screen
                                Write-Host `
                                    '    Pub All:    '$PubIP.PublicIpAllocationMethod       # Write message to screen
                                $PubIP = $null                                              # Clears $var
                            }                                                               # End if ($Config.PublicIPAddress.ID)
                            else {                                                          # Else if $Config.PublicIPAddress.ID does not have a value
                                Write-Host '    Public IP:   N/A'                           # Write message to screen
                                Write-Host '    Pub All:     N/A'                           # Write message to screen
                            }                                                               # End else (if ($Config.PublicIPAddress.ID))
                        }                                                                   # End foreach ($Config in $Nic.IPConfigurations)
                    }                                                                       # End foreach ($NIC in $_.Nic)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $VMList)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the VM for:'$CallingFunction              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureVM                                                        # Breaks :GetAzureVM
                }                                                                           # End if ($_Select -eq '0')
                elseif ($OpSelect -in $VMArray.Number) {
                    $OpSelect = $VMArray | Where-Object {$_.Number -eq $OpSelect}           # $OpSelect equals $VMArray where $VMArray.Number equals $OpSelect
                    $VMObject = Get-AzVM -ResourceGroupName $OpSelect.RG `
                        -Name $OpSelect.Name                                                # Pulls full $VMObject
                    Return $VMObject                                                        # Returns to calling function with $VMObject
                }                                                                           # End elseif ($OpSelect -in $VMArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureVM while ($true)
        }                                                                                   # End :GetAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVM