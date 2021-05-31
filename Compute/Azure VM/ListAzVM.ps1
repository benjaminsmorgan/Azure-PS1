# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzVM:                    Lists all VM objects
} #>
<# Variables: {
    :ListAzureVM                Outer loop for managing function
    $VMList:                    List of all VMs
    $ListNumber:                $Var used to select $VMObject
    $VMArray:                   Array used to list VM info
    $ArrayInput:                $Var used to load items into array
} #>
<# Process Flow {
    Function
        Call ListAzVM > Get $null
        End ListAzVMWin
            Return Function > Send $null
}#>
function ListAzVM {                                                                         # Function to list all virtual machines
    Begin {                                                                                 # Begin function
        :ListAzureVM while ($true) {                                                        # Outer loop for managing function
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureVM                                                           # Breaks :ListAzureVM
            }                                                                               # End if (!$VMList)
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Name'=$_.Name;'RG'= $_.ResourceGroupName;'Status' = $_.PowerState;`
                    'LOC'=$_.Location;'OS'=$_.OsProfile;'NIC'=$_.Nic                        # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
            }                                                                               # End foreach ($_ in $VMList)
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
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VMList)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureVM                                                               # Breaks :ListAzureVM
        }                                                                                   # End :ListAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVM