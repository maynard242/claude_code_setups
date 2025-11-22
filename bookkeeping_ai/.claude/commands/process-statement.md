---
description: Process a bank or credit card PDF statement into a categorized CSV file
---

You are processing a banking transaction PDF into a clean, categorized CSV file.

## Your Task

1. Ask the user for the PDF file path
2. Read the PDF using your PDF reading capabilities
3. Extract all transactions from the statement
4. Clean and standardize merchant names
5. Categorize each transaction
6. Validate the results
7. Generate the CSV output

## Step-by-Step Process

### Step 1: Get PDF Path
Ask the user: "Please provide the path to your PDF statement (e.g., input/statement.pdf):"

### Step 2: Read and Extract
- Read the PDF file
- Identify the transaction table
- Extract: Date, Description/Merchant, Amount
- Note the statement period and totals shown

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

### Step 5: Validate Results
Check and report:
```
Validation Results:
✓ Transaction count: [X] transactions
✓ Total expenses: $[amount]
✓ Total income: $[amount]
✓ Net: $[amount]
✓ Date range: [start] to [end]
✓ All fields populated
```

Flag any issues with ✗

### Step 6: Generate CSV
Create CSV with format:
```csv
Date,Transaction Details,Amount,Category
DD-MM-YYYY,MERCHANT NAME,XX.XX,Category: Subcategory
```

Rules:
- Date format: DD-MM-YYYY
- Positive amounts = expenses (money out)
- Negative amounts = income (money in)
- Save to output directory with date-based filename

### Step 7: Report to User
Provide:
1. Summary of transactions processed
2. Validation results
3. Path to output CSV file
4. Any issues or manual review needed

## Output Example

```csv
Date,Transaction Details,Amount,Category
01-03-2024,STARBUCKS,5.50,Expense: Dining
01-03-2024,MRT FARE,2.00,Expense: Transport
02-03-2024,AMAZON,49.99,Expense: Misc
03-03-2024,SHELL STATION,45.00,Expense: Auto
05-03-2024,NETFLIX,15.99,Expense: Subscriptions
10-03-2024,SALARY,-3000.00,Income: Self, Income
```

## Important Notes

- Always verify transaction count matches the PDF
- Check that totals reconcile with statement summary
- Flag any transactions that couldn't be categorized
- Preserve original PDF for reference
- Output files should go in the output/ directory
