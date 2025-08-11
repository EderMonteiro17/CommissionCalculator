# Commission Calculator Startup Script
Write-Host "🚀 Starting FCamara Commission Calculator..." -ForegroundColor Green

# Start API in background
Write-Host "📡 Starting API Server..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'c:\Users\eder\Documents\CommissionCalculator\api'; dotnet run"

# Wait a moment for API to start
Start-Sleep -Seconds 3

# Start React App
Write-Host "🌐 Starting React App..." -ForegroundColor Yellow
Set-Location "c:\Users\eder\Documents\CommissionCalculator\ui"
npm start

Write-Host "✅ Application started successfully!" -ForegroundColor Green
Write-Host "API: http://localhost:5111" -ForegroundColor Cyan
Write-Host "Web App: http://localhost:3000" -ForegroundColor Cyan