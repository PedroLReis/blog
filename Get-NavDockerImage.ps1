Function Get-NavDockerImage{
    [Cmdletbinding()]
    [OutputType([string[]])]
    Param()

    $RepositoryName = "microsoft/dynamics-nav"
    $AuthResponse = Invoke-RestMethod `
                        -Method Get `
                        -Uri ("https://auth.docker.io/token?service=registry.docker.io&scope=repository:{0}:pull" -f $RepositoryName) `
                        -ErrorAction:$ErrorActionPreference

    $Headers = @{"Authorization" = "Bearer $($AuthResponse.access_token)"}

    $Response = Invoke-RestMethod `
                    -Method Get `
                    -Uri ("https://index.docker.io/v2/{0}/tags/list" -f $RepositoryName) `
                    -Headers $Headers `
                    -ErrorAction:$ErrorActionPreference
                    
    $Response.tags | ForEach-Object{
        Write-Output "$($RepositoryName):$_"
    }
}