# Benjamin Morgan benjamin.s.morgan@outlook.com 
# ref https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.0.0
# $Locklevel - Accepts CanNotDelete or ReadOnly or any amount of those terms such as CanNo or Rea
# $RGinput - Operator input used to get the RG object
# $RGObject - Full RG object .resourcegroupname is used for the actual command
# $Resinput - Operator input used to get the resource object
# $ResObject - Full resource object .resourcename and .resourcetype are used to apply a lock directly to resource
# $OPName - AZ user email address, used as part of the lock note
# $Scope - Used to determine if the lock is being applied at the resource or the group level
# $LockName - Operator provided lock name
# $LockNote - Operator provided lock notes
function FunctionName {
    param (
        [Parameter(Mandatory=$true, Position=0)] # Accepts CanNotDelete or ReadOnly (C or R)
        [string]$Locklevel
    )
    Begin {
        $ErrorActionPreference = "silentlyContinue" # Disables all auto errors
        if($Locklevel -like "c*" -or $Locklevel -like "r*"){ # Continues script if the lock level is set correctly
            # Collection of additional variables
            $RGinput = Read-Host "Please provide the name of the resource group for this lock" # Operator input for the RG name
            $RGObject = Get-AzResourceGroup -Name $RGinput # Gets RG object using operator input
            if (!$RGObject) { # If the operator provided name does not match an existing RG name, this if statement will promptt again
                Write-Host "The RG name provided did not match any resource groups"
                Write-Host "This is the list of available resource groups"
                Write-Host "**********************************************"
                $RGlist = (Get-AzResourceGroup).resourcegroupname | Format-Table # Gets list of all available RG names the operator has access to
                $RGlist # Prints the list for the operator
                Write-Host "**********************************************"
                Write-Host " "
                $RGinput = Read-Host "Please provide the name of the resource group for this lock" # Operator input for the RG name
                $RGObject = Get-AzResourceGroup -Name $RGinput # Gets RG object using operator input
                if (!$RGObject) { # If the operator mistypes the RG name a second time
                    Write-Host "Terminating script..."
                    Break # Terminates script
                }
            }
            $Scope = Read-Host "Is this lock being applied at the resource group" # Prompts operator for the scope of the lock
            # End collection of additional variables
            if ($Scope -eq "Y" -or $Scope -eq "Yes") { # This if statement is used to apply a lock to the RG scope
                SetAZRGLock($Locklevel, $RGObject) # Used to call (Function) SetAZRGLock and pass $LockLevel and $RGObject
            }
            elseif ($Scope -eq "N" -or $Scope -eq "No") { # This if statement is used to apply a lock to the resource scope           
                SetAZRSLock($Locklevel, $RGObject) # Used to call (Function) SetAZRSLock and pass $LockLevel and $RGObject
            }
            else { # Gives operator second chance to set the scope level
                Write-Host " "
                Write-Host "If the lock is to be applied to the entire resource group, type Yes"
                Write-Host "If the lock is to be applied to a resource within the group, type No"
                Write-Host " "
                $Scope = Read-Host "Is this lock being applied at the resource group" # Prompts operator for the scope of the lock
                if ($Scope -eq "Y" -or $Scope -eq "Yes") { # This if statement is used to apply a lock to the RG scope
                    SetAZRGLock($Locklevel, $RGObject) # Used to call (Function) SetAZRGLock and pass $LockLevel and $RGObject
                }
                elseif ($Scope -eq "N" -or $Scope -eq "No") { # This if statement is used to apply a lock to the resource scope           
                    SetAZRSLock($Locklevel, $RGObject) # Used to call (Function) SetAZRSLock and pass $LockLevel and $RGObject
                }
                else { # If the operator fails to enter a valid entry a second time
                    Write-Host "Terminating script..."
                    Break # Terminates script
                }
            }
        }
        elseif ($LockLevel -like "Exit" ) {
            Break
        }
        else {
            Write-Host "**********************************************"
            Write-Host "A non-valid lock level provided"
            Write-Host "Valid options are 'CanNotDelete' or 'ReadOnly'"
            Write-Host "Both options can be shortened to 'c' or 'r'"
            Write-Host "Please try again"
            Write-Host "**********************************************"
            FunctionName                
        }
    }
}
function SetAZRGLock {
    Begin {
        $OPName = (Get-AzContext).account.Id
        $LockName = $RGObject.ResourceGroupName+"Group Lock"
        $LockNote = "This resource group has been locked by "+$OPName
        New-AzResourceLock -LockName $LockName -LockLevel $Locklevel -LockNotes $LockNote -ResourceGroupName $RGObject.ResourceGroupName # Applies all operator provided values to create a lock
    }
}
function SetAZRSLock {
    Begin {
        Write-Host "Here are the resource names in"$RGObject.ResourceGroupName
        $ResList = (Get-AzResource -ResourceGroupName $RGObject.resourcegroupname).ResourceName | Format-Table
        Write-Host "*******************************************"
        $ResList
        Write-Host "*******************************************"
        $Resinput = Read-Host "Please provide the resource name"
        $ResObject = Get-AzResource -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $Resinput
        $OPName = (Get-AzContext).account.Id
        $LockName = $ResObject.ResourceName+"ResourceLock"
        $LockNote = "This resource has been locked by "+$OPName
        New-AzResourceLock -LockName $LockName -LockLevel $Locklevel -LockNotes $LockNote -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $ResObject.ResourceName -ResourceType $ResObject.ResourceType
    }
}