Function Get-NavDockerRepositoryName{
    Write-Output "microsoft/dynamics-nav"
}
Function Get-AuthorizationHeader{
    [Cmdletbinding()]
    [OutputType([hashtable])]
    Param()

    $AuthResponse = Invoke-RestMethod `
                        -Method Get `
                        -Uri ("https://auth.docker.io/token?service=registry.docker.io&scope=repository:{0}:pull" -f (Get-NavDockerRepositoryName)) `
                        -ErrorAction:$ErrorActionPreference

    Write-Output  @{"Authorization" = "Bearer $($AuthResponse.access_token)"}
}
Function Get-NavDockerImage{
    [Cmdletbinding()]
    [OutputType([string[]])]
    Param()

    $RepositoryName = Get-NavDockerRepositoryName
    $Response = Invoke-RestMethod `
                    -Method Get `
                    -Uri ("https://index.docker.io/v2/{0}/tags/list" -f $RepositoryName) `
                    -Headers (Get-AuthorizationHeader -ErrorAction:$ErrorActionPreference) `
                    -ErrorAction:$ErrorActionPreference
                    
    $Response.tags | ForEach-Object{
        Write-Output "$($RepositoryName):$_"
    }
}
Function Test-NavDockerImage{
    [Cmdletbinding()]
    [OutputType([bool])]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipeline)][string]$Name
    )

    begin
    {
        $Images = Get-NavDockerImage -ErrorAction:$ErrorActionPreference
    }

    process
    {
        Write-Output (($Images | Where-Object {$_ -eq $Name}) -ne $null)
    }

    end{}
}