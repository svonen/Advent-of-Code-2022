$dots = 741
$Input1 = (Get-Content -Path 'Day13\Input.txt' -TotalCount $dots)
[int[]]$x = @()
[int[]]$y = @()
foreach ($line in $Input1) {
    $x1,$y1 = $line.split(',')
    $x += $x1
    $y += $y1
}
$Instructions = 12
$foldsx = @()
[int[]]$foldlineslines = @()
Get-Content -Path 'Day13\Input.txt' -tail $Instructions | ForEach-Object{
    $direction, $line = $_.split("=")
    $foldlineslines += [int]$line
    if($direction.ToCharArray() -contains "x"){
        $foldsx += 1
    }else {
        $foldsx += 0
    }
}
for ($i = 0; $i -lt $Instructions; $i++) {
    if ($foldsx[$i] -eq 1) {
        for ($j = 0; $j -lt $x.Count; $j++) {
            if ($x[$j] -lt 0) {}
            elseif ($x[$j] -gt $foldlineslines[$i]) {
                $x[$j] = 2*$foldlineslines[$i]-$x[$j] 
            }elseif ($x[$j] -eq $foldlineslines[$i]) {
                $x[$j]=-100
            }
        }
    }else {
        for ($j = 0; $j -lt $y.Count; $j++) {
            if ($y[$j] -lt 0) {}
            elseif  ($y[$j] -gt $foldlineslines[$i]) {
                $y[$j] = 2*$foldlineslines[$i]-$y[$j] 
            }elseif ($y[$j] -eq $foldlineslines[$i]) {
                $y[$j]=-100
            }
        }
    }

}
$yv = @{}
$cordinates = @{}
for ($i = 0; $i -lt $dots; $i++) {
    $x1 = $x[$i]
    $y1 = $y[$i]
    if ($x[$i] -ge 0 -and $y[$i] -ge 0 ) {
        $cordinates["$x1,$y1"] += 1
        if ($yv["$y1"] -contains $x1) {
            $yv.Name
        }else{
            $yv["$y1"] += , $x1
        }
    }
}
$cordinates.Count
$printtable =  New-Object -TypeName "System.Collections.ArrayList"

for ($i = 0; $i -lt 6; $i++) {
    $emptyline = @()
    for ($j = 0; $j -lt 40; $j++) {
        if ($yv["$i"] -contains $j) {
            $emptyline += "#"
        }else {
            $emptyline += "."
        }
    }
    [void]$printtable.Add($emptyline)
}

foreach ($item in $printtable) {
    Write-Host "$item"
}