# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-5.3.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzKeyVault:              Creates new key vault object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :NewAzureKeyVault           Outer loop for function
    :SetAzureKeyVaultName       Inner loop for setting name
    :SetAzureKeyVaultLoc        Inner loop for setting location
    $OperatorConfirm:           Operator input to confirm previous inputs
    $RGObject:                  Resource group object
    $KeyVaultNameInput:         Operator input for name
    $ValidSku:                  List of valid skus for key vaults
    $ValidLocation:             List of valid azure locations
    $KeyVaultLocInput:          Operator input for location
    $KeyVaultObject:            New key vault object
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call NewAzKeyVaul > Get $KeyVaultObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzKeyVault > Send $RGObject
        End NewAzKeyVault 
            Return Function > Send $KeyVaultObject
}#>
function NewAzKeyVault { # Creates a new key vault
    Begin {
        $ErrorActionPreference='silentlyContinue' # Turns off error reporting
        :NewAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup  # Calls GetAzResourceGroup and assigns to $RGObject
                if (!$RGObject) { # If $RGObject is still $null
                    Break NewAzureKeyVault # Breaks NewAzureKeyVault loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :SetAzureKeyVaultName while ($true) { # Inner loop for setting the key vault name
                $KeyVaultNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of vault name
                    [ValidatePattern('^[a-z,0-9]+$')]$KeyVaultNameInput = [string](Read-Host "New vault name (3-24 letters and numbers only)") # Operator input for the vault name, only allows letters and numbers. All letters converted to lowercase
                } # End try
                catch {Write-Host "The vault name can only include letters and numbers"} # Error message for failed try
                if ($KeyVaultNameInput -eq 'exit') { # $KeyVaultNameInput is equal to exit
                    Break NewAzureKeyVault # Breaks NewAzureKeyVault loop
                } # if ($KeyVaultNameInput -eq 'exit')
                elseif ($KeyVaultNameInput -eq '0') {}# Elseif when Try statement fails
                elseif ($KeyVaultNameInput.Length -le 2 -or $KeyVaultNameInput.Length -ge 25) { # If $KeyVaultNameInput is not between 3 and 24 characters
                    Write-Host "The vault name must be between 3 and 24 characters in length" # Write message to screen
                } # End elseif ($KeyVaultNameInput.Length -le 2 -or $KeyVaultNameInput.Length -ge 25)
                else { # If Try statement input has value not equal to exit
                    Write-Host $KeyVaultNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureKeyVaultName # Breaks SetAzureKeyVaultName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($KeyVaultNameInput -eq 'exit'))
            } # :SetAzureKeyVaultName while ($true)
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            :SetAzureKeyVaultLoc while ($true) { # Inner loop for setting the vault location
                $KeyVaultLocInput = Read-Host "New key vault location" # Operator input for the vault location
                if ($KeyVaultLocInput -eq 'exit') { # If $KeyVaultLocInput is 'exit'
                    Break NewAzureKeyVault # Breaks :NewAzureKeyVault
                } # if ($KeyVaultNameInput -eq 'exit')
                if ($KeyVaultLocInput -iin $ValidLocation.Location) { # if $KeyVaultLocInput is in $ValidLocation.Location (Case insensitive)
                    Write-Host $KeyVaultLocInput # Write $KeyVaultLocInput to screen
                    $OperatorConfirm = Read-Host "Is the location correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureKeyVaultLoc # Breaks :SetAzureKeyVaultLoc
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($KeyVaultLocInput -iin $ValidLocation)
                else { # All other inputs for $KeyVaultLocInput
                    Write-Host "The location provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidLocation.Location -Separator `n # Writes $ValidLocation.Location to screen
                } # End else (if ($KeyVaultLocInput -iin $ValidLocation))
            } # End :SetAzKeyVaultLoc while ($true)
            $KeyVaultObject = New-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName -Location $KeyVaultLocInput -Name $KeyVaultNameInput # Creates the new key vault and assigns to $KeyVaultObject
            Return $KeyVaultObject # Returns $var to calling function
        } # End :NewAzureKeyVault while ($true)
        Break # Returns to calling function empty
    } # End Begin
} # End function NewAzkeyvault