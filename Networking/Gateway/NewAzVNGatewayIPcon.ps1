# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    New-AzVirtualNetworkGatewayIpConfig:        https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetworkgatewayipconfig?view=azps-6.3.0
} #>
<# Required Functions Links: {
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
} #>
<# Functions Description: {
    NewAzVNGatewayIPcon:        Function to create a new gateway ip configuration
    GetAzPublicIpAddress:       Function to get an existing public IP address
} #>
<# Variables: {      
    :NewAzureVNGWIPCon          Outer loop for managing function
    :SetAzureGWIPName           Inner loop for setting the IP config name
    :SetVNGWPubIP               Inner loop for setting the config public IP
    :Confirm                    Inner loop for confirming the config public IP
    $ValidArray:                Array of ipconfig valid body characters
    $Valid1stChar:              Array of ipconfig valid 1st characters
    $ValidLastChar:             Array of ipconfig valid last characters
    $GWIPNameObject:            Operator input for the IP config name
    $GWNameArray:               $GWIPNameObject converted to array
    $OpConfirm:                 Operator confirmation of inputs
    $PublicIPObject:            Public IP object
    $GatewaySku:                Sku of gateway this IP config is being attached to
    $GatewayIPConfig:           Gateway IP config object
    $MSG:                       Last powershell error message
    GetAzPublicIpAddress{}      Gets $PublicIPObject
} #>
<# Process Flow {
    function
        Call NewAzVNGatewayIPcon > Get $GatewayIPConfig
            Call GetAzPublicIpAddress > Get $PublicIPObject
            End GetAzPublicIpAddress
                Return NewAzVNGatewayIPcon > Send $PublicIPObject
        End NewAzVNGatewayIPcon
            Return function > Send $GatewayIPConfig
}#>
function NewAzVNGatewayIPcon {                                                              # Function to create a new gateway ip configuration
    Begin {                                                                                 # Begin function
        :NewAzureVNGWIPCon while ($true) {                                                  # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureGWIPName while ($true) {                                               # Inner loop for setting the gateway IP name
                Write-Host 'Enter the gateway IP name'                                      # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $GWIPNameObject = Read-Host 'Name'                                          # Operator input for the gateway IP config name
                $GWNameArray = $GWIPNameObject.ToCharArray()                                # Loads $GWIPNameObject into array
                Clear-Host                                                                  # Clears screen
                if ($GWIPNameObject.Length -ge 81) {                                        # If $GWIPNameObject.Length is greater or equal to 81
                    Write-Host 'The gateway IP name is to long'                             # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWIPNameObject = $null                                                 # Clears $GWIPNameObject
                }                                                                           # End if ($GWIPNameObject.Length -ge 80)
                if ($GWNameArray[0] -notin $Valid1stChar) {                                 # If 0 position of $GWNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWIPNameObject = $null                                                 # Clears $GWIPNameObject
                }                                                                           # End if ($GWNameArray[0] -notin $Valid1stChar)
                if ($GWNameArray[-1] -notin $ValidLastChar) {                               # If last position of $GWNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWIPNameObject = $null                                                 # Clears $GWIPNameObject
                }                                                                           # End if ($GWNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $GWNameArray) {                                              # For each item in $GWNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Gateway IP name cannot include any spaces'          # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $GWIPNameObject = $null                                             # Clears $GWIPNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $GWNameArray)
                if ($GWIPNameObject) {                                                      # If $GWIPNameObject has a value
                    Write-Host 'Use:'$GWIPNameObject' as the gateway IP name'               # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the gateway name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureVNGWIPCon                                             # Breaks :NewAzureVNGWIPCon
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureGWIPName                                              # Breaks :SetAzureGWIPName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($GWIPNameObject)
                else {                                                                      # If $GWIPNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($GWIPNameObject))
            }                                                                               # End :SetAzureGWIPName while ($true)
            :SetVNGWPubIP while ($true) {                                                   # Inner loop to set the public IP sku
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $PublicIPObject is $null
                    Break NewAzureVNGateway                                                 # Breaks :NewAzureVNGateway
                }                                                                           # End if (!$PublicIPObject)
                if ($GatewaySku -notlike '*AZ*') {                                          # If $GatewaySku not like '*AZ*'
                    if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static') {            # If $PublicIPObject.PublicIpAllocationMethod equals 'Static'                
                        Write-Host 'This public IP sku cannot be used'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Please selected a public IP with'                       # Write message to screen
                        Write-Host 'an allocation method of "Dynamic"'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                        $PublicIPObject = $null                                             # Clears $var
                    }                                                                       # End if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static')
                }                                                                           # End if ($GatewaySku -notlike '*AZ*') 
                if ($GatewaySku -like '*AZ*') {                                             # If $GatewaySku like '*AZ*'
                    if ($PublicIPObject.PublicIpAllocationMethod -ne 'Static') {            # If $PublicIPObject.PublicIpAllocationMethod does not equal 'Static'                
                        Write-Host 'This public IP sku cannot be used'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Please selected a public IP with'                       # Write message to screen
                        Write-Host 'an allocation method of "Static"'                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                        $PublicIPObject = $null                                             # Clears $var
                    }                                                                       # End if ($PublicIPObject.PublicIpAllocationMethod -ne 'Static')
                    if ($PublicIPObject.sku.Name -eq 'Basic') {                             # If $PublicIPObject.sku.Name equals 'Basic'               
                        Write-Host 'This public IP sku cannot be used'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Please selected a public IP with'                       # Write message to screen
                        Write-Host 'an sku of "Standard"'                                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                        $PublicIPObject = $null                                             # Clears $var
                    }                                                                       # End if ($PublicIPObject.sku.Name -eq 'Basic')
                }                                                                           # End if ($GatewaySku -like '*AZ*') 
                if ($PublicIPObject.IpConfiguration.ID) {                                   # If $PublicIPObject.IpConfiguration.ID has a value
                    Write-Host 'This public IP sku cannot be used'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Please selected a public IP with'                           # Write message to screen
                    Write-Host 'that is not currently assigned to'                          # Write message to screen
                    Write-Host 'another object'                                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    $PublicIPObject = $null                                                 # Clears $var
                }                                                                           # End if ($PublicIPObject.IpConfiguration.ID)
                if ($PublicIPObject) {                                                      # If $PublicIPObject has a value
                    :Confirm while ($true) {                                                # Inner loop for confirming the public IP address
                        Write-Host 'Use:'$PublicIPObject.Name' as the gateway public IP'    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator input for confirming the public IP address
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetVNGWPubIP                                              # Breaks :SetVNGWPubIP
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        if ($OpConfirm -eq 'n') {                                           # If $OpConfirm equals 'n'
                            $PublicIPObject = $null                                         # Clears $var
                            Break Confirm                                                   # Breaks :confirm 
                        }                                                                   # End if ($OpConfirm -eq 'n')
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break NewAzureVNGWIPCon                                         # Breaks :NewAzureVNGWIPCon 
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpConfirm
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :Confirm while ($true)
                }                                                                           # End if ($PublicIPObject)
            }                                                                               # End :SetVNGWPubIP while ($true)  
            Try {                                                                           # Try the following
                $GatewayIPConfig = New-AzVirtualNetworkGatewayIpConfig -Name `
                        $GWIPNameObject -SubnetID $SubnetObject.ID -PublicIpAddressID `
                        $PublicIPObject.ID -ErrorAction 'Stop'                              # Creates the gateway IP config
            }                                                                               # End try
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
                Break NewAzureVNGWIPCon                                                     # Breaks :NewAzureVNGWIPCon    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The gateway IP config has been created'                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $GatewayIPConfig                                                         # Returns to calling function with $var  
        }                                                                                   # End :NewAzureVNGWIPCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzVNGatewayIPcon