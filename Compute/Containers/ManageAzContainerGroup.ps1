# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzContainerGroup :      https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/new-azcontainergroup?view=azps-5.6.0
    Get-AzContainerGroup:       https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/get-azcontainergroup?view=azps-5.6.0
    Remove-AzContainerGroup:    https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/remove-azcontainergroup?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/NewAzContainerGroup.ps1
    GetAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/GetAzContainerGroup.ps1
    RemoveAzContainerGroup:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/RemoveAzContainerGroup.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1   
} #>
<# Functions Description: {
    ManageAzContainerGroup:     Management function for container groups
    NewAzContainerGroup:        Creates a container group
    GetAzContainerGroup:        Gets a container group
    RemoveAzContainerGroup:     Removes a container group
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {
    :ManageAzureContainerGroup  Outer loop for managing function
    $ContainerObject:           Container group object
    $ManageAzContainerGroup     Operator input to select the management function
    NewAzContainerGroup{}       Creates $ContainerGroup
    GetAzContainerGroup{}       Gets $ContainerGroup
    RemoveAzContainerGroup{}    Removes $ContainerGroup
} #>
<# Process Flow {
    Function
        Call ManageAzContainerGroup > Get $null
            Call NewAzContainerGroup > Get $ContainerObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup 
                Return NewAzContainerGroup > Send $RGObject
            End NewAzContainerGroup
                Return ManageAzContainerGroup > Send $ContainerObject
            Call GetAzContainerGroup > Get $ContainerObject
            End GetAzContainerGroup
                    Return ManageAzContainerGroup > Send $ContainerObject
            Call RemoveAzContainerGroup > Get $null
                Call GetAzContainerGroup > Get $ContainerObject
                End GetAzContainerGroup
                    Return RemoveAzContainerGroup > Send $ContainerObject
            End RemoveAzContainerGroup
                Return ManageAzContainerGroup > Send $null
        End ManageAzContainerGroup
            Return function > Send $null
}#>
function ManageAzContainerGroup {                                                           # Function to manage container groups
    Begin {                                                                                 # Begin function
        :ManageAzureContainerGroup while ($true) {                                          # Outer loop for managing function
            if ($ContainerObject) {                                                         # If $ContainerObject has a value
                Write-Host 'The currently selected container object is' `
                    $ContainerObject.name                                                   # Write message to screen
            }                                                                               # End if ($ContainerObject)
            Write-Host "Azure Container Group Management"                                   # Write message to screen
            Write-Host '0 Clear "$ContainerObject"'                                         # Write message to screen
            Write-Host '1 New container group'                                              # Write message to screen
            Write-Host '2 Get container group'                                              # Write message to screen
            Write-Host '3 Remove container group'                                           # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzContainerGroup = Read-Host "Option?"                                   # Collects operator input on $ManageAzContainerGroup option
            if ($ManageAzContainerGroup -eq 'exit') {                                       # If $ManageAzContainerGroup equals 'exit'
                Break ManageAzureContainerGroup                                             # Breaks :ManageAzureContainerGroupr
            }                                                                               # End if ($ManageAzContainerGroup -eq 'exit')
            elseif ($ManageAzContainerGroup -eq '0') {                                      # Elseif $ManageAzContainerGroup equals 0
                if ($ContainerObject) {                                                     # If $ContainerObject has a value
                    Write-Host 'Clearing "$ContainerObject'                                 # Write message to screen
                    $ContainerObject = $null                                                # Clears $ContainerObject
                }                                                                           # End if ($ContainerObject)
                else {                                                                      # If $ContainerObject does not have a value
                    Write-Host '$ContainerObject is already clear'                          # Write message to screen
                }                                                                           # End else (if ($ContainerObject))
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '0')
            elseif ($ManageAzContainerGroup -eq '1') {                                      # Elseif $ManageAzContainerGroup equals 1
                Write-Host 'New container group'                                            # Write message to screen
                $ContainerObject = NewAzContainerGroup ($RGObject)                          # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '1')
            elseif ($ManageAzContainerGroup -eq '2') {                                      # Elseif $ManageAzContainerGroup equals 2
                Write-Host 'Get container group'                                            # Write message to screen
                $ContainerObject = GetAzContainerGroup                                      # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '2')
            elseif ($ManageAzContainerGroup -eq '3') {                                      # Elseif $ManageAzContainerGroup equals 3
                Write-Host 'Remove container group'                                         # Write message to screen
                RemoveAzContainerGroup ($ContainerObject)                                   # Calls function
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '3')
            else {                                                                          # If $ManageAzContainerGroup do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzContainerGroup -eq 'exit'))
        }                                                                                   # End :ManageAzureContainerGroup while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzContainerGroup
function NewAzContainerGroup {                                                              # Function to create a new container
    Begin {                                                                                 # Begin function
        :NewAzureContainerGroup while ($true) {                                             # Outer loop for managing functions
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzContainerGroup'                                    # Sets $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetContainerName while ($true) {                                               # Inner loop for setting the container name
                $ContainerNameObject = Read-Host 'Container name'                           # Operator input for the container name
                if ($ContainerNameObject -eq 'exit') {                                      # If $ContainerName equals exit
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ContainerNameObject -eq 'exit')
                $ContainerNameObject = $ContainerNameObject.ToLower()
                Write-Host 'Use' $ContainerNameObject 'as the container name'               # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the container name
                if ($OperatorConfirm -eq 'y') {                                             # If OperatorConfirm equals 'y'
                    Break SetContainerName                                                  # Breaks :SetContainerName    
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetContainerName while ($true)  
            :SetAzureContainerType while ($true) {                                          # Inner loop for setting the container type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the container type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ImageType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    if ($ImageTypeObject -eq '1') {                                         # If $ImageTypeObject equals '1'
                        $ImageTypeObject = 'Windows'                                        # Sets $ImageTypeObject to 'Windows'
                    }                                                                       # End if ($ImageTypeObject -eq '1')
                    if ($ImageTypeObject -eq '2') {                                         # If $ImageTypeObject equals '2'
                    $ImageTypeObject = 'Linux'                                              # Sets $ImageTypeObject to 'Linux'
                    }                                                                       # End if ($ImageTypeObject -eq '2')
                    Break SetAzureContainerType                                             # Breaks :SetAzureContainerType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)    
            :SetAzureContainerImage while ($true) {                                         # Inner loop for setting the container image
                Write-Host 'Enter the URL of the container image'                           # Write message to screen
                Write-Host 'Short names of images on the '                                  # Write message to screen
                Write-Host 'azure marketplace may also be used'                             # Write message to screen
                Write-Host 'Type "Exit" to leave this function'                             # Write message to screen
                $ContainerImage = Read-Host 'Image info'                                    # Operator input for the image info
                Write-Host $ContainerImage                                                  # Write message to screen
                $OperatorConfirm = Read-Host 'Please confirm the image info [Y] or [N]'     # Operator confirmation of the image info
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureContainerImage                                            # Breaks :SetAzureContainerImagr
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm does not equal 'y'
                    Write-Host ''                                                           # Writes message to screen
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureContainerImage while ($true)
            :SetAzureContainerDNS while ($true) {                                           # Inner loop to set the container DNS
                $ContainerDNS = Read-Host 'Please create a DNS entry'                       # Operator input for the container DNS
                if ($ContainerDNS -eq 'exit') {                                             # If $ContainerDNS equals exit
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ContainerDNS -eq 'exit')
                Write-Host 'Use' $ContainerDNS 'as the container DNS'                       # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the DNS
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureContainerDNS                                              # Breaks :SetAzureContainerDNS
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm not equal 'y'
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureContainerDNS while ($true)
            Try {                                                                           # Try the following
                $ContainerObject = New-AzContainerGroup -ResourceGroupName `
                    $RGObject.ResourceGroupName -Name $ContainerNameObject -Image `
                    $ContainerImage -OsType $ImageTypeObject -DnsNameLabel $ContainerDNS    # Creates the new container group and assigns to $ContainerObject
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The defult resource may not be available at this time'          # Write message to screen
                Write-Host 'You may not have the permissions complete this action'          # Write message to screen
                Break NewAzureContainerGroup                                                # Breaks :NewAzureContainerGroup
            }                                                                               # End catch
            Return $ContainerObject                                                         # Returns to calling function with $ContainerObject
        }                                                                                   # End :NewAzureContainerGroup while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzContainerGroup
function GetAzContainerGroup {                                                              # Function to get a container
    Begin {                                                                                 # Begin function
        :GetAzureContainerGroup while ($true) {                                             # Outer loop to manage function
            $ContainerList = Get-AzContainerGroup                                           # Gets a list of all containers
            if (!$ContainerList) {                                                          # If $ContainerList has no value
                Write-Host 'No container groups found'                                      # Write message to screen
                Write-Host 'Returning to previous function'                                 # Write message to screen
                Break GetAzureContainerGroup                                                # Breaks :GetAzureContainerGroup
            }                                                                               # End if (!$ContainerList)
            $ContainerListNumber = 1                                                        # List number used for container selection
            [System.Collections.ArrayList]$ContainerArray = @()                             # Creates the array used for selection
            foreach ($_ in $ContainerList) {                                                # For each item in $ContainerList
                $ArrayInput = [PSCustomObject]@{                                            # Creates the array input
                    'Number' = $ContainerListNumber; 'Name' = $_.Name; 'RG' = `
                        $_.ResourceGroupName                                                # Adds items to the array input
                }                                                                           # End $ArrayInput = [PSCustomObject]
                $ContainerArray.Add($ArrayInput) | Out-Null                                 # Adds the array input to array
                $ContainerListNumber = $ContainerListNumber + 1                             # Increments $ContainerListNumber by 1
            }                                                                               # End foreach ($_ in $ContainerList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ContainerArray) {                                               # For each item in $ContainerArray
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Container Name:'$_.name                                         # Write message to screen
                Write-Host 'Resource Group:'$_.RG                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ContainerArray)
            :SelectAzureContainer while ($true) {                                           # Inner loop for selecting the Container
                $ContainerSelect = Read-Host 'Container selection number'                   # Operator input for the Container selection
                if ($ContainerSelect -eq '0') {                                             # If $ContainerSelect equals 0
                    Break GetAzureContainerGroup                                            # Breaks :GetAzureContainer
                }                                                                           # End if ($ContainerSelect -eq '0')
                elseif ($ContainerSelect -in $ContainerArray.Number) {                      # If $ContainerSelect is in $ContainerArray.Number
                    $ContainerSelect = $ContainerArray | Where-Object `
                        {$_.Number -eq $ContainerSelect}                                    # $ContainerSelect is equal to the array item where $ContainerSelect equals the array number
                    $ContainerObject = Get-AzContainerGroup -ResourceGroupName `
                        $ContainerSelect.RG -Name $ContainerSelect.name                     # Pulls the full ContainerObject
                    if ($ContainerObject) {                                                 # If the Container object is pulled
                        Return $ContainerObject                                             # Return to calling function with $ContainerObject
                    }                                                                       # End if ($ContainerObject)
                    else {                                                                  # If the Container object not pulled
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureContainer                                             # Breaks :GetAzureContainer
                    }                                                                       # End else (if ($ContainerObject))
                }                                                                           # End elseif ($ContainerSelect -in $ContainerArray.Number)
                else {                                                                      # If $ContainerSelect is not 0 or in the array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($ContainerSelect -eq '0') )
            }                                                                               # End :SelectAzureContainer while ($true)
        }                                                                                   # End :GetAzureContainerGroup
    }                                                                                       # End Begin
}                                                                                           # End function GetAzContainerGroup
function RemoveAzContainerGroup {                                                           # Function to remove a container
    Begin{                                                                                  # Begin function
        :RemoveAzureContainerGroup while ($true) {                                          # Outer loop to manage function
            if (!$ContainerObject) {                                                        # If $ContainerObject is $null
                $ContainerObject = GetAzContainerGroup                                      # Calls function and assigns output to $var 
                if (!$ContainerObject) {                                                    # If $ContainerObject is $null
                    Break RemoveAzureContainerGroup                                         # Breaks :RemoveAzureContainerGroup
                }                                                                           # End if (!$ContainerObject)
            }                                                                               # End if (!$ContainerObject)
            Write-Host 'Remove container ' $ContainerObject.name                            # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input to confirm removal
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Remove-AzContainerGroup -ResourceGroupName `
                    $ContainerObject.ResourceGroupName -Name $ContainerObject.Name          # Removes $ContainerObject 
                Break RemoveAzureContainerGroup                                             # Breaks :RemoveAzureContainerGroup
            }                                                                               # End if ($OperatorConfirm equals 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureContainerGroup                                             # Breaks :RemoveAzureContainerGroup
            }                                                                               # End else (if ($OperatorConfirm equals 'y'))
        }                                                                                   # End :RemoveAzContainerGroup while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzContainerGroup