# MoMo Transaction API Testing Script (PowerShell)
# Author: Solomon Leek
# Description: Automated tests for Windows using PowerShell

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "MoMo Transaction API - Testing Suite" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$BaseUrl = "http://localhost:8000"
$Auth = "admin:password"
$WrongAuth = "admin:wrongpass"
$AuthBytes = [System.Text.Encoding]::UTF8.GetBytes($Auth)
$AuthBase64 = [System.Convert]::ToBase64String($AuthBytes)
$WrongAuthBytes = [System.Text.Encoding]::UTF8.GetBytes($WrongAuth)
$WrongAuthBase64 = [System.Convert]::ToBase64String($WrongAuthBytes)

# Test counters
$Passed = 0
$Failed = 0

function Print-Result {
    param([bool]$Success)
    if ($Success) {
        Write-Host "✓ PASSED" -ForegroundColor Green
        $script:Passed++
    } else {
        Write-Host "✗ FAILED" -ForegroundColor Red
        $script:Failed++
    }
    Write-Host ""
}

function Test-Endpoint {
    param(
        [string]$TestName,
        [string]$Method,
        [string]$Endpoint,
        [string]$Body = $null,
        [string]$AuthHeader,
        [int]$ExpectedStatus
    )
    
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Test: $TestName" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    
    try {
        $Headers = @{
            "Authorization" = "Basic $AuthHeader"
        }
        
        if ($Method -eq "POST" -or $Method -eq "PUT") {
            $Headers["Content-Type"] = "application/json"
        }
        
        $Params = @{
            Uri = "$BaseUrl$Endpoint"
            Method = $Method
            Headers = $Headers
        }
        
        if ($Body) {
            $Params["Body"] = $Body
        }
        
        $Response = Invoke-WebRequest @Params -ErrorAction SilentlyContinue
        $StatusCode = $Response.StatusCode
        
        Write-Host "HTTP Status: $StatusCode"
        Write-Host "Response:" -ForegroundColor Yellow
        $Response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10
        
        Print-Result ($StatusCode -eq $ExpectedStatus)
        
    } catch {
        $StatusCode = $_.Exception.Response.StatusCode.value__
        Write-Host "HTTP Status: $StatusCode"
        
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $responseBody = $reader.ReadToEnd()
            Write-Host "Response:" -ForegroundColor Yellow
            Write-Host $responseBody
        }
        
        Print-Result ($StatusCode -eq $ExpectedStatus)
    }
}

# Test 1: GET /transactions (Valid Auth)
Test-Endpoint -TestName "GET /transactions (Valid Auth)" `
    -Method "GET" `
    -Endpoint "/transactions" `
    -AuthHeader $AuthBase64 `
    -ExpectedStatus 200

# Test 2: GET /transactions (Invalid Auth)
Test-Endpoint -TestName "GET /transactions (Invalid Auth)" `
    -Method "GET" `
    -Endpoint "/transactions" `
    -AuthHeader $WrongAuthBase64 `
    -ExpectedStatus 401

# Test 3: GET /transactions/{id}
Test-Endpoint -TestName "GET /transactions/5" `
    -Method "GET" `
    -Endpoint "/transactions/5" `
    -AuthHeader $AuthBase64 `
    -ExpectedStatus 200

# Test 4: POST /transactions
$PostBody = @{
    type = "Send Money"
    amount = 25000
    sender = "256700000001"
    receiver = "256700000099"
    timestamp = "2026-01-22T16:00:00"
    status = "completed"
} | ConvertTo-Json

Test-Endpoint -TestName "POST /transactions" `
    -Method "POST" `
    -Endpoint "/transactions" `
    -Body $PostBody `
    -AuthHeader $AuthBase64 `
    -ExpectedStatus 201

# Test 5: POST with Missing Fields
$PostBodyIncomplete = @{
    type = "Send Money"
    sender = "256700000001"
} | ConvertTo-Json

Test-Endpoint -TestName "POST /transactions (Missing Fields)" `
    -Method "POST" `
    -Endpoint "/transactions" `
    -Body $PostBodyIncomplete `
    -AuthHeader $AuthBase64 `
    -ExpectedStatus 400

# Test 6: PUT /transactions/{id}
$PutBody = @{
    amount = 12000
    status = "refunded"
} | ConvertTo-Json

Test-Endpoint -TestName "PUT /transactions/3" `
    -Method "PUT" `
    -Endpoint "/transactions/3" `
    -Body $PutBody `
    -AuthHeader $AuthBase64 `
    -ExpectedStatus 200

# Test 7: DELETE /transactions/{id}
Test-Endpoint -TestName "DELETE /transactions/20" `
    -Method "DELETE" `
    -Endpoint "/transactions/20" `
    -AuthHeader $AuthBase64 `
    -ExpectedStatus 200

# Test 8: GET Non-existent Transaction
Test-Endpoint -TestName "GET /transactions/999 (Not Found)" `
    -Method "GET" `
    -Endpoint "/transactions/999" `
    -AuthHeader $AuthBase64 `
    -ExpectedStatus 404

# Test Summary
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "TEST SUMMARY" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Passed: $Passed" -ForegroundColor Green
Write-Host "Failed: $Failed" -ForegroundColor Red
Write-Host "==========================================" -ForegroundColor Cyan
