# Dynamic MIS Reporting Engine

The **Dynamic MIS Reporting Engine** is a state-of-the-art, **100% metadata-driven reporting platform** built with **React (Vite)**, **Spring Boot**, and **PostgreSQL**. 

Unlike traditional management information systems where every new report requires building a hardcoded frontend screen, defining custom DTOs, and writing new backend controller endpoints, this platform operates as an **autonomous reporting engine**. Report blueprints, input filter configurations, dropdown options, and SQL queries are entirely stored in database tables (`report_master` and `report_parameter`).

## ✨ Key Features

- **100% Metadata-Driven UI**: Filter controls (dropdowns, text inputs, dates) are rendered dynamically in React based on parameter metadata fetched from the database. Zero hardcoded form fields!
- **Dynamic SQL Assembly at Runtime**: The Spring Boot backend safely constructs parameterized SQL queries (`WHERE` / `AND` clauses with JDBC placeholders) on the fly by matching user filter selections against database parameter definitions.
- **Dynamic Output Column Selection**: Users can customize their dashboard view by checking/unchecking output columns in real time. The selected columns are dynamically projected into both table views and exported documents.
- **Server-Side PDF & Excel Export Engine**: Features a robust, centralized backend export engine using **OpenPDF** (`.pdf`) and **Apache POI** (`.xlsx`). Generated exports dynamically respect the user's custom column selections.
- **Premium UI/UX & Alert Highlighting**: Designed with modern dark-mode aesthetics, glassmorphic cards, smooth micro-animations, and intelligent cell alerting (automatically highlighting low attendance `< 75%`, failing marks `< 40%`, or supplementary exam requirements).

---

## 📁 Repository Layout

```text
dynamic-mis/
├── frontend/             # React dashboard (Vite + Vanilla CSS + Lucide Icons)
├── backend/              # Spring Boot REST API & Export Engine (Java 17+, Maven Wrapper)
└── backend/database/     # PostgreSQL Schema & Seed Data
    ├── 01_schema.sql     # Database tables (report_master, report_parameter, student, etc.)
    └── 02_sample_data.sql# Sample data & 13 dynamic parameter definitions across 5 reports
```

---

## 🚀 Setup & Installation Instructions

### Prerequisites
- **Java**: JDK 17 or higher
- **Node.js**: v18.0.0 or higher
- **PostgreSQL**: v14 or higher

### 1. Database Configuration
1. Open PostgreSQL and create a database named `postgres` (or use your existing database).
2. Execute the schema script:
   ```bash
   psql -U postgres -d postgres -f backend/database/01_schema.sql
   ```
3. Execute the seed data and metadata script:
   ```bash
   psql -U postgres -d postgres -f backend/database/02_sample_data.sql
   ```

### 2. Running the Spring Boot Backend
The backend includes a Maven Wrapper, so no local Maven installation is required.

```bash
cd backend
# On Windows (PowerShell / CMD):
.\mvnw.cmd spring-boot:run

# On Linux / macOS:
./mvnw spring-boot:run
```
*The backend API server will start on **http://localhost:8081**.*

### 3. Running the React Frontend
```bash
cd frontend
npm install
npm run dev
```
*The React dashboard will start on **http://localhost:5173**.*

---

## 🏗️ Architecture & How It Works

The engine relies on a clean relational contract between two primary metadata tables:

1. **`report_master`**: Stores the base SQL query (`report_query`), report name, and description.
2. **`report_parameter`**: Stores input filter definitions linked to a report. Each row specifies:
   - `parameter_name`: The database column or filter key (e.g., `department_id`, `semester`).
   - `parameter_label`: The user-friendly label shown on the UI (e.g., `"Department / Degree"`).
   - `parameter_type`: Either `DROPDOWN` or `TEXT`/`DATE`.
   - `dropdown_query`: A dynamic SQL query executed by the backend to fetch dropdown options (e.g., `SELECT department_id AS value, department_name AS label FROM department ORDER BY department_id`).

### Request Flow
1. **Report Discovery**: The frontend calls `GET /api/reports` and populates the Report Type selector.
2. **Parameter & Option Fetching**: When a report is selected, the frontend calls `GET /api/reports/{id}/parameters`. The backend evaluates any `dropdown_query` via `JdbcTemplate` and attaches `{value, label}` pairs directly to the parameter list.
3. **Dynamic Rendering**: React iterates over the parameters array, rendering `<select>` menus for dropdowns and `<input>` boxes for text search.
4. **Query Execution**: When the user clicks **Search Records**, the frontend sends a POST request with a dynamic `filters` map and `selectedColumns` array. `ReportExecutionService` builds the SQL WHERE clauses safely using prepared statements and returns the exact data projection requested.
5. **Document Export**: Clicking **Export Excel** or **Export PDF** triggers `ReportExportService`, which formats the data into styled spreadsheets or branded PDF reports on the fly.

---

## ➕ How to Add a New Dynamic Report (Zero Code Changes!)

To add a brand new report to the application, you **do not need to modify any React or Spring Boot code**. Follow these 4 simple steps in your database:

### Step 1: Write and Test Your Base SQL Query
Write your query in PostgreSQL. Make sure to use clear column aliases (e.g., `AS "Student Name"`).
```sql
SELECT roll_no AS "Roll No", student_name AS "Student Name", cgpa AS "CGPA" 
FROM student WHERE 1=1;
```

### Step 2: Insert into `report_master`
```sql
INSERT INTO report_master (report_id, report_name, report_description, report_query, active_flag)
VALUES (
    6, 
    'Top Scholars Overview', 
    'Summary of students with academic standing.', 
    'SELECT roll_no AS "Roll No", student_name AS "Student Name", cgpa AS "CGPA" FROM student WHERE 1=1', 
    true
);
```

### Step 3: Insert Filter Definitions into `report_parameter`
Define what filters the user can search by:
```sql
-- Add a Dropdown Filter for Department
INSERT INTO report_parameter (parameter_id, report_id, parameter_name, parameter_label, parameter_type, dropdown_query, display_order)
VALUES (
    14, 6, 'department_id', 'Filter by Department', 'DROPDOWN', 
    'SELECT department_id AS value, department_name AS label FROM department', 1
);

-- Add a Text Search Filter for Student Name
INSERT INTO report_parameter (parameter_id, report_id, parameter_name, parameter_label, parameter_type, display_order)
VALUES (
    15, 6, 'student_name', 'Search Student Name', 'TEXT', 
    NULL, 2
);
```

### Step 4: Refresh Your Browser!
Open **http://localhost:5173**. Your new report `"Top Scholars Overview"` will immediately appear in the dropdown menu, render its custom department dropdown and name search box, execute queries, allow column toggling, and export to PDF/Excel!

---

## 🛠️ Technology Stack
- **Frontend**: React 18, Vite, Vanilla CSS (Custom Design System & Glassmorphism), Lucide Icons
- **Backend**: Java 17+, Spring Boot 3.x, Spring JDBC (`JdbcTemplate`), Spring Data JPA, HikariCP
- **Database**: PostgreSQL 14+
- **Document Generation**: OpenPDF (PDF Reports), Apache POI (Excel Spreadsheets)
