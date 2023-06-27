param(
[switch]$CSV,
[switch]$Grid
)	

$URL = "https://download.lenovo.com/bsco/public/allModels.json"
$Get_Web_Content = Invoke-RestMethod -Uri $URL -Method GET
$Models_Array = @()
ForEach($Model in $Get_Web_Content | where-object {($_ -notlike "*-UEFI Lenovo*") -and ($_ -notlike "*dTPM*") -and ($_ -notlike "*Asset*") -and ($_ -notlike "*fTPM*")})
	{
		$Model_Value = $Model.name
		$Model_Value = ($Model_Value.split(")"))[0]
		$Get_FamilyName = ($Model_Value.split("("))[0]
		$Get_MTM = (($Model_Value.split("("))[1])

		$Obj = New-Object PSObject
		Add-Member -InputObject $Obj -MemberType NoteProperty -Name "FamilyName" -Value $Get_FamilyName
		Add-Member -InputObject $Obj -MemberType NoteProperty -Name "MTM" -Value $Get_MTM
		$Models_Array += $Obj	
		$Models = $Models_Array | sort -Property FamilyName -Unique
	}	

If($CSV)
	{
		$Result_file = "$env:temp\MTM_to_FriendlyName.csv"		
		$Models | Export-CSV $Result_file -Delimiter ";" -NoTypeInformation
	}	
If($Grid)
	{
		$Models | Out-Gridview
	}