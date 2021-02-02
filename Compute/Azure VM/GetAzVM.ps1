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
    $VMListNumber:              $Var used to select $VMObject
    $VMListSelect:              Operator input for selecting $VMObject
    $VMObject:                  VM Object
} #>
<# Process Flow {
    Function
        Call GetAzVM > Get $VMObject
        End GetAzVMWin
            Return Function > Send $VMObject
}#>
function GetAzVM { # Gets $VMObject from list
    Begin {
        :GetAzureVM while ($true) { # Outer loop for managing function
            $VMList = Get-AzVM -status # Gets a list
            $VMListNumber = 1 # $Var for setting $VMList.Number
            foreach ($_ in $VMList) { # For each item in $VMList
                $_ | Add-Member -NotePropertyName 'Number' -NotePropertyValue $VMListNumber # Adds number property to each item in list
                $VMListNumber = $VMListNumber + 1 # Increments $VMListNumber by 1
            } # End foreach ($_ in $VMList)
            Write-Host "Exit:    0" # Write message to screen
            Write-Host "" # Write message to screen 
            foreach ($_ in $VMList) { # Writes all VMs to screen
                Write-Host "Number: "$_.Number # Write message to screen 
                Write-Host "Name:   "$_.Name # Write message to screen 
                Write-Host "RG:     "$_.ResourceGroupName # Write message to screen
                Write-Host "Status: "$_.PowerState # Write message to screen
                Write-Host "" # Write message to screen
            } # End foreach ($_ in $VMList)
            :GetAzureVMName while ($true) { # Inner loop for selecting VM from list
                $VMSelect = Read-Host "Please enter the number of the VM" # Operator input for the selection
                if ($VMSelect -eq '0') { # If $VMSelect is 0
                    Break GetAzureVM # Breaks :GetAzureVM
                } # End if ($_Select -eq '0')
                $VMListSelect = $VMList | Where-Object {$_.Number -eq $VMSelect} # Isolates selected VM 
                if ($VMListSelect) { # If $VMListSelect has a valud
                    Break GetAzureVMName # Breaks :GetAzureVMName
                } # End if ($VMListSelect)
                Write-Host "That was not a valid selection" # Write message to screen 
            } # End :GetAzureVMName while ($true)
            $VMObject = Get-AzVM -Name $_.Name -ResourceGroup $_.ResourceGroupName # Collects the full object after selection
            Return $VMObject # Returns $VMObject to calling function
        } # End :GetAzureVM while ($true)
        Return # Returns with $null 
    } # End Begin
} # End function GetAzureVMName