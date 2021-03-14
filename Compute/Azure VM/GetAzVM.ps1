# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzVM:                    Gets a VM object
} #>
<# Variables: {
    :GetAzureVM                 Outer loop for managing function
    :GetAzureVMName             Inner loop for selecting the VM
    $VMList:                    List of all VMs
    $ListNumber:                $Var used to select $VMObject
    $VMArray:                   Array used to list VM info
    $ArrayInput:                $Var used to load items into array
    $VMListSelect:              Operator input for selecting $VMObject
    $VMObject:                  VM Object
} #>
<# Process Flow {
    Function
        Call GetAzVM > Get $VMObject
        End GetAzVMWin
            Return Function > Send $VMObject
}#>
function GetAzVM {                                                                          # Gets $VMObject from list
    Begin {                                                                                 # Begin function
        :GetAzureVM while ($true) {                                                         # Outer loop for managing function
            $VMList = Get-AzVM -status                                                      # Gets a list
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number' = $ListNumber; 'Name' = $_.Name; `
                    'RG' =  $_.ResourceGroupName; 'Status' = $_.PowerState                  # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
            }                                                                               # End foreach ($_ in $VMList)
            Write-Host "Exit:    0"                                                         # Write message to screen
            Write-Host ""                                                                   # Write message to screen 
            foreach ($_ in $VMArray) {                                                      # Writes all VMs to screen
                Write-Host "Number: "$_.Number                                              # Write message to screen 
                Write-Host "Name:   "$_.Name                                                # Write message to screen 
                Write-Host "RG:     "$_.RG                                                  # Write message to screen
                Write-Host "Status: "$_.Status                                              # Write message to screen
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VMList)
            :GetAzureVMName while ($true) {                                                 # Inner loop for selecting VM from list
                $VMSelect = Read-Host "Please enter the number of the VM"                   # Operator input for the selection
                if ($VMSelect -eq '0') {                                                    # If $VMSelect is 0
                    Break GetAzureVM                                                        # Breaks :GetAzureVM
                }                                                                           # End if ($_Select -eq '0')
                $VMListSelect = $VMArray | Where-Object {$_.Number -eq $VMSelect}           # Isolates selected VM 
                if ($VMListSelect) {                                                        # If $VMListSelect has a valud
                    $VMObject = Get-AzVM -ResourceGroupName $VMListSelect.RG `
                        -Name $VMListSelect.Name                                            # Pulls full $VMObject
                    if ($VMObject) {                                                        # If $VMObject has a value
                        Return $VMObject                                                    # Returns to calling function with $VMObject
                    }                                                                       # End if ($VMObject)
                    else {                                                                  # If $VMObject does not have a value
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVM                                                    # Breaks :GetAzureVM
                    }                                                                       # End else (if ($VMObject))
                }                                                                           # End if ($VMListSelect)
                Write-Host "That was not a valid selection"                                 # Write message to screen 
            }                                                                               # End :GetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzureVMName