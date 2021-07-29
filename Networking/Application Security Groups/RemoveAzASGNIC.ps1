function RemoveAzASGNIC {                                                                   # Function to remove an application security group from a nic
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveASGNIC'                                               # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureASGNIC while ($true) {                                                  # Outer loop for managing function
            $NicIPConfigObject, $NicObject  = GetAzNICIpConfig                              # Calls function and assigns output to $var
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break RemoveAzureASGNIC                                                     # Breaks :RemoveAzureASGNIC
            }                                                                               # End if (!$NicIPConfigObject)
            $ObjectList = $NicIPConfigObject.ApplicationSecurityGroups.ID                   # Isolates all asg IDs to $var
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'This IP config is not associated'                               # Write message to screen
                Write-Host 'to any application security groups'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASGNIC                                                     # Breaks :RemoveAzureASGNIC
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGName = $_                                                               # Isloates the current item
                $ASGName =$ASGName.split('/')[-1]                                           # Isolates the current item ASG name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber                                                  # Object number
                    'ID'=$_                                                                 # ID
                    'Name'=$ASGName                                                         # ASG name
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput into $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGName = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureASG while ($true) {                                                 # Inner loop for selecting the ASG to remove
                Write-Host '[0]   Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]  "$_.Name                                     # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is greater than 9
                        Write-Host "[$Number] "$_.Name                                      # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection to remove the ASG
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break RemoveAzureASGNIC                                                 # Breaks :RemoveAzureASGNIC
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect in $ObjectArray.Number
                    $ASGObject = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}      # ASGObject = $ObjectArray where $ObjectArray.Number equals $OpSelect
                    Break SelectAzureASG                                                    # Breaks :SelectAzureASG
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureASG while ($true)
            $AppendedObjectList = @()                                                       # Creates $AppendedObjectList
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_ -ne $ASGObject.ID) {                                                 # If current item is not equal to $ASGObject.ID
                    $AppendedObjectList += $_                                               # Add current item to $AppendedObjectList
                }                                                                           # End if ($_ -ne $ASGObject.ID) 
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host 'Remove:'$ASGObject.ID                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($AppendedObjectList) {                                                      # If $AppendedObjectList has a value
                Write-Host 'Keep:'                                                          # Write message to screen
                foreach ($_ in $AppendedObjectList) {                                       # For each item in $AppendedObjectList
                    Write-Host '       '$_                                                   # Write message to screen
                }                                                                           # End foreach ($_ in $AppendedObjectList)
            }                                                                               # End if ($AppendedObjectList)
            else {                                                                          # Else if $AppendedObjectList is $null
                Write-Host 'Keep:   None'                                                   # Write message to screen
            }                                                                               # End else (if ($AppendedObjectList))
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC IP config'                                 # Write message to screen
                    Set-AzNetworkInterfaceIpConfig -NetworkInterface $NicObject -Name `
                        $NicIPConfigObject.Name -ApplicationSecurityGroupId `
                        $AppendedObjectList -ErrorAction 'Stop' | Out-Null                  # Updates the application security group listing
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null      # Saves the nic config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureASGNIC                                                 # Breaks :RemoveAzureASGNIC
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The ASG has been removed from the IP config'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASGNIC                                                     # Breaks :RemoveAzureASGNIC
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Clear-Host                                                                  # Clears screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASGNIC                                                     # Breaks :RemoveAzureASGNIC
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureASGNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzASGNIC