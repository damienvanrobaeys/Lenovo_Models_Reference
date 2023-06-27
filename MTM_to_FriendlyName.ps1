param(
$MTM
)

$URL = "https://download.lenovo.com/bsco/public/allModels.json"
$Get_Web_Content = Invoke-RestMethod -Uri $URL -Method GET
$Current_Model = ($Get_Web_Content | where-object {($_ -like "*$MTM*") -and ($_ -notlike "*-UEFI Lenovo*") -and ($_ -notlike "*dTPM*") -and ($_ -notlike "*Asset*") -and ($_ -notlike "*fTPM*")})[0]
$Get_FamilyName = ($Current_Model.name.split("("))[0]
$Get_FamilyName
