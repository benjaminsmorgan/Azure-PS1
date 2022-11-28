# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzAksCluster :          https://docs.microsoft.com/en-us/powershell/module/az.aks/new-azakscluster?view=azps-5.6.0
    Get-AzAksCluster:           https://docs.microsoft.com/en-us/powershell/module/az.aks/get-azakscluster?view=azps-5.6.0
    Remove-AzAksCluster:        https://docs.microsoft.com/en-us/powershell/module/az.aks/remove-azakscluster?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzAksCluster:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/NewAzAksCluster.ps1 
    GetAzAksCluster:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/GetAzAksCluster.ps1 
    RemoveAzAksCluster:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/RemoveAzAksCluster.ps1 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1   
} #>
<# Functions Description: {
    NewAzAksCluster:            Creates an Aks cluster
    GetAzAksCluster:            Gets an Aks cluster
    RemoveAzAksCluster:         Removes a selected Aks cluster
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {
    :ManageAzureAksCluster      Outer loop for managing function 
    $AksObject:                 Aks cluster object
    $ManageAzAksCluster:        Operator input for selecting the management function
    NewAzAksCluster{}           Creates $AksObject
        GetAzResourceGroup{}        Gets $RGObject
    GetAzAksCluster{}           Gets $AksObject
    RemoveAzAksCluster          Removes $AksObject
        GetAzAksCluster{}           Gets $AksObject
} #>
<# Process Flow {
    Function
        Call ManageAzAksCluster > Get $null
            Call NewAzAksCluster > Get $AksObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup 
                Return NewAzAksCluster > Send $RGObject
            End NewAzAksCluster
                Return ManageAzAksCluster > Send $AksObject
            Call GetAzAksCluster > Get $AksObject
            End GetAzAksCluster
                Return ManageAzAksCluster > Send $AksObject
            Call RemoveAzAksCluster > Get $null
                Call GetAzAksCluster > Get $AksObject
                End GetAzAksCluster
                    Return RemoveAzAksCluster > Send $AksObject
            End RemoveAzAksCluster
                Return ManageAzAksCluster > Send $null
        End ManageAzAksCluster
            Return function > Send $null
}#>
function ManageAzAksCluster {                                                               # Function to manage Aks clusters
    Begin {                                                                                 # Begin function
        :ManageAzureAksCluster while ($true) {                                              # Outer loop for managing function
            if ($AksObject) {                                                               # If $AksObject has a value
                Write-Host 'Current Aks cluster object is:'$AksObject.Name                  # Write message to screen
            }                                                                               # End if ($AksObject)
            Write-Host "Azure Kubernetes Service Cluster Management"                        # Write message to screen
            Write-Host '0 Clear "$AksObject"'                                               # Write message to screen
            Write-Host '1 New Aks cluster'                                                  # Write message to screen
            Write-Host '2 Get Aks cluster'                                                  # Write message to screen
            Write-Host '3 Remove Aks cluster'                                               # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzAksCluster = Read-Host "Option?"                                       # Collects operator input on $ManageAzAksCluster option
            if ($ManageAzAksCluster -eq 'exit') {                                           # If $ManageAzAksCluster equals 'exit'
                Break ManageAzureAksCluster                                                 # Breaks :ManageAzureAksCluster
            }                                                                               # End if ($ManageAzAksCluster -eq 'exit')
            elseif ($ManageAzAksCluster -eq '0') {                                          # Elseif $ManageAzAksCluster equals 0
                if ($AksObject) {                                                           # If $AksObject has a value
                    Write-Host 'Clearing "$AksObject'                                       # Write message to screen
                    $AksObject = $null                                                      # Clears $AksObject
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Write-Host '$AksObject is already clear'                                # Write message to screen
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End elseif ($ManageAzAksCluster -eq '0')
            elseif ($ManageAzAksCluster -eq '1') {                                          # Elseif $ManageAzAksCluster equals 1
                Write-Host 'New Aks cluster'                                                # Write message to screen
                $AksObject = NewAzAksCluster ($RGObject)                                    # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzAksCluster -eq '1')
            elseif ($ManageAzAksCluster -eq '2') {                                          # Elseif $ManageAzAksCluster equals 2
                Write-Host 'Get Aks cluster'                                                # Write message to screen
                $AksObject = GetAzAksCluster                                                # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzAksCluster -eq '2')
            elseif ($ManageAzAksCluster -eq '3') {                                          # Elseif $ManageAzAksCluster equals 3
                Write-Host 'Remove Aks cluster'                                             # Write message to screen
                RemoveAzAksCluster ($AksObject)                                             # Calls function
            }                                                                               # End elseif ($ManageAzAksCluster -eq '3')
            else {                                                                          # If $ManageAzAksCluster do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzAksCluster -eq 'exit'))
        }                                                                                   # End :ManageAzureAksCluster while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzAksCluster
function NewAzAksCluster {                                                                  # Function to create a new Aks Cluster
    Begin {                                                                                 # Begin function
        :NewAzureAksCluster while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzAksCluster'                                        # Sets $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetAksClusterName while ($true) {                                              # Inner loop for setting the AksCluster name
                $AksClusterNameObject = Read-Host 'Aks cluster name'                        # Operator input for the AksCluster name
                if ($AksClusterNameObject -eq 'exit') {                                     # If $AksClusterName equals exit
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($AksClusterNameObject -eq 'exit')
                Write-Host 'Use' $AksClusterNameObject 'as the Aks cluster name'            # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the AksCluster name
                if ($OperatorConfirm -eq 'y') {                                             # If OperatorConfirm equals 'y'
                    Break SetAksClusterName                                                 # Breaks :SetAksClusterName    
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAksClusterName while ($true)  
            :SetAzureAksClusterType while ($true) {                                         # Inner loop for setting the AksCluster type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the AksCluster type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($ImageType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    if ($ImageTypeObject -eq '1') {                                         # If $ImageTypeObject equals '1'
                        $ImageTypeObject = 'Windows'                                        # Sets $ImageTypeObject to 'Windows'
                    }                                                                       # End if ($ImageTypeObject -eq '1')
                    if ($ImageTypeObject -eq '2') {                                         # If $ImageTypeObject equals '2'
                    $ImageTypeObject = 'Linux'                                              # Sets $ImageTypeObject to 'Linux'
                    }                                                                       # End if ($ImageTypeObject -eq '2')
                    Break SetAzureAksClusterType                                            # Breaks :SetAzureAksClusterType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq 'exit') )
            }                                                                               # End :SetAzureAksType while ($true)
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host "Enter the name of the tag"                       # Operator input for a tag name
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag"                     # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Writes tag to screen
                $OperatorConfirm = Read-Host "Use this tag for the Aks Cluster [Y] or [N]"  # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y') {                                             # If statement for $Tag being correct
                    break SetAzureTag                                                       # Ends :SetAzureTag while loop
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm does not equal 'y'
                    Write-Host ''                                                           # Write message to screen  
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureTag while ($true)
            :SetAzureAksNodeCount while ($true) {                                           # Loop for setting the node count
                Write-Host '[0] to exit'                                                    # Write message to screen
                [int]$AksNodeObject = Read-Host 'Enter the number of nodes'                 # Operator input for the node count
                if ($AksNodeObject -eq '0') {                                               # If $AksNodeObject equals 0
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($AksNodeObject -eq '0')
                elseif (!$AksNodeObject) {                                                  # Else if $AksNodeObject is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen   
                }                                                                           # End elseif (!$AksNodeObject)
                elseif ($AksNodeObject -lt 0) {
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }
                else {                                                                      # If $AksNodeObject has value
                    $OperatorConfirm = Read-Host 'This Aks cluster will have' `
                    $AksNodeObject 'node(s)? [Y] or [N]'                                    # Operator confirmation of the node count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureAksNodeCount                                          # Breaks :SetAzureAksNodeCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # If OperatorConfirm does not equal 'y'
                        Clear-Variable $AksNodeObject                                       # Clears $AksNodeObject
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (End if ($AksNodeObject -eq '0'))
            }                                                                               # End :SetAzureAksNodeCount while ($true)
            if ($ImageTypeObject -eq 'Linux') {                                             # If $ImageTypeObject equals 'linux'
                Try {
                    $AksObject = New-AzAksCluster -ResourceGroupName `
                        $RGObject.ResourceGroupName -Name $AksClusterNameObject `
                        -Tag $Tag -NodeCount $AksNodeObject -ErrorAction 'Stop'             # Creates the Aks cluster for linux
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                }                                                                           # End catch
                if ($AksObject) {                                                           # If $AksObject has a value
                    Return $AksObject                                                       # Returns $AksObject to calling function 
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAks Cluster
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End if ($ImageTypeObject -eq 'Linux')
            else {                                                                          # If $ImageTypeObject does not equal linux  
                :SetAzureAksUserName while ($true) {                                        # Inner loop for setting the Aks username
                    $AksUserNameObject = Read-Host "Aks username"                           # Operator input of the Aks user name
                    if ($AksUserNameObject -eq 'exit') {                                    # If $AksUsernameObject is $null
                        Break NewAzureAksCluster                                            # Breaks :NewAzureAks Cluster
                    }                                                                       # End if ($AksUserNameObject -eq 'exit')
                    Write-Host $AksUserNameObject                                           # Writes message to screen
                    $OperatorConfirm = Read-Host "Use as the Aks username? [Y] or [N]"      # Operator confirmation of the Aksuser name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureAksUserName                                           # Breaks :SetAzureAksUserName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End :SetAzureAksUserName while ($true)
                :SetAzureAksPassword while ($true) {                                        # Inner loop for setting the password
                    $AksPasswordObject = Read-Host "Aks password"                           # Operator input for the password
                    if ($AksPasswordObject -eq 'exit') {                                    # If $AksPasswordObject equals 'exit'
                        Break NewAzureAksCluster                                            # Breaks :NewAzureAks Cluster
                    }                                                                       # End if ($AksPasswordObject -eq 'exit')
                    Write-Host $AksPasswordObject                                           # Write message to screen
                    $OperatorConfirm = Read-Host "Use as the Aks password? [Y] or [N]"      # Operator confirmation of the password
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        $AksPasswordObject = ConvertTo-SecureString $AksPasswordObject `
                            -AsPlainText -Force                                             # Hashes $AksPasswordObject
                        Break SetAzureAksPassword                                           # Breaks :SetAzureAksPassword
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End :SetAzureAksPassword while ($true)
                Try {                                                                       # Try the following
                    $AksObject = New-AzAksCluster -ResourceGroupName `
                        $RGObject.ResourceGroupName -Name $AksClusterNameObject `
                        -WindowsProfileAdminUserName $AksUserNameObject `
                        -WindowsProfileAdminUserPassword $AksPasswordObject `
                        -NetworkPlugin azure -NodeVmSetType VirtualMachineScaleSets `
                        -Tag $Tag -NodeCount $AksNodeObject -ErrorAction 'Stop'              # Creates the Aks cluster
                    $AksNodeName = 'Nnamet'
                    New-AzAksNodePool -ResourceGroupName $RGObject.ResourceGroupName `
                        -ClusterName $AksClusterNameObject -Name $AksNodeName -OsType `
                        Windows -VmSetType VirtualMachineScaleSets                          # Adds additional windows parameters 
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                }                                                                           # End catch
                if ($AksObject) {                                                           # If $AksObject has a value
                    Return $AksObject                                                       # Returns $AksObject to calling function 
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAks Cluster
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End else (if ($ImageTypeObject -eq 'Linux'))
        }                                                                                   # End :NewAzureAksCluster while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzAksCluster
function GetAzAksCluster {                                                                  # Function to get an Aks cluster
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Turns of warning messages
        :GetAzureAksCluster while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Getting a list of all Aks Clusters'                                 # Write message to screen
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            $ObjectListNumber = 1                                                           # $var used as list number
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the array that all objects will be loaded into
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $ObjectList = Get-AzAksCluster -ResourceGroupName $_.ResourceGroupName      # Gets a list of any AKS clusters
                if ($ObjectList) {                                                          # If $ObjectList has a value
                    $RGName = $_.ResourceGroupName                                          # $RGName is set to the current resource group name
                    foreach ($_ in $ObjectList) {                                           # For each item in $ObjectList
                        $ArrayInput = [PSCustomObject]@{'Name' = $_.Name; 'Number' = `
                            $ObjectListNumber; 'NRG' = $_.NodeResourceGroup; 'RG' =$RGName} # Creates $var to load items into array                
                        $ObjectArray.Add($ArrayInput) | Out-Null                            # Adds items to the array
                        $ObjectListNumber = $ObjectListNumber + 1                           # Increments $ObjectListNumber up by 1
                    }                                                                       # End foreach ($_ in $ObjectList)                                                 
                }                                                                           # End if ($ObjectList)
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $Object array
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Aks Name:  '$_.Name                                             # Write message to screen
                Write-Host 'NodeRG:    '$_.NRG                                              # Write message to screen
                Write-Host 'Object RG: '$_.RG                                               # Write message to screen    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureAksCluster while ($true) {                                          # Inner loop to select the Aks cluster
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host "You are selecting the Aks cluster for"$CallingFunction      # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OperatorSelect = Read-Host 'Enter the number of the Aks Cluster'           # Operator input for the Aks cluster
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureAksCluster                                                # Breaks :GetAzureAksCluster
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $ObjectArray.Number) {                          # Else if $OperatorSelect equals $ObjectArray.Number
                    $AksObject = $ObjectArray | Where-Object {$_.Number -eq `
                        $OperatorSelect}                                                    # $AksObject is equal to $ObjectArray where $OperatorSelect equals $ObjectArray.Number
                    Return $AksObject                                                       # Returns to calling function with $AksObject
                }                                                                           # End elseif ($OperatorSelect -eq $ObjectArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureAksCluster while ($true)
        }                                                                                   # End :GetAzureAksCluster while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzAksCluster
function RemoveAzAksCluster {                                                               # Function to remove an Aks cluster
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Turns of warning messages
        :RemoveAzureAksCluster while ($true) {                                              # Outer loop for managing function
            if (!$AksObject) {                                                              # If $AksObject is $null
                $CallingFunction = 'RemoveAzAksCluster'                                     # Creates $Calling function $var
                $AksObject = GetAzAksCluster ($CallingFunction)                             # Calls function and assigns output to $var
                if (!$AksObject) {                                                          # If $AksObject is $null
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End if (!$AksObject)
            }                                                                               # End if (!$AksObject)
            Write-Host 'Remove Aks Cluster named:'$AksObject.Name'in RG:'$AksObject.RG       # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Aks cluster
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzAksCluster -ResourceGroupName $AksObject.RG `
                        -Name $AksObject.Name -Force -ErrorAction 'Stop'                    # Removes the Object
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to this resource'          # Write message to screen
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End Catch
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Break RemoveAzureAksCluster                                                 # Breaks :RemoveAzureAksCluster
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureAksCluster while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzAksCluster

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
                Write-Host $_.Number $_.Name "|" $_.Location                                # Writes RG number, name, and location to screen
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