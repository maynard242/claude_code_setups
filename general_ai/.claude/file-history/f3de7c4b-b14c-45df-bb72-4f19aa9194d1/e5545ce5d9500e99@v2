# Usage Guide: Processing Credit Card Statements

## Quick Reference

1. Place PDF in `input/` folder
2. Run `/process-statement` command
3. Provide PDF filename when prompted
4. Review validation results
5. Find CSV in `output/` folder

## Detailed Walkthrough

### Step 1: Prepare Your Statement

Place your credit card statement PDF in the input folder:

```bash
input/
└── citibank-march-2024.pdf
```

### Step 2: Run the Command

In Claude Code, type:

```
/process-statement
```

### Step 3: Provide the PDF Path

When prompted, provide the path to your PDF:

```
input/citibank-march-2024.pdf
```

Or use the full path:

```
/Users/levi/data/finance/input/citibank-march-2024.pdf
```

### Step 4: Review Processing

Claude will:
1. Read your PDF using the PDF skill
2. Extract all transaction data
3. Clean and standardize merchant names
4. Categorize each transaction
5. Perform validation checks

### Step 5: Check Validation Results

The command will display validation results like:

```
Validation Results:
✓ Transaction count: 47 transactions (matches PDF)
✓ Amount tally: $2,345.67 (verified against statement)
✓ Date range: 01-03-2024 to 31-03-2024
✓ All fields populated
```

If any validation fails:
- ✗ indicates a problem
- Review the specific issue
- Check if manual correction needed
- Re-run if necessary

### Step 6: Locate Your CSV

Find your processed CSV in the output folder:

```bash
output/
└── statement-2024-03-31.csv
```

The filename includes the statement closing date for easy identification.

## CSV Output Example

```csv
01-03-2024,STARBUCKS,5.50,Expense: Dining
02-03-2024,AMAZON,49.99,Expense: Misc
03-03-2024,SHELL STATION,45.00,Expense: Auto
05-03-2024,SALARY DEPOSIT,-3000.00,Income: Self, Income
```

Note:
- Positive amounts = expenses (money out)
- Negative amounts = income/credits (money in)
- Merchant names are cleaned (no transaction codes)
- All transactions categorized

## Transaction Categories

### Common Expense Categories

- **Expense: Dining** - Restaurants, cafes, food delivery
- **Expense: Groceries** - Supermarkets, grocery stores
- **Expense: Transport** - Public transport, ride-sharing
- **Expense: Auto** - Fuel, parking, car maintenance
- **Expense: Subscriptions** - Netflix, Spotify, etc.
- **Expense: Utilities** - Phone, internet, electricity
- **Expense: Medical** - Healthcare, pharmacy
- **Expense: Recreation** - Entertainment, hobbies
- **Expense: Clothing** - Apparel, shoes
- **Expense: Misc** - Uncategorized expenses

### Common Income Categories

- **Income: Self, Income** - Regular salary
- **Income: Self, Bonus** - Bonus payments
- **Income: Business Reimbursement** - Expense reimbursements
- **Income: Interest Income** - Bank interest
- **Income: Gifts Received** - Gift money

For complete category list, see `categories.txt`.

## Troubleshooting

### Problem: Transaction count doesn't match

**Solution:**
- Check if PDF contains all pages
- Look for continuation pages
- Verify if any transactions appear in footnotes
- Re-run with complete PDF

### Problem: Amount tally is off

**Possible causes:**
- Credits vs debits confusion (check signs)
- Fees or interest not included
- Previous balance carried forward
- Statement contains adjustments

**Solution:**
- Compare with statement total
- Check for special transactions
- Verify opening/closing balance calculation

### Problem: Wrong categories assigned

**Solution:**
- Review the transaction
- Note the correct category
- Manually edit the CSV if needed
- Categories can be refined over time

### Problem: Merchant names not standardized

**Example issue:**
- "YOUTRIP*123456 SINGAPORE SG"
- "YOUTRIP*789012 SINGAPORE SG"

**Solution:** The command should standardize to "YOUTRIP SINGAPORE"
- If not, manually standardize in CSV
- Report pattern for future improvement

## Best Practices

### Organization

- Keep original PDFs in `input/`
- Never delete source PDFs
- Use descriptive PDF filenames
- Review CSVs before importing to accounting software

### Validation

- Always check transaction count
- Verify amount totals
- Spot-check a few transactions
- Review unusual categories

### Security

- PDFs and CSVs are gitignored
- Contains sensitive financial data
- Don't commit to version control
- Backup securely

### Workflow

- Process statements monthly
- Name files consistently: `bank-YYYY-MM.pdf`
- Review and correct categories as needed
- Keep a log of any manual corrections

## Multiple Statements

To process multiple statements:

1. Place all PDFs in `input/`
2. Run `/process-statement` for each
3. Each generates separate CSV

Future enhancement: Merge multiple CSVs into one master file.

## Data Import

The CSV format is compatible with:
- Excel / Google Sheets
- Accounting software (QuickBooks, Xero, etc.)
- Personal finance apps (YNAB, Mint, etc.)
- Custom analysis scripts

Import considerations:
- Verify date format (DD-MM-YYYY)
- Check amount signs (positive/negative)
- Map categories to your system
- Handle duplicates if re-processing

## Support

If you encounter issues:
1. Check this guide first
2. Review validation messages
3. Examine the PDF manually
4. Try with a different statement
5. Document the issue for improvement

## Tips

- Start with recent statements (easier to verify)
- Keep category assignments consistent
- Review quarterly for category refinement
- Use validation checks as quality gates
- Build a library of standard merchant names
