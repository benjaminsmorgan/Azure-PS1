function ManageAzVNGWConfig {                                                               # Function to manage virtual network gateway configs
    Begin {                                                                                 # Begin function
        :ManageAzureGateway while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Manage Gateway Configs'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'This function is under development'                                 # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureGateway                                                    # Breaks :ManageAzureGateway
            }                                                                               # End if ($OpSelect -eq '0')
            <#elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Function name'                                                    # Write message to screen
                #Functiongohere                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')  #>
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVNGWConfig