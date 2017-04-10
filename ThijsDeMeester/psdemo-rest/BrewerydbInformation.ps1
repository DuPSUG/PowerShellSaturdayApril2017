<#
  brewerydb docs
  start-process "http://www.brewerydb.com/developers/docs"
#>

#region key
$BreweryDBkey = get-content  C:\Development\psdemo-rest\BreweryDBkey.txt
#endregion

#region get empty call
$url = "http://api.brewerydb.com/v2/?key=$BreweryDBkey"

$RestResult = invoke-restmethod -Uri $url -Method Get
#endregion