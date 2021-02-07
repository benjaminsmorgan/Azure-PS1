# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzDisk:                  Collects disk object
} #>
<# Variables: {
    :GetAzureDisk               Outer loop for managing funciton
    :SelectAzureDisk            Inner loop for selecting the disk
    $DiskList:                  List of all disks
    $DiskListNumber:            $var used in the disk selection
    $DiskSelect:                Operator input for selecting the disk
    $DiskListSelect:            The selected object, used to pull the full object
    $DiskObject:                The disk object
} #>
<# Process Flow {
    function
        Call GetAzDisk > Get $DiskObject
        End GetAzDisk 
            Return Function > Send $DiskObject
}#>
function GetAzDisk { # Collects disk object
    Begin {
        :GetAzureDisk while ($true) { # Outer loop for managing function
            $DiskList = Get-AzDisk # Gets a list of all disks
            $DiskListNumber = 1 # $Var for setting $DiskList.Number
            foreach ($_ in $DiskList) { # For each item in $DiskList
                $_ | Add-Member -NotePropertyName 'Number' -NotePropertyValue $DiskListNumber # Adds number property to each item in list
                $DiskListNumber = $DiskListNumber + 1 # Increments $DiskListNumber by 1
            } # End foreach ($_ in $DiskList)
            Write-Host "Option:  0 [Exit]" # Write message to screen
            Write-Host"" # Write message to screen
            foreach ($_ in $DiskList) { # Writes all objects to screen
                Write-Host "Option: "$_.Number # Write message to screen
                Write-Host "Name:   " $_.Name # Write message to screen
                Write-Host "RG:     " $_.ResourceGroupName # Write message to screen
                Write-Host "State:  " $_.DiskState # Write message to screen
                Write-Host"" # Write message to screen
            } # End foreach ($_ in $DiskList)
            :SelectAzureDisk while ($true) { # Inner loop for selecting object from list
                $DiskSelect = Read-Host "Please enter the number of the disk" # Operator input for the selection
                if ($DiskSelect -eq '0') { # If $DiskSelect is 0
                    Break GetAzureDisk # Breaks :GetAzureDisk
                } # End if ($_Select -eq '0')
                $DiskListSelect = $DiskList | Where-Object {$_.Number -eq $DiskSelect} # Isolates selected object 
                if ($DiskListSelect) { # If $DiskListSelect has a valud
                    Break SelectAzureDisk # Breaks SelectAzureDisk
                } # End if ($DiskListSelect)
                Write-Host "That was not a valid selection" # Write message to screen 
            } # End :SelectAzureDisk while ($true)
            $DiskObject = Get-AzDisk | Where-Object {$_.Name -eq $DiskListSelect.Name} # Pulls the full list object
            Return $DiskObject # Returns $Object to calling function
        } # End :GetAzureDisk while ($true)
        Return # Returns to calling function with $null 
    } # End Begin
} # End function GetAzDisk