# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    New-AzureADUser:            https://docs.microsoft.com/en-us/powershell/module/azuread/new-azureaduser?view=azureadps-2.0
    Get-AzureADUser:            https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureaduser?view=azureadps-2.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    NewAzADUser:                Creates a Azure AD account
} #>
<# Variables: {
    :NewAzureADUser             Outer loop for managing function
    :SetAzureADUserGName        Inner loop for setting the given (First) name
    :SetAzureADUserSName        Inner loop for setting the surname (Last)
    :SetAzureADUserMName        Inner loop for setting the middle name
    :SetAzureADUserPName        Inner loop for creating the user prinicipal name
    :CheckAzureADUserPName      Inner loop for verifing the user prinicipal name is available
    $PassProfile:               Default password profile
    $GName:                     Operator input for the given name
    $GNameStart:                First character of the the $GName to upper
    $GNameEnd:                  Remaining characters of $GName to lower
    $SName:                     Operator input for the surname
    $SNameStart:                First character of the the $SName to upper
    $SNameEnd:                  Remaining characters of $SName to lower
    $MName:                     Operator input for the middle name
    $OpConfirm:                 Operator confirmation of the name objects
    $SNameSub:                  First 6 charaters of (or all if less than 6) $SName
    $GNameSub                   First character of $GName
    $MNameSub:                  First character of $MName
    $UPName:                    Combination of $SNameSub, $GNameSub, $MNameSub, and $AddCountString
    $AddCount:                  Number used to append onto $UPName if needed
    $AddCountString:            Current $AddCount as string
    $CheckADUser:               $var if current $UPName matches an existing account
    $Dname:                     Combination of $GName and $SName
    $MailName:                  $UPName before '@'
} #>
<# Process Flow {
    Function
        Call NewAzADUser > Get $null
        End NewAzADUser
            Return function > Send $null
}#>
function NewAzADUser {                                                                      # Function for adding a new Azure AD User
    Begin {                                                                                 # Begin Function
        :NewAzureADUser while ($true) {                                                     # Outer loop for managing function
            $PassProfile = New-Object -Type Microsoft.Open.AzureAD.Model.PasswordProfile    # Creates a password profile
            $PassProfile.Password = 'PASSword1234$$'                                        # Adds defaults to password profile
            $PassProfile.ForceChangePasswordNextLogin = $true                               # Adds defaults to password profile
            $PassProfile.EnforceChangePasswordPolicy = $true                                # Adds defaults to password profile
            :SetAzureADUserGName while ($true) {                                            # Inner loop for setting the user given (first) name
                $GName = Read-Host 'Enter the given (first) name'                           # Operator input for the given name
                $GNameStart = $GName.Substring(0,1).ToUpper()                               # Creates $GNameStart
                $GNameEnd = $GName.Substring(1).ToLower()                                   # Creates $GNameEnd
                $GName = $GNameStart+$GNameEnd                                              # Recreates $GName
                Write-Host $GName 'is correct?'                                             # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the given name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'y'
                    Break NewAzureADUser                                                    # Breaks :NewAzureADUser                                                    
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Elseif $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen
                    Break SetAzureADUserGName                                               # Breaks :SetAzureADUserGName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureADUserGName while ($true)
            :SetAzureADUserSName while ($true) {                                            # Inner loop for setting the user sur (last) name
                $SName = Read-Host 'Enter the surname (last) name'                          # Operator input for the surname
                $SNameStart = $SName.Substring(0,1).ToUpper()                               # Creates $SNameStart
                $SNameEnd = $SName.Substring(1).ToLower()                                   # Creates $SNameEnd
                $SName = $SNameStart+$SNameEnd                                              # Recreates $SName
                Write-Host $SName 'is correct?'                                             # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the surname
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'y'
                    Break NewAzureADUser                                                    # Breaks :NewAzureADUser                                                    
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Elseif $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen
                    Break SetAzureADUserSName                                               # Breaks :SetAzureADUserSName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureADUserSName while ($true)
            :SetAzureADUserMName while ($true) {                                            # Inner loop for setting the user middle inital
                $MName = Read-Host 'Enter the middle Name (if present)'                     # Operator input for the middle inital
                if ($MName) {                                                               # If $MName has a value
                    Write-Host $MName 'is correct?'                                         # Write message to screen
                }                                                                           # End if ($MName)
                else {                                                                      # If $MName does not have a value
                    Write-Host 'Confirm no middle name'                                     # Write message to screen
                }                                                                           # End else (if ($MName))
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the surname
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'y'
                    Break NewAzureADUser                                                    # Breaks :NewAzureADUser                                                    
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Elseif $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen    
                    Break SetAzureADUserMName                                               # Breaks :SetAzureADUserMName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureADUser<Name while ($true)
            :SetAzureADUserPName while ($true) {                                            # Inner loop for setting the user principalName
                if ($SName.Length -gt 6) {                                                  # If $SName.Length is greater than 6
                    $SNameSub = $SName.Substring(0,6)                                       # Collects the first 6 letters of SName
                }                                                                           # End if ($SName.Length -gt 6)
                else {                                                                      # If $SName.Length is 6 or less
                    $SNameSub = $SName                                                      # $SNameSub is equal to $SName                
                }                                                                           # End else (if ($SName.Length -gt 6))
                $GNameSub = $GName.Substring(0,1).ToLower()                                 # Collects the first letter of the GName                        
                if ($MName) {                                                               # If $MName has a value
                    $MNameSub = $MName.Substring(0,1).ToLower()                             # Collects the first letter of $MName
                    $UPName = $SNameSub+$GNameSub+$MNameSub+'@morganbs.com'                 # Creates $UPName
                    $AddCount = 1                                                           # Number used to append to $UPName
                    :CheckAzureADUserPName while ($true) {                                  # Inner loop for validating the $UPName
                        [string]$AddCountString = $AddCount                                 # Converts $AddCount to string
                        $CheckADUser = Get-AzureAdUser | Where-Object `
                            {$_.UserPrincipalName -eq $UPName}                              # Finds a matching UserPrinicpalName is existing
                        if ($CheckADUser) {                                                 # If $CheckADUser has a value
                            $UPName = `
                            $SNameSub+$GNameSub+$MNameSub+$AddCountString+'@morganbs.com'   # Updates $UPName with $AddCountString
                            $AddCount = $AddCount + 1                                       # Increments $AddCount up by 1
                            $CheckADUser = $null                                            # Clears $CheckADUser
                        }                                                                   # End if ($CheckADUser)
                        else {                                                              # If $CheckADUser does not have a value
                            Break SetAzureADUserPName                                       # Breaks :SetAzureADUserPName
                        }                                                                   # End else (if ($CheckADUser))
                    }                                                                       # End :CheckAzureADUserPName while ($true) 
                }                                                                           # End if ($MName)
                else {                                                                      # If $MName does not have a value
                    $UPName = $SNameSub+$GNameSub+'@morganbs.com'                           # Creates $UPName
                    $AddCount = 1                                                           # Number used to append to $UPName
                    :CheckAzureADUserPName while ($true) {                                  # Inner loop for validating the $UPName
                        [string]$AddCountString = $AddCount                                 # Converts $AddCount to string
                        $CheckADUser = Get-AzureAdUser | Where-Object `
                            {$_.UserPrincipalName -eq $UPName}                              # Finds a matching UserPrinicpalName is existing
                        if ($CheckADUser) {                                                 # If $CheckADUser has a value
                            $UPName = $SNameSub+$GNameSub+$AddCountString+'@morganbs.com'   # Updates $UPName with $AddCountString
                            $AddCount = $AddCount +1                                        # Increments $AddCount up by 1
                            $CheckADUser = $null                                            # Clears $CheckADUser
                        }                                                                   # End if ($CheckADUser)
                        else {                                                              # If $CheckADUser does not have a value
                            Break SetAzureADUserPName                                       # Breaks :SetAzureADUserPName
                        }                                                                   # End else (if ($CheckADUser))
                    }                                                                       # End :CheckAzureADUserPName while ($true)
                }                                                                           # End else (if ($MName))
            }                                                                               # End :SetAzureADUserPName while ($true)
            $Dname = $GName + ' ' + $SName                                                  # Creates $DName (Display Name)
            $MailName = $UPName.Split('@')[0]                                               # Creates $MailName (Mail Nickname)
            Try {                                                                           # Try the following
                New-AzureADUser -UserPrincipalName $UPName -DisplayName $Dname `
                    -MailNickname $MailName -GivenName $GName -Surname $SName `
                    -PasswordProfile $PassProfile -AccountEnabled $true `
                    -ErrorAction 'Stop'                                                     # Creates the user account
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break NewAzureADUser                                                        # Breaks :NewAzureADUser
            }                                                                               # End catch   
            Write-Host 'The user account has been created'                                  # Write message to screen
            Start-Sleep(2)                                                                  # Pauses all actions for 2 seconds
            Break NewAzureADUser                                                            # Breaks :NewAzureADUser
        }                                                                                   # End :NewAzureADUser while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzADUser