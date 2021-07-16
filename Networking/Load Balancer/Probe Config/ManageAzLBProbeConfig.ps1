# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/add-azloadbalancerprobeconfig?view=azps-6.1.0
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Remove-AzLoadBalancerProbeConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancerprobeconfig?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
} #>
<# Required Functions Links: {
    AddAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Probe%20Config/AddAzLBProbeConfig.ps1
    ListAzLBProbeConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Probe%20Config/ListAzLBProbeConfig.ps1
    GetAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Probe%20Config/GetAzLBProbeConfig.ps1
    RemoveAzLBProbeConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Probe%20Config/RemoveAzLBProbeConfig.ps1
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
} #>
<# Functions Description: {
    ManageAzLBProbeConfig:      Function to manage load balancer probe configurations
    AddAzLBProbeConfig:         Function to add a new load balancer probe config
    ListAzLBProbeConfig:        Function to list all load balancer probe configs
    RemoveAzLBProbeConfig:      Function to remove a load balancer probe config
    GetAzLBProbeConfig:         Function to get an existing load balancer probe config
    GetAzLoadBalancer:          Function to get a load balancer 
} #>
<# Variables: {      
    :ManageAzureLBProbeConfig   Outer loop for managing function
    $OpSelect:                  Operator input for selecting the management function
    AddAzLBProbeConfig{}        Creates $LBProbeObject
        GetAzLoadBalancer{}         Gets $LoadBalancerObject
    ListAzLBProbeConfig{}       Lists $LBProbeObject
    RemoveAzLBProbeConfig{}     Removes $LBProbeObject
} #>
<# Process Flow {
    function
        Call ManageAzLBProbeConfig > Get $null
            Call AddAzLBProbeConfig > Get $null
                Call GetAzLoadBalancer > Get $LoadBalancerObject
                End GetAzLoadBalancer
                    Return AddAzLBProbeConfig > Send $LoadBalancerObject
            End AddAzLBProbeConfig
                Return ManageAzLBProbeConfig > Send $null
            Call ListAzLBProbeConfig > Get $null
            End ListAzLBProbeConfig
                Return ManageAzLBProbeConfig > Send $null
            Call RemoveAzLBProbeConfig > Get $null
                Call GetAzLBProbeConfig > Get $LBProbeObject,$LoadBalancerObject
                End GetAzLBProbeConfig
                    Return RemoveAzLBProbeConfig > Send $LBProbeObject,$LoadBalancerObject
            End RemoveAzLBProbeConfig
                Return ManageAzLBProbeConfig > Send $null
        End ManageAzLBProbeConfig
            Return function > Send $null
}#>
function ManageAzLBProbeConfig {                                                            # Function to manage load balancer probe configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBProbeConfig while ($true) {                                           # Outer loop for managing function
            Write-Host 'Manage Load Balancer Probes'                                        # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Probe Config'                                               # Write message to screen
            Write-Host '[2] List Probe Configs'                                             # Write message to screen
            Write-Host '[3] Change Probe Interval Configs'                                  # Write message to screen
            Write-Host '[4] Remove Probe Config'                                            # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBProbeConfig                                              # Breaks :ManageAzureLBProbeConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Probe Config'                                               # Write message to screen
                AddAzLBProbeConfig                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Probe Configs'                                             # Write message to screen
                ListAzLBProbeConfig                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Change Probe Interval Configs'                                  # Write message to screen
                SetAzLBProbeInterval                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove Probe Config'                                            # Write message to screen
                RemoveAzLBProbeConfig                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBProbeConfig
function AddAzLBProbeConfig {                                                               # Function to add a new load balancer probe config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBProbeConfig'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureLBProbe while ($true) {                                                    # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject is $null
                Break AddAzureLBProbe                                                       # Breaks :AddAzureLBProbe
            }                                                                               # End if (!$LoadBalancerObject)
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureLBProbeName while ($true) {                                            # Inner loop for setting the name
                Write-Host 'Probe name rules:'                                              # Write message to screen
                Write-Host 'The name can be up to 80 characters long'                       # Write message to screen
                Write-Host 'It must begin with a word character (A-9)'                      # Write message to screen
                Write-Host 'The name may contain word characters or . - _'                  # Write message to screen
                Write-Host 'It must end with a word character (A-9) or with _'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($LoadBalancerObject.Probes.Name) {                                      # If $LoadBalancerObject.Probes.Name has a value
                    Write-Host 'The following names are already in use'                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $LoadBalancerObject.Probes.Name) {                       # For each item in $LoadBalancerObject.Probes.Name
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $LoadBalancerObject.Probes.Name)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($LoadBalancerObject.Probes.Name)
                $ProbeName = Read-Host 'Name'                                               # Operator input for the back end pool name
                $ProbeNameArray = $ProbeName.ToCharArray()                                  # Converts $var to character array
                Clear-Host                                                                  # Clears screen
                if ($ProbeName.Length -gt 80) {                                             # If $ProbeName.Length is greater than 80
                    Write-Host 'The input is to long and cannot be used'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $var
                }                                                                           # End if ($ProbeName.Length -gt 80)
                if ($ProbeNameArray[0] -notin $VName1st) {                                  # If 0 position of $ProbeNameArray is not in $VName1st
                    Write-Host  $ProbeNameArray[-1]' is not a valid character'              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeNameArray[0] -notin $VName1st)
                foreach ($_ in $ProbeNameArray) {                                           # For each item in $ProbeNameArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'Back end name cannot include any spaces'            # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ProbeName = $null                                                  # Clears $ProbeName
                    }                                                                       # End if ($_ -notin $ProbeNameArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($ProbeNameArray[-1] -notin $VNameLast) {                                # If last position of $ProbeNameArray is not in $VNameLast
                    Write-Host  $ProbeNameArray[-1]' is not a valid character'              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeNameArray[0] -notin $VNameLast)
                if ($ProbeName -in $LoadBalancerObject.Probes.Name) {                       # If $ProbeName is in $LoadBalancerObject.Probes.Name
                    Write-Host 'That name is already in use'                                # Write message to screen
                    Write-Host 'Please use a new name'                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeName -in $LoadBalancerObject.Probes.Name) 
                if ($ProbeName) {                                                           # If $ProbeName has a value
                    Write-Host 'Use:'$ProbeName' as the back end pool name'                 # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end pool name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureLBProbeName                                           # Breaks :SetAzureLBProbeName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeName)
                else {                                                                      # Else if $ProbeName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeName))
            }                                                                               # End :SetAzureLBProbeName while ($true)
            [System.Collections.ArrayList]$ProbeProtocol = @()                              # Creates array for list to be loaded into
            if ($LoadBalancerObject.Sku.Name -eq 'Basic') {                                 # If $LoadBalancerObject.Sku.Name equals 'Basic'                                  
                $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                    'port' = '80'}                                                          # Creates the item to loaded into array
                $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                          # Loads item into array, out-null removes write to screen
            }                                                                               # End if ($LoadBalancerObject.Sku.Name -eq 'Basic')
            else {                                                                          # Else if $LoadBalancerObject.Sku.Name does not equal 'Basic'
                :SetAzureProbeProtocol while ($true) {                                      # Inner loop for setting the probe type
                    Write-Host 'Load balanacer health probe protocol'                       # Write message to screen
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Http (80)'                                              # Write message to screen
                    Write-host '[2] Https(443)'                                             # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpSelect = Read-Host 'Option[#]'                                       # Operator input for the probe type object
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe 
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Elseif $OpSelect equals '1'
                        $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                            'port' = '80'}                                                  # Creates the item to loaded into array
                        $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                  # Loads item into array, out-null removes write to screen         
                        Break SetAzureProbeProtocol                                         # Breaks :SetAzureProbeProtocol 
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Elseif $OpSelect equals '2'
                        [System.Collections.ArrayList]$ProbeProtocol = @()                  # Creates array for list to be loaded into
                        $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                            'port' = '443'}                                                 # Creates the item to loaded into array
                        $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                  # Loads item into array, out-null removes write to screen         
                        Break SetAzureProbeProtocol                                         # Breaks :SetAzureProbeProtocol 
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (If $OpSelect -eq '0')
                }                                                                           # End :SetAzureProbeProtocol while ($true)
            }                                                                               # End else (if ($LBSkuObject -eq 'Basic'))
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureProbeInterval while ($true) {                                          # Inner loop for setting the probe interval time
                Write-Host 'Enter the probe interval in seconds'                            # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $ProbeIntervalObject = Read-Host 'Probe interval'                           # Operator input for the probe interval
                $ProbeIntervalArray = $ProbeIntervalObject.ToCharArray()                    # Loads $ProbeIntervalObject into array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $ProbeIntervalArray) {                                       # For each item in $ProbeIntervalArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $ProbeIntervalObject = $null                                        # Clears $ProbeIntervalObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ProbeIntervalArray)
                $ProbeIntervalArray = $null                                                 # Clears $ProbeIntervalArray
                if ($ProbeIntervalObject) {                                                 # If $ProbeIntervalObject has a value
                    Write-Host 'Set probe interval at:'$ProbeIntervalObject' Seconds'       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeInterval                                         # Breaks :SetAzureProbeInterval        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeIntervalObject)
                else {                                                                      # Else if $ProbeIntervalObject is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeIntervalObject))
            }                                                                               # End :SetAzureProbeInterval while ($true)
            :SetAzureProbeCount while ($true) {                                             # Inner loop for setting the probe count
                Write-Host 'Enter the number of probes required to'                         # Write message to screen
                Write-Host 'report node is no longer functioning'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $ProbeCountObject = Read-Host 'Unhealthy threshold'                         # Operator input for the probe count
                $ProbeCountArray = $ProbeCountObject.ToCharArray()                          # Loads $ProbeCountObject into array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $ProbeCountArray) {                                          # For each item in $ProbeIntervalArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $ProbeCountObject = $null                                           # Clears $ProbeCountObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ProbeIntervalArray)
                $ProbeIntervalArray = $null                                                 # Clears $ProbeIntervalArray
                if ($ProbeCountObject) {                                                    # If $ProbeCountObject has a value
                    Write-Host 'Set probe count at:'$ProbeCountObject                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeCount                                            # Breaks :SetAzureProbeCount        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeCountObject)
                else {                                                                      # All other inputs for $ProbeCountObject
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeCountObject))
            }                                                                               # End :SetAzureProbeCount while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building health probe configuration'                            # Write message to screen
                Add-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject `
                    -Name $ProbeName -RequestPath healthcheck.aspx -Protocol `
                    $ProbeProtocol.Protocol -Port $ProbeProtocol.port `
                    -IntervalInSeconds $ProbeIntervalObject -ProbeCount $ProbeCountObject `
                    -ErrorAction 'Stop'                                                     # Creates the probe config
                Clear-Host                                                                  # Clears screen  
                Write-Host 'Saving the health probe config'                                 # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop'                # Saves the probe config to $LoadBalancerObject
                Clear-Host                                                                  # Clears screen
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBProbe                                                       # Breaks :AddAzureLBProbe
            }                                                                               # End catch    
            Write-Host 'Health probe config has been added'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureLBProbe                                                           # Breaks :AddAzureLBProbe
        }                                                                                   # End :AddAzureLBProbe while ($true)                                                     
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzLBProbeConfig
function ListAzLBProbeConfig {                                                              # Function to list all load balancer probe configs
    Begin {                                                                                 # Begin function
        :ListAzureLBProbeConfig while ($true) {                                             # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBProbeConfig                                                 # Breaks ListAzureLBProbeConfig
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $ProbeConfigList = Get-AzLoadBalancerProbeConfig -LoadBalancer $_           # Gets a list of all probes on $LBObject
                foreach ($_ in $ProbeConfigList) {                                          # For each item in $ProbeConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Probe protocol
                        'Port'=$_.Port;                                                     # Probe port
                        'Int'=$_.IntervalInSeconds;                                         # Probe interval
                        'Count'=$_.NumberOfProbes;                                          # Probe count
                        'RPath'=$_.RequestPath;                                             # Request path
                        'Rule'=$_.LoadBalancingRules.ID                                     # Probe rules if any
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                }                                                                           # End foreach ($_ in $ProbeConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer probe configs exist in this subscription'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBProbeConfig                                                # Breaks :ListAzureLBProbeConfig
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Probe Name:    '$_.Name                                         # Write message to screen
                Write-Host 'LB Name:       '$_.LBName                                       # Write message to screen
                Write-Host 'LB RG:         '$_.RGName                                       # Write message to screen
                Write-Host 'Probe Protocol:'$_.Proto                                        # Write message to screen
                Write-Host 'Probe Port:    '$_.Port                                         # Write message to screen
                Write-Host 'Probe Interval:'$_.Int                                          # Write message to screen
                Write-Host 'Probe Count:   '$_.Count                                        # Write message to screen
                if ($_.RPath) {                                                             # If current item .RPath has a value
                    Write-Host 'Probe RPath:   '$_.Rpath                                    # Write message to screen
                }                                                                           # End if ($_.RPath)
                else {                                                                      # Else if current item .RPath does not have value
                    Write-Host 'Probe RPath:    N/A'                                        # Write message to screen         
                }                                                                           # End else (if ($_.RPath))
                Write-Host 'Rule count:    '$_.Rule.Count                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen         
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBProbeConfig                                                    # Breaks :ListAzureLBProbeConfig
        }                                                                                   # End :ListAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBProbeConfig
function GetAzLBProbeConfig {                                                               # Function to get an existing load balancer probe config
    Begin {                                                                                 # Begin function
        :GetAzureLBProbeConfig while ($true) {                                              # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBProbeConfig                                                 # Breaks GetAzureLBProbeConfig
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $ProbeConfigList = Get-AzLoadBalancerProbeConfig -LoadBalancer $_           # Gets a list of all probes on $LBObject
                foreach ($_ in $ProbeConfigList) {                                          # For each item in $ProbeConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Probe protocol
                        'Port'=$_.Port;                                                     # Probe port
                        'Int'=$_.IntervalInSeconds;                                         # Probe interval
                        'Count'=$_.NumberOfProbes;                                          # Probe count
                        'RPath'=$_.RequestPath;                                             # Request path
                        'Rule'=$_.LoadBalancingRules.ID                                     # Probe rules if any
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $ProbeConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer probe configs exist in this subscription'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBProbeConfig                                                 # Breaks :GetAzureLBProbeConfig
            }                                                                               # End if (!$ObjectArray)
            :SelectAzureLBProbeConfig while ($true) {                                       # Inner loop to select the load balancer probe config
                Write-Host '[0]             Exit'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB Name:       '$_.LBName                                   # Write message to screen
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
                    Write-Host 'Probe Protocol:'$_.Proto                                    # Write message to screen
                    Write-Host 'Probe Port:    '$_.Port                                     # Write message to screen
                    Write-Host 'Probe Interval:'$_.Int                                      # Write message to screen
                    Write-Host 'Probe Count:   '$_.Count                                    # Write message to screen
                    if ($_.RPath) {                                                         # If current item .RPath has a value
                        Write-Host 'Probe RPath:   '$_.Rpath                                # Write message to screen
                    }                                                                       # End if ($_.RPath)
                    else {                                                                  # Else if current item .RPath does not have value
                        Write-Host 'Probe RPath:    N/A'                                    # Write message to screen         
                    }                                                                       # End else (if ($_.RPath))
                    Write-Host 'Rule count:    '$_.Rule.Count                               # Write message to screen
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the probe config for:'$CallingFunction    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLBProbeConfig                                             # Breaks :GetAzureLBProbeConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.LBName `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    $LBProbeObject = Get-AzLoadBalancerProbeConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer probe config object
                    Clear-Host                                                              # Clears screen
                    Return $LBProbeObject, $LoadBalancerObject                              # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBProbeConfig while ($true)
        }                                                                                   # End :GetAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBProbeConfig
function SetAzLBProbeInterval {                                                             # Function to change an existing load balancer probe interval config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBProbeInterval'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureProbeConfig while ($true) {                                                # Outer loop for managing function
            $LBProbeObject, $LoadBalancerObject = GetAzLBProbeConfig ($CallingFunction)     # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig
            }                                                                               # End if (!$LBProbeObject)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureLBProbeInt while ($true) {                                             # Inner loop for setting the probe interval
                Write-Host 'Enter new probe interval in seconds'                            # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBProbeinterval = Read-Host 'Probe interval (Seconds)'                     # Operator input for the probe interval 
                $LBProbeArray = $LBProbeinterval.ToCharArray()                              # Adds $LBProbeinterval to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBProbeArray) {                                             # For each item in $LBProbeArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBProbeinterval = $null                                            # Clears $LBProbeinterval
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBProbeArray)
                $LBProbeintervalInt = [INT]$LBProbeinterval | Out-Null                      # Converts $LBProbeinterval to an integer
                if ($LBProbeintervalInt -lt 5 -or $LBProbeintervalInt -gt 2147483646) {     # if ($LBProbeintervalInt less than 5 or $LBProbeintervalInt greater than 2147483646)
                    Write-Host 'The interval out must be between 5 and 2 Billion seconds'   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBProbeinterval = $null                                                # Clears $LBProbeinterval
                }                                                                           # End if ($LBProbeintervalInt -lt 5 -or $LBProbeintervalInt -gt 2147483646)
                $LBProbeArray = $null                                                       # Clears $LBProbeArray
                if ($LBProbeinterval) {                                                     # If $LBProbeinterval has a value
                    Write-Host 'Set'$LBProbeinterval' seconds as the probe interval'        # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureProbeConfig                                           # Breaks :SetAzureProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBProbeInt                                            # Breaks :SetAzureLBProbeInt        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBProbeinterval)
                else {                                                                      # Else if $LBProbeinterval is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBProbeinterval))
            }                                                                               # End :SetAzureLBProbeInt while ($true)
            Write-Host 'Updating the probe configuration'                                   # Write message to screen
            Try {                                                                           # Try the following
                Set-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject -Name `
                    $LBProbeObject.Name -IntervalInSeconds $LBProbeinterval -Protocol `
                    $LBProbeObject.Protocol -Port $LBProbeObject.Port -ProbeCount `
                    $LBProbeObject.NumberOfProbes -RequestPath $LBProbeObject.RequestPath `
                    -ErrorAction 'Stop' | Out-Null                                          # Updates the probe interval
                Write-Host 'Saving the load balancer config'                                # Write message to screen
                Set-AzLoadBalancer -LoadBalancer $LoadBalancerObject -ErrorAction 'Stop'    # Saves the updated load balancer configuration
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig  
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The requested changes have been made'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureProbeConfig                                                       # Breaks :SetAzureProbeConfig
        }                                                                                   # End :SetAzureProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBProbeInterval
function RemoveAzLBProbeConfig {                                                            # Function to remove a load balancer probe config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBProbeConfig'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBProbeConfig while ($true) {                                           # Outer loop for managing function
            $LBProbeObject, $LoadBalancerObject = GetAzLBProbeConfig ($CallingFunction)     # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break RemoveAzureLBProbeConfig                                              # Breaks :RemoveAzureLBProbeConfig
            }                                                                               # End if (!$LBProbeObject)
            if ($LBProbeObject.LoadBalancingRules.ID) {                                     # If $LBProbeObject.LoadBalancingRules.ID
                Write-Host 'This probe config must be removed from the'                     # Write message to screen
                Write-Host 'following rules before it can be removed:'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $LBProbeObject.LoadBalancingRules.ID) {                      # For each item in $LBProbeObject.LoadBalancingRules.ID
                    $RuleName = $_                                                          # Isolates the current item
                    $RuleName = $RuleName.Split('/')[-1]                                    # Isolates the rule name
                    Write-Host $RuleName                                                    # Write message to screen
                }                                                                           # End foreach ($_ in $LBProbeObject.LoadBalancingRules.ID)
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBProbeConfig                                              # Breaks :RemoveAzureLBProbeConfig    
            }                                                                               # End if ($LBProbeObject.LoadBalancingRules.ID)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Config Name:'$LBProbeObject.Name                                    # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'                                        # Write message to screen
                    Remove-AzLoadBalancerProbeConfig -LoadBalancer `
                        $LoadBalancerObject -Name $LBProbeObject.name `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the config
                    Write-Host 'Saving changes'                                             # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop'            # Saves the updated load balancer config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'to perform this action'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBProbeConfig                                          # Breaks :RemoveAzureLBProbeConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBProbeConfig                                              # Breaks :RemoveAzureLBProbeConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBProbeConfig                                              # Breaks :RemoveAzureLBProbeConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBProbeConfig
# Additional functions required for ManageAzLBProbeConfig
function GetAzLoadBalancer {                                                                # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :GetAzureLoadBalancer while ($true) {                                               # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLoadBalancer                                                  # Breaks GetAzureLoadBalancer
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                if ($_.BackendAddressPools.BackendIpConfigurations.id) {                    # If current item .BackendAddressPools.BackendIpConfigurations.id has a value
                    $VmssID = $_.BackendAddressPools.BackendIpConfigurations.id             # Isolates .BackendAddressPools.BackendIpConfigurations.id
                    $VmssRG = $VmssID.Split('/')[4]                                         # Isolates the Vmss resource group
                    $VmssName = $VmssID.Split('/')[8]                                       # Isolates the Vmss name
                }                                                                           # End if ($_.BackendAddressPools.BackendIpConfigurations.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Number'=$ObjectNumber;'Name'=$_.Name;'RGName'=$_.ResourceGroupName;`
                    'LOC'=$_.Location;'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;`
                    'PubAddress'=$PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name; `
                    'VmssName'=$VmssName;'VmssRG'=$VmssRG                                   # Gets current item info
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureLoadBalancer while ($true) {                                        # Inner loop to select the load balancer
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB loc:        '$_.loc                                      # Write message to screen
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
                    Write-Host 'LB SKU:        '$_.Sku                                      # Write message to screen
                    if ($_.Pubname) {                                                       # If $_.Pubname has a value
                        Write-Host 'Pub IP name:   '$_.Pubname                              # Write message to screen
                        Write-Host 'Pub IP address:'$_.PubAddress                           # Write message to screen
                        Write-Host 'Pub IP allocat:'$_.PubAllocation                        # Write message to screen
                    }                                                                       # End if ($_.Pubname)
                    if ($_.VmssName) {                                                      # If $_.VmssName has a value
                        Write-Host 'Vmss name:     '$_.VmssName                             # Write message to screen
                        Write-Host 'Vmss RG:       '$_.VmssRG                               # Write message to screen
                    }                                                                       # End if ($_.VmssName)
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the load balancer for:'$CallingFunction   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                Clear-Host                                                                  # Clears screen 
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLoadBalancer                                              # Breaks :GetAzureLoadBalancer
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.Name `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    Return $LoadBalancerObject                                              # Returns to calling function with $LoadBalancerObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # If $LoadBalancerObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLoadBalancer while ($true)
        }                                                                                   # End :GetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLoadBalancer