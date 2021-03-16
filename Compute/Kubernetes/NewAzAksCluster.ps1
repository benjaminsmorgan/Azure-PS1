# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzAksCluster :          https://docs.microsoft.com/en-us/powershell/module/az.aks/new-azakscluster?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1   
} #>
<# Functions Description: {
    NewAzAksCluster:            Creates an Aks cluster
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {
    :NewAzureAksCluster         Outer loop for managing function 
    :SetAksClusterName          Inner loop for setting the cluster name 
    :SetAzureAksClusterType     Inner loop for setting the image type
    :SetAzureTag                Inner loop for setting the created RG tag
    :SetAzureAksUserName        Inner loop for setting the cluster username
    :SetAzureAksPassword        Inner loop for setting the cluster password
    $RGObject:                  Resource group object
    $CallingFunction:           Passed the current function name to GetAzResourceGroup$AksClusterNameObject:
    $ImageTypeObject:           Operator input for windows or linux
    $TagNameInput:              Operator input for a tag name
    $TagValueInput:             Operator input for a tag value
    $Tag:                       The full tag name and value
    $AksUserNameObject:         For a windows AKS, operator input for the user name
    $AksPasswordObject:         For a windows AKS, operator input for the password
    $OperatorConfirm:           Operator confirmation of values
    $AksObject:                 Created AKS object
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call NewAzAksCluster > Get $AksObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup 
            Return NewAzAksCluster > Send $RGObject
        End NewAzAksCluster
            Return function > Send $AksObject
}#>
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