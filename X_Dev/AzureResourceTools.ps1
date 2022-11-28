#This is a combined admin script thats still in progress, not for use. 
function AzureAdmin {
    Begin {
        #$SelectedResourceGroupObject = $null
        #$SelectedResourceObject = $null
        $AzureLogin = Get-AzContext
        if (!$Azurelogin) {
            Write-Host "Performing log in to Azure"
            az login
        }
        else {
            $ResourceOrAccounts = Read-Host "User accounts or resources"
            if ($ResourceOrAccounts -like "r*") {
                $SkipRGroup = $false
                $SkipResourceOrGroup = $false
                $SkipResource = $true
                ResourceManagement ($SkipRGroup, $SkipResource, $SkipResourceOrGroup) #function for resources
            }
            elseif ($ResourceOrAccounts -like 'u*') {
                #function for AzureAD
            }
        }
    }
}
function ResourceManagement {
    Begin {
        if ($SkipRGroup -eq $false) {
            $AllResouceGroupsObjects = Get-AzResourceGroup
            Write-Host "This is the list of all resource Groups"
            Write-Host "***************************************"
            $AllResouceGroupsObjects | Select-Object ResourceGroupName | Format-Table
            Write-Host "***************************************"
            $SelectedResourceGroupInput = Read-Host "Please enter the name of the resource group"
            $SelectedResourceGroupObject = Get-AzResourceGroup -Name $SelectedResourceGroupInput
        }
        if ($SkipResourceOrGroup -eq $false) { 
            $ResourceOrGroup = Read-Host "Admininster a resource inside of a group?"
            if ($ResourceOrGroup -eq 'y' -or $ResourceOrGroup -eq 'yes') {
                $SkipResource = $false
            }
            else {
                $SelectedResourceObject = $null
            }
        }
        if ($SkipResource -eq $false) {
            $AllResourceObjects = Get-AzResource -ResourceGroupName $SelectedResourceGroupObject.ResourceGroupName
            Write-Host "This is the list of all resources"
            Write-Host "*********************************"
            $AllResourceObjects | Select-Object Name | Format-Table
            Write-Host "*********************************"
            $SelectedResourceInput = Read-Host "Please enter the name of the resource"
            $SelectedResourceObject = Get-AzResource -ResourceGroupName $SelectedResourceGroupObject.ResourceGroupName -Name $SelectedResourceInput
            if (!$SelectedResourceObject){ 
                Write-Host "The resource name provided does not match"
                $SkipRGroup = $true
                $SkipResourceOrGroup = $true
                ResourceManagement
            }
        }
        $SelectedResourceGroupObject.ResourceGroupName
        $SelectedResourceObject.Name
        Write-Host "What type of function is being done?"
        Write-Host "1 Tags"
        Write-Host "2 Locks"
        Write-Host "3 KeyVault"
        Write-Host "4 Delete Resources"
        $ResourceAdminFunction = Read-Host""
        if ($ResourceAdminFunction -eq "1"){
            AzureTagsAdmin ($SelectedResourceGroupObject, $SelectedResourceObject)
        }
        elseif ($ResourceAdminFunction -eq "2") {
            AzureLocksAdmin ($SelectedResourceGroupObject, $SelectedResourceObject)
        }
        elseif ($ResourceAdminFunction -eq "3") {
            AzureKeyVaultAdmin ($SelectedResourceGroupObject, $SelectedResourceObject)
        }
        elseif ($ResourceAdminFunction -eq "4") {
            AzureDeleteAdmin ($SelectedResourceGroupObject, $SelectedResourceObject)
        }
        else {
            Write-Host "You didn't select a number value"
            $SkipRGroup = $true
            $SkipResource = $true
            ResourceManagement
        }
    }
}
function AzureTagsAdmin {
    Begin {
        Write-Host "This is the Tags Function"
        Write-Host "1 Add additional tags"
        Write-Host "2 Replace existing tags"
        Write-Host "3 Remove existing tags"
        Write-Host "4 View current tags"
        $TagsAdminFunction = Read-Host""
        if ($TagsAdminFunction -eq "1" -or $TagsAdminFunction -eq "2") {
            $NewTagName = Read-Host "What is the new tag name"
            $NewTagValue = Read-host "What is the new tag value"
            $NewTags = @{$NewTagName=$NewTagValue}
        }
        if ($TagsAdminFunction -eq "1") {
            if (!$SelectedResourceObject) {
                Update-AzTag -ResourceId $SelectedResourceGroupObject.ResourceId -Tag $NewTags -Operation Merge
            }
            else {
                Update-AzTag -ResourceId $SelectedResourceObject.ResourceId -Tag $NewTags -Operation Merge
            }
        }
        elseif ($TagsAdminFunction -eq "2") {
            if (!$SelectedResourceObject) {
                Update-AzTag -ResourceId $SelectedResourceGroupObject.ResourceId -Tag $NewTags -Operation Replace
            }
            else {
                Update-AzTag -ResourceId $SelectedResourceObject.ResourceId -Tag $NewTags -Operation Replace
            }
        }
        elseif ($TagsAdminFunction -eq "3") {
            if (!$SelectedResourceObject) {
                #$AllTags = (Get-AzTag -ResourceId $SelectedResourceGroupObject.ResourceId).properties
                #$AllTags
                Write-Host "RGArea"
                Write-Host "Select the Tag name to be removed"
                Write-Host "To remove all tags type 'All'"
                Write-host "To exit type 'Exit'"
                $TagsAdminFunctionRemove = Read-Host " "
                if ($TagsAdminFunctionRemove -eq "All") {
                    Remove-AzTag -ResourceId $SelectedResourceGroupObject.ResourceId
                }
                elseif ($TagsAdminFunctionRemove -eq "Exit") {
                    Write-Host "No changes made, GoodBye"
                    Break 
                }
                else {
                    Remove-AzTag -ResourceId $SelectedResourceGroupObject.ResourceId -Name
                }
            }
            else {
                $AllTags = (Get-AzResource -ResourceId $SelectedResouceObject.ResourceId).tags | Format-Table
                $AllTags
                Write-Host "Resource Tag Remove area"
                Write-Host "Select the Tag name to be removed"
                Write-Host "To remove all tags type 'All'"
                Write-host "To exit type 'Exit'"
                $TagsAdminFunctionRemove = Read-Host""
                if ($TagsAdminFunctionRemove -eq "All") {
                    Remove-AzTag -ResourceId $SelectedResourceObject.ResourceId
                }
                elseif ($TagsAdminFunctionRemove -eq "Exit") {
                    Write-Host "No changes made, GoodBye"
                    Break 
                }
                else {
                    Remove-AzTag -ResourceId $SelectedResourceObject.ResourceId -Name $TagsAdminFunctionRemove
                }
            }
        }
        elseif ($TagsAdminFunction -eq "4") {
            if (!$SelectedResourceObject) {
                $AllTags = (Get-AzTag -ResourceId $SelectedResourceGroupObject.ResourceID).properties
                $AllTags
            }
            else {
                $AllTags = (Get-AzTag -ResourceId $SelectedResourceObject.ResourceID).properties
                $AllTags
            }
        }
        else {
            Write-Host "You didn't select a number value"
            AzureTagsAdmin
        }
        $SelectedResourceGroupObject
        $SelectedResourceObject
        
    }
}
function AzureLocksAdmin {
    Begin {
        Write-Host "This is the Locks Function"
        $SelectedResourceGroupObject
        $SelectedResourceObject
        
    }
}
function AzureKeyVaultAdmin {
    Begin {
        Write-Host "This is the Keyvault Function"
        $SelectedResourceGroupObject
        $SelectedResourceObject
        
    }
}
function AzureDeleteAdmin {
    Begin {
        Write-Host "This is the Delete Function"
        $SelectedResourceGroupObject
        $SelectedResourceObject
        
    }
}