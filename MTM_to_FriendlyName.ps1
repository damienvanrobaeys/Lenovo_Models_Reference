param(
$MTM
)

$URL = "https://download.lenovo.com/bsco/schemas/list.conf.txt"
# $OutFile = "$env:temp\Models_List.txt"
# Invoke-WebRequest -Uri $URL -OutFile $OutFile 
$Get_Web_Content = Invoke-RestMethod -Uri $URL -Method GET
$Get_Models = $Get_Web_Content -split "`r`n"
$Get_Models = Get-Content $OutFile | where-object { $_ -like "*$MTM*"}
$Get_FamilyName = ($Get_Models.split("("))[0]
$Get_FamilyName