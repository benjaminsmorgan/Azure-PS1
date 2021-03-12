

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
            :SetAzureContainerImage while ($true) {
                Write-Host 'Enter the URL of the container image'
                $ContainerImage = Read-Host 'Image info'
                Break SetAzureContainerImage 
            }                                                                               # End :SetAzureContainerImage while ($true)
            $ContainerObject = New-AzContainerGroup -ResourceGroupName `
                $RGObject.ResourceGroupName -Name $ContainerNameObject -Image `
                $ContainerImage -OsType $ImageTypeObject -DnsNameLabel aci-taco-test
            Return $ContainerObject
        }                                                                                   # End :NewAzureContainerGroup while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzContainerGroup
function GetAzResourceGroup {                                                               # Function to get a resource group, can pipe $RGObject to another function
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # Gets all resource groups and assigns to $RGList
            $RGListNumber = 1                                                               # Sets $RGListNumber to 1
            [System.Collections.ArrayList]$RGListArray = @()                                # Creates the RG list array
            foreach ($_ in $RGList) {                                                       # For each $_ in $RGListList
                $RGListInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $RGListNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $RGListArray.Add($RGListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $RGListNumber = $RGListNumber + 1                                           # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $RGListArray) {                                                  # For each $_ in $RGListArray
                Write-Host $_.Number $_.Name "|" $_.Location                                    # Writes RG number, name, and location to screen
            }                                                                               # End foreach ($_ in $RGListArray)
            :SelectAzureRGList while ($true) {                                              # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                $RGSelect = $RGListArray | Where-Object {$_.Number -eq $RGSelect}           # $RGSelect is equal to $RGArray where $RGArray.Number is equal to $RGSelect                                  
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RGSelect.Name}                               # Pulls the full resource group object
                if ($RGObject) {                                                            # If $RGObject has a value
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureRGList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup