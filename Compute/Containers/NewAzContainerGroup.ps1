# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzContainerGroup :      https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/new-azcontainergroup?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1   
} #>
<# Functions Description: {
    NewAzContainerGroup:        Creates a container group
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {
    :NewAzureContainerGroup     Outer loop for managing function
    :SetContainerName           Inner loop for setting the container name
    :SetAzureContainerType      Inner loop for setting the container image type
    :SetAzureContainerImage     Inner loop for setting the container image
    :SetAzureContainerDNS       Inner loop for setting the container dns
    $RGObject:                  Resource group object
    $CallingFunction:           Passed the current function name to GetAzResourceGroup
    $ContainerNameObject:       Operator input for the name of the container group
    $ImageTypeObject:           Operator input for the image type of the container group
    $ContainerImage:            Operator input for the image name or location of the container group
    $ContainerDNS:              Operator input for the DNS of the container group
    $OperatorConfirm:           Operator confirmation of the container group $vars
    $ContainerObject:           Container object
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call NewAzContainerGroup > Get $ContainerObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup 
            Return NewAzContainerGroup > Send $RGObject
        End NewAzContainerGroup
            Return function > Send $ContainerObject
}#>
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