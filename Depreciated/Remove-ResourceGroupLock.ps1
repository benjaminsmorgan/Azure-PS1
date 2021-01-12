function Name { # This function removes all resource locks applied to a resource group
    param (
        # Parameter help description
        [Parameter(Mandatory=$true, Position=0)]
        [string] $RGName
    )
    Begin {
        $RGInfo = (Get-AzResourceGroup -Name $RGName)
        $LockList = (Get-AzResourceLock -ResourceGroupName $RGInfo.ResourceGroupName)
        #Remove-AzResourceLock -ResourceId $LockID -Force
        #Write-Host "Lock as been removed from RG" $RGInfo.ResourceGroupName
        foreach ($LockID in $LockList) {
            Remove-AzResourceLock -LockId $LockID.LockID -Force
        }
    }
}