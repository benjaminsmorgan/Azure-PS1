# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.2.1
    Set-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.2.1
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzASGNIC:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/Nic%20Attachment/GetAzASGNIC.ps1
} #>
<# Functions Description: {
    RemoveAzASGNIC:             Function to remove an application security group from a nic
    GetAzASGNIC:                Function to get a nic with an ASG attached
} #>
<# Variables: {      
    :RemoveAzureASGNIC          Outer loop for managing function
    :SelectAzureASG             Inner loop for selecting ASG to remove
    $CallingFunction:           Name of this function or the one that called it
    $NicObject:                 Network interface object
    $ObjectList:                $NicObject.IPConfigurations.ApplicationSecurityGroups.ID
    $ObjectList2:               Array used to get only all ASGs on $NICObject and remove duplicate entries
    $ObjectNumber:              $var used for listing and selecting ASG
    $ObjectArray:               Array holding all ASG info
    $ASGName:                   Current item .split (ASG name)
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number
    $OpSelect:                  Operator selection of the ASG to remove
    $ASGObject:                 Application security group object ID
    $AppendedObjectList:        List of all ASGs on $NicObject that are not being removed
    $OpConfirm:                 Operator confirmation to make these changes
    $NICIPConfigs:              List of all IP configs on $NicObject
    GetAzASGNIC{}               Gets $NicObject
} #>
<# Process Flow {
    function
        Call RemoveAzASGNIC > Get $null
            Call GetAzASGNIC > Get $NicObject              
            End GetAzASGNIC
                Return RemoveAzASGNIC > Send $NicObject
        End RemoveAzASGNIC
            Return function > Send $null
}#>
function RemoveAzASGNIC {                                                                   # Function to remove an application security group from a nic
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzASGNIC'                                             # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureASGNIC while ($true) {                                                  # Outer loop for managing function
            $NicObject = GetAzASGNIC ($CallingFunction)                                     # Calls function and assigns output to $var
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break RemoveAzureASGNIC                                                     # Breaks :RemoveAzureASGNIC
            }                                                                               # End if (!$NicObject)
            $ObjectList = $NicObject.IPConfigurations.ApplicationSecurityGroups.ID          # Isolates all asg IDs to $var
            $ObjectList2 = @()                                                              # Creates $ObjectList2 array
            foreach ($_ in $Objectlist) {                                                   # For each item in $ObjectList
                $Objectlist2 += $_                                                          # Adds current item to $ObjectList2
            }                                                                               # End foreach ($_ in $Objectlist)
            $Objectlist = $ObjectList2 | Select-Object -Unique | Sort-Object                # $ObjectList is equal to $ObjectList2 only unique entries
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGName = $_                                                               # Isloates the current item
                $ASGName = $ASGName.split('/')[-1]                                          # Isolates the current item ASG name
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
            Write-Host 'Remove:'$ASGObject.ID.split('/')[-1]                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($AppendedObjectList) {                                                      # If $AppendedObjectList has a value
                Write-Host 'Keep:'                                                          # Write message to screen
                foreach ($_ in $AppendedObjectList) {                                       # For each item in $AppendedObjectList
                    Write-Host '       '$_.split('/')[-1]                                   # Write message to screen
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
                    Write-Host 'Updating the NIC IP configs'                                # Write message to screen
                    $NICIPConfigs = Get-AzNetworkInterfaceIpConfig -NetworkInterface `
                        $NicObject -ErrorAction 'Stop'                                      # Gets a list of all IP configs on $NICObject
                    foreach ($_ in $NICIPConfigs) {
                        Set-AzNetworkInterfaceIpConfig -NetworkInterface $NicObject -Name `
                            $_.Name -ApplicationSecurityGroupId `
                            $AppendedObjectList -ErrorAction 'Stop' | Out-Null              # Updates the application security group listing
                    }                                                                       # End foreach ($_ in $NICIPConfigs)
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
                Write-Host 'The ASG has been removed from the NIC IP configs'               # Write message to screen
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