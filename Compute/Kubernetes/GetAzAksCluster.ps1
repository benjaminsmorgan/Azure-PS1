# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzAksCluster:           https://docs.microsoft.com/en-us/powershell/module/az.aks/get-azakscluster?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None  
} #>
<# Functions Description: {
    GetAzAksCluster:            Gets an Aks cluster
} #>
<# Variables: {
    :GetAzureAksCluster         Outer loop for managing function 
    :SelectAzureAksCluster      Inner loop for selecting the Aks cluster
    $RGList:                    List of all resource groups
    $ObjectListNumber:          $Var used for the object array number
    $ObjectArray:               Array that objects are loaded into
    $ObjectList:                List of Aks cluster objects
    $RGName:                    Pulls the currently selected resource group name
    $ArrayInput:                $Var used to load items into array
    $CallingFunction:           $Var used to list the calling function name
    $OperatorSelect:            Operator input for selecting the Aks cluster
    $AksObject:                 Aks cluster object
} #>
<# Process Flow {
    Function
        Call GetAzAksCluster > Get $AksObject
        End GetAzAksCluster
            Return function > Send $AksObject
}#>
function GetAzAksCluster {                                                                  # Function to get an Aks cluster
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Turns of warning messages
        :GetAzureAksCluster while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Getting a list of all Aks Clusters'                                 # Write message to screen
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            $ObjectListNumber = 1                                                           # $var used as list number
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the array that all objects will be loaded into
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $ObjectList = Get-AzAksCluster -ResourceGroupName $_.ResourceGroupName      # Gets a list of any AKS clusters
                if ($ObjectList) {                                                          # If $ObjectList has a value
                    $RGName = $_.ResourceGroupName                                          # $RGName is set to the current resource group name
                    foreach ($_ in $ObjectList) {                                           # For each item in $ObjectList
                        $ArrayInput = [PSCustomObject]@{'Name' = $_.Name; 'Number' = `
                            $ObjectListNumber; 'NRG' = $_.NodeResourceGroup; 'RG' =$RGName} # Creates $var to load items into array                
                        $ObjectArray.Add($ArrayInput) | Out-Null                            # Adds items to the array
                        $ObjectListNumber = $ObjectListNumber + 1                           # Increments $ObjectListNumber up by 1
                    }                                                                       # End foreach ($_ in $ObjectList)                                                 
                }                                                                           # End if ($ObjectList)
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $Object array
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Aks Name:  '$_.Name                                             # Write message to screen
                Write-Host 'NodeRG:    '$_.NRG                                              # Write message to screen
                Write-Host 'Object RG: '$_.RG                                               # Write message to screen    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureAksCluster while ($true) {                                          # Inner loop to select the Aks cluster
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host "You are selecting the Aks cluster for"$CallingFunction      # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OperatorSelect = Read-Host 'Enter the number of the Aks Cluster'           # Operator input for the Aks cluster
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureAksCluster                                                # Breaks :GetAzureAksCluster
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $ObjectArray.Number) {                          # Else if $OperatorSelect equals $ObjectArray.Number
                    $AksObject = $ObjectArray | Where-Object {$_.Number -eq `
                        $OperatorSelect}                                                    # $AksObject is equal to $ObjectArray where $OperatorSelect equals $ObjectArray.Number
                    Return $AksObject                                                       # Returns to calling function with $AksObject
                }                                                                           # End elseif ($OperatorSelect -eq $ObjectArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureAksCluster while ($true)
        }                                                                                   # End :GetAzureAksCluster while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzAksCluster