[int[]]$InitialState = (Get-Content -Path 'Day6\Input.txt').split(',')
$EndDay = 256
$Lookup = @{"0" = 0}
function Get-Babies {
    param (
        $DaysLeft,
        $Counter
    )
    $Babies = 0
    $continue = $true
    Do{
        $Counter--
        $DaysLeft--
        if ($DaysLeft -lt 0) {
            #write-host "Done"
            $continue = $false
        }elseif ($Counter -lt 0) {
            $Counter = 6
            $DaysLeftForChild = $DaysLeft + 1 
            if ($Lookup[$DaysLeftForChild.ToString()]) {
            }else {
                $Lookup[$DaysLeftForChild.ToString()] += Get-Babies -DaysLeft $DaysLeftForChild -Counter 9
            }
            $Grandchildren = $Lookup[$DaysLeftForChild.ToString()]
            $Babies += 1 + $Grandchildren
        }
        #$Day = 18 - $DaysLeft
        #write-host "after day $Day counter $Counter"
        
    } While ($continue)
    return $Babies
}


$TotalFish = 0
$Array = (0,0,0,0,0,0)
1..6 | ForEach-Object {
    $Array[$_-1]+= Get-Babies -DaysLeft $EndDay -Counter $_
}
foreach ($Fish in $InitialState){
    $TotalFish++
    $TotalFish += $Array[$Fish-1]
}
$TotalFish
