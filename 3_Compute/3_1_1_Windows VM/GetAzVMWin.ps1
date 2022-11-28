# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzVMWin:                 Gets a windows VM object
    GetAzResourceGroup:         Gets a resource group object
} #>
<# Variables: {
    :GetAzureVMWindows          Outer loop for managing function
    :GetAzureVMWinName          Inner loop for selecting the VM
    $RGObject:                  Resource group object
    $WinVMList:                 List of all Windows VMs in $RGObject
    $WinVMListNumber:           $Var used to select $WinVMObject
    $WinVMListSelect:           Operator input for selecting $WinVMObject
    $WinVMObject:               Windows VM Object
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call GetAzVMWin > Get $WinVMObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return GetAzVMWin > Send $RGObject
        End GetAzVMWin
            Return Function > Send $WinVMObject
}#>
function GetAzVMWin { # Gets a windows VM object
    Begin {
        :GetAzureVMWindows while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureVMWindows # Ends :GetAzureVMWindows
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $WinVMList = Get-AzVM -ResourceGroupName $RGObject.ResourceGroupName | Where-Object {$_.StorageProfile.OsDisk.OsType -eq 'Windows'} # Creates list of all Windows VMs in resource group
            if (!$WinVMList) { # If $WinVMList returns empty
                Write-Host "No Windows VMs exist in this resource group" # Message write to screen
                Break GetAzureVMWindows # Ends :GetAzureVMWindows
            } # End if (!$WinVMList)
            $WinVMListNumber = 1 # Sets the base value of $WinVMListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $WinVMList) { # For each item in $WinVMList
                Write-Host $WinVMListNumber"." $_.Name # Writes $WinVMList to screen
                $WinVMListNumber = $WinVMListNumber+1 # Adds 1 to $WinVMListNumber
            } # End foreach ($_ in $WinVMList)
            :GetAzureVMWinName while ($true) { # Inner loop for selecting the VM
                $WinVMListNumber = 1 # Sets the base value of $WinVMListNumber
                $WinVMListSelect = Read-Host "Please enter the number of the VM" # Operator input for the Windows VM selection
                if ($WinVMListSelect -eq '0') { # If $WinVMList is '0'
                    Break GetAzureVMWindows # Ends :GetAzureVMWindows
                } # if ($WinVMListSelect -eq '0')
                foreach ($_ in $WinVMList) { # For each item in $WinVMList
                    if ($WinVMListSelect -eq $WinVMListNumber) { # If the operator input matches the current $WinVMListNumber
                        $WinVMObject = Get-AzVM -ResourceGroupName $RGObject.ResourceGroupName -Name $_.Name # Assigns current item in $WinVMList to $WinVMObject
                        Break GetAzureVMWinName # Breaks :GetAzureVMWinName
                    } # End if ($WinVMListSelect -eq $WinVMListNumber)
                    else { # If user input does not match the current $WinVMListNumber
                        $WinVMListNumber = $WinVMListNumber+1 # Adds 1 to $WinVMListNumber
                    } # End else (if ($WinVMListSelect -eq $WinVMListNumber))
                } # End foreach ($_ in $WinVMList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageAccount while ($true) {
            Return $WinVMObject # Returns to calling function with $WinVMObject
        } # End :GetAzureVMWindows while ($true)
        Return # Returns to calling function with $null
    } # End Begin 
} # End function GetAzVMWin