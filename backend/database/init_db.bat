@echo off
set PGPASSWORD=admin123
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d postgres -f "%~dp001_schema.sql"
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d postgres -f "%~dp002_sample_data.sql"
echo College MIS Database initialized successfully!
