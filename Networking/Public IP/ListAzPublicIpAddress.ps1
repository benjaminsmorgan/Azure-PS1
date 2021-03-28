# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzPublicIpAddress:      Lists existing public IP addresses
} #>
<# Variables: {      
    :ListAzurePublicIP          Outer loop for managing function
    $PublicIPList:              List of all public IP objects
    $PublicIPArray:             Array used to select the public IP
    $PublicIPNumber:            List number used for selection
    $PublicIPInput:             $var used to load items into array
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
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $PublicIPInput = [PSCustomObject]@{'Name' = $_.Name; 'RG' = `
                    $_.ResourceGroupName;'Sku'=$_.Sku.Name;'Allocation'=`
                    $_.PublicIpAllocationMethod;'Address'=$_.IPAddress;'NIC'=`
                    $AttachedNIC;'IPconfig'=$AttachedNICIPConfig}                           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $PublicIPArray)
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                Write-Host "IP SKU Name "$_.Name                                            # Write message to screen
                Write-Host "RG Name:    "$_.RG                                              # Write message to screen
                Write-Host "Allocation: "$_.Allocation                                      # Write message to screen
                Write-Host "IP Address: "$_.address                                         # Write message to screen
                Write-Host "SKU Type:   "$_.Sku                                             # Write message to screen
                if ($_.Nic) {                                                               # If current item .Nic has a value
                    Write-Host "NIC Name:   "$_.Nic                                         # Write message to screen
                    Write-Host "NIC Config: "$_.IPConfig                                    # Write message to screen
                }                                                                           # End if ($_.Nic)                  
                else {                                                                      # If current item .Nic does not have a value
                    Write-Host "NIC Name:    N/A"                                           # Write message to screen
                    Write-Host "NIC Config:  N/A"                                           # Write message to screen
                }                                                                           # End else (if ($_.Nic))
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            Break ListAzurePublicIP                                                         # Breaks :ListAzurePublicIP
        }                                                                                   # End :ListAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzPublicIpAddress