$Input = Get-Content -Path 'Day9\Input.txt'

$Inputarray =  New-Object -TypeName "System.Collections.ArrayList"

$arr1 = @(9) * 102
$Inputarray.Add($arr1)
foreach ($item in $Input) {
    $a = @(9)
    $Array = $a + [int[]][string[]][char[]]$item + $a
    $Inputarray.Add($Array)
}
$Inputarray.Add($arr1)
$answer1 = 0
$Lowx = @()
$lowy = @()
for ($i = 1; $i -lt ($Inputarray.Count-1); $i++){
    for ($j = 1; $j -lt ($Inputarray[0].length -1); $j++) {
        if ($Inputarray[$i][$j] -lt $Inputarray[$i-1][$j] -and $Inputarray[$i][$j] -lt $Inputarray[$i][$j-1] -and $Inputarray[$i][$j] -lt $Inputarray[$i+1][$j] -and $Inputarray[$i][$j] -lt $Inputarray[$i][$j+1]) {
            $answer1 += $Inputarray[$i][$j] +1
            $lowy += $j
            $Lowx += $i
            #$x = $Inputarray[$i][$j]
            #write-host "x $x i $i j $j"
        }
        
    }
}
$answer1

function find-basin {
    param (
        $x,
        $y
    )
    $x1 = $x-1
    $x2 = $x+1
    $y1 = $y+1
    $y2 = $y-1
    if ($Inputarray[$x1][$y] -lt 9 -and $Inputarray[$x][$y] -lt $Inputarray[$x1][$y] -and !($basin["$x1,$y"])) {
        $basin["$x1,$y"] = 1
        find-basin -x $x1 -y $y
    }
    if ($Inputarray[$x][$y1] -lt 9 -and $Inputarray[$x][$y] -lt $Inputarray[$x][$y1] -and !$basin["$x,$y1"]) {
        $basin["$x,$y1"] = 1
        find-basin -x $x -y $y1
    }    
    if ($Inputarray[$x2][$y] -lt 9 -and $Inputarray[$x][$y] -lt $Inputarray[$x2][$y] -and !$basin["$x2,$y"]) {
        $basin["$x2,$y"] = 1
        find-basin -x $x2 -y $y
    }    
    if ($Inputarray[$x][$y2] -lt 9 -and $Inputarray[$x][$y] -lt $Inputarray[$x][$y2] -and !$basin["$x,$y2"]) {
        $basin["$x,$y2"] = 1
        find-basin -x $x -y $y2
    }
}
$basins = @()
$answer2 = 1
for ($i = 0; $i -lt $lowy.length; $i++) {
    $x = $Lowx[$i]
    $y = $lowy[$i]
    $basin = @{"$x,$y" = 1}
    find-basin -x $x -y $y
    $basins += $basin.Count
    
}
$basins | sort-object | Select-Object -Last 3
