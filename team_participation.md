# Team Participation Sheet - MoMo API Project

**Course:** Building and Securing a REST API
**Team Name:** ALU MoMo API Team  
**Submission Date:** January 24, 2026

---

## Team Members & Contact

| Name | Email | Role |
|------|-------|------|
| Darlene Ayinkamiye | d.ayinkamiye@alustudent.com | Team Leader & Backend Development |
| Chely Kelvin Sheja | c.sheja@alustudent.com | Data Parsing & API Development |

---

## Individual Contributions

### Darlene Ayinkamiye
**Primary Responsibilities:**
- REST API server architecture and routing
- CRUD endpoints implementation (PUT, DELETE)
- Basic Authentication implementation
- DSA performance comparison (linear search vs dictionary lookup)
- Project leadership and coordination

**Time Invested:** ~18 hours

**Key Contributions:**
- Built the core routing logic in `api/server.py` - handling path parsing and request delegation
- Implemented all CRUD endpoints with proper validation
- Created `api/auth.py` with Basic Authentication
- Implemented `dsa/search_comparison.py` - compared search algorithms with 10,000 iterations
- Found dictionary lookup is significantly faster than linear search
- Led team meetings and code integration
- Final testing and quality assurance before submission

**Evidence:**
- Git commits for `api/server.py`, `api/auth.py`, and `dsa/search_comparison.py`
- Implemented complex routing logic handling all HTTP methods
- DSA comparison script with detailed timing measurements

---

### Chely Kelvin Sheja
**Primary Responsibilities:**
- XML data parsing implementation
- GET endpoints (list all & single record)
- Data structure design
- API testing and documentation
- JSON conversion logic

**Time Invested:** ~16 hours

**Key Contributions:**
- Created `dsa/parser.py` using ElementTree for XML parsing
- Designed transaction dictionary structure for efficient lookups
- Implemented GET /transactions endpoint (list all records)
- Implemented GET /transactions/{id} endpoint (single record lookup)
- Added data validation and error handling for malformed XML
- Created comprehensive test scripts for all endpoints
- Wrote API documentation with examples
- Captured test screenshots for submission

**Evidence:**
- Git commits for `dsa/parser.py`, GET endpoints, tests, and documentation
- Comprehensive data parsing with proper error handling
- Efficient data structure design enabling fast lookups
- Complete test suite and documentation

---

## Team Meetings

### Meeting 1 - January 19, 2026
**Duration:** 2 hours
**Attendees:** Darlene, Chely
**Topics:**
- Project requirements review
- Task distribution and role assignment
- Technology stack decisions (Python http.server, ElementTree)
- Git repository setup

**Decisions:**
- Use plain Python without frameworks
- Darlene: Server routing, CRUD operations, Authentication, DSA
- Chely: Data parsing, GET endpoints, Testing, Documentation
- Daily check-ins on progress

**Notes:**
- Agreed on using Basic Auth for simplicity
- Will document security concerns as required
- Target completion: January 23rd for testing buffer

---

### Meeting 2 - January 21, 2026
**Duration:** 1.5 hours
**Attendees:** Darlene, Chely
**Topics:**
- Progress check on individual components
- Integration planning
- Issue resolution (JSON encoding, auth headers)

**Decisions:**
- Use UTF-8 encoding throughout
- Standardize error response format
- Combine code by January 22nd

**Notes:**
- Chely finished parsing, working on GET endpoints
- Darlene has routing done, starting CRUD and authentication
- Minor merge conflicts resolved quickly

---

### Meeting 3 - January 23, 2026
**Duration:** 2 hours
**Attendees:** Darlene, Chely
**Topics:**
- Final integration and testing
- Documentation review
- Screenshots and report preparation
- Submission checklist

**Decisions:**
- All tests passing successfully
- Documentation is complete
- Ready for submission

**Notes:**
- Tested all endpoints with curl
- Screenshots captured for all scenarios
- API documentation finalized
- Team participation sheet completed
- Feeling confident about the submission!

---

## Code Contribution Summary

| Team Member | Files/Modules | Lines of Code | Commit Count |
|-------------|---------------|---------------|--------------|
| Darlene Ayinkamiye | api/server.py, api/auth.py, dsa/search_comparison.py | ~400 | 4 |
| Chely Kelvin Sheja | dsa/parser.py, tests/, docs/, GET endpoints | ~350 | 3 |

**Total:** ~750 lines of functional code (excluding comments/docs)

---

## Challenges & Solutions

**Challenge 1:** Understanding Basic Auth header encoding
- **Solution:** Darlene researched base64 encoding and implemented proper header parsing

**Challenge 2:** Handling JSON request bodies in http.server
- **Solution:** Darlene figured out proper content-length reading and JSON parsing

**Challenge 3:** XML parsing with different transaction types
- **Solution:** Chely created flexible parser handling all transaction types

**Challenge 4:** Testing without a framework
- **Solution:** Chely created bash and PowerShell scripts using curl for comprehensive testing

---

## Team Dynamics

**Strengths:**
- Clear communication and daily check-ins
- Everyone completed their assigned tasks on time
- Helped each other debug issues
- Good distribution of workload

**Areas for Improvement:**
- Could have started earlier (tight timeline)
- More unit tests would be helpful
- Better Git branch management

**Overall Assessment:**
This was a successful team project. Both members contributed meaningfully and we learned a lot about REST APIs, authentication, and data structures. The collaboration was smooth and we're proud of what we built together!