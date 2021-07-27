# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzNSGRuleAccess:         Function to set a network security group rule access
} #>
<# Variables: {      
    :SetAzureNSGRuleDirection   Outer loop for managing function
    $OpSelect:                  Operator selection for NSG rule access
    $NSGRuleAccess:             NSG rule access
} #>
<# Process Flow {
    function
        Call SetAzNSGRuleAccess > Get $NSGRuleAccess
        End SetAzNSGRuleAccess
            Return function > Send $NSGRuleAccess
}#>
Function SetAzNSGRuleAccess {                                                               # Function to set a network security group rule access
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleAccess while ($true) {                                              # Inner loop to set the rule access
            Write-Host 'Select the rule access'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Allow'                                                          # Write message to screen
            Write-Host '[2] Deny'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule access
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleAccess                                                 # Breaks :SetAzureNSGRuleAccess
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleAccess = 'Allow'                                                    # Sets $NSGRuleAccess
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleAccess = 'Deny'                                                     # Sets $NSGRuleAccess
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
            if ($NSGRuleAccess) {                                                           # If $NSGRuleAccess has a value
                Return $NSGRuleAccess                                                       # Returns to calling funtion with $NSGRuleAccess
            }                                                                               # End if ($NSGRuleAccess)
        }                                                                                   # End :SetAzureNSGRuleAccess while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function SetAzNSGRuleAccess