# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzContainerGroup :      https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/get-azcontainergroup?view=azps-5.6.0
} #>
<# Required Functions Links: {
    None    
} #>
<# Functions Description: {
    GetAzContainerGroup:        Gets a container group
} #>
<# Variables: {
    :GetAzureContainerGroup     Outer loop for managing function
    :SelectAzureContainer       Inner loop for selecting the container
    $ContainerList:             List of existing containers
    $ContainerListNumber:       Number used for object selection
    $ContainerArray:            Array used to list the container information
    $ArrayInput:                $Var used to load info into $ContainerArray
    $ContainerSelect:           Operator input to select the container
    $ContainerObject:           Container group object  
} #>
<# Process Flow {
    Function
        Call GetAzContainerGroup > Get $ContainerObject
        End GetAzContainerGroup
            Return function > Send $ContainerObject
}#>
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