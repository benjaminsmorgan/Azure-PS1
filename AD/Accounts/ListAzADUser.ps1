# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    Get-AzADUser:               https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azaduser?view=azps-5.8.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzADUser:               Lists Azure AD accounts
} #>
<# Variables: {
    :ListAzureADUser            Outer loop for managing function
    $ObjectList:                List of all Azure AD user accounts
    $ObjectArray:               Array containing $Objectlist items
    $ObjectInput:               $var used to load items into $ObjectArray
} #>
<# Process Flow {
    Function
        Call ListAzADUser > Get $null
        End ListAzADUser
            Return function > Send $null
}#>
function ListAzADUser {                                                                     # Function to list Azure AD user accounts
    Begin {                                                                                 # Begin function
        :ListAzureADUser while ($true) {                                                    # Outer loop for managing function
            $ObjectList = Get-AzADUser                                                      # Pulls a list of all user accounts
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'UPN'=$_.UserPrincipalName;`
                    'Loc'=$_.UsageLocation;'GName'=$_.GivenName;'SName'=$_.Surname;`
                    'DName'=$_.DisplayName;'Mail'=$_.Mail;'Enabled'=$_.AccountEnabled;`
                    'ID'=$_.Id}                                                             # Adds info to current $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # Foreach item in $ObjectArray
                Write-Host 'User Pri Name'$_.UPN                                            # Write message to screen
                Write-Host 'Display Name:'$_.DName                                          # Write message to screen
                Write-Host 'Given Name:  '$_.GName                                          # Write message to screen
                Write-Host 'Surname:     '$_.SName                                          # Write message to screen
                Write-Host 'Location:    '$_.Loc                                            # Write message to screen
                if ($_.Mail) {                                                              # If current item .Mail has a value
                    Write-Host 'Email:       '$_.Mail                                       # Write message to screen
                }                                                                           # End if ($_.Mail)
                Write-Host 'ID:          '$_.ID                                             # Write message to screen
                Write-Host 'Enabled:     '$_.Enabled                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses for user input
            Break ListAzureADUser                                                           # Breaks :ListAzureADUser    
        }                                                                                   # End :ListAzureADUser while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzADUser