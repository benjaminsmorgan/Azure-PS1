# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzStorageShare:          Creates a new storage share
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    NewAzStorageShare {
        :NewAzureStorageShare       Outer loop for managing function
        :SetAzureShareName          Inner loop for setting the name of the new share
        $StorageAccObject:          Storage account object
        $ShareNameInput:            Operator input for the share name
        $ShareNameSplit:            List of names for each space in $ShareNameInput
        $OperatorConfirm:           Operator confirmation on provided values
        $StorageShareObject:        Storage share object 
        GetAzStorageAccount{
            :GetAzureStorageAccByName   Outer loop for managing funciton
            :GetAzureStorageAcc         Inner loop for getting the storage account
            $RGObject:                  Resource group object
            $StorageAccObjectInput:     Operator input for the name of the storage account
            $SAList:                    List of all storage accounts within $RGObject
            $StorageAccObject:          Storage account object    
            GetAzResourceGroup {
                $RGObject:                  Resource group object
                $RGObjectInput:             Operator input for the resource group name
                $RGList:                    Variable used for printing all resource groups to screen if needed
            } End GetAzResourceGroup
        } End GetAzStorageAccount
    } End NewAzStorageShare
} #>
<# Process Flow {
    function
        Call NewAzStorageShare > Get $StorageShareObject
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageAccount
                Return NewAzStorageShare > Send $StorageAccObject
        End NewAzStorageShare      
            Return Function > Send $StorageShareObject
}#>
function NewAzStorageShare { # Creates a new storage share
    Begin {
        :NewAzureStorageShare while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break NewAzureStorageShare # Breaks :NewAzureStorageShare
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :SetAzureShareName while ($true) { # Inner loop for setting the name of the new share
                Try { # First validation of the storage share name
                    Write-Host "Storage share name must be atleast 3 characters and made up of letters and numbers only" # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$ShareNameInput = [string](Read-Host "New Storage share name").ToLower() # Operator input for the share name
                } # End Try 
                catch { # Catch for failing to meet character validation of the share name
                    Write-Host "***Error***"  # Write message to screen
                    Write-Host "The provided name was not valid, accepted inputs are letters and numbers only" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End Catch
                if ($ShareNameInput.Length -le 2) { # If $ShareNameInput is less than 3 charaters
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, the minimum length of a name is 3 characters" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End if ($ShareNameInput.Length -le 2)
                $ShareNameSplit = $ShareNameInput.split() # Creates $ShareNameSplit, a list of entries for each space in $ShareNameInput
                if ($ShareNameSplit.Count -gt 1) { # If $ShareNameSplit is greater than 1 value
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, no spaces are allowed in the name" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End if ($ShareNameSplit.Count -gt 1)
                $ShareNameSplit = $null  # Sets $StorageConNameSplit to $null
                if ($ShareNameInput -eq '0') { # If $ShareNameInput is 0 (failed check)
                    Write-Host " " # Writes a message to screen, last action before restarting loop
                } # End if ($ShareNameInput -eq '0')
                else { # All checks on $ShareNameInput passed
                    Write-Host "This will be the share name" # Write message to screen
                    Write-Host $ShareNameInput # Write message to screen
                    $OperatorConfirm = Read-Host "[Y] or [N]" # Operator confirmation on using this name
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfrim is equal to 'y' or 'yes'
                        Break SetAzureShareName # Breaks :SetAzureShareName
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End else (if ($ShareNameInput.Length -le 2))
            } # End :SetAzureShareName while ($true)
            $StorageShareObject = New-AzStorageShare -Name $ShareNameInput -Context $StorageAccObject.Context # Creates the storage share and assigns to $StorageShareObject
            Return $StorageShareObject # Returns to calling function with $StorageShareObject
        } # End :NewAzureStorageShare while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzStorageShare