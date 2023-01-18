$URL = "https://download.lenovo.com/bsco/schemas/list.conf.txt"
$OutFile = "$env:temp\Models_List.txt"
Invoke-WebRequest -Uri $URL -OutFile $OutFile 
$Get_Models = Get-Content $OutFile 
$Models_Array = @()
ForEach($Model in $Get_Models | where-object { $_ -like "*(*"})
	{
		$Get_FamilyName = ($Model.split("("))[0]
		$Get_MTM = (($Model.split("("))[1]).replace(").ini","")
		$Obj = New-Object PSObject
		Add-Member -InputObject $Obj -MemberType NoteProperty -Name "FamilyName" -Value $Get_FamilyName
		Add-Member -InputObject $Obj -MemberType NoteProperty -Name "MTM" -Value $Get_MTM	
		$Models_Array += $Obj			
	}
$Models_Array	
