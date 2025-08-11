@echo off
echo ====================================
echo FCamara Commission Calculator
echo ====================================
echo.
echo Starting API server...
echo.

cd /d "c:\Users\eder\Documents\CommissionCalculator\api"
start "FCamara API" cmd /k "dotnet run"

echo Waiting for API to start...
timeout /t 5 /nobreak >nul

echo.
echo Opening calculator in your default browser...
echo.

start "" "c:\Users\eder\Documents\CommissionCalculator\standalone-calculator.html"

echo.
echo ====================================
echo Setup Complete!
echo ====================================
echo.
echo API is running at: https://localhost:5000
echo Calculator opened in your browser
echo.
echo Press any key to close this window...
pause >nul