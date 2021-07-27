# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzNSGRuleProtocol:       Function to set a network security group rule protocol
} #>
<# Variables: {      
    :SetAzureNSGRuleProtocol    Outer loop for managing function
    $OpSelect:                  Operator selection for NSG rule protocol
    $NSGRuleProtocol:           NSG rule protocol
} #>
<# Process Flow {
    function
        Call SetAzNSGRuleProtocol > Get $NSGRuleProtocol
        End SetAzNSGRuleProtocol
            Return function > Send $NSGRuleProtocol
}#>
Function SetAzNSGRuleProtocol {                                                             # Function to set a network security group rule protocol
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleProtocol while ($true) {                                            # Inner loop to set the rule protocol
            Write-Host 'Select the rule protocol'                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Any'                                                            # Write message to screen
            Write-Host '[2] TCP'                                                            # Write message to screen
            Write-Host '[3] UPD'                                                            # Write message to screen
            Write-Host '[4] ICMP'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule port
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleProtocol                                               # Breaks :SetAzureNSGRuleProtocol
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleProtocol = '*'                                                      # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleProtocol = 'TCP'                                                    # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                $NSGRuleProtocol = 'UDP'                                                    # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                $NSGRuleProtocol = 'ICMP'                                                   # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
            if ($NSGRuleProtocol) {                                                         # If $NSGRuleProtocol has a value
                Return $NSGRuleProtocol                                                     # Returns to calling function with $NSGRuleProtocol
            }                                                                               # End if ($NSGRuleProtocol)
        }                                                                                   # End :SetAzureNSGRuleProtocol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End functon SetAzNSGRuleProtocol