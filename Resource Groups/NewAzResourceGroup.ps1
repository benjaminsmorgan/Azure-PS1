# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    NewAzResourceGroup:         Creates a resource group object
} #>
<# Variables: {
    NewAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectinput:         Operator input for the resource group name
        $OperatorConfirm:       Operator confirmation info is correctly input
        $TagNameInput:          Operator input for a tag name
        $TagValueInput:         Operator input for the tag value
        $Tag:                   Full tag to be applied to the resource group creation
        $ValidLocation:         Collection of all Azure locations
        $LocationInput:         Operator input for the location
        :NewAzureRGObject       Named outer loop for creating a new resource group
        :SetTag                 Named inner loop for setting tag
        :SetName                Named inner loop for setting name
        :SetLocation            Named inner loop for setting location
    }
} #>
<# Process Flow {
    Function
        Call NewAzResourceGroup > Get $RGObject
            Return function > Send $RGObject
}#>
function NewAzResourceGroup { # Function to create a resource group, can pipe $RGObject to another function.
    Begin {
        :NewAzureRGObject while ($true) {
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            $Tag = $null # Clears all previous use
            $RGObject = $null # Clears all previous use
            :SetTag while ($true) { # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host "Enter the name of the tag (Enter 'skip' to leave untagged)" # Operator input for a tag name
                if ($TagNameInput -eq 'skip') {
                    Break SetTag # Breaks :SetTagLoop, allowing this step to be skipped
                } # End if ($TagNameInput -eq 'skip')
                if ($TagNameInput -eq 'exit') {
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag" # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput} # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }" # Writes tag to screen
                $OperatorConfirm = Read-Host "This is the tag to be applied to the new resource group" # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $Tag being correct
                    break SetTag # Ends :SetTag while loop
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End elseif ($OperatorConfirm -eq 'exit')
            } # End :SetTag while ($true)
            :SetName while ($true) { # Loop for creating and verifying $RGObject
                $RGObjectInput = Read-Host "New resource group name" # Operator input for the resource group name
                $OperatorConfirm = Read-Host "The new resource group will be called" $RGObjectInput # Operator confirmation that the name is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $RGObject being correct
                    Break SetName # Ends :SetName while loop
                } # End  if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End elseif ($OperatorConfirm -eq 'exit')    
            } # End while statement
            :SetLocation while ($true) { # Loop for creating and verifing $LocationInput
                $LocationInput = Read-Host "New resource group location" # Operator input for the location
                if ($LocationInput -eq 'exit') { # elseif statement to end this function
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End if ($LocationInput -eq 'exit')
                if ($LocationInput -iin $ValidLocation.Location) { # Validates $LocationInput against $ValidLocation
                    $OperatorConfirm = Read-Host "The new resource group will be located in" $LocationInput # Operator confirmation that the location is correct
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $LocationInput being correct
                        Break SetLocation # Ends :SetLocation while loop
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                        Break NewAzureRGObject # Breaks :NewAzrueRGObject
                    } # End elseif ($OperatorConfirm -eq 'exit')
                } # End if ($LocationInput -iin $ValidLocation.Location) 
                else { # Else statement for $LocationInput not matching anything in $ValidLocation
                    Write-Host "The location provided is not valid, please chose from the following" # Error reporting to the screen
                    Write-Host $ValidLocation.Location -Separator `n # Outputs the valid location lists
                } # End else (if ($LocationInput -iin $ValidLocation.Location)) 
            } # End :SetLocation while ($true)
            $ErrorActionPreference='Continue' # Turns back on error reporting, used if policy denies creation of a resource group
            if ($Tag) { # If statement for creating a resource group with the assigned tag
                $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location $LocationInput -Tag $Tag # Creates the resouce group and assigns to $RGObject
            } # End if ($Tag)
            else { # Create a resource group without a tag
                $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location $LocationInput # Creates the resouce group and assigns to $RGObject
            } # End else (if ($Tag))
            if ($RGObject) { # If $RGObject has been successfully created
                Return $RGObject # Returns to calling function
            } # End if ($RGObject)
            else { # else $RGObject has not been created
                Break NewAzrueRGObject # Ends :NewAzureRGObject loop
            } # End else (if ($RGObject))
        } # End :NewAzureRGObject while ($true)
        Return # Returns to a function that called it
    } # End of begin statement
} # End of function