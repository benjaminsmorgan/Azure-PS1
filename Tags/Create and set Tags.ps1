# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/powershell/module/az.resources/get-aztag?view=azps-5.0.0
# Ref https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.0.0
# $TagOperation = Determines if tag update action will merge in entries or replace them
# $Tagname = The name of the new tag
# $TagValue =  The value of the tag
# $Tags = The combined array of tag name and value
# $RTypeinput = Used to define if the tag will be applied to a resource or a resource group
# $RSContinue = Used to loop back to the start of (Function) ApplyRSTag as well as determine if the RG is used again
# $AZRGInput = Operator input string for the resource group name
# $AZRGNAME = Resource group object name
# $AZRGResources = List of all resources in the RG by name
# $AZRSInput = Operator input string for the resource name
# $AZRSID = Resource object ID
# $AZRSTags = Resource object tags
# $SameRG = Operator option to use the same $AZRGName or use a new one
# $AZRG = Full resource group object
# $RGContinue1 = Operator option to apply the tag to a different resource group
# $RGContinue2 = Operator oprion to apply the tag to a resource within the selected resource group
function FunctionName {
    param (
        [Parameter(Mandatory=$true, Position=0)] # Accepts Replace or Merge (R or M)
        [string]$TagOperation,
        [Parameter(Mandatory=$true, Position=1)] # Tag Name
            [string]$Tagname,
        [Parameter(Mandatory=$true, Position=2)] # Tag Value
            [string]$TagValue
    )
    Begin {
        $Tags =@{$Tagname=$TagValue} # The combined array of tag name and value
        Write-Host "Type RS for Resource"
        Write-host "Type RG for Resource Group"
        $RTypeinput = Read-Host ":" # Used to define if the tag will be applied to a resource or a resource group
        if ($RTypeinput -eq "RS") { # This if statement calls (Function) ApplyRSTag and passes $Tag and $TagOperation
            ApplyRSTag ($Tags, $TagOperation)
        }
        elseif ($Rtypeinput -eq "RG") { # This elseif statement calls (Function) ApplyRGTag and passes $Tag and $TagOperation
            ApplyRGTag ($Tags, $TagOperation)
        }
        else { # No additional sanitization done in this script, causes an exit
            Write-Host "That was not a valid option"
        }
    }
}
function ApplyRSTag () { # Applies tag only to resources
    Begin {
        if (!$RSContinue) { # $RSContinue is used after the first pass through of this funtion, it is used to bypass RG selection
            $AZRGInput = Read-Host "Resource Group Name" # Collects operator string for resource group name
            $AZRGNAME = (Get-AzResourceGroup -Name $AZRGInput).ResourceGroupName # collects RG object name
        }
        $AZRGResources = Get-AzResource -ResourceGroupName $AZRGNAME | select-object Name | Format-Table # Collects all resources within RG by name
        Write-Host "///////////////////////////////////////////"
        $AZRGResources # Outputs full list of resources in RG by name
        Write-Host "///////////////////////////////////////////"
        $AZRSInput = Read-Host "Resource Name" # Collects operator string for resource name
        $AZRSID = (Get-AzResource -ResourceGroupName $AZRGNAME -Name $AZRSInput) # Collects the resource object by ID
        Update-AzTag -ResourceId $AZRSID.ResourceId -Tag $Tags -Operation $TagOperation # Applies the tag to the object ID and tag operation
        $AZRSTags = Get-AzTag -ResourceId $AZRSID.ResourceId # Gets all tags applied to the resource
        $AZRSTags.Properties # Outputs the new tag into to the operator (Issue with output printing 2 times)
        $RSContinue = Read-Host "Apply this tag to another Resource?" # Prompts operator to apply tag to another resource
        if ($RSContinue -eq "Yes" -or $RSContinue -eq "Y") { # This if statement continues the process for tag application
            $SameRG = Read-Host "Is the Resource in" $AZRGNAME # Prompts operator if same RG will be used
            if ($SameRG -eq "Yes" -or $SameRG -eq "Y") { # if statement for retaining the same resource group
                ApplyRSTag ($RSContinue) # This if statement will pass along a not $null value to $RSContinue for the next loop
            }
            else { # Else statement for using a different RG for application
                $RSContinue = $null # Sets a $null for $RSContinue so script re-prompts for RG values
                ApplyRSTag # Restarts this function
            }
        }
        else { # Else statement for no additional tag applications
            Break # Terminates script
        }
    }
}
function ApplyRGTag { # Applies tag only to resource groups
    Begin {
        $AZRGInput = Read-Host "Resource Group Name" # Collects operator string for resource group name
        $AZRG = (Get-AzResourceGroup -Name $AZRGInput) # collects RG object (Both the name and ID will need to be used later)
        Update-AzTag -ResourceId $AZRG.ResourceId -Tag $Tags -Operation $TagOperation # Applies the tag to the object ID and tag operation
        $RGContinue1 = Read-Host "Apply this tag to another Resource Group?" # Prompts operator to apply tag to another RG
        if ($RGContinue1 -eq "Yes" -or $RGContinue1 -eq "Y") { # If statement to apply this tag to another RG
            ApplyRGTag # Restarts this function           
        }
        else { # Additional prompts follow
            $RGContinue2 = Read-Host "Apply this tag to a resource within" $AZRG.ResourceGroupName # Prompts operator to apply tag to a resource within this RG 
            if ($RGContinue2 -eq "Yes" -or $RGContinue2 -eq "Y") { # If statement for yes
                $RSContinue = "y" # Applies a non $null value to $RSContinue to skip RG info collection in (Function) ApplyRSTag
                $AZRGNAME = $AZRG.ResourceGroupName # Pulls RG name object from $AZRG object and applies to $var used in (Function) ApplyRSTag
                ApplyRSTag ($AZRGNAME, $RSContinue) # calls (Function) ApplyRSTag and passes $AZRGNAME and $RGContinue
            }
            else { # Else statment for non-yes response for continuing
                Break # Terminates script
            }
        }
    }   
}