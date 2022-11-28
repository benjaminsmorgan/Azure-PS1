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
    ListAzVM:                   Function to list VM objects
} #>
<# Variables: {
    :ListAzureVM                Outer loop for managing function
    $VMList:                    List of all VMs
    $VMArray:                   Array used to list VM info
    $ArrayInput:                $Var used to load items into array
    $NicArray:                  Array to hold current VM network interfaces
    $NicIDs:                    Current item network interface IDs
    $PriIP:                     Private IP address on interface primary config
    $PriIPAll:                  Private IP address allocation on interface primary config
} #>
<# Process Flow {
    ListAzVM
}#>
function ListAzVM {                                                                         # Function to list all virtual machines
    Begin {                                                                                 # Begin function
        :ListAzureVM while ($true) {                                                         # Outer loop for managing function
            Write-Host 'Gathering VM info, this may take a momement'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureVM                                                            # Breaks :ListAzureVM
            }                                                                               # End if (!$VMList)
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
            foreach ($_ in $VMArray) {                                                      # For each item in $VMArray
                Write-Host 'Name:    '$_.Name                                               # Write message to screen
                Write-Host 'RG:      '$_.RG                                                 # Write message to screen
                Write-Host 'Location:'$_.LOC                                                # Write message to screen
                if ($_.OS.WindowsConfiguration) {                                           # If current item .OS.WindowsConfiguration has a value
                    Write-Host 'OS Type:  Windows'                                          # Write message to screen
                }                                                                           # End if ($_.OS.WindowsConfiguration)
                elseif ($_.OS.LinuxConfiguration) {                                         # If current item .OS.LinuxConfiguration has a value
                    Write-Host 'OS Type:  Linux'                                            # Write message to screen
                }                                                                           # End elseif ($_.OS.LinuxConfiguration)
                Write-Host 'Status:  '$_.Status                                             # Write message to screen
                foreach ($NIC in $_.Nic) {                                                  # For each item in current item .nic
                    Write-Host 'Nic Name:'$NIC.Name                                         # Write message to screen
                    foreach ($Config in $Nic.IPConfigurations) {                            # For each item in $Nic.IPConfigurations
                        Write-Host '  Config Name:  '$Config.Name                           # Write message to screen
                        Write-Host '    Private IP: '$Config.PrivateIPAddress               # Write message to screen
                        Write-Host '    Pri IP All: '$Config.PrivateIpAllocationMethod      # Write message to screen
                        if ($Config.PublicIPAddress.ID) {                                   # If $Config.PublicIPAddress.ID has a value
                            $PubIP = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $Config.PublicIPAddress.ID}                      # Pulls the full public IP address object
                            Write-Host '    Public IP:  '$PubIP.IpAddress                   # Write message to screen
                            Write-Host '    Pub All:    '$PubIP.PublicIpAllocationMethod    # Write message to screen
                            $PubIP = $null                                                  # Clears $var
                        }                                                                   # End if ($Config.PublicIPAddress.ID)
                        else {                                                              # Else if $Config.PublicIPAddress.ID does not have a value
                            Write-Host '    Public IP:   N/A'                               # Write message to screen
                            Write-Host '    Pub All:     N/A'                               # Write message to screen
                        }                                                                   # End else (if ($Config.PublicIPAddress.ID))
                    }                                                                       # End foreach ($Config in $Nic.IPConfigurations)
                }                                                                           # End foreach ($NIC in $_.Nic)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VMList)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureVM                                                               # Breaks :ListAzureVM
        }                                                                                   # End :ListAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVM