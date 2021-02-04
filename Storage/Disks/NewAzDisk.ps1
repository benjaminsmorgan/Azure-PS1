function NewAzDisk {
    Begin {
        :NewAzureDisk while ($true) { 
            if (!$RGObject) { # IF $RGObject is $null # ***COMPLETE***
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # IF $RGObject is $null
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $RGObject.Location}  
            :SetAzureDiskOptions while ($true) { # ***IN PROGRESS***
                :SetAzureDiskSku while ($true) { # ***COMPLETE***
                    [System.Collections.ArrayList]$ValidSku = @() # Creates the valid sku array
                    $ValidSkuList = @('Standard_LRS','Premium_LRS','StandardSSD_LRS','UltraSSD_LRS') # Creates a list of items to load into $ValidSku Array
                    $SkuNumber = 1 # Sets the base number for the valid sku array
                    foreach ($_ in $ValidSkuList) { # For each item in $ValidSkuList
                        $SkuInput = [PSCustomObject]@{'Name' = $_;'Number' = $SkuNumber} # Creates the item to loaded into array
                        $ValidSku.Add($SkuInput) | Out-Null # Loads item into array, out-null removes write to screen
                        $SkuNumber = $SkuNumber + 1 # Increments $SkuNumber up 1
                    } # End foreach ($_ in $ValidSkuList)
                    foreach ($_ in $ValidSku) { # For each item in $ValidSkut
                        Write-Host $_.Number $_.Name # Write message to screen
                    } # End foreach ($_ in $ValidSku)
                    :SelectAzureDiskSku while ($true) { # Inner loop for selecting object from list
                        $SkuObjectSelect = Read-Host "Please enter the number of the sku" # Operator input for the selection
                        if ($SkuObjectSelect -eq '0') { # If $$SkuObjectSelect is 0
                            Break NewAzureDisk # Breaks :NewAzureDisk
                        } # End if ($_Select -eq '0')
                        $SkuObject = $ValidSku | Where-Object {$_.Number -eq $SkuObjectSelect} # Isolates selected object 
                        $SkuObject = $SkuObject.Name # Pulls just the .name value
                        if ($SkuObject) { # If $SkuObject has a value
                            Break SetAzureDiskSku # Breaks :SetAzureDiskSku
                        } # End if ($SetAzureDiskSku)
                        Write-Host "That was not a valid selection" # Write message to screen 
                    } # End :SelectAzureDiskSku while ($true)
                } #End :SetAzureDiskSku while ($true)
                :SetAzureDiskSize while ($true) { # ***COMPLETE***
                    $DiskSizeObject = -1 # Sets $var to non-break value
                    Try{ # Try the following
                        [int]$DiskSizeObject = Read-Host "Size in GB of the Disk [0] to exit" # Operator input for the disk size
                    } # End Try
                    catch {} # If Try fails
                    if ($DiskSizeObject -eq 0) { # If $DiskSizeObject equals 0
                        Break NewAzureDisk # Breaks :NewAzureDisk
                    } # End if ($DiskSizeObject -eq 0)
                    if ($DiskSizeObject -ge 1) { # If $DiskSizeObject has a value greater than 1
                        Break SetAzureDiskSize # Breaks :SetAzureDiskSize
                    } # End if ($DiskSizeObject)
                    else { # All other inputs
                        Write-Host "Please enter a positive integer" # Write message to screen
                    } # End else (if ($DiskSizeObject -ge 1))
                } # End :SetAzureDiskSize while ($true)
                :SetAzureDiskOSType while ($true) { # ***COMPLETE****
                    Write-Host "1 Windows" # Write message to screen
                    Write-Host "2 Linux" # Write message to screen
                    $DiskOSObject = Read-Host "[1] or [2]" # Operator input for disk os type
                    if ($DiskOSObject -eq 'exit') { # If $DiskOSObject equals 'exit'
                        Break NewAzureDisk # Breaks :NewAzureDisk
                    } #End if ($DiskOSObject -eq 'exit') 
                    elseif ($DiskOSObject -eq '1') { # If $DiskOSObject equals '1'
                        $DiskOSObject = 'Windows' # Changes $DiskOSObject to 'Windows'
                        Break SetAzureDiskOSType # Breaks :SetAzureDiskOSType
                    } # End elseif ($DiskOSObject -eq '1')
                    elseif ($DiskOSObject -eq '2') { # If $DiskOSObject equals '2'
                        $DiskOSObject = 'Linux' # Changes $DiskOSObject to 'Linux'
                        Break SetAzureDiskOSType # Breaks :SetAzureDiskOSType
                    } # End elseif ($DiskOSObject -eq '2')
                    else { # All other inputs for $DiskOSType
                        Write-Host "That was not a valid option" # Write message to screen
                    } # End else (if ($DiskOSObject -eq 'exit') )
                } # End :SetAzureDiskOSType while ($true)
                :EnableAzureDiskEncrypt while ($true) { # ***IN PROGRESS***
                    Break
                } # End :EnableAzureDiskEncrypt while ($true)
                Break SetAzureDiskOptions
            } # End :SetAzureDiskOptions while ($true)
            Write-Host $RGObject.ResourceGroupName
            Write-Host $LocationObject.Location
            Write-Host $SkuObject
            Write-Host $DiskSizeObject
            Return $DiskObject # Returns to calling function with $DiskObject
        } # End :NewAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzDisk

$ValidSku = 'Standard_LRS', 'Premium_LRS', 'StandardSSD_LRS', 'UltraSSD_LRS'

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