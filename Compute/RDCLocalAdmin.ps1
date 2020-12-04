# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.1.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.1.0
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
} #>
<# Required Functions: {
    GetAzResourceGroup:         Collects resource group object
    GetAzVM:                    Collects the VM information
    GetAzKeyVault:              Collects the key vault object
    GetAzKeyVaultSecret:        Collects a secret value
} #>
<# Variables: {
    RDCLocalAdmin {
        $RGObject:              Resource group object
        $VirtualMachine:        Virtual machine object
        $VirtualMachineNIC:     VM network interface object
        $VirtualMachinePubIP:   Public IP address object attached to $VirtualMachineNIC
        $PublicIPAddressString: $VirtualMachinePubIP.IPAdress assigned as a string
        $ConfirmSelection:      Confirm operator input of $UserNameInput
        $UserNameInput:         Operator input for the local admin username 
        $UserName:              Combintation of $UserNameInput and $VirtualMachine
        $KeyVault:              Key vault object containing the virtual machine local admin account password
        $KeyVaultSecret:        Hashed password from key vault  
        $KeyVaultSecretSVT:     $KeyVaultSecret.SecretValueText to pass to RDC 
    }
    GetAzKeyVault {
        $RGObject:              Resource group object
        $KeyVault:              KeyVault object
        $KeyVaultInput:         Operator input for the key vault name
        $KVList:                Variable used for printing all key vaults to screen if needed 
    }
    GetAzKeyVaultSecret {
        $KeyVault:              KeyVault object
        $KeyVaultSecret:        Key vault secret object
        $KeyVaultSecretInput:   Operator input for the key vault secret name
        $KVSList:               Variable used for printing all key vault secrets to screen if needed
        $KVSOperatorConfirm:    Operator confirmation to use passed secret name or to enter a different one
    }
    GetAzVM {
        $RGObject:              Resource group object
        $VirtualMachineInput:   Operator input for the virtual machine object
        $VirtualMachine:        Virtual machine object
        $VMList:                Object containing all virtual machine in listed resource group
    }
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectinput:         Operator input for the resource group name
        $RGList:                variable used for printing all resource groups to screen if needed
    }
    ManageAzureFunction (Unused)
        $OperatorSelect:        Operator input for selecting a management function
} #>
function RDCLocalAdmin { # Performs a remote desktop connection to a server hosted in Azure provided a key vault secret exists matches the pc name
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $RGObject = GetAzResourceGroup # Calls funciton GetAzResourceGroup and assigns to $RGObject
        $VirtualMachine = GetAzVM ($RGObject) # Calls function GetAzVM and assigns to $VirtualMachine
        # Collecting thr public IP address
        $PublicIPAddressString = $null # Clears $PublicIPAddressString from all previous use
        $VirtualMachineNIC = Get-AzNetworkInterface | Where-Object {$_.Id -eq $VirtualMachine.NetworkProfile.NetworkInterfaces[0].Id} # Matches the NIC used by the VM
        $VirtualMachinePubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $VirtualMachineNIC.IpConfigurations.PublicIpAddress.id} # Matches the public IP config to the NIC
        $PublicIPAddressString = $VirtualMachinePubIP.IpAddress # Converts the public IP address to a string for further use
        # Collecting the username and password
        $ConfirmSelection = $null # Clears $ConfirmSelection from all previous use
        while (!$ConfirmSelection) { # While loop to confirm operator input for username     
            $UserNameInput = Read-Host "Local admin username" # Operator input for the local admin username
            $ConfirmSelection = Read-Host $UserNameInput" is the correct admin username?" # Operator confirmation that the username was typed correctly
            if (!($ConfirmSelection -eq 'y' -or $ConfirmSelection -eq 'yes')) { # if $ConfirmSelection is not equal to 'y' or 'yes'
                $ConfirmSelection = $null # Sets $ConfirmSelection back to null to reset the loop
            } # End if statement
        } # End while statment
        $UserName = $PublicIPAddressString+"\"+$UserNameInput # Creates the full local username by merging the IP and operator input ex 192.168.1.1\username
        Write-Host "Please provide the resource group containing the key vault"
        $RGObject = GetAzResourceGroup # Collects the resource group object again, this time for the key vault
        $KeyVault = GetAzKeyVault ($RGObject)
        $KeyVaultSecretInput = $VirtualMachine.Name
        $KeyVaultSecret = GetAzKeyVaultSecret ($KeyVault, $KeyVaultSecret, $KeyVaultSecretInput)  
        $KeyVaultSecretSVT = $KeyVaultSecret.SecretValueText
        cmdkey /generic:TERMSRV/$PublicIPAddressString /user:$UserName /pass:$KeyVaultSecretSVT # Assigns variables to RDC session
        mstsc /v:$PublicIPAddressString # Starts RDC connection to first listed server
    } # End begin statement
} # End function
function GetAzKeyVault { # Function to get a key vault, can pipe $KeyVault to another function.
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue' # Disables Errors
        if (!$RGObject) { # Check if $RGObject has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to assign $RGObject
        } # End if statement
        $KeyVault = $null # Clears $KeyVault from all previous use
        while (!$KeyVault) { # Loop to continue getting a key vault until the operator provided name matches an existing key vault
            $KeyVaultInput = Read-Host "Key vault name" # Operator input for the key vault name
            $KeyVault = Get-AzKeyVault -VaultName $KeyVaultInput -ResourceGroupName $RGObject.ResourceGroupName # Collection of the key vault from the operator input
            if (!$KeyVault) { # Error reporting if input does not match and existing key vault
                Write-Host "The name provided does not match an existing key vault" # Error note
                Write-Host "This is the list of available key vaults" # Error note
                $KVList = Get-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName # Collects all key vault objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $KVList.VaultName -Separator `n # Write-host used so list is written to screen when function is used as $KeyVault = GetAzKeyVault
                Write-Host "" # Error reporting
            } # End if statement
            else { # Else if $KeyVault is assigned
                Write-Host $KeyVault.VaultName 'Has been assigned to "$KeyVault"' # Writes the key vault name to the screen before ending function 
            } # End else statement
        } # End while statement
        Return $KeyVault
    } # End begin statement
} # End function
function GetAzKeyVaultSecret { # Function to get a key vault secret can pipe $KeyVaultSecret to another function.
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KeyVaultSecret = $null # Clears $KeyVaultSecret from all previous use
        while (!$KeyVaultSecret) { # Loop to continue getting a key vault secret until the operator provided name matches an existing key vault secret
            if ($KeyVaultSecretInput) { # Check to see if a previous function passed along a secret name
                $KVSOperatorConfirm = Read-Host "Use" $KeyVaultSecretInput" secret?" # Writes the current value of $KeyVaultSecretInput
                if ($KVSOperatorConfirm -eq 'y' -or $KVSOperatorConfirm -eq 'yes') { # If statement if the operator wishes to use this secret (Statement makes no action)
                } # End of if statement
                else { # Else statement for operator to change $KeyVaultSecretInput
                    $KeyVaultSecretInput = Read-Host "KeyVault secret name" # Operator input for the key vault secret name
                } # End else statement
            }
            else { # Else statement if $KeyVaultSecretInput is empty because no value was passed, or this is a second loop
                $KeyVaultSecretInput = Read-Host "KeyVault secret name" # Operator input for the key vault secret name
            } # End else statement
            $KeyVaultSecret = Get-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $KeyVaultSecretInput  # Collection of the key vault secret from the operator input
            if (!$KeyVaultSecret) { # Error reporting if input does not match and existing key vault secret
                Write-Host "The name provided does not match an existing key vault secret" # Error note
                Write-Host "This is the list of available key vault secrets" # Error note
                $KVSList = Get-AzKeyVaultSecret -VaultName $KeyVault.VaultName # Collects all key vault secret objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $KVSList.Name -Separator `n # Write-host used so list is written to screen when function is used as $KeyVaultSecret = GetAzKeyVaultSecret
                Write-Host "" # Error reporting
                $KeyVaultSecretInput = $null # Reverts $KeyVaultSecretInput back to $null, used in case passed $KeyVaultSecretInput is not a valid name
            } # End if statement
            else { # Else if $KeyVaultSecret is assigned
                Write-Host $KeyVaultSecret.Name 'Has been assigned to "$KeyVaultSecret"' # Writes the key vault name secret to the screen before ending function 
            } # End else statement
        } # End while statement
        Return $KeyVaultSecret
    } # End begin statement
} # End function
function GetAzVM {
    Begin {
        while (!$VirtualMachine) {
            if (!$RGObject) {
                $RGObject = GetAzResourceGroup
            } # End if statement
            $VirtualMachineInput = Read-Host "Virtual machine name" 
            $VirtualMachine = Get-AzVM -ResourceGroupName $RGObject.ResourceGroupName -Name $VirtualMachineInput
            if (!$VirtualMachine) {
                Write-Host "The name provided does not match an virtual machine in the resource group" # Error note
                Write-Host "This is the list of available virtual machines" # Error note
                $VMList = Get-AzVM -ResourceGroupName $RGObject.ResourceGroupName # Collects all VM objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $VMList.Name -Separator `n # Write-host used so list is written to screen when function is used as $VirtualMachine = GetAzVM
                Write-Host "" # Error reporting
            } # End if statement
            else { # Else for when $VirtualMachine is assigned
                Write-Host $VirtualMachine.Name 'Has been assigned to "$RGObject"' # Writes the virtual machine name to the screen before ending function
            } # End else statement
        } # End while statment
        Return $VirtualMachine
    } # End begin statment
} # End function
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function.
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        while (!$RGObject) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RGObject  # Returns the value of $RGObject to a function that called it
    } # End of begin statement
} # End of function