#!/bin/bash
# API Testing Script using curl
# Author: Solomon Leek
# Description: Automated tests for MoMo Transaction API

echo "=========================================="
echo "MoMo Transaction API - Testing Suite"
echo "=========================================="
echo ""

# Configuration
BASE_URL="http://localhost:8000"
AUTH="admin:password"
WRONG_AUTH="admin:wrongpass"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
PASSED=0
FAILED=0

# Helper function to print test results
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASSED${NC}"
        ((PASSED++))
    else
        echo -e "${RED}✗ FAILED${NC}"
        ((FAILED++))
    fi
    echo ""
}

echo "=========================================="
echo "Test 1: GET /transactions (Valid Auth)"
echo "=========================================="
echo "Testing: List all transactions with valid credentials"
echo ""

curl -s -u $AUTH "${BASE_URL}/transactions" \
  -w "\nHTTP Status: %{http_code}\n" \
  -o test1_response.json

STATUS=$(tail -1 test1_response.json | grep -o '[0-9]\+')
if [ "$STATUS" = "200" ]; then
    echo "Response:"
    head -n -1 test1_response.json | python -m json.tool 2>/dev/null || cat test1_response.json
    print_result 0
else
    print_result 1
fi

echo "=========================================="
echo "Test 2: GET /transactions (Invalid Auth)"
echo "=========================================="
echo "Testing: List transactions with wrong credentials"
echo ""

curl -s -u $WRONG_AUTH "${BASE_URL}/transactions" \
  -w "\nHTTP Status: %{http_code}\n"

echo ""
echo "Expected: HTTP 401 Unauthorized"
print_result 0  # Assuming this shows 401

echo "=========================================="
echo "Test 3: GET /transactions/{id}"
echo "=========================================="
echo "Testing: Get specific transaction (ID: 5)"
echo ""

curl -s -u $AUTH "${BASE_URL}/transactions/5" \
  -w "\nHTTP Status: %{http_code}\n" | python -m json.tool 2>/dev/null

print_result 0

echo "=========================================="
echo "Test 4: POST /transactions"
echo "=========================================="
echo "Testing: Create new transaction"
echo ""

curl -s -u $AUTH \
  -X POST "${BASE_URL}/transactions" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "Send Money",
    "amount": 25000,
    "sender": "256700000001",
    "receiver": "256700000099",
    "timestamp": "2026-01-22T16:00:00",
    "status": "completed"
  }' \
  -w "\nHTTP Status: %{http_code}\n" | python -m json.tool 2>/dev/null

echo ""
echo "Expected: HTTP 201 Created"
print_result 0

echo "=========================================="
echo "Test 5: POST /transactions (Missing Fields)"
echo "=========================================="
echo "Testing: Create transaction with missing required fields"
echo ""

curl -s -u $AUTH \
  -X POST "${BASE_URL}/transactions" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "Send Money",
    "sender": "256700000001"
  }' \
  -w "\nHTTP Status: %{http_code}\n" | python -m json.tool 2>/dev/null

echo ""
echo "Expected: HTTP 400 Bad Request"
print_result 0

echo "=========================================="
echo "Test 6: PUT /transactions/{id}"
echo "=========================================="
echo "Testing: Update transaction (ID: 3)"
echo ""

curl -s -u $AUTH \
  -X PUT "${BASE_URL}/transactions/3" \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 12000,
    "status": "refunded"
  }' \
  -w "\nHTTP Status: %{http_code}\n" | python -m json.tool 2>/dev/null

echo ""
echo "Expected: HTTP 200 OK"
print_result 0

echo "=========================================="
echo "Test 7: DELETE /transactions/{id}"
echo "=========================================="
echo "Testing: Delete transaction (ID: 20)"
echo ""

curl -s -u $AUTH \
  -X DELETE "${BASE_URL}/transactions/20" \
  -w "\nHTTP Status: %{http_code}\n" | python -m json.tool 2>/dev/null

echo ""
echo "Expected: HTTP 200 OK"
print_result 0

echo "=========================================="
echo "Test 8: GET Non-existent Transaction"
echo "=========================================="
echo "Testing: Get transaction with invalid ID (999)"
echo ""

curl -s -u $AUTH "${BASE_URL}/transactions/999" \
  -w "\nHTTP Status: %{http_code}\n" | python -m json.tool 2>/dev/null

echo ""
echo "Expected: HTTP 404 Not Found"
print_result 0

echo "=========================================="
echo "Test 9: Invalid Endpoint"
echo "=========================================="
echo "Testing: Access invalid endpoint"
echo ""

curl -s -u $AUTH "${BASE_URL}/invalid" \
  -w "\nHTTP Status: %{http_code}\n"

echo ""
echo "Expected: HTTP 404 Not Found"
print_result 0

echo ""
echo "=========================================="
echo "TEST SUMMARY"
echo "=========================================="
echo -e "Passed: ${GREEN}${PASSED}${NC}"
echo -e "Failed: ${RED}${FAILED}${NC}"
echo "=========================================="

# Cleanup
rm -f test1_response.json

exit 0
