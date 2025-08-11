# Commission Calculator Stop Script
Write-Host "🛑 Stopping FCamara Commission Calculator..." -ForegroundColor Yellow

# Stop all dotnet processes (API)
$dotnetProcesses = Get-Process | Where-Object {$_.ProcessName -eq "dotnet"}
if ($dotnetProcesses) {
    Write-Host "📡 Stopping API Server..." -ForegroundColor Red
    $dotnetProcesses | Stop-Process -Force
    Write-Host "✅ API Server stopped" -ForegroundColor Green
} else {
    Write-Host "ℹ️ No API processes running" -ForegroundColor Gray
}

# Stop all node processes (React App)
$nodeProcesses = Get-Process | Where-Object {$_.ProcessName -eq "node"}
if ($nodeProcesses) {
    Write-Host "🌐 Stopping React App..." -ForegroundColor Red
    $nodeProcesses | Stop-Process -Force
    Write-Host "✅ React App stopped" -ForegroundColor Green
} else {
    Write-Host "ℹ️ No React processes running" -ForegroundColor Gray
}

Write-Host "🎯 All Commission Calculator processes stopped!" -ForegroundColor Green