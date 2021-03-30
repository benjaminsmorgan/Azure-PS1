# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
} #>
<# Functions Description: {
    NewAzResourceGroup:         Creates a resource group object
    GetAzLocation:              Gets Azure location
} #>
<# Variables: {
    NewAzResourceGroup {
        :NewAzureRGObject       Outer loop for creating a new resource group
        :SetAzureTag            Inner loop for setting tag
        :SetAzureName           Inner loop for setting name
        :SetAzureLocation       Inner loop for setting location
        $RGObject:              Resource group object
        $RGObjectinput:         Operator input for the resource group name
        $OperatorConfirm:       Operator confirmation info is correctly input
        $TagNameInput:          Operator input for a tag name
        $TagValueInput:         Operator input for the tag value
        $Tag:                   Full tag to be applied to the resource group creation
        $LocationObject:        Location object
        GetAzLocation{}         Gets $LocationObject
    }
} #>
<# Process Flow {
    Function
        Call NewAzResourceGroup > Get $RGObject
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzResourceGroup > Send $LocationObject
        End NewAzResourceGroup
            Return function > Send $RGObject
}#>
function NewAzResourceGroup { # Function to create a resource group, can pipe $RGObject to another function.
    Begin {
        :NewAzureRGObject while ($true) {
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            $Tag = $null # Clears all previous use
            $RGObject = $null # Clears all previous use
            :SetAzureTag while ($true) { # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host "Enter the name of the tag (Enter 'skip' to leave untagged)" # Operator input for a tag name
                if ($TagNameInput -eq 'skip') {
                    Break SetAzureTag # Breaks :SetAzureTagLoop, allowing this step to be skipped
                } # End if ($TagNameInput -eq 'skip')
                if ($TagNameInput -eq 'exit') {
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag" # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput} # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }" # Writes tag to screen
                $OperatorConfirm = Read-Host "This is the tag to be applied to the new resource group" # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $Tag being correct
                    break SetAzureTag # Ends :SetAzureTag while loop
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End elseif ($OperatorConfirm -eq 'exit')
            } # End :SetAzureTag while ($true)
            :SetAzureName while ($true) { # Loop for creating and verifying $RGObject
                $RGObjectInput = Read-Host "New resource group name" # Operator input for the resource group name
                $OperatorConfirm = Read-Host "The new resource group will be called" $RGObjectInput # Operator confirmation that the name is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $RGObject being correct
                    Break SetAzureName # Ends :SetAzureName while loop
                } # End  if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End elseif ($OperatorConfirm -eq 'exit')    
            } # End while statement
            if (!$LocationObject) { # If $LocationObject is $null
                :SetAzureLocation while ($true) { # Loop for creating and verifing $LocationInput
                    $LocationObject = GetAzLocation # Calls function and assigns output to $Var
                    if (!$LocationObject) { # If $LocationObject is $null
                        Break NewAzureRGObject # Breaks :NewAzureRGObject
                    } # End if (!$LocationObject)
                    Break SetAzureLocation # Breaks :SetAzureLocation
                } # End :SetAzureLocation while ($true)
            } # End if (!$LocationObject) 
            $ErrorActionPreference='Continue' # Turns back on error reporting, used if policy denies creation of a resource group
            if ($Tag) { # If statement for creating a resource group with the assigned tag
                $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location $LocationObject.Location -Tag $Tag # Creates the resouce group and assigns to $RGObject
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
function GetAzLocation { # Gets azure location
    Begin {
        :GetAzureLocation while ($true) { # Outer loop for managing function
            $LocationList = Get-AzLocation # Gets a list of all Azure locations
            $LocationListNumber = 1 # $Var for selecting the location
            Write-Host "0. Exit" # Write message to screen
            foreach ($Location in $LocationList) { # For each item in $LocationList
                Write-Host $LocationListNumber"." $Location.DisplayName # Writes list to screen
                $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
            } # End foreach ($Location in $LocationList)
            :GetAzureLocationName while ($true) { # Inner loop for selecting location from list
                $LocationSelect = Read-Host "Please enter the number of the location" # Operator input for the selection
                if ($LocationSelect -eq '0') { # If $LocationSelect is 0
                    Break GetAzureLocation # Breaks :GetAzureLocation
                } # End if ($LocationSelect -eq '0')
                $LocationListNumber = 1 # Resets $LocationListNumber
                foreach ($Location in $LocationList) { # For each item in $locationList
                    if ($LocationSelect -eq $LocationListNumber) { # If $LocationSelect equals $LocationListNumber
                        $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $Location.Location} # Collects the current location and assigns to $Location
                        Break GetAzureLocationName # Breaks :GetAzureLocationName 
                    } # End if ($LocationSelect -eq $LocationListNumber)
                    else { # If $locationSelect does not equal $LocationListNumber
                        $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
                    } # End else if ($LocationSelect -eq $LocationListNumber)
                } # End foreach ($Location in $LocationList)
                Write-Host "That was not a valid selection" # Write message to screen
            } # End :GetAzureLocationName while ($true)
            Return $LocationObject # Returns $Location to calling function
        } # End :GetAzureLocation while ($true)
        Return # Returns with $null 
    } # End Begin
} # End function GetAzLocation