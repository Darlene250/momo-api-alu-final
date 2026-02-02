# MoMo Transaction REST API

A secure REST API for managing Mobile Money (MoMo) transaction records parsed from SMS data. Built using pure Python (http.server) with Basic Authentication, CRUD operations, and Data Structures & Algorithms (DSA) performance analysis.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Team Members & Contributions](#team-members--contributions)
4. [Prerequisites](#prerequisites)
5. [Installation & Setup](#installation--setup)
6. [Running the Server](#running-the-server)
7. [API Endpoints](#api-endpoints)
8. [Authentication](#authentication)
9. [Testing the API](#testing-the-api)
10. [DSA Performance Comparison](#dsa-performance-comparison)
11. [Project Structure](#project-structure)
12. [Security Considerations](#security-considerations)
13. [Screenshots](#screenshots)
14. [Documentation](#documentation)

---

## Project Overview

This project implements a REST API that:
- Parses SMS transaction data from XML format (`modified_sms_v2.xml`)
- Converts records to JSON format for API consumption
- Provides secure CRUD endpoints with Basic Authentication
- Demonstrates DSA efficiency comparison (Linear Search vs Dictionary Lookup)

**Course:** Building and Securing a REST API  
**Submission Date:** January 24, 2026

---

## Features

- ✅ **XML to JSON Parsing** - Parse mobile money SMS transaction data
- ✅ **Full CRUD Operations** - Create, Read, Update, Delete transactions
- ✅ **Basic Authentication** - Secure endpoints with username/password
- ✅ **Error Handling** - Proper HTTP status codes and error messages
- ✅ **CORS Support** - Cross-origin requests enabled
- ✅ **DSA Analysis** - Performance comparison of search algorithms

---

## Team Members & Contributions

| Name | Role | Contributions |
|------|------|---------------|
| **Darlene Ayinkamiye** | Team Leader & Backend Developer | REST API server (`api/server.py`), CRUD endpoints (PUT, DELETE), Authentication (`api/auth.py`), DSA comparison (`dsa/search_comparison.py`), Project coordination |
| **Chely Kelvin Sheja** | Data Engineer & QA | XML parsing (`dsa/parser.py`), GET endpoints, Data structure design, Testing scripts, API documentation (`docs/api_docs.md`) |
| **Solomon Leek** | Security & Documentation | Authentication module, Authorization handling, Security documentation, Test verification |

📋 **[View Full Team Participation Sheet](team_participation.md)**

---

## Prerequisites

- **Python 3.7+** (tested on Python 3.10)
- **curl** or **Postman** (for testing)
- No additional packages required (uses Python standard library only)

---

## Installation & Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/Darlene250/momo-api-alu-final.git
cd momo-api-alu-final
```

### Step 2: Verify Python Installation

```bash
python --version
# Should output Python 3.7 or higher
```

### Step 3: Verify Project Structure

Ensure all required files are present:
```bash
ls -la
# Should see: api/, data/, docs/, dsa/, screenshots/, tests/, README.md
```

**No pip install required** - This project uses only Python's standard library.

---

## Running the Server

### Start the API Server

```bash
python api/server.py
```

**Expected Output:**
```
Loading transactions from XML...
Loaded 22 transactions
Server running on http://localhost:8000
Press Ctrl+C to stop
```

The server will run on `http://localhost:8000`

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/transactions` | List all transactions |
| `GET` | `/transactions/{id}` | Get a specific transaction by ID |
| `POST` | `/transactions` | Create a new transaction |
| `PUT` | `/transactions/{id}` | Update an existing transaction |
| `DELETE` | `/transactions/{id}` | Delete a transaction |

**Full API documentation:** [docs/api_docs.md](docs/api_docs.md)

---

## Authentication

All endpoints require **Basic Authentication**.

### Default Credentials

| Username | Password |
|----------|----------|
| `admin` | `password` |
| `user1` | `test123` |
| `developer` | `devpass` |

### Using Authentication with curl

```bash
curl -u admin:password http://localhost:8000/transactions
```

### Using Authentication with Postman

1. Go to **Authorization** tab
2. Select **Basic Auth** from dropdown
3. Enter username: `admin`, password: `password`

---

## Testing the API

### Test 1: GET All Transactions (with authentication)

```bash
curl -u admin:password http://localhost:8000/transactions
```

### Test 2: GET Single Transaction

```bash
curl -u admin:password http://localhost:8000/transactions/1
```

### Test 3: POST - Create New Transaction

```bash
curl -u admin:password -X POST http://localhost:8000/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "type": "Send Money",
    "amount": 5000,
    "sender": "250780000001",
    "receiver": "250780000002",
    "timestamp": "2026-01-22T14:00:00",
    "status": "completed"
  }'
```

### Test 4: PUT - Update Transaction

```bash
curl -u admin:password -X PUT http://localhost:8000/transactions/1 \
  -H "Content-Type: application/json" \
  -d '{"amount": 7500, "status": "refunded"}'
```

### Test 5: DELETE - Remove Transaction

```bash
curl -u admin:password -X DELETE http://localhost:8000/transactions/1
```

### Test 6: Unauthorized Request (wrong credentials)

```bash
curl -u admin:wrongpassword http://localhost:8000/transactions
# Returns 401 Unauthorized
```

### Run Automated Tests

```bash
# Bash (Linux/Mac)
bash tests/test_api.sh

# PowerShell (Windows)
powershell tests/test_api.ps1
```

---

## DSA Performance Comparison

This project compares two search methods for finding transactions by ID:

### Run the Comparison

```bash
python dsa/search_comparison.py
```

### Search Methods Compared

| Method | Time Complexity | Description |
|--------|----------------|-------------|
| **Linear Search** | O(n) | Iterates through list sequentially |
| **Dictionary Lookup** | O(1) | Direct key-based access using hash table |

### Results Summary

The dictionary lookup is approximately **30x faster** than linear search for our dataset of 20+ records.

### Why Dictionary Lookup is Faster

1. **Hash Table**: Dictionaries use hash tables with O(1) average lookup time
2. **Direct Access**: No need to iterate through elements
3. **Scalability**: Performance advantage increases with dataset size

### Alternative Data Structures

Other efficient approaches include:
- **Binary Search Tree (BST)**: O(log n) search time
- **B-Tree**: Efficient for disk-based storage
- **Trie**: If searching by prefix patterns

---

## Project Structure

```
momo-api-alu-final/
├── api/
│   ├── server.py              # Main REST API server with routing
│   └── auth.py                # Basic Authentication module
├── data/
│   └── modified_sms_v2.xml    # Source SMS transaction data
├── docs/
│   └── api_docs.md            # Complete API documentation
├── dsa/
│   ├── parser.py              # XML to JSON parser
│   └── search_comparison.py   # DSA performance analysis
├── screenshots/
│   ├── 01_get_all_transactions.png
│   ├── 02_get_single_transaction.png
│   ├── 03_post_new_transaction.png
│   ├── 04_put_update_transaction.png
│   ├── 05_delete_transaction.png
│   ├── 06_error_no_auth.png
│   ├── 07_error_not_found.png
│   └── 08_dsa_comparison.png
├── tests/
│   ├── test_api.sh            # Bash test script
│   └── test_api.ps1           # PowerShell test script
├── .gitignore
├── README.md                  # This file
├── report.pdf                 # Final project report
└── team_participation.md      # Team contribution details
```

---

## Security Considerations

### Basic Authentication Limitations

⚠️ **Basic Authentication is NOT recommended for production** because:

1. **Credentials in Plain Text**: Base64 encoding is not encryption
2. **No Session Management**: Credentials sent with every request
3. **Vulnerable to MITM**: Without HTTPS, credentials can be intercepted
4. **No Token Expiration**: Credentials remain valid indefinitely

### Recommended Alternatives

| Method | Advantages |
|--------|-----------|
| **JWT (JSON Web Tokens)** | Stateless, expirable tokens, can include claims |
| **OAuth 2.0** | Industry standard, supports third-party auth, scoped access |
| **API Keys** | Simple per-client identification with rate limiting |
| **HTTPS + Certificate Auth** | Strong encryption, mutual authentication |

For production deployment, always:
- Use HTTPS/TLS encryption
- Implement proper session management
- Add rate limiting
- Use secure password hashing
- Enable logging and monitoring

---

## Screenshots

Test screenshots demonstrating all API functionality are available in the [`screenshots/`](screenshots/) folder:

| Screenshot | Description |
|------------|-------------|
| `01_get_all_transactions.png` | Successful GET request with authentication |
| `02_get_single_transaction.png` | GET single transaction by ID |
| `03_post_new_transaction.png` | Creating a new transaction |
| `04_put_update_transaction.png` | Updating an existing transaction |
| `05_delete_transaction.png` | Deleting a transaction |
| `06_error_no_auth.png` | 401 Unauthorized response (invalid credentials) |
| `07_error_not_found.png` | 404 Not Found response |
| `08_dsa_comparison.png` | DSA performance comparison results |

---

## Documentation

- **API Documentation:** [docs/api_docs.md](docs/api_docs.md)
- **Team Participation Sheet:** [team_participation.md](team_participation.md)
- **Project Report:** [report.pdf](report.pdf)

---

## License

This project was created for educational purposes as part of the ALU curriculum.

---

## Contact

For questions or issues, please contact:
- Darlene Ayinkamiye - d.ayinkamiye@alustudent.com
- Chely Kelvin Sheja - c.sheja@alustudent.com
