# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.3.0
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
function ListAzVM {                                                                         # Function to list VM objects
    Begin {                                                                                 # Begin function
        :ListAzureVM while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering VM info, this may take a momement'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureVM                                                           # Breaks :ListAzureVM
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
                $NicArray = $null                                                           # Clears $var
                $NicIDs = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $VMList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $VMArray) {                                                      # Foreach item in $VMArray
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
                    if ($NIC.IPConfigurations.Count -gt 1) {                                # If $NIC.IPConfigurations.Count is greater than 1
                        $PriIP = $NIC.IpConfigurations.PrivateIpAddress[0]                  # $PriIP is equal $NIC.IpConfigurations.PrivateIpAddress 1st value
                        $PriIPAll = $NIC.IpConfigurations.PrivateIpAllocationMethod[0]      # $PriIPAll is equal $NIC.IpConfigurations.PrivateIpAllocationMethod 1st value
                        Write-Host '  Pri IP:  '$PriIP                                      # Write message to screen
                        Write-Host '  Pri Allo:'$PriIPAll                                   # Write message to screen
                    }                                                                       # End if ($NIC.IPConfigurations.Count -gt 1)
                    else {                                                                  # Else If $NIC.IPConfigurations.Count is 1 or less
                        $PriIP = $NIC.IpConfigurations.PrivateIpAddress                     # $PriIP is equal $NIC.IpConfigurations.PrivateIpAddress
                        $PriIPAll = $NIC.IpConfigurations.PrivateIpAllocationMethod         # $PriIPAll is equal to $NIC.IpConfigurations.PrivateIpAllocationMethod 
                        Write-Host '  Pri IP:  '$PriIP                                      # Write message to screen
                        Write-Host '  Pri Allo:'$PriIPAll                                   # Write message to screen
                    }                                                                       # End else (if ($NIC.IPConfigurations.Count -gt 1))
                }                                                                           # End foreach ($NIC in $_.Nic)
            }                                                                               # End foreach ($_ in $VMArray)
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureVM                                                               # Breaks :ListAzureVM
        }                                                                                   # End :ListAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVM