table 6231703 RegnskabsTable720
{
    DataClassification = CustomerContent;

    fields
    {
        field(8; financialYear; Integer)
        {
        }

        field(9; financialStatementLastReport; Date)
        {

        }

        field(10; financialStatementLastChange; DateTime)
        {
        }
        field(1; lastChange; DateTime)
        {
        }

        field(2; caseNumber; Code[20])
        {
        }

        field(3; startDate; Date)
        {
        }

        field(4; endDate; Date)
        {
        }

        field(5; grossProfit; Decimal)
        {
        }

        field(6; profitBeforeTax; Decimal)
        {
        }

        field(7; equity; Decimal)
        {

        }

        field(11; Vat; Text[20])
        {
        }

        field(12; ShowMore; Integer)
        {
            Caption = 'Vis flere regnskaber';
            FieldClass = FlowField;
            CalcFormula = count(RegnskabsTable720 where(Vat = field(Vat)));
        }

        field(13; pdfBase; Blob)
        {
        }

        field(14; currentAssets; Decimal)
        {
    
        }

        field(15; shorttermLiabilities; Decimal)
        {

        }

        field(16; profitLossOperatingActivities; Decimal)
        {

        }

        field(17; liabilitiesAndEquity; Decimal)
        {
        }

        field(18; profitLoss; Decimal)
        {

        }

    }

    keys
    {
        key(PK; caseNumber)
        {
            Clustered = true;
        }

        key(key2; endDate)
        {

        }
    }
}