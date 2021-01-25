# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzVMWin:                Lists all Windows VM by resource group
} #>
<# Variables: {
    $RGList:                    List of all resource groups in subscription
    $WinVMList:                 List of all Windows VM from current object in $RGList
} #>
<# Process Flow {
    Function
        Call ListAzVMWin > Get $null
        End ListAzVMWin
            Return Function > Send $null
}#>
function ListAzVMWin { # Lists all Windows VM by resource group
    Begin {
        $RGList = Get-AzResourceGroup # creates list of all resource groups
        foreach ($_ in $RGList) { # For each object in $RGList
            Write-Host "------------------------------------------" # Write message to screen
            Write-Host "Resource Group:" $_.ResourceGroupName # Write message to screen
            $WinVMList = Get-AzVM -ResourceGroupName $_.ResourceGroupName | Where-Object {$_.StorageProfile.OsDisk.OsType -eq 'Windows'} # Creates a list of all windows VMs current resource group
            if ($WinVMList) { # If Windows VMs exist ing this resource group
                foreach ($Name in $WinVMList) { # For each object in $WinVMList
                    Write-Host "------------------------------------------" # Write message to screen
                    Write-Host "VMName: " $Name.Name # Write message to screen
                    Write-Host "OS:     " $Name.StorageProfile.ImageReference.Sku # Write message to screen
                    Write-Host "Version:" $Name.StorageProfile.ImageReference.ExactVersion # Write message to screen
                } # End foreach ($Name in $WinVMList)
            } # End if ($WinVMList)
            else { # If no VMs exist in current group
                Write-Host "No Windows VMs in this resource group" # Write message to screen
            } # End else(if ($WinVMList))
        } # End foreach ($_ in $RGList)
        Write-Host "------------------------------------------" # Write message to screen
        Return # Returns to calling function
    } # End Begin
} # End function ListAzVMWin