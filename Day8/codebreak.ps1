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
get-two -code $Inputarray[0]

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
        if (!$word.contains($cval) -and $word -ne $six) {
            return $word
        }
    }
}
get-five -Code $Inputarray[0] -one "ab" -six "cdfgeb"

function get-six {
    param (
        $Code,
        $one
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
        if ($item.length -eq 6 -and !$item.contains($cval)) {
            return $item
        }
    }
}
get-six -Code $Inputarray[0] -one "ab"
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
get-nine -Code $Inputarray[0] -four "eafb"