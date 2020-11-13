# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/powershell/module/az.resources/move-azresource?view=azps-5.0.0 
# $ErrorActionPreference - Built in function, used to suppress error messages
# $SkipRG1 - Used to verify if a RG matched the operator input for the name
# $SkipRG2 - Used to verify if a RG matched the operator input for the name
# $SkipRS1 - Used to verify if a resource matched the operator input for the name
# $AllRGs - Used to list all RGs within a subscription
# $TargetRGInput - Operator input for the orginal RG name
# $TargetRGObj - Object for the orginal resource group
# $AllRSs - Used to list all resources within a resource group
# $TargetRSInput - Operator input for the resource name
# $TargetRSObj - Object to be moved
# $DestRGInput - Operator input for the destination RG name
# $DestRGObj - Object for the resource group that the resouce will be moved to
function FunctionName { # This script is training example for the command Move-AzResource, it should not be used as it does not have a robust functionality to properly move assets
    Begin {
        $ErrorActionPreference = "silentlyContinue" # Disables all auto errors
        if (!$SkipRG1) {
            $AllRGs = Get-AzResourceGroup | Select-Object ResourceGroupName | Format-Table
            Write-Host "Here is the list of Resource Groups in this subscription"
            Write-Host "*********************************"
            $AllRGs
            Write-Host "*********************************"
            $TargetRGInput = Read-Host "Please enter the RG name containing the resource" # Operator input for the resource group name
            $TargetRGObj = Get-AzResourceGroup $TargetRGInput # Resource group object containing the resource
            if (!$TargetRGObj) {
                Write-Host "The resource group name entered was invalid"
                FunctionName
            }
            else {
                $SkipRG1 = 'Yes'
            }
        }
        if (!$SkipRS1) {
            $AllRSs = Get-AzResource -ResourceGroupName $TargetRGObj.ResourceGroupName | Select-Object Name | Format-Table
            Write-Host "Here is the list of Resources in this group"
            Write-Host "*********************************"
            $AllRSs
            Write-Host "*********************************"
            $TargetRSInput = Read-Host "Please enter the name of the resource to be moved" # Operator input for the resource name
            $TargetRSObj = Get-AzResource -ResourceGroupName $TargetRGObj.ResourceGroupName -Name $TargetRSInput # Resource object to be moved
            if (!$TargetRSObj) {
                Write-Host "The resource name entered was invalid"
                FunctionName
            }
            else {
            $SkipRS1 = 'Yes'
            }
        }
        if (!$SkipRG2) {
            $AllRGs = Get-AzResourceGroup | Select-Object ResourceGroupName | Format-Table
            Write-Host "Here is the list of Resource Groups in this subscription"
            Write-Host "*********************************"
            $AllRGs
            Write-Host "*********************************"
            $DestRGInput = Read-Host "Please enter the RG name the resource is moving to" # Operator input for the resource group #
            $DestRGObj = Get-AzResourceGroup $DestRGInput # Resource group object #
            if (!$DestRGObj) {
                Write-Host "The resource group name entered was invalid"
                FunctionName
            }
            else {
                $SkipRG2 = 'Yes'
            }
        }
        Move-AzResource -DestinationResourceGroupName $DestRGObj.ResourceGroupName -ResourceId $TargetRSObj.ResourceId
    }
}