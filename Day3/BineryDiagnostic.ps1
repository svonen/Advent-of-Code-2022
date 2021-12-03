[string[]]$arrayFromFile = Get-Content -Path 'Day3\Input.txt'
$bin_length =  $arrayFromFile[0].length
[int[]]$mostcommonvalue = New-Object int[] $bin_length
foreach($bin_num in $arrayFromFile){
    $bits = $bin_num.ToCharArray()
    0..($bin_length-1) | ForEach-Object {
        if ($bits[$_] -eq "0") {
            $mostcommonvalue[$_] -= 1
        } elseif ($bits[$_] -eq "1") {
            $mostcommonvalue[$_] += 1
        }
    }
}
[string] $gamma_string = ""
[string] $epsilon_string = ""
foreach ($bit in $mostcommonvalue){
    if ($bit -gt 0){
        $gamma_string += "1"
        $epsilon_string += "0"

    } else {
        $gamma_string += "0"
        $epsilon_string += "1"
    }
}

[convert]::ToInt32($gamma_string,2)*[convert]::ToInt32($epsilon_string,2)


$col = 0
$oxyge_data = $arrayFromFile
$most = $gamma_string[0]
[string]$oxygen = $most
1..$bin_length | ForEach-Object {
    $new_data = @()
    $validnumbers = 0
    foreach ($bin_num in $oxyge_data){
        $bits = $bin_num.ToCharArray()
        if ($bits[$col] -eq $most) {
            $new_data += $bin_num
            $validnumbers += 1
        }
    }
    $oxyge_data = $new_data
    $mostcommon = 10
    if ($validnumbers -le 10) {
        $validnumbers
        $col
        $new_data
    }
    if ($validnumbers -eq 1 ) {
        write-output $bin_num
        [convert]::ToInt32($bin_num,2)
        break
    }else {
        $col += 1
        foreach($bin_num in $oxyge_data){
            $bits = $bin_num.ToCharArray()
            if ($bits[$col] -eq "0") {
                $mostcommon -= 1
            } elseif ($bits[$col] -eq "1") {
                $mostcommon += 1
            }
        }
        if ($mostcommon -ge 10) {
            $most = "1"
        }else {
            $most = "0"
        }
    }
}


$col = 0
$CO2_data = $arrayFromFile
$least = $epsilon_string[0]
1..$bin_length | ForEach-Object {
    $new_data = @()
    $validnumbers = 0
    $least
    foreach ($bin_num2 in $CO2_data){
        $bits = $bin_num2.ToCharArray()
        if ($bits[$col] -eq $least) {
            $new_data += $bin_num2
            $validnumbers += 1
        }
    }
    $CO2_data = $new_data
    if ($validnumbers -le 10) {
        $col
        $validnumbers
        $new_data
    }
    $leastcommon = 10
    if ($validnumbers -eq 1 ) {
        write-output $bin_num2
        [convert]::ToInt32($bin_num2,2)
        break
    }else {
        $col += 1
        foreach($bin_num2 in $CO2_data){
            $bits = $bin_num2.ToCharArray()
            if ($bits[$col] -eq "0") {
                $leastcommon -= 1
            } elseif ($bits[$col] -eq "1") {
                $leastcommon += 1
            }
        }
        if ($leastcommon -lt 10) {
            $least = "1"
        }else {
            $least = "0"
        }
    }
}
[convert]::ToInt32($bin_num2,2)*[convert]::ToInt32("100111001101",2)