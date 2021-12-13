[string[]]$arrayFromFile = Get-Content -Path 'Day10\Input.txt'

$hash =@{
    "{" = "}"
    "(" = ")"
    "[" = "]"
    "<" = ">"
}
$scorea = @{
    ")" = 3
    "]" = 57
    "}" = 1197
    ">" = 25137
}
$score2 = @{
    ")" = 1
    "]" = 2
    "}" = 3
    ">" = 4
}
$score = 0
$sums = @()
foreach ($line in $arrayFromFile) {
    $FIFO = @()
    $incomplete = $true
    foreach ($item in $line.ToCharArray()) {
        if ($FIFO.Length -eq 0) {
            $top = "false"
        } else {
            $top = $FIFO | Select-Object -Last 1
        }

        
        $expected = $hash["$top"]
        $errorsigns = $hash.values | where-object{$_ -ne "$expected"}
        if ($item -eq $expected) {
            #Write-Host "ok $item  "
            if ($FIFO.Length -eq 1) {
                $FIFO = @()
            }else {
                $FIFO = $FIFO[0..($FIFO.length-2)]
            }
            

        }elseif ($item -in $errorsigns) {
            #Write-Host "break $item  "
            $score += $scorea["$item"]
            $incomplete = $false
            break
        }else {
            $FIFO += $item
        }
        #Write-Host "fifo $FIFO"
    }
    if ($incomplete) {
        #Write-Host "fifo $FIFO"
        $sum = 0 
        [array]::Reverse($FIFO)
        
        foreach($item in $FIFO){
            $key = $hash["$item"]
            $sum *= 5
            $sum += $score2["$key"]
        }
        $sums += $sum
    }
    
}
$score
$sumss = $sums | Sort-Object
