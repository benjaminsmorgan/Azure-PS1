# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzPublicIpAddress:       Gets an existing public IP address
} #>
<# Variables: {      
    :GetAzurePublicIP           Outer loop for managing function
    :SelectAzurePublicIP        Inner loop for selecting the public IP
    $PublicIPList:              List of all public IP objects
    $PublicIPArray:             Array used to select the public IP
    $PublicIPNumber:            List number used for selection
    $PublicIPInput:             $var used to load items into array
    $SelectPublicIP:            Operator input for IP selection
    $PublicIPObject:            Public IP object
} #>
<# Process Flow {
    function
        Call GetAzPublicIpAddress > Get $PublicIPObject
        End GetAzPublicIpAddress
            Return function > Send $PublicIPObject
}#>
function GetAzPublicIpAddress {                                                             # Function for 
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            $PublicIPNumber = 1                                                             # Creates #var used for list selection
            Write-Host "[ 0 ] to exit"                                                      # Write message to screen
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                $PublicIPInput = [PSCustomObject]@{'Name' = $_.Name;'Number' `
                    = $PublicIPNumber;'RG' = $_.ResourceGroupName;'Sku'=$_.Sku.Name `
                ;'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress}           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
            }                                                                               # End foreach ($_ in $PublicIPArray)
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                Write-Host "["$_.Number"]"                                                  # Write message to screen
                Write-Host "Name "$_.Name                                                   # Write message to screen
                Write-Host "RG:  "$_.RG                                                     # Write message to screen
                Write-Host "Type:"$_.Allocation                                             # Write message to screen
                Write-Host "Add: "$_.address                                                # Write message to screen
                Write-Host "Sku: "$_.Sku                                                    # Write message to screen                            
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                $SelectPublicIP = Read-Host "Enter the list number for public IP"           # Operator input for the public IP selection
                if ($SelectPublicIP -eq '0') {                                              # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($SelectPublicIP -eq '0')
                elseif ($SelectPublicIP -in $PublicIPArray.Number) {                        # If $SelectPublicIP in $PublicIPArray.Number list
                    $SelectPublicIP = $PublicIPArray | Where-Object `
                        {$_.Number -eq $SelectPublicIP}                                     # SelectPublicIP is equal to $PublicIPArray where $PublicIPArray.Number equals $SelectPublicIP
                    $PublicIPObject = Get-AzPublicIpAddress -Name $SelectPublicIP.Name `
                        -ResourceGroupName $SelectPublicIP.RG                               # Pulls $PublicIPObject
                    if ($PublicIPObject) {                                                  # If $PublicIPObject has a value
                        Return $PublicIPObject                                              # Returns to calling function with $PublicIPObject
                    }                                                                       # End if ($PublicIPObject)
                    else {                                                                  # If $PublicIPObject is $null
                        Write-Host "An error has occured"                                   # Write message to screen
                        Break GetAzurePublicIP                                              # Breaks :GetAzurePublicIP
                    }                                                                       # End else (if ($PublicIPObject))
                }                                                                           # End elseif ($SelectPublicIP -in $PublicIPArray.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($SelectPublicIP -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress