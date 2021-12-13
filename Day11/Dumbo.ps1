$Input = Get-Content -Path 'Day11\Input.txt'
$Inputarray =  New-Object -TypeName "System.Collections.ArrayList"
foreach ($item in $Input) {
    $Array = [int[]][string[]][char[]]$item
    $Inputarray.Add([int[]][string[]][char[]]$item)
}
$ymax = $Inputarray.Count
$xmax = $Inputarray[0].length

foreach ($arr in  $Inputarray){
    write-host "$arr"
}
write-host ""

function Increase-All {
    for ($i = 0; $i -lt $Inputarray.Count; $i++) {
        for ($j = 0; $j -lt $Inputarray[0].length; $j++) {
            $Inputarray[$i][$j]+=1
        }
    }
}

function Find-nines {
    $x = @()
    $y = @()
    for ($i = 0; $i -lt $Inputarray.Count; $i++) {
        for ($j = 0; $j -lt $Inputarray[0].length; $j++) {
            if ($Inputarray[$i][$j] -gt 9) {
                $x += $j
                $y += $i
            }
        }
    }
    $myarray = @{
        "y" = $y
        "x" = $x
    }
    return $myarray
}

function Increase-Adjesent {
    param (
        $x,
        $y
    )
    for ($i = -1; $i -le 1; $i++) {
        for ($j = -1; $j -le 1; $j++) {
            if ($i -eq 0 -and $j -eq 0) {}
            elseif ($x+$j -lt 0 -or $x+$j -ge $xmax -or  $y+$i -lt 0 -or $y+$i -ge $ymax) {}
            else {
                $Inputarray[$y+$i][$x+$j]+=1
            }
        }
    }
}
function Reset-Nines {
    param (
        $x,
        $y
    )
    $Inputarray[$y][$x] = 0
}
function Set-Nines {
    param (
        $x,
        $y
    )
    $Inputarray[$y][$x] = -999
}

$blinks = 0 
1..1000 |foreach-object{
    Increase-All
    $blinked = @{}
    $flashing = $true
    do {
        
        $nines = Find-nines
        if ($nines["x"].Count -eq 0){
            $flashing = $false
        }
        else {
            for ($i = 0; $i -lt $nines["x"].Count; $i++) {
                $blinks += 1
                Increase-Adjesent -x $nines["x"][$i] -y $nines["y"][$i]
                set-Nines -x $nines["x"][$i] -y $nines["y"][$i]
            }
            $blinked["x"] += $nines["x"]
            $blinked["y"] += $nines["y"]
        }


    } while ($flashing)
    if ($blinked["x"].Count -eq 100) {
        write-host "day $_"
        break
    }
    for ($i = 0; $i -lt $blinked["x"].Count; $i++) {
        Reset-Nines -x $blinked["x"][$i] -y $blinked["y"][$i]
    }
}
foreach ($arr in  $Inputarray){
    write-host "$arr"
}