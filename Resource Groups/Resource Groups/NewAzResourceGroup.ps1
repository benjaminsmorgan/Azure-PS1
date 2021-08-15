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
    :NewAzureRGObject           Outer loop for managing function
    :SetAzureName               Inner loop to set the group name
    :SetAzureTag                Inner loop ro set the group tag
    $CallingFunction:           Name of this function or the one that called it
    $CurrentRGNames:            List of all currently existing resource groups
    $RGObjectInput:             Operator input of the resource group name
    $OpConfirm:                 Operator confirmation of values
    $LocationObject:            Location object
    $TagNameInput:              Operator input for tag name
    $TagValueInput:             Operator input for tag value
    $Tag:                       Combined tag name and value
    $MSG:                       Last PS error message
    GetAzLocation{}             Gets $LocationObject
} #>
<# Process Flow {
    Function
        Call NewAzResourceGroup > Get null
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzResourceGroup > Send $LocationObject
        End NewAzResourceGroup
            Return function > Send null
}#>
function NewAzResourceGroup {                                                               # Function to create a resource group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzResourceGroup'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureRGObject while ($true) {                                                   # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            $CurrentRGNames = Get-AzResourceGroup | Select-Object ResourceGroupName         # Gets a list of all currently existing names
            :SetAzureName while ($true) {                                                   # Inner loop for setting the resource group name
                Write-Host 'Enter a resource group name'                                    # Write message to screen
                $RGObjectInput = Read-Host 'Name'                                           # Operator input for the resource group name
                Clear-Host                                                                  # Clears screen
                if ($RGObjectInput -in $CurrentRGNames.ResourceGroupName) {                 # If $RGObjectInput is in $CurrentRGNames.ResourceGroupName
                    Write-Host $RGObjectInput 'is currently in use'                         # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    $RGObjectInput = $null                                                  # Clears $RGObjectInput
                }                                                                           # End if ($RGObjectInput -in $CurrentRGNames.ResourceGroupName)
                if ($RGObjectInput -eq 'exit') {                                            # If $RGObjectInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End elseif ($RGObjectInput -eq 'exit') 
                if ($RGObjectInput) {                                                       # If $RGObjectInput has a value
                    Write-Host 'The new resource group will be called:'$RGObjectInput       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation that the name is correct
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureName                                                  # Break :SetAzureName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureRGObject                                              # Breaks :NewAzrueRGObject
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                }                                                                           # End if ($RGObjectInput)
            }                                                                               # End :SetAzureName while ($true)
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $Var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureRGObject                                                      # Breaks :NewAzureRGObject
            }                                                                               # End if (!$LocationObject)
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                Write-Host 'Enter a tag name'                                               # Write message to screen
                Write-Host 'Leave blank to create the'                                      # Write message to screen
                Write-Host 'resource group without tags'                                    # Write message to screen
                $TagNameInput = Read-Host 'Tag name'                                        # Operator input for a tag name
                Clear-Host                                                                  # Clears screen
                if (!$TagNameInput) {                                                       # If $TagNameInput equals 'skip'
                    Break SetAzureTag                                                       # Breaks :SetAzureTag
                }                                                                           # End if ($!TagNameInput)
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End if ($TagNameInput -eq 'exit')
                Write-Host 'Enter the tag value for:'$TagNameInput                          # Write message to screen
                $TagValueInput = Read-Host 'Tag value'                                      # Operator input for the tag value
                Clear-Host                                                                  # Clears screen
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Write message to screen
                Write-Host 'Apply this tag to the new resource group'                       # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation that tag info is correct
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureTag                                                       # Break :SetAzureTag
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject
                }                                                                           # End elseif ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureTag while ($true)
            Try {                                                                       # Try the following
                if ($Tag) {                                                                     # If $Tag has a value        
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    Write-Host 'Tags:'$TagNameInput $TagValueInput                          # Write message to screen
                    New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End if ($Tag)
                else {                                                                      # If $Tag is $null
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End else (if ($Tag))
            }                                                                               # End Try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureRGObject                                                      # Breaks :NewAzureRGObject    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears Screen
            Write-Host 'The resource group has been created'                                # Write message to screen
            Pause                                                                           # Pauses all actions for operator input 
            Break NewAzureRGObject                                                          # Breaks :NewAzureRGObject  
        }                                                                                   # End :NewAzureRGObject while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End of begin statement
}                                                                                           # End function NewAzResourceGroup