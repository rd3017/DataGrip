$myArray = Get-ChildItem -path "C:\program files\JetBrains"
$myStack = New-Object System.Collections.Stack
$highestDataGripVersion = "1.1.1"


# push all the installed datagrip versions to stack($myStack) in c:\program files\JetBrains
for($i = 0; $i -lt $myArray.length; $i++) {
	
	# check if any datagrip folders exists
	if($myArray[$i].name -like '*DataGrip*') {
		$myStack.Push($myArray[$i].name.substring($myArray[$i].name.indexof(" ") +1) )
		
		if( [version]$myStack.Peek() -gt $highestDataGripVersion ) {
			$highestDataGripVersion = $myStack.Peek()
		}
	}	
}

###$highestDataGripVersion

# go through stack and uninstall any older datagrip versions
$myTemp
while($myStack.Count -gt 0) {
	$myTemp = $myStack.Pop()
	
	# verify if installed datagrip version < latest datagrip AND uninstall executable exists
	if( [Version]$myTemp -lt [Version]$highestDataGripVersion ) {
		$myCMDCommand =   " ""C:\Program Files\JetBrains\DataGrip $myTemp\bin\uninstall.exe"" /S"
		
		# run string command to uninstall DataGrip
		cmd.exe /c $myCMDCommand
	}	
}
