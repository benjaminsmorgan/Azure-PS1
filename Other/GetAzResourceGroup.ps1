function GetAzResourceGroup {
    Begin {
        $ErrorActionPreference='silentlyContinue'
        $RGObject = $null
        while (!$RGObject) {
            $RGObjectInput = Read-Host "Resource group name"
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput
            if (!$RGObject) {
                Write-Host "The name provided does not match an existing resource group"
                Write-Host "This is the list of available resource groups"
                Get-AzResourceGroup | Select-Object ResourceGroupName | Format-Table
            }
            else {
                $RGObject | Select-Object ResourceGroupName, Tags | Format-Table
            }
        }
        Return $RGObject
    }
}