param(
[switch]$CSV,
[switch]$Grid
)	

If($CSV)
	{
		$Result_file = "$env:temp\MTM_to_FriendlyName.csv"	
	}

$URL = "https://download.lenovo.com/bsco/schemas/list.conf.txt"
# $OutFile = "$env:temp\Models_List.txt"
# Invoke-WebRequest -Uri $URL -OutFile $OutFile 
# $Get_Models = Get-Content $OutFile 

$Get_Web_Content = Invoke-RestMethod -Uri $URL -Method GET
$Get_Models = $Get_Web_Content -split "`r`n"
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

If($CSV)
	{
		$Models_Array | Export-CSV $Result_file -Delimiter ";" -NoTypeInformation
	}	
If($Grid)
	{
		$Models_Array | Out-Gridview
	}