# Banking Transaction PDF to CSV Processor

Convert banking transaction PDFs to CSV format with automatic categorization and validation.

## Quick Start

1. Place your credit card statement PDF in the `input/` directory
2. In Claude Code, run: `/process-statement`
3. Provide the PDF filename when prompted
4. Review validation checks
5. Find your CSV in the `output/` directory

## Features

- Intelligent PDF extraction using Claude's PDF skills
- Automatic transaction categorization (40+ categories)
- Merchant name standardization and cleanup
- Built-in validation checks:
  - Transaction count verification
  - Amount tally validation
  - Date range checks
  - Complete data verification
- Clean CSV output ready for import

## Directory Structure

```
finance/
├── .claude/
│   └── commands/
│       └── process-statement.md    # PDF processing command
├── input/                          # Place PDF files here
├── output/                         # CSV files generated here
├── scripts/                        # Additional scripts
├── categories.txt                  # Transaction categories
├── CLAUDE.md                      # Project context for Claude
├── USAGE.md                       # Detailed usage guide
├── README.md                      # This file
└── .gitignore                     # Ignores PDFs and CSVs
```

## CSV Output Format

```csv
Date,Transaction Details,Amount,Category
01-03-2024,STARBUCKS,5.50,Expense: Dining
02-03-2024,AMAZON,49.99,Expense: Misc
05-03-2024,SALARY DEPOSIT,-3000.00,Income: Self, Income
```

Specifications:
- **Date**: DD-MM-YYYY format
- **Transaction Details**: Cleaned merchant names (no transaction codes)
- **Amount**: Positive for expenses, negative for income/credits
- **Category**: Auto-assigned from 40+ predefined categories

## Documentation

- **USAGE.md** - Comprehensive usage guide with examples and troubleshooting
- **CLAUDE.md** - Technical documentation and command reference
- **categories.txt** - Complete list of transaction categories

## Transaction Categories

### Expenses
Auto, Bank Charge, Business Expenses, Cash, Charity, Children, Clothing, Computers, Dining, Education, Gifts Given, Groceries, Household Expenses, Housing Related, Insurance, Interest Expense, Medical, Misc, Personal Care, Pet, Postage and Delivery, Recreation, Rent, Subscriptions, Taxes, Transport, Utilities, Vacation

### Income
Business Reimbursement, Dividend Income, Gifts Received, Interest Income, Other Income, Rental Income, Salary, Self Income/Bonus, Spouse Income

See `categories.txt` for the complete list.

## Security

- **All PDFs and CSVs are gitignored by default**
- Contains sensitive financial data
- Never commit banking statements to version control
- Keep backups secure

## Validation

Every processed statement includes automatic validation:
- Transaction count matches PDF
- Amount totals verified
- Date ranges validated
- All fields complete

Review validation results before using the CSV.

## Compatibility

Generated CSVs work with:
- Excel / Google Sheets
- Accounting software (QuickBooks, Xero)
- Personal finance apps (YNAB, Mint)
- Custom analysis tools

## Getting Help

1. See **USAGE.md** for detailed walkthrough
2. Check **CLAUDE.md** for command reference
3. Review validation messages for specific issues
4. Examine PDF manually if needed

## Example Workflow

```bash
# 1. Add your statement
cp ~/Downloads/statement-march.pdf input/

# 2. In Claude Code, process it
/process-statement
# Enter: input/statement-march.pdf

# 3. Review output
cat output/statement-2024-03-31.csv
```
