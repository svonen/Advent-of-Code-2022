[string[]]$arrayFromFile = Get-Content -Path 'Day2\Input.txt'

$depth = 0
$horizontal = 0
foreach ($command in $arrayFromFile){
    [int]$value= $command.Substring($command.length - 1)
    $direction = $command.Split(" ")
    if ($direction -eq "forward") {
        $horizontal += $value
    } elseif ($direction -eq "down") {
        $depth += $value
    } elseif ($direction -eq "up") {
        $depth -= $value
    }
}
[int]$answer = $horizontal * $depth
Write-Output "Depth = $dept and horizontal $horizontal gives anwswer $answer "

$aim = 0
$horizontal = 0
$dept = 0
foreach ($command in $arrayFromFile){
    [int]$value= $command.Substring($command.length - 1)
    $direction = $command.Split(" ")
    if ($direction -eq "forward") {
        $horizontal += $value
        $dept += $value*$aim
    } elseif ($direction -eq "down") {
        $aim += $value
    } elseif ($direction -eq "up") {
        $aim -= $value
    }
}
[int]$answer = $horizontal * $dept
Write-Output "Depth = $dept and horizontal $horizontal gives anwswer $answer "