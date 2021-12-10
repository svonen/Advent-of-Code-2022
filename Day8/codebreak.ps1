$Input = (Get-Content -Path 'Day8\Input.txt').split(' | ')

$Output = @()
for ($i = 1; $i -lt $Input.Count; $i+=2) {
    $Array = $Input[$i].Split()
    $Output += $Array
}
$EasyNumbers= 0
foreach ($item in $Output) {
    switch ($item.Length) {
        2 { $EasyNumbers++}
        3 { $EasyNumbers++}
        4 { $EasyNumbers++}
        7 { $EasyNumbers++}   
        Default {}
    }
}

$character = ('a','b','c','d','e','f','g')
$Inputarray =  New-Object -TypeName "System.Collections.ArrayList"
for ($i = 0; $i -lt $Input.Count; $i+=2) {
    $Array = $Input[$i].Split()
    $Inputarray.Add($Array)
}
$Outputtarray =  New-Object -TypeName "System.Collections.ArrayList"
for ($i = 1; $i -lt $Input.Count; $i+=2) {
    $Array = $Input[$i].Split()
    $Outputtarray.Add($Array)
}

function get-zero {
    param (
        $Code,
        $six,
        $nine
    )
    foreach ($item in $Code){
        if ($item.length -eq 6 -and $item -ne $six -and $item -ne $nine) {
            return $item
        }
    }
}
function get-one {
    param (
        $Code
    )
    foreach ($item in $Code){
        if ($item.length -eq 2) {
            return $item
        }
    }
}
function get-two {
    param (
        $Code
    )
    $occurances = (0,0,0,0,0,0,0)
    foreach ($item in $Code){
        $car = $item.ToCharArray()
        $car | ForEach-Object {
            switch ($_) {
                'a' { $occurances[0]++}
                'b' { $occurances[1]++}
                'c' { $occurances[2]++}
                'd' { $occurances[3]++}  
                'e' { $occurances[4]++}
                'f' { $occurances[5]++}
                'g' { $occurances[6]++}
                Default {}
            }
        }
    }
    0..6 | ForEach-Object {
        if ($occurances[$_] -eq 9) {
            $fval = $character[$_]
        }
    }
    foreach ($word in $Code){
        $car = $word.ToCharArray()
        if ($word.contains($fval)) {
        }else {
            return $word
        }
    }
}

function get-three {
    param (
        $Code,
        $two,
        $five
    )
    foreach ($item in $Code){
        if ($item.length -eq 5 -and $item -ne $five -and $item -ne $two) {
            return $item
        }
    }
}


function get-four {
    param (
        $Code
    )
    foreach ($item in $Code){
        if ($item.length -eq 4) {
            return $item
        }
    }
}

function get-five {
    param (
        $Code,
        $one,
        $six
    )
    $occurances = (0,0,0,0,0,0,0)
    foreach ($item in $Code){
        $car = $item.ToCharArray()
        $car | ForEach-Object {
            switch ($_) {
                'a' { $occurances[0]++}
                'b' { $occurances[1]++}
                'c' { $occurances[2]++}
                'd' { $occurances[3]++}  
                'e' { $occurances[4]++}
                'f' { $occurances[5]++}
                'g' { $occurances[6]++}
                Default {}
            }
        }
    }
    0..6 | ForEach-Object {
        if ($occurances[$_] -eq 8 -and $one.contains($character[$_])) {
            $cval = $character[$_]
        }
    }
    foreach ($word in $Code){
        $car = $word.ToCharArray()
        if (!$word.contains($cval) -and $word.length -eq 5) {
            return $word
        }
    }
}

function get-six {
    param (
        $Code,
        $nine
    )
    $occurances = (0,0,0,0,0,0,0)
    foreach ($item in $Code){
        $car = $item.ToCharArray()
        $car | ForEach-Object {
            switch ($_) {
                'a' { $occurances[0]++}
                'b' { $occurances[1]++}
                'c' { $occurances[2]++}
                'd' { $occurances[3]++}  
                'e' { $occurances[4]++}
                'f' { $occurances[5]++}
                'g' { $occurances[6]++}
                Default {}
            }
        }
    }
    0..6 | ForEach-Object {
        if ($occurances[$_] -eq 8 -and $one.contains($character[$_])) {
            $cval = $character[$_]
        }
    }
    foreach ($item in $Code){
        if (!$item.contains($cval) -and $item.length -eq 6 -and $item -ne $nine) {
            return $item
        }
    }
}
function get-seven {
    param (
        $Code
    )
    foreach ($item in $Code){
        if ($item.length -eq 3) {
            return $item
        }
    }
}
function get-eigth {
    param (
        $Code
    )
    foreach ($item in $Code){
        if ($item.length -eq 7) {
            return $item
        }
    }
}
function get-nine {
    param (
        $Code,
        $four
    )
    $afour = $four.ToCharArray()
    foreach ($item in $Code){
        if ($item.length -eq 6) {
            $test = 0
            foreach ($x in $afour){
                if ($item.Contains($x)){
                    $test++
                }
            }
            if ($test -eq 4) {
                return $item
            }
        }
    }
}
$Counter = 0
0..($Inputarray.length.Length-1) | ForEach-Object {
    $sequence =  $Inputarray[$_]
    $Lookup = @{"test" = 0}
    $one = get-one -Code $Sequence
    $ones = -join ($one.TocharArray()| Sort-Object)
    $Lookup[$ones] = "1" 
    $two = get-two -Code $Sequence
    $twos = -join ($two.TocharArray()| Sort-Object)
    $Lookup[$twos] = "2"
    $four = get-four -Code $Sequence
    $fours = -join ($four.TocharArray() | Sort-Object)
    $Lookup[$fours] = "4"
    $seven = get-seven -Code $Sequence
    $sevens = -join ($seven.TocharArray()| Sort-Object)
    $Lookup[$sevens] = "7"
    $eight = get-eigth -Code $Sequence
    $eights = -join ($eight.TocharArray()| Sort-Object)
    $Lookup[$eights]= "8"
    $nine = get-nine -Code $Sequence -four $four
    $nines = -join ($nine.TocharArray()| Sort-Object)
    $Lookup[$nines] = "9"
    $six = get-six -Code $Sequence -nine $nine
    $sixs = -join ($six.TocharArray()| Sort-Object)
    $Lookup[$sixs] = "6"
    $zero = get-zero -code $Sequence -six $six -nine $nine
    $zeros = -join ($zero.TocharArray()| Sort-Object)
    $Lookup[$zeros] = "0"
    $five = get-five -Code $Sequence -one $one -six $six
    $fives = -join ($five.TocharArray()| Sort-Object)
    $Lookup[$fives] = "5"
    $three = get-three -code $sequence -five $five -two $two
    $threes = -join ($three.TocharArray()| Sort-Object)
    $Lookup[$threes] = "3"
    
    $answer = ""
    foreach ($number in $Outputtarray[$_]){
        $key = $number.TocharArray() | sort-object
        $key = -join $key
        $answer += $Lookup[$key]

        #$x = $Lookup[$key]
        #write-host "$key  and $x"
        
    }
    $counter += [int]$answer
}
$counter 