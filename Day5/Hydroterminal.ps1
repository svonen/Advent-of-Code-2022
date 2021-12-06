$alllines = (Get-Content -Path 'Day5\Input.txt')

$pairs =  New-Object -TypeName "System.Collections.ArrayList"
foreach ($line in $alllines){
    $newline = $line -Replace "->",',' -replace " ",""
    [int[]]$array = $newline -split(',')
    $pairs.Add($array)
}
$score = @{"0,0" = 0}
foreach ($pair in $pairs){
    if ($pair[0] -eq $pair[2]){
        $pair[1]..$pair[3] |ForEach-Object{
            $key = $pair[0].ToString()+","+ $_.ToString()
            $score[$key]+=1

        }
    } elseif ($pair[1] -eq $pair[3]) {
        $pair[0]..$pair[2] |ForEach-Object{
            $key = $_.ToString() +","+ $pair[1].ToString()
            $score[$key]+=1
        }
    } elseif ($pair[0]-$pair[2] -eq $pair[1]-$pair[3] -or $pair[0]-$pair[2] -eq $pair[3]-$pair[1]) {
        $x = @()
        $y = @()
        $pair[0]..$pair[2] |ForEach-Object{
            $x += $_
        }
        $pair[1]..$pair[3] |ForEach-Object{
            $y+= $_
            
        }
        $steps = $pair[0]-$pair[2] 
        if ($steps -lt 0) {
            $steps = -$steps
        }
        0..($steps) | ForEach-Object{
            $key = $x[$_].ToString() +","+ $y[$_].ToString()
            $score[$key]+=1
            
            
        }
    }
}
$sum=0
$score.Values | ForEach-Object{
    if ($_ -ge 2) {
        $sum++
    }
}
$sum