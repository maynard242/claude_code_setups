# Process All Credit Card Statements to Combined CSV

You are processing ALL credit card statement PDFs in the input directory and converting them to a single combined CSV file.

## Step 1: Discover and Read All PDFs

First, read the categories file to understand available categories:
- Read `/Users/levi/data/finance/categories.txt`

Then, discover all PDF files in the input directory:
- Use Bash or Glob to list all PDF files in `/Users/levi/data/finance/input/`
- Sort the PDF files by name/date

For each PDF file found:
- Use the PDF skill to read and extract all transaction data
- Keep track of which statement each transaction came from

## Step 2: Process All Transactions

For each PDF, create transaction records with the following specifications:

### Required Columns:
1. **Date** - Convert to DD-MM-YYYY format
2. **Transaction Details** - Simplify and standardize payee names, remove unique transaction codes/reference numbers
3. **Amount** - Use positive values for debits/withdrawals, negative values for credits/deposits
4. **Category** - Assign appropriate categories from the categories.txt file

### Processing Instructions:
- Clean up merchant/payee names by removing transaction codes, reference numbers, and unnecessary details
- Standardize similar payees across ALL statements (e.g., all "YOUTRIP SINGAPORE" entries should use the same name)
- Categorize each transaction using only the categories from categories.txt
- If uncertain about a category, use "Expense: Misc" as default

### Combining Data:
- Collect all transactions from all PDFs into one master list
- Sort all transactions chronologically by date (oldest first)
- Remove any duplicate transactions if the same transaction appears in multiple statements

## Step 3: Validation Checks

For each PDF processed, track validation:
1. **Transaction Count**: Count total transactions per PDF
2. **Date Range**: Note the date range for each statement
3. **Missing Data**: Check that no transaction has empty fields

Report validation summary:
- ✓ Files processed: X PDFs found and processed
- ✓ Total transactions: X transactions across all statements
- ✓ Date range: DD-MM-YYYY to DD-MM-YYYY (overall range)
- ✓ All fields populated

## Step 4: Save Combined Output

Save the combined CSV content to `/Users/levi/data/finance/output/` with filename:
`combined-statements.csv`

### CSV Format:
- One transaction per line
- No header row
- Sorted chronologically by date
- All transactions from all statements combined
- Use comma separation for CSV format

## Summary

Provide a detailed summary:
- Number of PDF files processed
- List of statement files processed
- Total transactions combined
- Overall date range covered
- File saved location
- Any notable issues, duplicates removed, or manual review needed
