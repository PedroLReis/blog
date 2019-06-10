$ContainerName = 'sandbox'
$BaseUri = "http://$($ContainerName):7048/nav/api/microsoft/automation/beta/"
$CompanyId = 'a31c2b21-c5f0-4cf1-9b08-611eb939d5da'
$PackageCode = 'MyPackage'

$Uri = $BaseUri + "companies($CompanyId)/configurationPackages('$PackageCode')"

$Result = Invoke-RestMethod -Method Get -Uri $Uri -UseDefaultCredentials

$Result.importStatus
$Result.applyStatus