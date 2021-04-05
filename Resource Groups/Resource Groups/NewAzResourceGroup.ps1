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
    :NewAzureRGObject           Outer loop for creating a new resource group
    :SetAzureTag                Inner loop for setting tag
    :SetAzureName               Inner loop for setting name
    :SetAzureLocation           Inner loop for setting location
    $RGObject:                  Resource group object
    $RGObjectinput:             Operator input for the resource group name
    $OperatorConfirm:           Operator confirmation info is correctly input
    $TagNameInput:              Operator input for a tag name
    $TagValueInput:             Operator input for the tag value
    $Tag:                       Full tag to be applied to the resource group creation
    $LocationObject:            Location object
    GetAzLocation{}             Gets $LocationObject
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
function NewAzResourceGroup {                                                               # Function to create a resource group
    Begin {                                                                                 # Begin function
        :NewAzureRGObject while ($true) {                                                   # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            $Tag = $null                                                                    # Clears all previous use
            $RGObject = $null                                                               # Clears all previous use
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host `
                    "Enter the name of the tag (leave blank to leave untagged)"             # Operator input for a tag name
                if (!$TagNameInput) {                                                       # If $TagNameInput equals 'skip'
                    Break SetAzureTag                                                       # Breaks :SetAzureTag
                }                                                                           # End if ($!TagNameInput)
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag"                     # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Write message to screen
                Write-Host 'Apply this tag to the new resource group'                       # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureTag                                                       # Break :SetAzureTag
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureTag while ($true)
            :SetAzureName while ($true) {                                                   # Inner loop for setting the resource group name
                $RGObjectInput = Read-Host 'New resource group name'                        # Operator input for the resource group name
                if ($RGObjectInput -eq 'exit') {                                            # If $RGObjectInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End elseif ($RGObjectInput -eq 'exit') 
                Write-Host 'The new resource group will be called' $RGObjectInput           # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation that the name is correct
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureName                                                      # Break :SetAzureName
                }                                                                           # End if ($OperatorConfirm -eq 'y')   
            }                                                                               # End :SetAzureName while ($true)
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                :SetAzureLocation while ($true) {                                           # Inner loop for setting the resource group location
                    $CallingFunction = 'NewAzResourceGroup'                                 # Creates $CallingFunction
                    $LocationObject = GetAzLocation ($CallingFunction)                      # Calls function and assigns output to $Var
                    if (!$LocationObject) {                                                 # If $LocationObject is $null
                        Break NewAzureRGObject                                              # Breaks :NewAzureRGObject
                    }                                                                       # End if (!$LocationObject)
                    Break SetAzureLocation                                                  # Breaks :SetAzureLocation
                }                                                                           # End :SetAzureLocation while ($true)
            }                                                                               # End if (!$LocationObject) 
            if ($Tag) {                                                                     # If $Tag has a value
                Try {                                                                       # Try the following
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    Write-Host 'Tags:'$TagNameInput $TagValueInput                          # Write message to screen
                    $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions required'                  # Write message to screen
                    Write-Host 'Policy may exist preventing this action'                    # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject  
                }                                                                           # End catch
                Clear-Host                                                                  # Clears Screen
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End if ($Tag)
            else {                                                                          # If $Tag does not have a value
                Try {                                                                       # Try the following
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions required'                  # Write message to screen
                    Write-Host 'Policy may exist preventing this action'                    # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject  
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End else (if ($Tag))
        }                                                                                   # End :NewAzureRGObject while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End of begin statement
}                                                                                           # End function NewAzResourceGroup