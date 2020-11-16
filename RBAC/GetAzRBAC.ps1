# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/azure/role-based-access-control/role-assignments-list-powershell\
# $TargetUserInput - Operator input for the target AzureAD user
# $TargetUserObject - AzureAD object undergoing review
# $SubPermissions - $Var containing all assigned RBAC permissions set the subscription scope
# $RGPermissions - $Var containing all assigned RBAC permissions set the resource group scope
# $RSPermissions - $Var containing all assigned RBAC permissions set the resource scope
function FunctionName {
    Begin {
        $TargetUserInput = Read-Host "User email address" # Collects email address for target user
        $TargetUserObject = Get-AzADUser -UserPrincipalName $TargetUserInput # gets target user object
        Write-Host "Subscription level permissions"
        $SubPermissions = Get-AzRoleAssignment -SignInName $TargetUserObject.UserPrincipalName  -ExpandPrincipalGroups | Where-Object {$_.Scope -notlike "*resourceGroups*" } | format-list DisplayName, RoleDefinitionName, Scope # Gets RBAC roles, keeps only those whos scopes do not include 'resourceGroup'
        if (!$SubPermissions) { # Message for empty $SubPermissions
            Write-Host "No permissions assigned at the subscription Scope"
        }
        else {
            $SubPermissions # Writes $var to screen
        }
        Write-Host "*******************************************************"
        Write-Host "Resource group level permissions"
        $RGPermissions = Get-AzRoleAssignment -SignInName $TargetUserObject.UserPrincipalName  -ExpandPrincipalGroups | Where-Object {$_.Scope -like "*resourceGroups*" -and $_.Scope -notlike "*providers*"} | format-list DisplayName, RoleDefinitionName, Scope # Gets RBAC roles, keeps only those whos scope includes 'resourceGroup' but not 'providers'
        if (!$RGPermissions) { # Message for empty $RGPermissions
            Write-Host "No permissions assigned at the resource group scope"
        }
        else {
            $RGPermissions # Writes $var to screen
        }
        Write-Host "*******************************************************"
        Write-Host "Resource level permissions"
        $RSPermissions = Get-AzRoleAssignment -SignInName $TargetUserObject.UserPrincipalName  -ExpandPrincipalGroups | Where-Object {$_.Scope -like "*providers*"} | format-list DisplayName, RoleDefinitionName, Scope # Gets RBAC roles, keeps only those whos scope includes 'providers'
        if (!$RSPermissions) { # Message for empty $RSPermissions
            Write-Host "No permissions assigned at the resource scope"
        }
        else {
            $RSPermissions # Writes $var to screen
        }
        Write-Host "*******************************************************"
        Write-Host "End of permissions"
    }
}