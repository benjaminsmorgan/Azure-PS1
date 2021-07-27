# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzNSGRuleDirection:      Function to set a network security group rule direction
} #>
<# Variables: {      
    :SetAzureNSGRuleDirection   Outer loop for managing function
    $OpSelect:                  Operator selection for NSG rule direction
    $NSGRuleDirection:          NSG rule direction
} #>
<# Process Flow {
    function
        Call SetAzNSGRuleDirection > Get $NSGRuleDirection
        End SetAzNSGRuleDirection
            Return function > Send $NSGRuleDirection
}#>
Function SetAzNSGRuleDirection {                                                            # Function to set a network security group rule direction
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleDirection while ($true) {                                           # Inner loop to set the rule direction
            Write-Host 'Select the rule direction'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Inbound'                                                        # Write message to screen
            Write-Host '[2] Outbound'                                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule direction
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleDirection                                              # Breaks :SetAzureNSGRuleDirection
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleDirection = 'Inbound'                                               # Sets $NSGRuleDirection
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleDirection = 'Outbound'                                              # Sets $NSGRuleDirection
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))   
            if ($NSGRuleDirection) {                                                        # If $NSGRuleDirection has a value
                Return $NSGRuleDirection                                                    # Returns to calling function with $NSGRuleDirection
            }                                                                               # End if ($NSGRuleDirection)
        }                                                                                   # End :SetAzureNSGRuleDirection while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function SetAzNSGRuleDirection