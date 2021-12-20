$Input1 = (Get-Content -Path 'Day14\Input.txt' -TotalCount 1).ToCharArray()


$Instructions = 100
$templates = @{}
Get-Content -Path 'Day14\Input.txt' -tail $Instructions | ForEach-Object{
    $pair, $result = $_.split(" -> ")
    $templates[$pair] = $result
}
$summary = @{}


$Npairs = @{}
for ($i = 0; $i -lt $Input1.Count - 1; $i++) {
    $test = -join ($Input1[$i],$Input1[$i+1])
    $Npairs["$test"] += 1
}
1..40 | %{
    $added = @()
    $addedtimes = @()
    $remove = @()
    $removetimes = @()
    foreach ($item in $Npairs.GetEnumerator()) {
        $key = $item.Name
        if ($templates.ContainsKey($key)) {
            $remove += $key
            $removetimes += $item.Value
            $add = $templates["$key"]
            $a1,$a2 = $key.ToCharArray()
            $added += -join ($a1,$add)
            $added += -join ($add,$a2)
            $addedtimes += @($item.Value,$item.Value)
            #$Npairs["$newkey1"]+= 1
            #$Npairs["$newkey2"]+= 1
        }
    }
    for ($i = 0; $i -lt $added.Count; $i++) {
        $newkey = $added[$i]
        $Npairs["$newkey"]+= $addedtimes[$i]
        if ($i -lt $remove.count) {
            $remove_t= $remove[$i]
            $Npairs["$remove_t"] -= $removetimes[$i]
        }
    }
}
$summary = @{}
foreach ($item in $Npairs.GetEnumerator()) {
    $a1,$a2 = $item.Name.ToCharArray()
    $summary["$a1"] += $item.Value/2
    $summary["$a2"] += $item.Value/2
}
$first = $Input1[0]
$last = $Input1[-1]
$summary["$first"] += 0.5
$summary["$last"] += 0.5
$summary.Values | Sort-Object




1..10 | foreach-object{
    $next = @()
    for ($i = 0; $i -lt $Input1.Count - 1; $i++) {
        $next += $Input1[$i]
        $test = -join ($Input1[$i],$Input1[$i+1])
        if ($templates[$test]) {
            $next += $templates[$test]
        }
    }
    $next += $Input1[-1]
    $Input1 = $next
}
$dummary = @{}
foreach ($char in $Input1) {
    $dummary["$char"] += 1
}
$dummary
function Goto-Next {
    param (
        $counter,
        $current
    )
    if ($counter -ge 10) {
        return 0
    }else {
        if ($dummary[$current]) {
            
        }
    }
}