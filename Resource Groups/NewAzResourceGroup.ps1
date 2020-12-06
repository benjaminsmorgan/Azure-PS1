# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.1.0
} #>
<# Required Functions: {
    NewAzResourceGroup:         Creates a resource group object
} #>
<# Variables: {
    NewAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectinput:         Operator input for the resource group name
        $RGList:                variable used for printing all resource groups to screen if needed
        $OperatorConfirm:       Operator confirmation info is correctly input
        $TagNameInput:          Operator input for a tag name
        $TagValueInput:         Operator input for the tag value
        $Tag:                   Full tag to be applied to the resource group creation
        $ValidLocation:         Collection of all Azure locations
        :SetTag                 Named while loop for setting tag
        :SetName                Named while loop for setting name
        :SetLocation            Named while loop for setting location
    }
} #>
function NewAzResourceGroup { # Function to create a resource group, can pipe $RGObject to another function.
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
        :SetTag while (!$Tag) { # Loop for creating and verifing $Tag
            $TagNameInput = Read-Host "Enter the name of the tag" # Operator input for a tag name
            $TagValueInput = Read-Host "Enter the value of the tag" # Operator input for the tag value
            $Tag = @{$TagNameInput=$TagValueInput} # Full tag to be applied to the resource group creation
            $Tag # Writes tag to screen
            $OperatorConfirm = Read-Host "This is the tag to be applied to the new resource group" # Operator confirmation that tag info is correct
            if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $Tag being correct
                break SetTag # Ends :SetTag while loop
            } # End if statement
            elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                Write-Host "**Terminating script**" # Write to screen that function is ending
                Return # Ends function and returns to calling function
            } # End elseif statement
            else { # Else statement for all other inputs
                $Tag = $null # Sets $Tag to $null restarting while loop
            } # End while statement
        } # End while statement
        :SetName while (!$RGObjectInput) { # Loop for creating and verifying $RGObject
            $RGObjectInput = Read-Host "New resource group name" # Operator input for the resource group name
            $OperatorConfirm = Read-Host "The new resource group will be called" $RGObjectInput # Operator confirmation that the name is correct
            if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $RGObject being correct
                Break SetName # Ends :SetName while loop
            } # End if statement
            elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                Write-Host "**Terminating script**" # Write to screen that function is ending
                Return # Ends function and returns to calling function
            } # End elseif statement
            else { # Else statement for all other inputs
                $RGObjectInput = $null # Sets $RGObject to $null restsrting while loop
            } # End else statement
        } # End while statement
        :SetLocation while (!$Location) { # Loop for creating and verifing $Location
            $Location = Read-Host "New resource group location" # Operator input for the location
            if ($Location -iin $ValidLocation.Location) { # Validates $Location against $ValidLocation
                $OperatorConfirm = Read-Host "The new resource group will be located in" $Location # Operator confirmation that the location is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $Location being correct
                    Break SetLocation # Ends :SetLocation while loop
                } # End if statement
                elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                    Write-Host "**Terminating script**" # Write to screen that function is ending
                    Return # Ends function and returns to calling function
                } # End elseif statment
                else { # Else statement for all other inputs
                    $Location = $null # Sets $Location to $null restsrting while loop
                } # End else statement
            } # End if statement
            else { # Else statement for $Location not matching anything in $ValidLocation
                Write-Host "The location provided is not valid, please chose from the following" # Error reporting to the screen
                $ValidLocation.Location # Outputs the valid location lists
                $Location = $null # Sets $Location back to $null
            } # End else statement
        } # End while statement
        $ErrorActionPreference='Continue' # Turns back on error reporting, used if policy denies creation of a resource groip
        New-AzResourceGroup -Name $RGObjectInput -Location $Location -Tag $Tag # Creates the resouce group
        Return # Returns to a function that called it
    } # End of begin statement
} # End of function