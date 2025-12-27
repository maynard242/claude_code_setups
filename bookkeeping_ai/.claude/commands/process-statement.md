---
description: Process bank/credit card statement PDF and convert to categorized CSV
---

Process the provided bank or credit card statement following this rigorous workflow:

## Processing Steps

1. **Extract Statement Metadata**
   - Account holder name
   - Account number (last 4 digits only)
   - Statement period (from date - to date)
   - Opening balance
   - Closing balance
   - Total debits (if shown)
   - Total credits (if shown)
   - Transaction count (if shown)

2. **Parse All Transactions**
   Extract each transaction with:
   - Transaction date
   - Description (merchant/payee)
   - Amount (debit or credit)
   - Running balance (if available)
   - Any reference numbers

3. **Validation (Critical)**
   Verify data integrity:
   - [ ] Count extracted transactions
   - [ ] Sum all debits
   - [ ] Sum all credits
   - [ ] Calculate net change (credits - debits)
   - [ ] Verify: opening balance + net change = closing balance
   - [ ] Compare totals against statement totals

   **If validation fails:**
   - Report the discrepancy
   - Identify missing or duplicate transactions
   - Request review before proceeding

4. **Categorize Transactions**
   Assign categories based on merchant/description:
   - Income (salary, refunds, transfers in)
   - Housing (rent, mortgage, insurance)
   - Transportation (gas, parking, auto payment)
   - Food (groceries, restaurants)
   - Utilities (electric, gas, water, internet, phone)
   - Healthcare (medical, pharmacy, insurance)
   - Entertainment (movies, streaming, hobbies)
   - Shopping (retail, clothing, online)
   - Other/Uncategorized (when unclear)

5. **Generate CSV Output**
   Format: Date,Description,Amount,Category,Notes

   Requirements:
   - NO header line (data only)
   - Date format: YYYY-MM-DD
   - Amount: Positive for income/credits, negative for expenses/debits
   - Clean description (remove extra spaces, special chars)
   - Sort by date (oldest to newest)
   - One CSV file per statement

## Example Output

```
2024-01-15,Whole Foods Market,-87.32,Food,Groceries
2024-01-16,Shell Gas Station,-45.00,Transportation,Fuel
2024-01-17,Paycheck Deposit,2500.00,Income,Bi-weekly salary
2024-01-18,Netflix Subscription,-15.99,Entertainment,Streaming
```

## Validation Report

After processing, provide summary:
- Total transactions processed: X
- Total debits: $X.XX
- Total credits: $X.XX
- Net change: $X.XX
- Opening balance: $X.XX
- Closing balance: $X.XX
- Validation status: ✓ PASS or ✗ FAIL with details

## Important Notes

- Preserve exact amounts (don't round)
- Maintain chronological order
- Flag unusual or large transactions
- Note any transactions that couldn't be categorized
- Mask full account numbers for privacy
