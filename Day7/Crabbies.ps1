
[int[]]$InitialState = (Get-Content -Path 'Day7\Input.txt').split(',')

function Get-Fuelcost {
    param (
        [int[]] $CrabPositions,
        [int]$Position
    )
    $Fuelcost = 0
    foreach ($Crab in $CrabPositions){
        $Fuelcost += [Math]::Abs($Crab - $Position)
    }
    return $Fuelcost
}
function Get-AdvancedFuelcost {
    param (
        [int[]] $CrabPositions,
        [int]$Position
    )
    $Fuelcost = 0
    foreach ($Crab in $CrabPositions){
        $Distance = [Math]::Abs($Crab - $Position)
        1..$Distance | ForEach-Object{
            $Fuelcost += $_
        }
    }
    return $Fuelcost
}


$Best = 9999999999999
0..1500 | ForEach-Object{
    $test = Get-Fuelcost -CrabPositions $InitialState -Position $_
    if ($test -lt $best) {
        $best = $test
    }

}
$Best

$Best2 = 9999999999999
$Coninue = $true

$BestPosition = 7
$IncreasteNext = $true
$x1 = 0
$y1 = Get-AdvancedFuelcost -CrabPositions $InitialState -Position $x1
$Step = 256
$counter = 1
while ($Coninue) {
    
    if ($IncreasteNext) {
        $x2 = $x1 + $Step
    }else {
        $x2 = $x1 - $Step
    }
    $y2 = Get-AdvancedFuelcost -CrabPositions $InitialState -Position $x2
    Write-Host "position $x1 fuel $y1"
    Write-Host "position $x2 fuel $y2"
    if ($y1 -le $y2) {
        if ($step -ge 2) {
            $Step = $Step/2
        }else {
            $counter -= 1
        }
        
        $IncreasteNext = !$IncreasteNext
    }else {
        $x1 = $x2
        $y1 = $y2
    }
    if ($counter = 0) {
        $Coninue = $false
    }
}