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
# $ReplaceRoles2 - Operator Final confirmation to remove current existing roles at the current scope level
function FunctionName { # This function is used to create or replace roles for a user
    Begin {
        # $Var creation
        $TargetUserInput = Read-Host "User email address" # Operator input for User ID (Email address)
        $TargetUserObj = Get-AzADUser -UserPrincipalName $TargetUserInput # User object, rights are assigned and removed from this
        $RightsLevel = Read-Host "Role" # Operator input for role (Not sanitized)
        $Subscript = (get-azcontext).Subscription.id # Currently logged in subscription ID
        $SubID = "/subscriptions/"+$Subscript # Azure formatting of the scope at the subscription level
        $Scope = Read-Host "Assign permissions to a Subscription?" # Operator input to verify that script will run at subscription level
        if ($Scope -eq "y" -or $Scope -eq "Yes") { # Verify operator input
            $ReplaceRoles = Read-Host "Replace current roles at this scope level?" # Operator 1st confirmation to remove current existing roles at the current scope level
            if ($ReplaceRoles -eq "Y" -or $ReplaceRoles -eq "Yes") { # First verification on current role removal for scope
                $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -Scope $SubID # List of all target user roles at the current scope level
                Write-Host "The current roles will be removed"
                Write-Host "******************************************************"
                $CurrentRole | Select-Object scope, RoleDefinitionName | Format-Table # List of all target user roles at the current scope level, the scope and role are output into a table
                Write-Host "******************************************************"
                $ReplaceRoles2 = Read-Host "Type Yes to confirm removal" # Operator final confirmation to remove current existing roles at the current scope level
                if ($ReplaceRoles2 -eq "Yes" -or $ReplaceRoles2 -eq "Y") { # Final verification on current role removal for scope
                    foreach ($RoleAssignmentId  in $CurrentRole) { # Performs following action for each instance of $RoleAssignmentID in $CurrentRole
                        Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope # Removes the listed role
                    }
                }
            }
            New-AZRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -RoleDefinitionName $RightsLevel -Scope $SubID # Creates the new role
            Break # Terminates script
        }    
        $Scope2 = Read-Host "Assign permissions to a Resource Group?" # Operator input to verify that script will run at resource group level
        if ($Scope2 -eq "y" -or $Scope2 -eq "Yes") { # Verify operator input
            $TargetRGInput = Read-Host "RGName" # Operator input for the resource group name
            $TargetRGObj = Get-AzResourceGroup $TargetRGInput # Resource group object, rights are assigned and removed  from this
            $SubID2 = $SubID+"/resourceGroups/"+$TargetRGObj.ResourceGroupName # Azure formatting of the scope at the resource group level
            $ReplaceRoles = Read-Host "Replace current roles at this scope level?"  # Operator 1st confirmation to remove current existing roles at the current scope level
            if ($ReplaceRoles -eq "Y" -or $ReplaceRoles -eq "Yes") { # First verification on current role removal for scope
                $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName | Where-Object {$_.Scope -eq $SubID2} # List of all target user roles at the current scope level
                Write-Host "The current roles will be removed"
                Write-Host "******************************************************"
                $CurrentRole | Select-Object scope, RoleDefinitionName | Format-Table # List of all target user roles at the current scope level, the scope and role are output into a table
                Write-Host "******************************************************"
                $ReplaceRoles2 = Read-Host "Type Yes to confirm removal" # Operator final confirmation to remove current existing roles at the current scope level
                if ($ReplaceRoles2 -eq "Yes" -or $ReplaceRoles2 -eq "Y") { # Final verification on current role removal for scope
                    foreach ($RoleAssignmentId  in $CurrentRole) { # Performs following action for each instance of $RoleAssignmentID in $CurrentRole
                        Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope # Removes the listed role
                    }
                }
            }    
            New-AZRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -RoleDefinitionName $RightsLevel -ResourceGroupName $TargetRGObj.ResourceGroupName # Creates the listed role
            Break # Terminates script
        }
        $Scope3 = Read-Host "Assign permissions to a Resource?" # Operator input to verify that script will run at resource level
        if ($Scope3 -eq "y" -or $Scope3 -eq "Yes") { # Verify operator input
            $TargetRGInput = Read-Host "RGName" # Operator input for the resource group name
            $TargetRGObj = Get-AzResourceGroup $TargetRGInput # Resource group object containing the resource
            $TargetRSInput = Read-Host "Resource Name" # Operator input for the resource name
            $TargetRSObj = Get-AzResource -ResourceGroupName $TargetRGObj.ResourceGroupName -Name $TargetRSInput # Resource group object, rights are assigned and removed  from this
            $SubID3 = $SubID+"/resourceGroups/"+$TargetRGObj.ResourceGroupName+"/providers/"+$TargetRSObj.ResourceType+"/"+$TargetRSObj.Name # Azure formatting of the scope at the resource level 
            $ReplaceRoles = Read-Host "Replace current roles at this scope level?" # Operator 1st confirmation to remove current existing roles at the current scope level
            if ($ReplaceRoles -eq "Y" -or $ReplaceRoles -eq "Yes") { # First verification on current role removal for scope
                $CurrentRole = Get-AzRoleAssignment -SignInName $TargetUserObj.UserPrincipalName | Where-Object {$_.Scope -eq $SubID3} # List of all target user roles at the current scope level
                Write-Host "The current roles will be removed"
                Write-Host "******************************************************"
                $CurrentRole | Select-Object scope, RoleDefinitionName | Format-Table # List of all target user roles at the current scope level, the scope and role are output into a table
                Write-Host "******************************************************"
                $ReplaceRoles2 = Read-Host "Type Yes to confirm removal" # Operator final confirmation to remove current existing roles at the current scope level
                if ($ReplaceRoles2 -eq "Yes" -or $ReplaceRoles2 -eq "Y") { # Final verification on current role removal for scope
                    foreach ($RoleAssignmentId  in $CurrentRole) { # Performs following action for each instance of $RoleAssignmentID in $CurrentRole
                        Remove-AzRoleAssignment -ObjectID $RoleAssignmentId.ObjectID -RoleDefinitionName $RoleAssignmentId.RoleDefinitionName -Scope $RoleAssignmentId.Scope # Removes the listed role
                    }
                }
            }
            New-AZRoleAssignment -SignInName $TargetUserObj.UserPrincipalName -RoleDefinitionName $RightsLevel -ResourceGroupName $TargetRGObj.ResourceGroupName -ResourceName $TargetRSObj.ResourceName -ResourceType $TargetRSObj.ResourceType # Creates the listed role 
            Break # Terminates script
        }
    }
}