# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/new-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzASG:                   Function to get a application security group
    GetAzResourceGroup:         Function to get a resource group
} #>
<# Variables: {      
    :NewAzureASG                Outer loop for managing function
    :SetAzureASGName            Inner loop for setting the ASG name
    $CallingFunction:           Name of this function or the one that called it
    $RGObject:                  Resource group object
    $CurrentASGList:            List of ASGs on $RGObject
    $ValidArray:                Array of valid body characters for $ASGName
    $Valid1stChar:              Array of valid 1st characters for $ASGName
    $ValidLastChar:             Array of valid last characters for $ASGName
    $ASGName:                   Operator input of the ASG name
    $NameArray:                 $ASGName converted to array
    $OpConfirm:                 Operator confirmation of the name
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call NewAzASG > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzASG > Send $RGObject
        End NewAzASG
            Return function > Send $null
}#>
function NewAzASG {                                                                         # Function to create a application security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzASG'                                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureASG while ($true) {                                                        # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null 
                Break NewAzureASG                                                           # Breaks :NewAzureASG
            }                                                                               # End if (!$RGObject)
            $CurrentASGList = Get-AzApplicationSecurityGroup -ResourceGroupName `
                $RGObject.ResourceGroupName                                                 # Gets list of all existing application security groups on $RGObject
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureASGName while ($true) {                                                # Inner loop for setting the ASG name
                Write-Host 'The application security group name must meet the following'    # Write message to screen
                Write-Host 'Begin with letter or number'                                    # Write message to screen
                Write-Host 'End with a letter, number, or "_"'                              # Write message to screen
                Write-Host 'Contain only numbers, letters, or "- . _ "'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($CurrentASGList) {                                                      # If $CurrentASGList has a value
                    Write-Host 'The following names are already in use'                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $CurrentASGList) {                                       # For each item in $CurrentASGList
                        Write-Host $_.Name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $CurrentASGList)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CurrentASGList)
                $ASGName = Read-Host 'ASG name'                                             # Operator input for the ASG name
                Clear-Host                                                                  # Clears screen
                if ($ASGName -in $CurrentASGList.Name) {                                    # If $ASGName is in $CurrentASGList.Name
                    Write-Host $ASGName' is already in use'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ASGName = $null                                                        # Clears $var
                }                                                                           # End if ($ASGName -in $CurrentASGList.Name)
                if ($ASGName) {                                                             # If $ASGName has a value
                    $NameArray = $ASGName.ToCharArray()                                     # Converts $NameArray to array
                    if ($NameArray[0] -notin $Valid1stChar) {                               # If 0 position of $NameArray is not in $Valid1stChar
                        Write-Host 'The first character of the name'                        # Write message to screen
                        Write-Host 'must be a letter or number'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $ASGName = $null                                                    # Clears $ASGName
                    }                                                                       # End if ($NameArray[0] -notin $Valid1stChar)
                    if ($NameArray[-1] -notin $ValidLastChar) {                             # If last position of $NameArray is not in $ValidLastChar
                        Write-Host 'The last character of the '                             # Write message to screen
                        Write-Host 'name must be a letter, number or _ '                    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $ASGName = $null                                                    # Clears $ASGName
                    }                                                                       # End if ($NameArray[0] -notin $Valid1stChar)
                    foreach ($_ in $NameArray) {                                            # For each item in $NameArray
                        if ($_ -notin $ValidArray) {                                        # If current item is not in $ValidArray
                            if ($_ -eq ' ') {                                               # If current item equals 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host 'ASG name cannot include any spaces'             # Write message to screen
                            }                                                               # End if ($_ -eq ' ')
                            else {                                                          # If current item is not equal to 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host $_' is not a valid character'                    # Write message to screen
                            }                                                               # End else (if ($_ -eq ' '))
                            $ASGName = $null                                                # Clears $ASGName
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $NameArray)
                    $NameArray = $null                                                      # Clears $var
                }                                                                           # End if ($ASGName)
                if ($ASGName) {                                                             # If $ASGName has a value
                    Write-Host 'Use:'$ASGName' as the ASG name'                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the ASG name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpSelect equals 'e'
                        Break NewAzureASG                                                   # Breaks :NewAzureASG
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureASGName                                               # Breaks :SetAzureASGName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'n') {                                           # Else if $OpConfirm equals 'n'    
                        $ASGName = $null                                                    # Clears $ASGName
                    }                                                                       # End elseif ($OpConfirm -eq 'n')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpConfirm -eq 'e') )
                }                                                                           # End if ($ASGName)
                else {                                                                      # If $ASGName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ASGName))
            }                                                                               # End :SetAzureASGName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the app security group'                                # Write message to screen
                New-AzApplicationSecurityGroup -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $RGObject.Location `
                    -Name $ASGName -ErrorAction 'Stop' | Out-null
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureASG                                                           # Breaks :NewAzureASG
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The application security group has been made'                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureASG                                                               # Breaks :NewAzureASG
        }                                                                                   # End :NewAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzASG