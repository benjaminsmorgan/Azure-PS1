# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzAksCluster:        https://docs.microsoft.com/en-us/powershell/module/az.aks/remove-azakscluster?view=azps-5.6.0
    Get-AzAksCluster:           https://docs.microsoft.com/en-us/powershell/module/az.aks/get-azakscluster?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzAksCluster:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/GetAzAksCluster.ps1  
} #>
<# Functions Description: {
    RemoveAzAksCluster:         Removes a selected Aks cluster
    GetAzAksCluster:            Gets an Aks cluster
} #>
<# Variables: {
    :RemoveAzureAksCluster      Outer loop for managing function 
    $AksObject:                 Aks cluster object
    $CallingFunction:           $Var used to pass this functions name to a called function
    $OperatorConfirm:           Operator confirmation to remove this Aks cluster
    GetAzAksCluster{}           Gets $AksObject
} #>
<# Process Flow {
    Function
        Call RemoveAzAksCluster > Get $null
            Call GetAzAksCluster > Get $AksObject
            End GetAzAksCluster
                Return RemoveAzAksCluster > Send $AksObject
        End RemoveAzAksCluster
            Return function > Send $null
}#>
function RemoveAzAksCluster {                                                               # Function to remove an Aks cluster
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Turns of warning messages
        :RemoveAzureAksCluster while ($true) {                                              # Outer loop for managing function
            if (!$AksObject) {                                                              # If $AksObject is $null
                $CallingFunction = 'RemoveAzAksCluster'                                     # Creates $Calling function $var
                $AksObject = GetAzAksCluster ($CallingFunction)                             # Calls function and assigns output to $var
                if (!$AksObject) {                                                          # If $AksObject is $null
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End if (!$AksObject)
            }                                                                               # End if (!$AksObject)
            Write-Host 'Remove Aks Cluster named:'$AksObject.Name'in RG:'$AksObject.RG       # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Aks cluster
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzAksCluster -ResourceGroupName $AksObject.RG `
                        -Name $AksObject.Name -Force -ErrorAction 'Stop'                    # Removes the Object
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to this resource'          # Write message to screen
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End Catch
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Break RemoveAzureAksCluster                                                 # Breaks :RemoveAzureAksCluster
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureAksCluster while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzAksCluster