# Bookkeeping / Personal Finance Setup

Personal finance and bookkeeping configuration for Claude Code, specialized in processing bank statements and managing financial records.

## Use Cases

- Process bank/credit card PDF statements to CSV
- Automatic transaction categorization
- Merchant name standardization
- Expense tracking and analysis
- Financial record organization

## Features

### Specialized Agent
- **statement-processor**: Bookkeeping specialist for PDF extraction, transaction categorization, validation, and CSV generation

### Slash Command
- `/process-statement`: Process a PDF statement into a categorized CSV file

### Auto-Approved Tools
- File operations: mkdir, cp, mv, cat, ls
- Python for data processing
- Git for version control

### Status Line
Shows bookkeeping mode indicator with current directory

## Quick Start

```bash
# Install
cp -r bookkeeping_ai/.claude ~/

# Or use setup switcher
./switch-setup.sh bookkeeping_ai

# Set up your project structure
mkdir -p input output

# Test it
claude
> /process-statement
# Provide: input/your-statement.pdf
```

## Workflow

1. **Prepare**: Place PDF statement in `input/` directory
2. **Process**: Run `/process-statement` command
3. **Provide Path**: Enter the PDF filename
4. **Review**: Check validation results
5. **Output**: Find CSV in `output/` directory

## CSV Output Format

```csv
Date,Transaction Details,Amount,Category
01-03-2024,STARBUCKS,5.50,Expense: Dining
02-03-2024,AMAZON,49.99,Expense: Misc
05-03-2024,SALARY DEPOSIT,-3000.00,Income: Self, Income
```

- **Date**: DD-MM-YYYY format
- **Transaction Details**: Cleaned merchant names
- **Amount**: Positive (expense) / Negative (income)
- **Category**: Auto-assigned from 40+ categories

## Transaction Categories

### Expenses
- Dining, Groceries, Transport, Auto
- Subscriptions, Utilities, Medical
- Recreation, Clothing, Household
- Education, Misc

### Income
- Salary, Bonus, Reimbursements
- Interest, Dividends, Gifts

## Validation Checks

Every processed statement includes:
- ✓ Transaction count verification
- ✓ Amount tally validation
- ✓ Date range checks
- ✓ Field completeness

## Project Structure

```
your-project/
├── input/           # Place PDF statements here
├── output/          # Generated CSV files
├── archive/         # Processed statements
└── categories.txt   # Custom categories (optional)
```

## Compatibility

Generated CSVs work with:
- Excel / Google Sheets
- QuickBooks, Xero, Wave
- YNAB, Mint, Personal Capital
- Custom Python/pandas analysis

## Security Notes

- PDFs and CSVs contain sensitive financial data
- Add to .gitignore to prevent accidental commits
- Keep backups of original statements
- Store processed files securely

## Best For

- Personal expense tracking
- Small business bookkeeping
- Tax preparation
- Budget analysis
- Financial record digitization
