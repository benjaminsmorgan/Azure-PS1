# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    Update-AzADUser:            https://docs.microsoft.com/en-us/powershell/module/az.resources/update-azaduser?view=azps-5.8.0
    Get-AzADUser:               https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azaduser?view=azps-5.8.0
} #>
<# Required Functions Links: {
    GetAzADUser:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/GetAzADUser.ps1                
} #>
<# Functions Description: {
    DisableAzADUser:            Disables an Azure AD account
    GetAzADUser:                Gets an Azure AD account
} #>
<# Variables: {
    :DisableAzureADUser         Outer loop for managing function
    $CallingFunction:           Name of this function
    $ADUserObject:              Azure AD user account object
    $OpConfirm:                 Operator confirmation to remove $ADUserObject
    GetAzADUser{}               Gets $ADUserObject
} #>
<# Process Flow {
    Function
        Call DisableAzADUser > Get $null 
            Call GetAzADUser > Get $ADUserObject
            End GetAzADUser
                Return DisableAzADUser > Send $ADUserObject
        End DisableAzADUser
            Return function > Send $null
}#>
function DisableAzADUser {                                                                  # Function to disable an Azure AD user account
    Begin {                                                                                 # Begin function
        $CallingFunction = 'DisableAZADUser'                                                # Creates $CallingFunction
        :DisableAzureADUser while ($true) {                                                 # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject is $null
                Break DisableAzureADUser                                                    # Breaks :DisableAzureADUser
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Disable account'$ADUserObject.UserPrincipalName                     # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to disable account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Update-AzADUser -UPNOrObjectId $ADUserObject.UserPrincipalName `
                        -EnableAccount $false -ErrorAction 'Stop'                           # Disables the account
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes made'                                            # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Break DisableAzureADUser                                                # Breaks :DisableAzureADUser
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been disabled'               # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break DisableAzureADUser                                                    # Breaks :DisableAzureADUser
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break DisableAzureADUser                                                    # Breaks :DisableAzureADUser
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :DisableAzureADUser while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function DisableAzADUser