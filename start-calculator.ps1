Write-Host "====================================" -ForegroundColor Cyan
Write-Host "FCamara Commission Calculator" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Starting API server..." -ForegroundColor Yellow
Write-Host ""

# Start API in background
$apiPath = "c:\Users\eder\Documents\CommissionCalculator\api"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location '$apiPath'; dotnet run" -WindowStyle Normal

Write-Host "Waiting for API to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "Opening calculator in your default browser..." -ForegroundColor Yellow
Write-Host ""

# Open the HTML file in default browser
$htmlPath = "c:\Users\eder\Documents\CommissionCalculator\standalone-calculator.html"
Start-Process $htmlPath

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "API is running at: https://localhost:5000" -ForegroundColor White
Write-Host "Calculator opened in your browser" -ForegroundColor White
Write-Host ""
Write-Host "Your example (10 local + 10 foreign × £100):" -ForegroundColor Cyan
Write-Host "- FCamara Commission: £550.00" -ForegroundColor Green
Write-Host "- Competitor Commission: £95.50" -ForegroundColor Red
Write-Host "- FCamara Advantage: £454.50" -ForegroundColor Green
Write-Host ""
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")