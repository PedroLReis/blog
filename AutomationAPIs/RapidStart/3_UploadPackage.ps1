$ContainerName = 'sandbox'
$BaseUri = "http://$($ContainerName):7048/nav/api/microsoft/automation/beta/"
$CompanyId = 'a31c2b21-c5f0-4cf1-9b08-611eb939d5da'
$PackageCode = 'MyPackage'
$PackageFile = Join-Path $PSScriptRoot 'MyPackage.rapidstart'

$Uri = $BaseUri + "companies($CompanyId)/configurationPackages('$PackageCode')/file('$PackageCode')/content"

$Headers = @{}
$Headers.Add('If-Match','*')
$Headers.Add('Content-Type','application/octet-stream')
$Headers.Add('accept-encoding','gzip, deflate')

Invoke-RestMethod -Uri $Uri -Method Patch -Headers $Headers -InFile $PackageFile -UseDefaultCredentials
