$bingonumbers = (Get-Content -Path 'Day4\Input.txt' -TotalCount 1).split(',')
$bingoboards = @()
Get-Content -Path 'Day4\Input.txt' -tail 599 | ForEach-Object{
    $line = $_ 
    $bingoboards += ,$line
}
$table =  New-Object -TypeName "System.Collections.ArrayList"
foreach ($line in $bingoboards){
    if ($line) {
        [int[]]$array = -split $line
        $table.Add($array)
    }
}
$number_lines = $table.length.Length
$boardsize = 5
$colums =  New-Object -TypeName "System.Collections.ArrayList"
for ($i=0; $i -le $number_lines-$boardsize; $i+=5) {
    for ($k = 0; $k -le 4; $k++) {
        $col = @()
        for ($j=$i; $j -lt $i+$boardsize; $j++){
            $col += $table[$j][$k]
        }
        $colums.Add($col)
    }
}

$bingo_length = $table.length.Length
[int[]]$ColScore = New-Object int[] $bingo_length
[int[]]$RowScore = New-Object int[] $bingo_length
$break = $false
foreach ($item in $bingonumbers) {
    for ($i=0; $i -lt $bingo_length; $i++){
        if ($item -in $colums[$i]) {
            $ColScore[$i] += 1
            if ($ColScore[$i] -ge $boardsize) {
                $index = $i
                $break = $true
            }
        }if ($item -in $table[$i]) {
            $RowScore[$i] += 1
            if ($RowScore[$i] -ge $boardsize) {
                $index = $i
                $break = $true
            }
        }
    }
    if ($break) {
        break
    }
}

while ($index % 5){
    $index--
}
$item
$markedindex = [array]::IndexOf($bingonumbers,$item)
$markednumbers = $bingonumbers[0..$markedindex]
$endindex = $index +4
$sum = 0
$index..$endindex | ForEach-Object {
    for ($i=0; $i -lt $boardsize; $i++){
        if ($table[$_][$i] -in $markednumbers) {
        }else {
            $sum += $table[$_][$i]
        }
    }
}
$sum*$item


$bingo_length = $table.length.Length
$NumBingoboards = $bingo_length/$boardsize
[int[]]$boardscore = New-Object int[] $NumBingoboards
[int[]]$ColScore = New-Object int[] $bingo_length
[int[]]$RowScore = New-Object int[] $bingo_length
$break = $false
foreach ($item in $bingonumbers) {
    for ($i=0; $i -lt $bingo_length; $i++){
        if ($item -in $colums[$i]) {
            $ColScore[$i] += 1
            if ($ColScore[$i] -ge $boardsize) {
                $index = $i
                while ($index % 5){
                    $index--
                }
                $boardnumberi = $index/5
                if ($boardscore[$boardnumberi] -eq 0) {
                    $boardscore[$boardnumberi]++
                    $sum = 0
                    $boardscore | Foreach { $sum += $_}
                    if ($sum -eq $NumBingoboards) {
                        $index2 = $i
                        $break = $true
                        $i
                    }
                }
            }
        }if ($item -in $table[$i]) {
            $RowScore[$i] += 1
            if ($RowScore[$i] -ge $boardsize) {
                $index = $i
                while ($index % 5){
                    $index--
                }
                $boardnumberi = $index/5
                if ($boardscore[$boardnumberi] -eq 0) {
                    $boardscore[$boardnumberi]++
                    $sum = 0
                    $boardscore | Foreach { $sum += $_}
                    if ($sum -eq $NumBingoboards) {
                        $index2 = $i
                        $break = $true
                    }
                }

            }
        }
    }
    if ($break) {
        break
    }
}

$index = $index2
while ($index % 5){
    $index--
}

$markedindex = [array]::IndexOf($bingonumbers,$item)
$markednumbers = $bingonumbers[0..$markedindex]
$endindex = $index +4
$sum = 0
$index..$endindex | ForEach-Object {
    for ($i=0; $i -lt $boardsize; $i++){
        if ($table[$_][$i] -in $markednumbers) {
        }else {
            $sum += $table[$_][$i]
        }
    }
}
$sum*$item
