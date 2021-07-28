# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzApplicationSecurityGroup:          https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzASG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/GetAzASG.ps1
} #>
<# Functions Description: {
    RemoveAzASG:                Function to remove an application security group
    GetAzASG:                   Function to get an application security group
} #>
<# Variables: {      
    :RemoveAzureASG             Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $ASGObject:                 Application security group object
    $AttachedNics:              List of nics $ASGObject is attached to
    $OpConfirm:                 Operator confirmation to remove the ASG
    GetAzASG{}                  Gets $ASGObject
} #>
<# Process Flow {
    function
        Call RemoveAzASG > Get $null
            Call GetAzASG > Get $ASGObject
            End GetAzASG
                Return RemoveAzASG > Send $ASGObject
        End RemoveAzASG
            Return function > Send $null
}#>
function RemoveAzASG {                                                                      # Function to remove an application security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzASG'                                                # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureASG while ($true) {                                                     # Outer loop for managing function
            $ASGObject = GetAzASG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$ASGObject) {                                                              # If $ASGObject does not have a value
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG
            }                                                                               # End if (!$ASGObject)
            $AttachedNics = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGObject.ID}        # Gets a list of attached NICs to $ASGObject
            if ($AttachedNics) {                                                            # If $AttachedNics has a value
                Write-Host 'The following NICs have configs referencing'                    # Write message to screen
                Write-Host 'this Application Security Group:'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $AttachedNics) {                                             # For each item in $AttachedNics
                    Write-Host $_.Name                                                      # Write message to screen
                }                                                                           # End foreach ($_ in $AttachedNics)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The ASG will need to be removed from the'                       # Write message to screen
                Write-Host 'IP configurations before it can be deleted'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG    
            }                                                                               # End if ($AttachedNics)
            Write-Host 'Remove ASG:'$ASGObject.name                                         # Write message to screen
            Write-Host 'From RG:   '$ASGObject.ResourceGroupName                            # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the ASG
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the application security group'                        # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzApplicationSecurityGroup -ResourceGroupName `
                        $ASGObject.ResourceGroupName -Name $ASGObject.Name `
                        -Force -ErrorAction 'Stop' | Out-Null                               # Removes the application security group
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureASG                                                    # Breaks :RemoveAzureASG    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The application security group has been removed'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzASG