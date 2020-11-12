# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/powershell/module/az.resources/set-azroledefinition?view=azps-5.0.0
# Ref https://docs.microsoft.com/en-us/azure/role-based-access-control/tutorial-role-assignments-user-powershell
# Ref https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azroleassignment?view=azps-5.0.0
function FunctionName {
    Begin {
        $TargetUserInput = Read-Host "UserName"
        $TargetUserObj = Get-AzADUser -UserPrincipalName $TargetUserInput
        $RightsLevel = Read-Host "Role"
        $Subscript = (get-azcontext).Subscription.id
        $SubID = "/subscriptions/"+$Subscript
        $Scope = Read-Host "Assign permissions to a Subscription?"
        if ($Scope -eq "y" -or $Scope -eq "Yes") {
            $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -Scope $SubID
            foreach ($RoleAssignmentId  in $CurrentRole) {
                Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope
            }
            New-AZRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -RoleDefinitionName $RightsLevel -Scope $SubID
            Break
        }    
        $Scope2 = Read-Host "Assign permissions to a Resource Group?" 
        if ($Scope2 -eq "y" -or $Scope2 -eq "Yes") {
            $TargetRGInput = Read-Host "RGName"
            $TargetRGObj = Get-AzResourceGroup $TargetRGInput
            $SubID2 = $SubID+"/resourceGroups/"+$TargetRGObj.ResourceGroupName
            $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName | Where-Object {$_.Scope -eq $SubID2} 
            foreach ($RoleAssignmentId  in $CurrentRole) {
                Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope
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
            $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName | Where-Object {$_.Scope -eq $SubID3} 
            foreach ($RoleAssignmentId  in $CurrentRole) {
                Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope
            }
            New-AZRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -RoleDefinitionName $RightsLevel -ResourceGroupName $TargetRGObj.ResourceGroupName -ResourceName $TargetRSObj.ResourceName -ResourceType $TargetRSObj.ResourceType  
            Break
        }
    }
}