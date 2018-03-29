Function Test-NavDockerImage{
    [Cmdletbinding()]
    [OutputType([bool])]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipeline)][string]$DockerImageName
    )

    begin
    {
        $Images = Get-NavDockerImage -ErrorAction:$ErrorActionPreference
    }

    process
    {
        Write-Output (($Images | Where-Object {$_ -eq $DockerImageName}) -ne $null)
    }

    end{}
}