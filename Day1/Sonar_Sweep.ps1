[int[]]$arrayFromFile = Get-Content -Path 'Day1\Input.txt'
$Previus = 0
$Previus2 = 0
$Previus3measurments = 0
$count = -1
$count2 = -3
foreach ($measurment in $arrayFromFile) {
    if ($measurment -gt $Previus) {
        $count += 1
    }
    $3measurments = $measurment + $Previus + $Previus2
    if ($3measurments -gt $Previus3measurments) {
        $count2 += 1
        
    }
    $Previus3measurments = $3measurments
    $Previus2 = $Previus
    $Previus = $measurment
    
}
write-output "$count are larger than the previus measurement"
write-output "$count2 are larger than the previus  3 measurement"