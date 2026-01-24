# MoMo Transaction REST API

## What This Project Does
We built a REST API to manage Mobile Money transaction records from SMS data. It's written in pure Python (no Flask or Django) and includes all the CRUD endpoints with authentication. We also compared different data structure search methods to see which is faster.

## Team & Who Did What

### Darlene Ayinkamiye
- Built the main API server with routing and all the HTTP handlers
- Implemented PUT and DELETE endpoints
- Created the DSA comparison tool to benchmark linear search vs dictionary lookup
- Led the project development and integration

### Chely Kelvin Sheja
- Parsed the XML transaction data and converted it to JSON
- Designed the data structures we use for storing transactions
- Implemented the GET endpoints (both list all and get by ID)
- Created data validation logic

### Solomon Leek
- Created the authentication module with Basic Auth
- Handled all the authorization header parsing
- Wrote up security concerns and documentation
- Built the test scripts for verification
## What You Need
- Python 3.7+ (we tested on 3.10)
- curl or Postman to test it

## How to Run

1. **Get the code**
```bash
git clone <repository-url>
cd momo-api-project
```

2. **That's it!** No pip install needed - we only used Python's standard library

3. **Start the server**
```bash
python api/server.py
```

Server runs on `http://localhost:8000`

4. **Try it out**
```bash
# Get all transactions (you need to login)
curl -u admin:password http://localhost:8000/transactions

# Get one transaction
curl -u admin:password http://localhost:8000/transactions/1

# Add a new transaction
curl -u admin:password -X POST http://localhost:8000/transactions \
  -H "Content-Type: application/json" \
  -d '{"type":"Send Money","amount":5000,"sender":"250780000001","receiver":"250780000002"}'
```

## Project Structure
```
momo-api-project/
├── api/
│   ├── server.py          # Main API server (Teniola)
│   └── auth.py            # Authentication logic (Michaella)
├── dsa/
│   ├── parser.py          # XML parsing (Kevin)
│   └── search_comparison.py  # DSA analysis (Teniola)
├── docs/
│   └── api_docs.md        # API documentation (Kamunuga)
├── data/
│   └── modified_sms_v2.xml   # Sample data
├── screenshots/
│   └── README.md          # Test screenshots guide
├── tests/
│   └── test_api.sh        # Test scripts (Rajveer)
└── README.md              # This file (Kamunuga)
```

## Available Endpoints

- `GET /transactions` - Get all transactions
- `GET /transactions/{id}` - Get one specific transaction  
- `POST /transactions` - Create a new one
- `PUT /transactions/{id}` - Update an existing transaction
- `DELETE /transactions/{id}` - Remove a transaction

Check `docs/api_docs.md` for more details and examples.

## Login Info

Username: `admin`  
Password: `password`

*Yeah we know Basic Auth isn't the most secure but it's fine for this project*

## Testing Performance

Want to see how much faster dictionary lookup is than linear search?

```bash
python dsa/search_comparison.py
```

Spoiler: dictionaries are WAY faster (like 30x)
