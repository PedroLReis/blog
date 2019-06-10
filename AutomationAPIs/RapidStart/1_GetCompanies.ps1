$ContainerName = 'sandbox'
$BaseUri = "http://$($ContainerName):7048/nav/api/microsoft/automation/beta/"

$Uri = $BaseUri + "companies"

$Result = Invoke-RestMethod -Method Get -Uri $Uri -UseDefaultCredentials

$Result.value[0].id