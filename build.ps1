# build.ps1
param(
    [string]$Version = "4.1.1",
    [string]$Revision = "1",
    [string]$Username = "ТВОЙ_USERNAME"
)

$tag1 = "marketapp-client-ubuntu:${Version}-${Revision}"
$tag2 = "${Username}/marketapp-client-ubuntu:${Version}-${Revision}"
$tag3 = "${Username}/marketapp-client-ubuntu:${Version}"
$tag4 = "${Username}/marketapp-client-ubuntu:latest"

Write-Host "Building with tags:" -ForegroundColor Green
Write-Host "  $tag1"
Write-Host "  $tag2"
Write-Host "  $tag3"
Write-Host "  $tag4"

docker build `
  -t $tag1 `
  -t $tag2 `
  -t $tag3 `
  -t $tag4 `
  .

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build OK" -ForegroundColor Green
    Write-Host "Push with: docker push ${Username}/marketapp-client-ubuntu --all-tags" -ForegroundColor Yellow
}