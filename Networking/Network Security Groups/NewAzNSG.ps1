function NewAzNSG {                                                                         # Function to create a new network securit group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzNSG'                                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureNSG while ($true) {                                                        # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureNSG                                                           # Breaks :NewAzureNSG
            }                                                                               # End if (!$RGObject)
            $RGName = $RGObject.ResourceGroupName                                           # Isolates the resource group name
            $RGLoc = $RGObject.Location                                                     # Isolates the resource group location
            $CurrentNSGNames = (Get-AzNetworkSecurityGroup -ResourceGroupName $RGName).Name # Gets list of all network security groups on $RGObject
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureNSGName while ($true) {                                                # Inner loop to set the NSG name
                Write-Host 'NSG name must be between 2 and 64 characters'                   # Write message to screen
                Write-Host 'NSG name must begin with a letter or number'                    # Write message to screen
                Write-Host 'NSG name must end with a letter, number, or -'                  # Write message to screen
                Write-Host 'NSG name body must be a letter, number, or _ . -'               # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                if ($CurrentNSGNames) {                                                     # If $CurrentNSGNames has a value
                    Write-Host 'The following names are already in use on:'$RGName          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $CurrentNSGNames) {                                      # For each item in $CurrentNSGNames
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $CurrentNSGNames)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CurrentNSGNames)
                Write-Host 'Enter the name of the new network security group'               # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                $NSGName = Read-Host 'Name'                                                 # Operator input for the NSG name
                Clear-Host                                                                  # Clears screen
                $NSGNameArray = $NSGName.ToCharArray()                                      # Converts $NSGName to array
                if ($NSGName -in $CurrentNSGNames) {                                        # If $NSGName is in $CurrentNSGNames
                    Write-Host $NSGName' is already in use'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGName = $null                                                        # Clears $NSGName
                }                                                                           # End if ($NSGName -in $CurrentNSGNames)
                if ($NSGName.Length -lt 2 -or $NSGName.Length -gt 64) {                     # If $NSGName.Length less than 2 or $NSGName.Length greater than 64
                    Write-Host 'NSG name must be between 2 and 64 characters'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGName = $null                                                        # Clears $NSGName
                }                                                                           # End if ($NSGName.Length -lt 2 -or $NSGName.Length -gt 64)
                if ($NSGNameArray[0] -notin $VName1st) {                                    # If 0 position of $NSGNameArray[0] is not in $VName1st
                    Write-Host  $NSGNameArray[0]' is not a valid start character'           # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGName = $null                                                        # Clears $NSGName
                }                                                                           # End if ($NSGNameArray[0] -notin $VName1st)
                foreach ($_ in $NSGNameArray) {                                             # For each item in $NSGNameArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'NSG name cannot include any spaces'                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid body character'                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $NSGName = $null                                                    # Clears $NSGName
                    }                                                                       # End if ($_ -notin $VNameElse)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($NSGNameArray[-1] -notin $VNameLast) {                                  # If last position of $NSGNameArray is not in $VNameLast
                    Write-Host  $NSGNameArray[-1]' is not a valid end character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGName = $null                                                        # Clears $NSGName
                }                                                                           # End if ($NSGNameArray[-1] -notin $VNameLast)
                $NSGNameArray = $null                                                       # Clears $NSGNameArray
                if ($NSGName) {                                                             # If $NSGName has a value
                    Write-Host 'Use:'$NSGName' as the network security group name'          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the network security group name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureNSGName                                               # Breaks :SetAzureNSGName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureNSG                                                   # Breaks :NewAzureNSG
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                }                                                                           # End if ($NSGName)
                else {                                                                      # Else if $NSGName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($NSGName))
            }                                                                               # End :SetAzureNSGName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the network security group'                            # Write message to screen
                New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName `
                    $RGName -Location $RGLoc -Force -ErrorAction 'Stop' | Out-Null          # Creates the network securit group
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureNSG                                                           # Breaks :NewAzureNSG
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The network security group has been created'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureNSG                                                               # Breaks :NewAzureNSG
        }                                                                                   # End :NewAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzNSG 
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                Write-Host '[0]  Exit'                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name '|' $_.Location                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name '|' $_.Location                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the resource group for:'$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $OpSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup