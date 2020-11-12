# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/powershell/module/az.resources/set-azroledefinition?view=azps-5.0.0
# Ref https://docs.microsoft.com/en-us/azure/role-based-access-control/tutorial-role-assignments-user-powershell
# Ref https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azroleassignment?view=azps-5.0.
# $TargetUserInput - Operator input for User ID (Email address)
# $TargetUserObj - User object, rights are assigned and removed from this
# $RightsLevel - Operator input for role (Not sanitized)
# $Subscript - Currently logged in subscription ID
# $SubID - Azure formatting of the scope at the subscription level
# $SubID2 - Azure formatting of the scope at the resource group level
# $SubID3 - Azure formatting of the scope at the resource level
# $Scope - Operator input to verify that script will run at subscription level
# $Scope2 - Operator input to verify that script will run at resource group level
# $Scope3 - Operator input to verify that script will run at resource level
# $CurrentRole - List of all target user roles at the current scope level
# $TargetRGInput - Operator input for RG name
# $TargetRGObj - Object for the resource group
# $TargetRSInput - Operator input for the resource name
# $TargetRSObj - Object for the resource
# $RoleAssigmentID - $var used for-each cycle to remove existing roles at the current scope level
# $ReplaceRoles - Operator 1st confirmation to remove current existing roles at the current scope level
# $OPConfirm - Operator Final confirmation to remove current existing roles at the current scope level
function FunctionName {
    Begin {
        $TargetUserInput = Read-Host "UserName"
        $TargetUserObj = Get-AzADUser -UserPrincipalName $TargetUserInput
        $RightsLevel = Read-Host "Role"
        $Subscript = (get-azcontext).Subscription.id
        $SubID = "/subscriptions/"+$Subscript
        $Scope = Read-Host "Assign permissions to a Subscription?"
        if ($Scope -eq "y" -or $Scope -eq "Yes") {
            $ReplaceRoles = Read-Host "Replace current roles at this scope level?"
            if ($ReplaceRoles -eq "Y" -or $ReplaceRoles -eq "Yes") {
                $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -Scope $SubID
                Write-Host "The current roles will be removed"
                Write-Host "******************************************************"
                $CurrentRole | Select-Object scope, RoleDefinitionName | Format-Table
                Write-Host "******************************************************"
                $OPConfirm = Read-Host "Type Yes to confirm removal"
                if ($OPConfirm -eq "Yes" -or $OPConfirm -eq "Y") {
                    foreach ($RoleAssignmentId  in $CurrentRole) {
                        Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope
                    }
                }
            }
            New-AZRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -RoleDefinitionName $RightsLevel -Scope $SubID
            Break
        }    
        $Scope2 = Read-Host "Assign permissions to a Resource Group?" 
        if ($Scope2 -eq "y" -or $Scope2 -eq "Yes") {
            $TargetRGInput = Read-Host "RGName"
            $TargetRGObj = Get-AzResourceGroup $TargetRGInput
            $SubID2 = $SubID+"/resourceGroups/"+$TargetRGObj.ResourceGroupName
            $ReplaceRoles = Read-Host "Replace current roles at this scope level?"
            if ($ReplaceRoles -eq "Y" -or $ReplaceRoles -eq "Yes") {
                $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName | Where-Object {$_.Scope -eq $SubID2} 
                Write-Host "The current roles will be removed"
                Write-Host "******************************************************"
                $CurrentRole | Select-Object scope, RoleDefinitionName | Format-Table
                Write-Host "******************************************************"
                $OPConfirm = Read-Host "Type Yes to confirm removal"
                if ($OPConfirm -eq "Yes" -or $OPConfirm -eq "Y") {
                    foreach ($RoleAssignmentId  in $CurrentRole) {
                        Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope
                    }
                }
            }    
            New-AZRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -RoleDefinitionName $RightsLevel -ResourceGroupName $TargetRGObj.ResourceGroupName
            Break
        }
        $Scope3 = Read-Host "Assign permissions to a Resource?"    
        if ($Scope3 -eq "y" -or $Scope3 -eq "Yes") {
            $TargetRGInput = Read-Host "RGName"
            $TargetRGObj = Get-AzResourceGroup $TargetRGInput
            $TargetRSInput = Read-Host "Resource Name"
            $TargetRSObj = Get-AzResource -ResourceGroupName $TargetRGObj.ResourceGroupName -Name $TargetRSInput
            $SubID3 = $SubID+"/resourceGroups/"+$TargetRGObj.ResourceGroupName+"/providers/"+$TargetRSObj.ResourceType+"/"+$TargetRSObj.Name
            $ReplaceRoles = Read-Host "Replace current roles at this scope level?"
            if ($ReplaceRoles -eq "Y" -or $ReplaceRoles -eq "Yes") { 
                $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName | Where-Object {$_.Scope -eq $SubID3} 
                Write-Host "The current roles will be removed"
                Write-Host "******************************************************"
                $CurrentRole | Select-Object scope, RoleDefinitionName | Format-Table
                Write-Host "******************************************************"
                $OPConfirm = Read-Host "Type Yes to confirm removal"
                if ($OPConfirm -eq "Yes" -or $OPConfirm -eq "Y") {
                    foreach ($RoleAssignmentId  in $CurrentRole) {
                        Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope
                    }
                }
            }
            New-AZRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -RoleDefinitionName $RightsLevel -ResourceGroupName $TargetRGObj.ResourceGroupName -ResourceName $TargetRSObj.ResourceName -ResourceType $TargetRSObj.ResourceType  
            Break
        }
    }
}