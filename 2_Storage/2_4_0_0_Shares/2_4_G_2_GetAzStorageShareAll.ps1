# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzStorageShare:             https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:           https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.3.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzStorageShareAll:           Lists all storage shares in a subscription
} #>
<# Variables: {
    GetAzStorageShareAll{
        $StorageAccObject:          All storage accounts in subscription
        $StorageShareObject:        All storage shares in a storage account
    } End GetAzStorageShareAll
} #>
<# Process Flow {
    function
        Call GetAzStorageShareAll > Get $null
        End GetAzStorageShareAll 
            Return Function > Send $null
}#>
Function GetAzStorageShareAll { # Lists all storage shares in a subscription
    Begin {
        $StorageAccObject = Get-AzStorageAccount # Collects all storage accounts in the subscription
        foreach ($Name in $StorageAccObject) { # For each name in $StorageAccObject
            Write-Host "Resource Group:"$Name.ResourceGroupName # Write message to screen
            Write-Host "Storage Account:"$Name.StorageAccountName # Write message to screen
            Try { # Try to get storage shares within a storage account
                $StorageShareObject = Get-AzStorageShare -Context $Name.Context # Collects all storage shares in a storage account
            } # End Try
            Catch { # If Try fails
                Write-Host "Permissions or locks prevent a search in this storage account" # Write message to screen
                $StorageShareObject = $null # Clears $StorageShareObject
            } # End Catch
            foreach ($Name in $StorageShareObject) { # For each name in $StorageShareObject
                Write-Host "Storage Share:"$Name.Name # Write message to screen
            } # End foreach ($Name in $StorageShareObject)
            Write-Host "" # Write message to screen
        } # End foreach ($Name in $StorageAccObject) 
        Return # Returns nothing
    } # End Begin
} # End Function GetAzStorageShareAll