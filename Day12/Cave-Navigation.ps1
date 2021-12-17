$alllines = (Get-Content -Path 'Day12\Input.txt')

$mapping = @{}
foreach ($line in $alllines){
    $a,$b = $line -split('-')
    $mapping["$a"] += @($b)
    $mapping["$b"] += @($a)
}

$pairs =  New-Object -TypeName "System.Collections.ArrayList"
function Find-path {
    param (
        $current,
        [string[]]$Log,
        [string[]]$invalid
    )
    $Log += $current
    #write-host "$Log inv $invalid"
    if ($current -eq "end") {
        #write-host "$Log"
        [void]$pairs.Add($Log)
    }else {
        
        foreach ($node in $mapping["$current"]){
            if ($node -notin $invalid) {
                #write-host "next is $node"
                $GoNext = $true
                $smallCave = Can-Revisit -log $Log
                if ($node -cmatch "[A-Z]" -or $node -eq "end") {
                }elseif ($node -notin $log) {}
                elseif (!$smallcave) {
                    $GoNext = $false
                }
                else {
                    $invalid += $node
                }
                if ($GoNext) {
                    Find-path -current $node -invalid $invalid -Log $Log
                    $invalid = $invalid | Where-Object { $_ -ne $node }
                }
                
                
                
            }
        }
    }
}
function Can-Revisit {
    param (
        $log
    )
    $temp = $log | group | select Name, Count
    #write-host $temp
    foreach ($item in $temp){
        if ($item.Count -ge 2 -and !($item.Name -cmatch "[A-Z]") -and $item.Name -ne "start") {
            #write-host "false"
            return $false
        }
    }
    return $true
}


$Log = @()
$invalid = @("start")
Find-path -current "start" -invalid $invalid -Log $Log
$pairs.Count