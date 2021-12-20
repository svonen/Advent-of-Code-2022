$Inputtxt = Get-Content -Path 'Day15\Input.txt'
$Inputarray =  New-Object -TypeName "System.Collections.ArrayList"
foreach ($item in $Inputtxt) {
    [void]$Inputarray.Add([int[]][string[]][char[]]$item)
}
$inf = 999999999
$col = @()

$distancetoNode = @{}
for ($i = 0; $i -lt $Inputarray.Count; $i++) {
    for ($j = 0; $j -lt $Inputarray[0].Count; $j++) {
        $distancetoNode["$i,$j"]= $inf 
    }
}
$distancetoNode["0,0"]= 0 

for ($i = 0; $i -lt $Inputtxt.Count; $i++) {
    for ($j = 0; $j -lt $Inputarray[0].length; $j++) {
        if ($j -lt $Inputarray[0].length -1) {
            $v1 = $Inputarray[$i][$j+1]
            $AltDistance1 = $distancetoNode["$i,$j"] + $v1
            $next = $j+1
            if ($AltDistance1 -lt $distancetoNode["$i,$next"]) {
                $distancetoNode["$i,$next"] = $AltDistance1
            }
        }
    
        if ($i -lt $Inputtxt.Count -1) {
            $v2 = $Inputarray[$i+1][$j]
            $AltDistance2 = $distancetoNode["$i,$j"] + $v2
            $next = $i+1
            if ($AltDistance2 -lt $distancetoNode["$next,$j"]) {
                $distancetoNode["$next,$j"] = $AltDistance2
            }
        }
    }
}
$distancetoNode["99,99"]

