# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzDisk:                  Collects disk object
} #>
<# Variables: {
    :GetAzureDisk               Outer loop for managing function
    :SelectAzureDisk            Inner loop for selecting the disk
    $CallingFunction:           Name of this function or the one that called it
    $ObjectList:                List of all disks
    $ObjectNumber:              $var used for listing and selecting items
    $ObjectArray:               Array holding all disk items
    $ObjectInput:               $var used to load items into $ObjectArray
    $Number:                    Current item .Number, used for formatting
    $OpSelect:                  Operator input to select the disk
    $DiskObject:                Disk object
} #>
<# Process Flow {
    function
        Call GetAzDisk > Get $DiskObject
        End GetAzDisk 
            Return Function > Send $DiskObject
}#>
function GetAzDisk {                                                                        # Function to get a disk object
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzDisk'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureDisk while ($true) {                                                       # Outer loop for managing function
            $ObjectList = Get-AzDisk                                                        # Gets a list of all disks
            $ObjectNumber = 1                                                               # $Var for setting $ObjectList.Number
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number' = $ObjectNumber;`
                'Name'=$_.Name;'RG'=$_.ResourceGroupName;'OS'=$_.OsType;`
                'Size'=$_.DiskSizeGB;'State'=$_.DiskState;'Loc'=$_.Location;`
                'TC'=$_.TimeCreated;'Sku'=$_.Sku.Name}                                      # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureDisk while ($true) {                                                # Inner loop for selecting object from list
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number]       "$_.Name                                # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) 
                    Write-Host 'Location: '$_.loc                                           # Write message to screen
                    Write-Host 'Sku Name: '$_.Sku                                           # Write message to screen
                    Write-Host 'RG:       '$_.RG                                            # Write message to screen
                    Write-Host 'OS:       '$_.Os                                            # Write message to screen
                    Write-Host 'State:    '$_.State                                         # Write message to screen
                    Write-Host 'Created:  '$_.TC                                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction -and $CallingFunction -ne 'GetAzDisk') {               # If $CallingFunction has a value and not equal to 'GetAzDisk'
                    Write-Host 'You are selecting the disk for:'$CallingFunction            # Write message to screen
                }                                                                           # End if ($CallingFunction -and $CallingFunction -ne 'GetAzDisk')
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the disk
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                   Break GetAzureDisk                                                       # Breaks :GetAzureDisk
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $DiskObject = Get-AzDisk -ResourceGroupName $OpSelect.RG `
                        -DiskName $OpSelect.Name                                            # Gets full disk object
                    Return $DiskObject                                                      # Returns $DiskObject to calling function
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                   Write-Host 'That was not a valid input'                                  # Write message to screen
                   Pause                                                                    # Pauses all actions for operator input
                   Clear-Host                                                               # Clears host
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureDisk while ($true)
        }                                                                                   # End :GetAzureDisk while ($true)
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzDisk