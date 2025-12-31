# User Management Notebook

## Overview
This notebook automates the creation, update, and query of a user table for data governance, integrating access audit information and user attributes.
---

## 1. Development Process
### Technical Objective
Automate the consolidation of user data from access audits and attribute sources, maintaining an up-to-date, reliable user repository for governance and analytics.

### Technical Workflow
- Table creation with primary key and struct for user details
- Adding comments for documentation
- Aggregating access audit data for first/last access
- Integrating user attributes from CSV
- Joining, structuring, and deduplicating data
- Upserting data using MERGE
- Final query for validation and analysis

**Step-by-step Flowchart:**
1. Drop and create the `data_governance.users` table with required schema
2. Add comments to table and columns for clarity
3. Read user attributes from CSV and create temp view
4. Aggregate access audit data for each email
5. Join audit and attribute data, build user_info struct
6. Deduplicate records by email
7. Upsert into main table using MERGE
8. Query the table for validation

---

## 2. Maintance and evolution
### Guidelines
* Update the CSV source or audit table as needed for new users or changes
* Ensure schema consistency and update comments/documentation when fields change
* Validate data integration and deduplication logic after any update
* Monitor upsert logic to avoid data loss or duplication
* Document all changes for traceability

**Maintenance Flowchart:**
- Receive new/updated user data (CSV or audit)
- Validate schema and update documentation
- Integrate and test data pipeline
- Monitor upsert and deduplication
- Document changes and results

---

## 3. Usage and Value
### Strategic Value
* Centralized, reliable user repository for governance, security, and audit
* Enables tracking of user access, status, and organizational attributes
* Facilitates compliance, reporting, and strategic decision-making
* Reduces manual effort and risk of inconsistent data

**Business Value Flowchart:**
- Collect user access and attribute data
- Automate consolidation and validation
- Maintain up-to-date user repository
- Enable analytics, reporting, and compliance
- Support strategic decisions with reliable data

---

## Important Notes
* Ensure the CSV file path and audit table are accessible and up-to-date
* Adjust schema and logic as organizational needs evolve
* Document all changes for future maintenance and audits

---

This advanced documentation is designed for clarity, detail, and ease of maintenance. Follow the guidelines to adapt the notebook as needed and ensure reliable, valuable results.
