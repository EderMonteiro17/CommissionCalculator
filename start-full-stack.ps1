#!/usr/bin/env pwsh

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  FCamara Commission Calculator - Full Stack" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Ensure PATH includes Node.js
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH","User")

# Check prerequisites
Write-Host "🔍 Checking prerequisites..." -ForegroundColor Yellow

try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js not found. Please install Node.js first." -ForegroundColor Red
    exit 1
}

try {
    $npmVersion = npm --version
    Write-Host "✅ npm: v$npmVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ npm not found. Please install npm first." -ForegroundColor Red
    exit 1
}

try {
    $dotnetVersion = dotnet --version
    Write-Host "✅ .NET: $dotnetVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ .NET not found. Please install .NET 8 SDK first." -ForegroundColor Red
    exit 1
}

Write-Host ""

# Start API Server
Write-Host "🚀 Starting .NET API Server..." -ForegroundColor Yellow
$apiPath = "c:\Users\eder\Documents\CommissionCalculator\api"
$apiProcess = Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location '$apiPath'; Write-Host 'FCamara API Server' -ForegroundColor Cyan; dotnet run" -PassThru -WindowStyle Normal

Write-Host "⏳ Waiting for API to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 8

# Test API
try {
    $testBody = @{
        localSalesCount = 1
        foreignSalesCount = 1
        averageSaleAmount = 100
    } | ConvertTo-Json
    
    $apiTest = Invoke-RestMethod -Uri "https://localhost:5000/api/commision/calculate" -Method POST -Body $testBody -ContentType "application/json" -SkipCertificateCheck -TimeoutSec 10
    Write-Host "✅ API Server is running at https://localhost:5000" -ForegroundColor Green
} catch {
    Write-Host "⚠️  API might still be starting up..." -ForegroundColor Yellow
}

Write-Host ""

# Install React dependencies if needed
Write-Host "📦 Checking React dependencies..." -ForegroundColor Yellow
$uiPath = "c:\Users\eder\Documents\CommissionCalculator\ui"
Set-Location $uiPath

if (-not (Test-Path "node_modules")) {
    Write-Host "📥 Installing React dependencies..." -ForegroundColor Yellow
    npm install
    Write-Host "✅ Dependencies installed" -ForegroundColor Green
} else {
    Write-Host "✅ Dependencies already installed" -ForegroundColor Green
}

Write-Host ""

# Start React Development Server
Write-Host "🚀 Starting React Development Server..." -ForegroundColor Yellow
$reactProcess = Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location '$uiPath'; Write-Host 'FCamara React App' -ForegroundColor Cyan; npm start" -PassThru -WindowStyle Normal

Write-Host "⏳ Waiting for React app to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 15

# Test React app
try {
    $reactTest = Invoke-WebRequest -Uri "http://localhost:3000" -TimeoutSec 10
    Write-Host "✅ React App is running at http://localhost:3000" -ForegroundColor Green
} catch {
    Write-Host "⚠️  React app might still be starting up..." -ForegroundColor Yellow
}

Write-Host ""

# Open browser
Write-Host "🌐 Opening application in browser..." -ForegroundColor Yellow
Start-Process "http://localhost:3000"

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "🎉 FCamara Commission Calculator is Ready!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Application URLs:" -ForegroundColor White
Write-Host "   Frontend (React): http://localhost:3000" -ForegroundColor Cyan
Write-Host "   Backend API:      https://localhost:5000" -ForegroundColor Cyan
Write-Host "   API Documentation: https://localhost:5000/swagger" -ForegroundColor Cyan
Write-Host ""
Write-Host "💼 Business Rules Implemented:" -ForegroundColor White
Write-Host "   FCamara Rates:    Local 20% | Foreign 35%" -ForegroundColor Green
Write-Host "   Competitor Rates: Local 2%  | Foreign 7.55%" -ForegroundColor Red
Write-Host ""
Write-Host "📝 Example Calculation (10 local + 10 foreign × £100):" -ForegroundColor White
Write-Host "   FCamara Commission:    £550.00" -ForegroundColor Green
Write-Host "   Competitor Commission: £95.50" -ForegroundColor Red
Write-Host "   FCamara Advantage:     £454.50" -ForegroundColor Green
Write-Host ""
Write-Host "🛠️  Tech Stack:" -ForegroundColor White
Write-Host "   Backend:  ASP.NET Core 8 Web API" -ForegroundColor Cyan
Write-Host "   Frontend: React 18 with Hooks" -ForegroundColor Cyan
Write-Host "   Runtime:  Node.js $nodeVersion" -ForegroundColor Cyan
Write-Host ""
Write-Host "To stop the servers, close the PowerShell windows or press Ctrl+C" -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to continue..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")