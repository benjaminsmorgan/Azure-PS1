# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    Update-AzADUser:            https://docs.microsoft.com/en-us/powershell/module/az.resources/update-azaduser?view=azps-5.8.0
    Get-AzADUser:               https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azaduser?view=azps-5.8.0
} #>
<# Required Functions Links: {
    GetAzADUser:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/GetAzADUser.ps1                
} #>
<# Functions Description: {
    EnableAzADUser:             Enables an Azure AD account
    GetAzADUser:                Gets an Azure AD account
} #>
<# Variables: {
    :EnableAzureADUser          Outer loop for managing function
    $CallingFunction:           Name of this function
    $ADUserObject:              Azure AD user account object
    $OpConfirm:                 Operator confirmation to remove $ADUserObject
    GetAzADUser{}               Gets $ADUserObject
} #>
<# Process Flow {
    Function
        Call EnableAzADUser > Get $null 
            Call GetAzADUser > Get $ADUserObject
            End GetAzADUser
                Return EnableAzADUser > Send $ADUserObject
        End EnableAzADUser
            Return function > Send $null
}#>
function EnableAzADUser {                                                                   # Function to Enable an Azure AD user account
    Begin {                                                                                 # Begin function
        $CallingFunction = 'EnableAZADUser'                                                 # Creates $CallingFunction
        :EnableAzureADUser while ($true) {                                                  # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject is $null
                Break EnableAzureADUser                                                     # Breaks :EnableAzureADUser
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Enable account'$ADUserObject.UserPrincipalName                      # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to Enable account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Update-AzADUser -UPNOrObjectId $ADUserObject.UserPrincipalName `
                        -EnableAccount $true -ErrorAction 'Stop'                            # Enables the account
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes made'                                            # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Break EnableAzureADUser                                                 # Breaks :EnableAzureADUser
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been enabled'                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break EnableAzureADUser                                                     # Breaks :EnableAzureADUser
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break EnableAzureADUser                                                     # Breaks :EnableAzureADUser
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :EnableAzureADUser while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function EnableAzADUser