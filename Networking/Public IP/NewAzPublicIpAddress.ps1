# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0    
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzPublicIpAddress:       Creates a new public IP address
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {      
    :NewAzurePublicIP           Outer loop for managing function
    :SetAzurePublicIPName       Inner loop for setting public IP name
    :SetAzurePublicIPAlloc      Inner loop for setting public IP allocation type
    SetAzurePublicIPSku         Inner loop for setting public IP sku
    $CallingFunction:           Name of this function or the one that called it
    $RGObject:                  Resource group object
    $ValidArray:                Array of valid characters in the public IP name
    $Valid1stChar:              Array of valid first characters in the public IP name
    $PublicNameArray:           Array of $PublicNameInput
    $PublicNameInput:           Operator input for the public IP name
    $OpConfirm:                 Operator confirmation of input
    $OpSelect:                  Operator selection
    $PublicIPAllocationObject:  IP allocation type
    $PubIPSkuObject:            IP sku type
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call NewAzPublicIpAddress > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzPublicIpAddress > Send $RGObject
        End NewAzPublicIpAddress
            Return function > Send $null
}#>
function NewAzPublicIpAddress {                                                             # Function to create a new public IP address
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzPublicIpAddress'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup                                                  # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End if (!$RGObject)
            :SetAzurePublicIPName while ($true) {                                           # Inner loop for setting the public IP name
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz'                                # Creates a string of valid first character
                $Valid1stChar = $Valid1stChar.ToCharArray()                                 # Loads all valid characters into array
                Write-Host 'Public IP name must begin with a letter'                        # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $PublicNameArray = $null                                                    # Clears $PublicNameArray
                $PublicNameInput = Read-Host 'Public IP name'                               # Operator input for the public IP name
                $PublicNameArray = $PublicNameInput.ToCharArray()                           # Loads $PublicNameInput into array
                Clear-Host                                                                  # Clears screen
                if ($PublicNameInput.Length -ge 81) {                                       # If $PublicNameInput.Length is greater or equal to 81
                    Write-Host 'The public IP name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($PublicNameInput.Length -ge 62)
                if ($PublicNameArray[0] -notin $Valid1stChar) {                             # If 0 position of $PublicNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter'           # Write message to screen
                    $PublicNameInput = $null                                                # Clears $PublicNameInput
                }                                                                           # End if ($PublicNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $PublicNameArray) {                                          # For each item in $PublicNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Public IP name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $PublicNameInput = $null                                            # Clears $PublicNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $PublicNameArray)
                if ($PublicNameInput) {                                                     # If $PublicNameInput has a value
                    Write-Host 'Use:'$PublicNameInput' as the public IP name'               # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzurePublicIP                                              # Breaks :NewAzurePublicIP
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzurePublicIPName                                          # Breaks :SetAzurePublicIPName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    else {                                                                  # If $OpConfirm does not equal 'y'
                        $PublicNameInput = $null                                            # Clears $PublicNameInput
                    }                                                                       # End else if ($OpConfirm -eq 'y')
                }                                                                           # End if ($PublicNameInput) 
                else {                                                                      # If $PublicNameInput does not have a value
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PublicNameInput))
            }                                                                               # End :SetAzurePublicIPName while ($true)
            :SetAzurePublicIPAlloc while ($true) {                                          # Inner loop for setting the public IP allocation method
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Dynamic'                                                    # Write message to screen
                Write-Host '[2] Static'                                                     # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the allocation method
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals 1
                    $PublicIPAllocationObject = 'dynamic'                                   # Creates $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc    
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals 2
                    $PublicIPAllocationObject = 'static'                                    # Creates $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (($OpSelect -eq '0'))
            }                                                                               # End :SetAzurePublicIPAlloc while ($true)
            :SetAzurePublicIPSku while ($true) {                                            # Inner loop for setting the public IP Sku
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Basic'                                                      # Write message to screen
                Write-Host '[2] Standard'                                                   # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the allocation method
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals 1
                    $PubIPSkuObject = 'Basic'                                               # Creates $PubIPSkuObject
                    Break SetAzurePublicIPSku                                               # Breaks :SetAzurePublicIPSku    
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals 2
                    $PubIPSkuObject = 'Standard'                                            # Creates $PubIPSkuObject
                    Break SetAzurePublicIPSku                                               # Breaks :SetAzurePublicIPSku
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (($OpSelect -eq '0'))
            }                                                                               # End :SetAzurePublicIPSku while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the public IP'                                         # Write message to screen
                New-AzPublicIpAddress -Name $PublicNameInput `
                    -ResourceGroupName $RGObject.ResourceGroupName -Location `
                    $RGObject.Location -AllocationMethod $PublicIPAllocationObject `
                    -DomainNameLabel $PublicIPNameObject -Sku $PubIPSkuObject -Force `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the new public IP address
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The public IP has been created'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzurePublicIP                                                          # Breaks :NewAzurePublicIP
        }                                                                                   # End :NewAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with # null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzPublicIpAddress