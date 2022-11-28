# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzDisk:                 Lists disks
} #>
<# Variables: {
    :ListAzureDisk              Outer loop for managing funciton
    $DiskList:                  List of all disks
} #>
<# Process Flow {
    function
        Call ListAzDisk > Get $null
        End ListAzDisk 
            Return Function > Send $null
}#>
function ListAzDisk {                                                                       # Function to list all disk objects
    Begin {                                                                                 # Begin function
        :ListAzureDisk while ($true) {                                                      # Outer loop for managing function
            $DiskList = Get-AzDisk                                                          # Gets a list of all disks
            foreach ($_ in $DiskList) {                                                     # For each item in $DiskList
                Write-Host 'Disk Name: ' $_.Name                                            # Write message to screen
                Write-Host 'RG:        ' $_.ResourceGroupName                               # Write message to screen
                Write-Host 'OS:        ' $_.OsType                                          # Write message to screen
                Write-Host 'Size (GB): ' $_.DiskSizeGB                                      # Write message to screen
                Write-Host 'State:     ' $_.DiskState                                       # Write message to screen
                Write-Host 'Location:  ' $_.Location                                        # Write message to screen
                Write-Host 'Created:   ' $_.TimeCreated                                     # Write message to screen
                Write-Host 'Net Access:' $_.NetworkAccessPolicy                             # Write message to screen    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $DiskList)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureDisk                                                             # Breaks :ListAzureDisk
        }                                                                                   # End :ListAzureDisk while ($true)
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function ListAzDisk