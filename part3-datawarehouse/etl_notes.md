Decision 1 — Standardized Date Format
Problem: The raw data contains inconsistent date formats, such as "01-11-2023" and "2023/11/01".
Resolution: Converted all date entries to a uniform ISO format "YYYY-MM-DD" before loading into the date dimension table.

Decision 2 — Handling NULL Values in Store City
Problem: Some transactions have missing store_city entries.
Resolution: Replaced NULLs with "Unknown" or used the most frequent city value where data was missing, to maintain data integrity.

Decision 3 — Normalizing Product Categories
Problem: Product categories appeared with inconsistent casing and abbreviations, e.g., "clothing", "Cloth.", "GROCERIES".
Resolution: Standardized categories to lowercase and fixed spelling errors to ensure consistent categorization, enabling accurate grouping in analysis.