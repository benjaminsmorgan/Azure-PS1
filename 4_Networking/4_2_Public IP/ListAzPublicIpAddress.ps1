# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzPublicIpAddress:      Lists existing public IP addresses
} #>
<# Variables: {      
    :ListAzurePublicIP          Outer loop for managing function
    $ObjectList:                List of all public IP objects
    $ObjectArray:               Array used to select the public IP
    $ObjectInput:               $var used to load items into array
    $AttachedNIC:               Name of a NIC if attached
    $AttachedNICIPConfig:       NAme of a NIC IP config if attached
} #>
<# Process Flow {
    function
        Call ListAzPublicIpAddress > Get $null
        End ListAzPublicIpAddress
            Return function > Send $null
}#>
function ListAzPublicIpAddress {                                                            # Function for listing all public IP address skus
    Begin {                                                                                 # Begin function
        :ListAzurePublicIP while ($true) {                                                  # Outer loop for managing function
            $ObjectList = Get-AzPublicIpAddress                                             # Gets a list of all public IP address
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No public IP skus are present in this subscription'             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzurePublicIP                                                     # Breaks :ListAzurePublicIP
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates array for list to be loaded into
            foreach ($_ in $ObjectList) {                                                   # For each item in list
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $ObjectInput = [PSCustomObject]@{                                           # Custom item to load into array
                    'Name'=$_.Name;'RG'=$_.ResourceGroupName;'Sku'=$_.Sku.Name;`
                    'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress;'NIC'=`
                    $AttachedNIC;'IPconfig'=$AttachedNICIPConfig                            # Creates the item list to load int array
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in list
                Write-Host 'IP SKU Name '$_.Name                                            # Write message to screen
                Write-Host 'RG Name:    '$_.RG                                              # Write message to screen
                Write-Host 'Allocation: '$_.Allocation                                      # Write message to screen
                Write-Host 'IP Address: '$_.address                                         # Write message to screen
                Write-Host 'SKU Type:   '$_.Sku                                             # Write message to screen
                if ($_.Nic) {                                                               # If current item .Nic has a value
                    Write-Host 'NIC Name:   '$_.Nic                                         # Write message to screen
                    Write-Host 'NIC Config: '$_.IPConfig                                    # Write message to screen
                }                                                                           # End if ($_.Nic)                  
                else {                                                                      # If current item .Nic does not have a value
                    Write-Host 'NIC Name:    N/A'                                           # Write message to screen
                    Write-Host 'NIC Config:  N/A'                                           # Write message to screen
                }                                                                           # End else (if ($_.Nic))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input 
            Break ListAzurePublicIP                                                         # Breaks :ListAzurePublicIP
        }                                                                                   # End :ListAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzPublicIpAddress