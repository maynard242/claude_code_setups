# Finance - Banking Transaction PDF to CSV Processor

## Overview
This project processes banking transaction PDFs and converts them to CSV format for analysis and record-keeping.

## Project Structure

```
/Users/levi/data/finance/
├── .claude/
│   └── commands/
│       └── process-statement.md    # PDF to CSV processing command
├── input/                          # Place PDF files here for processing
├── output/                         # Generated CSV files
├── scripts/                        # Processing scripts
├── categories.txt                  # Transaction category definitions
├── CLAUDE.md                      # This file
├── README.md                      # Project documentation
└── .gitignore                     # Git ignore rules
```

## Workflow

### Quick Start
1. **Input**: Place banking transaction PDF files in `input/` directory
2. **Process**: Run `/process-statement` command (no arguments needed)
3. **Validate**: Review validation checks for each statement processed
4. **Output**: Single combined CSV file automatically saved to `output/combined-statements.csv`

### Using the `/process-statement` Command

```
/process-statement
```

The command will automatically:
1. Discover all PDF files in the `input/` directory
2. Read each PDF using Claude's PDF skills
3. Extract and categorize all transactions from all statements
4. Combine all transactions and sort chronologically
5. Remove duplicate transactions (if any appear in multiple statements)
6. Perform validation checks for each statement:
   - Transaction count per PDF
   - Date range per statement
   - No missing data
7. Save combined CSV to `output/combined-statements.csv`
8. Provide a comprehensive summary report

**Note**: The command processes ALL PDFs in the input directory and creates ONE combined output file with all transactions sorted by date.

### Transaction Categories

All transactions are categorized using predefined categories from `categories.txt`:
- **Expense categories**: Auto, Bank Charge, Business Expenses, Cash, Charity, Children, Clothing, Computers, Dining, Education, Gifts Given, Groceries, Household Expenses, Housing Related, Insurance, Interest Expense, Medical, Misc, Personal Care, Pet, Postage and Delivery, Recreation, Rent, Subscriptions, Taxes (various), Transport, Utilities, Vacation
- **Income categories**: Income, Business Reimbursement, Dividend Income, Gifts Received, Interest Income, Other Income, Rental Income, Salary, Self Bonus/Income, Spouse Income

### CSV Format

Output format in `combined-statements.csv`:
```csv
Date,Transaction Details,Amount,Category
DD-MM-YYYY,Merchant Name,123.45,Expense: Category
```

Specifications:
- Date: DD-MM-YYYY format
- Transaction Details: Cleaned merchant names (no reference codes)
- Amount: Positive for debits, negative for credits
- Category: From categories.txt
- Sorting: Chronologically by date (oldest to newest)
- Deduplication: Duplicate transactions removed automatically

### Validation Checks

The command includes automatic validation for each statement:
- Transaction count verification per PDF
- Date range tracking per statement
- Complete data checks across all files
- Summary of all statements processed

## Processing Features

- Intelligent PDF extraction using Claude's PDF skills
- Automatic transaction categorization
- Merchant name standardization
- Built-in validation checks
- Clean, consistent CSV output

## Notes

- PDFs and CSVs are gitignored (contain sensitive data)
- The command processes ALL PDFs in the input directory automatically
- Output is a single combined file: `combined-statements.csv`
- Transactions are sorted chronologically across all statements
- Duplicates are automatically detected and removed
- Always review the validation summary before using the CSV
- Keep original PDFs in `input/` as source of truth
- If validation fails, the command will flag issues for manual review
