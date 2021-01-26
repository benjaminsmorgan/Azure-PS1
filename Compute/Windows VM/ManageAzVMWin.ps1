# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvm?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Remove-AzVM:                https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azvm?view=azps-5.4.0

    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    NewAzVMWin:                 TBD
    ListAzVMWin:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Windows%20VM/ListAzVMWin.ps1
    GetAzVMWin:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Windows%20VM/GetAzVMWin.ps1
    RDCAzVMWin:                 TBD
    RemoveAzVMWin:              TBD
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzVMWin:              Manages functions for Windows VM
        NewAzVMWin:                 Creates new Windows VM
        ListAzVMWin:                Lists all Windows VMs by resource group
        GetAzVMWin:                 Gets a Windows VM Object
        RDCAzVMWin:                 Creates a remote desktop session with Windows VM
        RemoveAzVMWin:              Remove a Windows VM
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :ManageAzureCompute         Outer loop for managing function
    ManageAzCompute:            Operator input for function selection
    $RGObject:                  Resource group object
    $WinVMObject:               Windows VM Object
    $ManageAzVMWin:             Operator input for calling next function
    NewAzVMWin{}                Creates $WinVMObject
        GetAzResourceGroup{}        Get$RGObject
    ListAzVMWin{}               Lists $WinVMObjects
    GetAzVMWin{}                Gets $WinVMObject
         GetAzResourceGroup{}        Get$RGObject
    RDCAzVMWin{}                Connects to $WinVMObject
        GetAzVMWin{}                Gets $WinVMObject
            GetAzResourceGroup{}        Get$RGObject
    RemoveAzVMWin{}             Removes $WinVMObject
        GetAzVMWin{}                Gets $WinVMObject
            GetAzResourceGroup{}        Get$RGObject
} #>
<# Process Flow {
    function
        Call ManageAzVMWin > Get $null
            Call NewAzVMWin > Get $WinVMObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzVMWin > Send $RGObject
            End NewAzVMWin
                Return ManageAzVMWin > Send $WinVMObject
            Call ListAzVMWin > Get $null
            End ListAzVMWin
                Return ManageAzVMWin > Send $null
            Call GetAzVMWin > Get $WinVMObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzVMWin > Send $RGObject
            End GetAzVMWin
                Return ManageAzVMWin > Send $WinVMObject
            Call RDCAzVMWin > Get $null
                Call GetAzVMWin > Get $WinVMObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzVMWin > Send $RGObject
                End GetAzVMWin
                Return RDCAzVMWin > Send $WinVMObject
            End RDCAzVMWin
                Return ManageAzVMWin > Send $null
            Call RemoveAzVMWin > Get $null
                Call GetAzVMWin > Get $WinVMObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzVMWin > Send $RGObject
                End GetAzVMWin
                Return RemoveAzVMWin > Send $WinVMObject
            End RemoveAzVMWin
                Return ManageAzVMWin > Send $null
        End ManageAzVMWin
            Return Function > Send $null
}#>
function ManageAzVMWin {
    Begin {
        :ManageAzureWinVM while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host "Resource Group:" $RGObject.ResourceGroupName # Write message to screen
            } # End if ($RGObject)
            if ($WinVMObject) { # If $WinVMObject has a value
                Write-Host "VM Object     :" $WinVMObject.Name # Write message to screen
            } # End if ($WinVMObject)
            Write-Host "Windows VM Management" # Write message to screen
            Write-Host "1 New Windows VM" # Write message to screen
            Write-Host "2 List All Windows VMs" # Write message to screen
            Write-Host "3 Get Windows VM" # Write message to screen
            Write-Host "4 Connect Windows VM" # Write message to screen
            Write-Host "5 Remove Windows VM" # Write message to screen
            Write-Host "0 Clear current RGObject and WinVMObject"
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzVMWin = Read-Host "Option?" # Collects operator input on $ManageAzVMWin option
            if ($ManageAzVMWin -eq 'exit') { # Exit if statement for this function
                Break ManageAzureWinVM # Ends :ManageAzureWinVM loop, leading to return statement
            } # End if ($ManageAzVMWin -eq 'exit')
            elseif ($ManageAzVMWin -eq '1') { # Elseif statement for creating new Windows VM
                Write-Host "New Windows VM" # Write message to screen
                $WinVMObject = NewAzVMWin ($RGObject) # Calls function and assigns output to $var
            } # End elseif ($ManageAzVMWin -eq '1')
            elseif ($ManageAzVMWin -eq '2') { # Elseif statement for listing all VMs
                Write-Host "List All Windows VMss" # Write message to screen
                ListAzVMWin # Call function    
            } # End elseif ($ManageAzVMWin -eq '2')
            elseif ($ManageAzVMWin -eq '3') { # Elseif statement for getting Windows VM
                Write-Host "Get Windows VM" # Write message to screen
                $WinVMObject = GetAzVMWin ($RGObject) # Calls function and assigns output to $var
            } # End elseif ($ManageAzVMWin -eq '3')
            elseif ($ManageAzVMWin -eq '4') { # Elseif statement for connecting remote desktop session
                Write-Host "Connect Windows VM" # Write message to screen
                RDCAzVMWin ($RGObject, $WinVMObject) # Calls function
            } # End elseif ($ManageAzVMWin -eq '4')
            elseif ($ManageAzVMWin -eq '5') { # Elseif statement for removing a Windows VM
                Write-Host "Remove Windows VM" # Write message to screen
                RemoveAzVMWin ($RGObject, $WinVMObject) # Calls function
            } # End elseif ($ManageAzVMWin -eq '5')
            elseif ($ManageAzVMWin -eq '0') { # elseif to clear $Vars
                $RGObject = $null # Clears $var
                $WinVMObject = $null # Clears $var
            } # End elseif ($ManageAzVMWin -eq '0')
            else { # if a non-valid option was input
                Write-Host "That was not a valud option" # Write message to screen
            } # End else (if ($ManageAzVMWin -eq 'exit'))
        } # End ManageAzureWinVM while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzVMWin
function NewAzVMWin {
    Begin {
        Write-Host "In Dev"
        :SetAzureServerImage while($true) {
            $ImageSkuList = Get-AzVMImageSku -Location $Location -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowServer'
            $ImageSkuListNumber = 1
            Write-Host "0 Exit"
            foreach ($Skus in $ImageSkuList) {
                Write-Host $ImageSkuListNumber $Skus.Skus
                $ImageSkuListNumber = $ImageSkuListNumber + 1
            } # End foreach ($Skus in $ImageSkuList)
            :SetAzureServerImageName while ($true) {
                $ImageSkuSelect = Read-Host "Please enter the number of the image"
                if ($ImageSkuSelect -eq '0') {
                    Break :NamedLoop
                } # End if ($ImageSkuSelect -eq '0')
                $ImageSkuListNumber = 1
                foreach ($Skus in $ImageSkuList) {
                    if ($ImageSkuSelect -eq $ImageSkuListNumber) {
                        $WinVMImageSkuList = Get-AzVMImage -Location $Location -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowServer' -Skus $Skus.Skus
                        $WinVMImageSkuListNumber = 1
                        Write-Host '0. Exit'
                        foreach ($Version in $WinVMImageSkuList) {
                            Write-Host WinVMImageSkuListNumber"." $Version.Version $Version.Skus
                            WinVMImageSkuListNumber = WinVMImageSkuListNumber + 1
                        } # End foreach ($Version in $WinVMImageSkuList)
                        $ImageVersionSelect = Read-Host "Please enter the number of the version"
                        if ($ImageVersionSelect -eq '0') {
                            Break :NamedLoop
                        } # End if ($ImageVersionSelect -eq '0')
                        $WinVMImageSkuListNumber = 1
                        foreach ($Version in $WinVMImageSkuList) {
                            if ($ImageVersionSelect -eq $WinVMImageSkuListNumber) {
                                $WinVMImageObject = Get-AzVMImage -Location $Location -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowServer' -Skus.Skus -version $Version.Version
                            } # End if ($ImageVersionSelect -eq $WinVMImageSkuListNumber)
                            else { # if ($ImageVersionSelect -eq $WinVMImageSkuListNumber)
                            $WinVMImageSkuListNumber + 1 
                            } # End else (if ($ImageVersionSelect -eq $WinVMImageSkuListNumber))
                        } # End foreach ($Version in $WinVMImageSkuList)
                    } # End if ($ImageSkuSelect -eq $ImageSkuListNumber)
                    else { # if ($ImageSkuSelect -eq $ImageSkuListNumber)
                        $ImageSkuListNumber = $ImageSkuListNumber + 1
                    } # End else (if ($ImageSkuSelect -eq $ImageSkuListNumber))
                    Break :SetAzureServerImageName
                    } # End foreach ($Skus in $ImageSkuList)
            } # End :SetAzureServerImageName while ($true)
        } # End :SetAzureServerImage while($true)
    } # End Begin
} # End function NewAzVMWin
function ListAzVMWin { # Lists all Windows VM by resource group
    Begin {
        $RGList = Get-AzResourceGroup # creates list of all resource groups
        foreach ($_ in $RGList) { # For each object in $RGList
            Write-Host "------------------------------------------" # Write message to screen
            Write-Host "Resource Group:" $_.ResourceGroupName # Write message to screen
            $WinVMList = Get-AzVM -ResourceGroupName $_.ResourceGroupName | Where-Object {$_.StorageProfile.OsDisk.OsType -eq 'Windows'} # Creates a list of all windows VMs current resource group
            if ($WinVMList) { # If Windows VMs exist ing this resource group
                foreach ($Name in $WinVMList) { # For each object in $WinVMList
                    Write-Host "------------------------------------------" # Write message to screen
                    Write-Host "VMName: " $Name.Name # Write message to screen
                    Write-Host "OS:     " $Name.StorageProfile.ImageReference.Sku # Write message to screen
                    Write-Host "Version:" $Name.StorageProfile.ImageReference.ExactVersion # Write message to screen
                } # End foreach ($Name in $WinVMList)
            } # End if ($WinVMList)
            else { # If no VMs exist in current group
                Write-Host "No Windows VMs in this resource group" # Write message to screen
            } # End else(if ($WinVMList))
        } # End foreach ($_ in $RGList)
        Write-Host "------------------------------------------" # Write message to screen
        Return # Returns to calling function
    } # End Begin
} # End function ListAzVMWin
function GetAzVMWin { # Gets a windows VM object
    Begin {
        :GetAzureVMWindows while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureVMWindows # Ends :GetAzureVMWindows
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $WinVMList = Get-AzVM -ResourceGroupName $RGObject.ResourceGroupName | Where-Object {$_.StorageProfile.OsDisk.OsType -eq 'Windows'} # Creates list of all Windows VMs in resource group
            if (!$WinVMList) { # If $WinVMList returns empty
                Write-Host "No Windows VMs exist in this resource group" # Message write to screen
                Break GetAzureVMWindows # Ends :GetAzureVMWindows
            } # End if (!$WinVMList)
            $WinVMListNumber = 1 # Sets the base value of $WinVMListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $WinVMList) { # For each item in $WinVMList
                Write-Host $WinVMListNumber"." $_.Name # Writes $WinVMList to screen
                $WinVMListNumber = $WinVMListNumber+1 # Adds 1 to $WinVMListNumber
            } # End foreach ($_ in $WinVMList)
            :GetAzureVMWinName while ($true) { # Inner loop for selecting the VM
                $WinVMListNumber = 1 # Sets the base value of $WinVMListNumber
                $WinVMListSelect = Read-Host "Please enter the number of the VM" # Operator input for the Windows VM selection
                if ($WinVMListSelect -eq '0') { # If $WinVMList is '0'
                    Break GetAzureVMWindows # Ends :GetAzureVMWindows
                } # if ($WinVMListSelect -eq '0')
                foreach ($_ in $WinVMList) { # For each item in $WinVMList
                    if ($WinVMListSelect -eq $WinVMListNumber) { # If the operator input matches the current $WinVMListNumber
                        $WinVMObject = Get-AzVM -ResourceGroupName $RGObject.ResourceGroupName -Name $_.Name # Assigns current item in $WinVMList to $WinVMObject
                        Break GetAzureVMWinName # Breaks :GetAzureVMWinName
                    } # End if ($WinVMListSelect -eq $WinVMListNumber)
                    else { # If user input does not match the current $WinVMListNumber
                        $WinVMListNumber = $WinVMListNumber+1 # Adds 1 to $WinVMListNumber
                    } # End else (if ($WinVMListSelect -eq $WinVMListNumber))
                } # End foreach ($_ in $WinVMList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageAccount while ($true) {
            Return $WinVMObject # Returns to calling function with $WinVMObject
        } # End :GetAzureVMWindows while ($true)
        Return # Returns to calling function with $null
    } # End Begin 
} # End function GetAzVMWin
function RDCAzVMWin {
    Begin {
        Write-Host "In Dev"
    } # End Begin
} # End function RDCAzVMWin
function RemoveAzVMWin {
    Begin {
        Write-Host "In Dev"
    } # End Begin
} # End function RemoveAzVMWin

function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        $RGList = Get-AzResourceGroup # Gets all resource groups and assigns to $RGList
        if (!$RGList) { # If $RGList returns empty
            Write-Host "No resource groups found" # Message write to screen
            Return # Returns to calling function with $null
        } # End if (!$RGList)
        $RGListNumber = 1 # Sets the base value of the list
        Write-Host "0. Exit" # Adds exit option to beginning of list
        foreach ($_ in $RGList) { # For each item in list
            Write-Host $RGListNumber"." $_.ResourceGroupName # Writes the option number and resource group name
            $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
        } # End foreach ($_ in $RGList)
        :GetAzureResourceGroup while ($true) { # Loop for selecting the resource group object
            $RGListNumber = 1 # Resets list number to 1
            $RGListSelect = Read-Host "Please enter the number of the resource group" # Operator input for selecting which resource group
            if ($RGListSelect -eq '0') { # If $RGListSelect is equal to 0
                Return # Returns to calling function with $null
            } # End if ($RGListSelect -eq '0')
            foreach ($_ in $RGList) { # For each item in list
                if ($RGListSelect -eq $RGListNumber) { # If the operator input matches the current $RGListNumber
                    $RGObject = $_ # Currently selected item in $RGList is assigned to $RGObject
                    Return $RGObject # Returns $RGObject to calling function
                } # End if ($RGListSelect -eq $RGListNumber)
                else { # If user input does not match the current $RGListNumber
                    $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
                } # End else (if ($RGListSelect -eq $RGListNumber))
            } # End foreach ($_ in $RGList)
            Write-Host "That was not a valid selection, please try again" # Write message to screen
        } # End :GetAzureResourceGroup while ($true)
        Return $RGObject # Returns $RGObject to calling function
    } # End of begin statement
} # End of function