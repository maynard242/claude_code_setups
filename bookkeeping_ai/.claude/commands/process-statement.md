---
description: Process all PDF statements in input directory into a single categorized CSV file
---

You are processing all banking transaction PDFs from the input directory into a single, clean, categorized CSV file.

## Your Task

1. Scan input directory for all PDF files
2. Process each PDF: extract, clean, and categorize transactions
3. Verify each PDF's totals against extracted data
4. Merge all transactions into one output file
5. Generate final CSV without header line

## Step-by-Step Process

### Step 1: Scan Input Directory
1. List all PDF files in the `input/` directory
2. Report found files to user: "Found X PDF files to process: [list]"
3. If no PDFs found, ask user to place files in `input/` directory

### Step 2: Read and Extract (for each PDF)
For each PDF file:
- Read the PDF file
- **Extract statement totals first**: Total debits, total credits, opening balance, closing balance, transaction count
- Identify the transaction table
- Extract all rows: Date, Description/Merchant, Amount
- Note the statement period

### Step 3: Clean Merchant Names
For each transaction:
- Remove transaction codes (e.g., *123456)
- Remove card numbers
- Standardize common merchants
- Keep relevant location info

Examples:
- `YOUTRIP*123456 SINGAPORE SG` → `YOUTRIP SINGAPORE`
- `STARBUCKS #8821 NYC` → `STARBUCKS NYC`
- `AMZN MKTP US*1X2Y3Z` → `AMAZON`

### Step 4: Categorize Transactions
Apply these category rules:

**Expenses:**
- Dining: restaurants, cafes, coffee shops, food delivery
- Groceries: supermarkets, grocery stores
- Transport: transit, taxi, ride-sharing
- Auto: fuel, parking, car services
- Subscriptions: streaming, software, memberships
- Utilities: phone, internet, electricity
- Medical: healthcare, pharmacy
- Recreation: entertainment, hobbies
- Clothing: apparel, accessories
- Household: home goods, repairs
- Misc: uncategorized

**Income:**
- Self, Income: salary deposits
- Self, Bonus: bonus payments
- Business Reimbursement: expense refunds
- Interest Income: bank interest
- Gifts Received: transfers marked as gifts

### Step 5: Verify Totals (CRITICAL - Do for EACH PDF)

**Double-check extracted data against PDF statement totals:**

For each PDF, calculate and compare:
1. Count extracted transactions vs statement's transaction count
2. Sum all debits (positive amounts) vs statement's "Total Debits/Withdrawals"
3. Sum all credits (negative amounts as absolute) vs statement's "Total Credits/Deposits"
4. Verify: (Credits - Debits) = (Closing Balance - Opening Balance)

```
Per-File Verification:
[bank-march-2024.pdf]
✓ Transactions: 47 extracted = 47 on statement
✓ Debits: $2,345.67 = $2,345.67 on statement
✓ Credits: $3,000.00 = $3,000.00 on statement
✓ Net change: $654.33 verified
```

**If any discrepancy found**: STOP and report to user. Do not proceed until resolved.

After all PDFs verified, report consolidated totals:
```
Consolidated Results:
✓ Files processed: 3 PDFs
✓ Total transactions: 127
✓ Combined expenses: $4,580.23
✓ Combined income: $6,500.00
✓ Date range: [start] to [end]
✓ All fields populated
```

Flag any issues with ✗

### Step 6: Generate CSV

Create single CSV file **without header line**:

**Output file**: `output/statements.csv`

**Format** (data rows only, no header):
```csv
DD-MM-YYYY,MERCHANT NAME,XX.XX,Category: Subcategory
```

Rules:
- **NO header row** - data rows only
- Merge all transactions from all PDFs into single file
- Sort all transactions by date (oldest first)
- Date format: DD-MM-YYYY
- Positive amounts = expenses (money out)
- Negative amounts = income (money in)

### Step 7: Report to User
Provide:
1. List of PDFs processed
2. Per-file verification results (transaction counts, totals matched)
3. Consolidated summary (total transactions, expenses, income)
4. Path to output CSV file: `output/statements.csv`
5. Any issues or manual review needed

## Output Example

**Note: No header line in output file**

```csv
01-03-2024,STARBUCKS,5.50,Expense: Dining
01-03-2024,MRT FARE,2.00,Expense: Transport
02-03-2024,AMAZON,49.99,Expense: Misc
03-03-2024,SHELL STATION,45.00,Expense: Auto
05-03-2024,NETFLIX,15.99,Expense: Subscriptions
10-03-2024,SALARY,-3000.00,Income: Self, Income
15-03-2024,WHOLE FOODS,87.32,Expense: Groceries
20-03-2024,UBER,12.50,Expense: Transport
```

## Important Notes

- **Batch processing**: All PDFs in input/ directory are processed together
- **Totals verification is mandatory**: Always verify counts and amounts against each PDF's statement totals
- **Stop on discrepancy**: If totals don't match, stop and report before proceeding
- Check that debit/credit totals match, and net change equals balance difference
- Flag any transactions that couldn't be categorized
- Single output file: `output/statements.csv` (no header line)
- Preserve original PDFs for reference
