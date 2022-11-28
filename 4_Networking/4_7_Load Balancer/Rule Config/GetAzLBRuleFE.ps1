# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.0.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
} #>
<# Required Functions Links: {
    None    
} #>
<# Functions Description: {
    GetAzLBRuleFE:              Function to get a load balancer front end config for load balancer rule
} #>
<# Variables: {      
    :GetAzureLBFEConfig         Outer loop for managing function
    :SelectAzureLBFEConfig      Inner loop for selecting the front end config
    $ObjectArray:               Array used to hold all config info
    $ObjectNumber:              $var used for listing and selecting items in $ObjectArray
    $LoadBalancerObject:        Load balancer object
    $ObjectList:                List of all configs on $LoadBalancerObject
    $SubnetID:                  Subnet ID on current item configuration
    $PublicIPID:                Public IP ID on current item configuration
    $PublicIPObject:            Public IP object on current item configuration
    $ObjectInput:               $var used to load info into $ObjectArray
    $OpSelect:                  Operator input to select the configutation
    $LBFEObject:                Front end configuration object    
} #>
<# Process Flow {
    function
        Call GetAzLBRuleFE > Get $LBFEObject
        End GetAzLBRuleFE
            Return function > Send $LBFEObject
}#>
function GetAzLBRuleFE {                                                                    # Function to get a load balancer front end config for load balancer rule
    Begin {                                                                                 # Begin function
        :GetAzureLBFEConfig while ($true) {                                                 # Outer loop for managing function
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            $ObjectList = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                $LoadBalancerObject                                                         # Gets the configs of $LoadBalancerObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.Subnet.ID) {                                                         # If current item .subnet.id has a value
                    $SubnetID = $_.Subnet.ID                                                # Isolates the subnet ID
                    $SubnetID = $SubnetID.Split('/')[-1]                                    # Isolates the subnet name
                }                                                                           # End if ($_.Subnet.ID)
                if ($_.PublicIPAddress.ID) {                                                # If current item .PublicIPAddress.ID 
                    $PublicIPID = $_.PublicIPAddress.ID                                     # Isolates the public IP ID 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PublicIPID}                                             # Gets the public IP object
                }                                                                           # End if ($_.PublicIPAddress.ID)
                $ObjectInput = [PSCustomObject]@{                                           # Custom object to be added to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # $ObjectNumber 
                    'Name'=$_.Name;                                                         # Current item .name
                    'PriIP'=$_.PrivateIpAddress;                                            # Current item .PrivateIPaddress
                    'PriIP2'=$_.PrivateIpAllocationMethod;                                  # Current item .PrivateIPAllocation
                    'Sub'=$SubnetID;                                                        # $SubnetID
                    'PubIP'=$PublicIPObject.IpAddress;                                      # PublicIPObject.IPAddress
                    'PubIP2'=$PublicIPObject.PublicIpAllocationMethod;                      # $PublicIPObject.PublicIpAllocationMethod
                    'PubIP3'=$PublicIPObject.Sku.Name;                                      # $PublicIPObject.Sku.Name     
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $SubnetID = $null                                                           # Clears $SubnetID
                $PublicIPID = $null                                                         # Clears $PublicIPID
                $PublicIPObject = $null                                                     # Clears $PublicIPObject
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureLBFEConfig while ($true) {                                          # Inner loop for selecting the front end config
                Write-Host '[0]          Exit'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen    
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .Number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$number]         "$_.Name                              # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is more than 9
                        Write-Host "[$number]       "$_.Name                                # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        Write-host 'Config Type: Public'                                    # Write message to screen
                        Write-Host 'IP Address: '$_.PubIP                                   # Write message to screen
                        Write-Host 'Allocation: '$_.PubIP2                                  # Write message to screen
                        Write-Host 'Sku Name:   '$_.PubIP3                                  # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    else {                                                                  # Else if current item .PubIP is $null
                        Write-host 'Config Type: Private'                                   # Write message to screen
                        if ($_.PriIP) {                                                     # if current item .priIP has a value
                            Write-Host 'IP Address: '$_.PriIP                               # Write message to screen
                        }                                                                   # End if ($_.PriIP)
                        Write-Host 'Allocation: '$_.PriIP2                                  # Write message to screen
                        Write-Host 'Subnet:     '$_.Sub                                     # Write message to screen
                    }                                                                       # End else (if ($_.PubIP))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the front end config for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the front end config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureLBFEConfig                                                # Breaks :GetAzureLBFEConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LBFEObject = Get-AzLoadBalancerFrontendIpConfig `
                        -LoadBalancer $LoadBalancerObject -Name $OpSelect.Name              # Gets the front end IP config object
                    Return $LBFEObject                                                      # Returns to calling function with $var    
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureLBFEConfig while ($true)
        }                                                                                   # End :GetAzureLBFEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBRuleFE