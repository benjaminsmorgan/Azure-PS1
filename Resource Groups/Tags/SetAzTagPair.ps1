# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzTagPair:               Create a tag array for another function
} #>
<# Variables: { 
    :SetAzureTagPair            Outer loop for function
    :SetAzureTagName            Inner loop for setting the tag name
    :SetAzureTagValue           Inner loop for setting the tag value
    $CallingFunction            Name of the function that called this function
    $TagNameInput:              Operator input for the tag name
    $TagValueInput:             Operator input for the tag value 
    $TagArray:                  Build array of tag name and value
    $ArrayInput:                Loads $TagNameInput and $TagValue input into $TagArray
    $OpConfirm:                 Operator confirmation on tag name and value 
} #>
<# Process Flow {
    Function
        Call SetAzTagPair > Get $TagArray
        End SetAzTagPair
            Return SetAzTagPair > Send $TagArray
#>
function SetAzTagPair {                                                                     # Function for setting the tag name and value pair
    Begin {                                                                                 # Being function
        [System.Collections.ArrayList]$TagArray = @()                                       # Creates the blank tag array
        :SetAzureTagPair while ($true) {                                                    # Outer loop for managing function
            if ($CallingFunction) {                                                         # If $CallingFunction has a value
                Write-host 'You are setting the tag for'$CallingFunction                    # Write message to screen
            }                                                                               # End if ($CallingFunction)
            :SetAzureTagName while ($true) {                                                # Inner loop for setting the tag name
                $TagNameInput = Read-Host "Tag Name"                                        # Operator input for the tag name
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break SetAzureTagPair                                                   # Breaks :SetAzureTagPair
                }                                                                           # End if ($TagNameInput -eq 'exit')
                Write-Host 'Use'$TagNameInput'as the tag name'                              # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator confirmation that the name entered is correct
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears the screen
                    Break SetAzureTagName                                                   # Breaks :SetAzureTagName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureTagName while ($true)
            :SetAzureTagValue while ($true) {                                               # Inner loop for setting the tag value
                $TagValueInput = Read-Host "Tag Value"                                      # Operator input for the tag value
                if ($TagValueInput -eq 'exit') {                                            # If $TagValueInput equals 'exit'
                    Break SetAzureTagPair                                                   # Breaks :SetAzureTagPair
                }                                                                           # End if ($TagVlaueInput -eq 'exit')
                if (!$TagValueInput) {                                                      # If $TagValueInput is $null
                    Write-Host 'Use a blank tag value'                                      # Write message to screen
                }                                                                           # End if (!$TagValueInput)
                else {                                                                      # If $TagValueInput has a value
                    Write-Host 'Use'$TagNameInput'as the tag name'                          # Write message to screen
                }                                                                           # End else (if (!$TagValueInput))
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator confirmation that the name entered is correct
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears the screen
                    Break SetAzureTagValue                                                  # Breaks :SetAzureTagName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureTagValue while ($true)
            $ArrayInput = [PSCustomObject]@{'Name'=$TagNameInput;'Value'=$TagValueInput}    # Creates the item to loaded into array
            $TagArray.Add($ArrayInput) | Out-Null                                           # Loads item into array, out-null removes write to screen
            Write-Host 'Add another pair'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] or [N]'                                             # Operator confirmation to add another tag
            if ($OpConfirm -eq 'n') {                                                       # If $OpConfirm equals 'n'
                Break SetAzureTagPair                                                       # Breaks :SetAzureTagPair
            }                                                                               # End if ($OpConfirm -eq 'n')
            Clear-Host                                                                      # Clear the screen 
        }                                                                                   # End :SetAzureTagPair while ($true)
        Clear-Host                                                                          # Clear the screen
        if ($TagArray) {                                                                    # If $TagArray has a value
            Return $TagArray                                                                # Returns to calling function with $var
        }                                                                                   # End if ($TagArray)
        else {                                                                              # If $TagArray does not have a value
            Return                                                                          # Returns to calling function with $null
        }                                                                                   # End else (if ($TagArray))
    }                                                                                       # End begin
}                                                                                           # End function SetAzTagPair
