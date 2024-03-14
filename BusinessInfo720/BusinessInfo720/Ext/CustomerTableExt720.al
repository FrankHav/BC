tableextension 6231700 CustomerTableExt720 extends Customer
{
    fields
    {
        field(6231700; businessCode720; Code[10])
        {
            TableRelation = BusinessTypeTable720;
            DataClassification = CustomerContent;

        }
        field(6231701; businessName720; Text[100])
        {
            TableRelation = BusinessTypeTable720;
            DataClassification = CustomerContent;

        }

        field(6231702; IndustryCode720; Code[10])
        {
            TableRelation = IndustryTable720;
            DataClassification = CustomerContent;

        }

        field(6231703; IndustryName720; Text[100])
        {
            TableRelation = BusinessTypeTable720;
            DataClassification = CustomerContent;

        }

        field(6231704; BusinessStatus720; Text[100])
        {
            Caption = 'Status';
            DataClassification = CustomerContent;

        }

        field(6231705; Vies720; Text[1])
        {
            DataClassification = CustomerContent;

        }

        field(6231706; CalcGrossProfit720; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = average(RegnskabsTable720.grossProfit where(Vat = field("VAT Registration No.")));
        }

        field(6231707;CalcEquity720;Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = max(RegnskabsTable720.equity where (Vat = field("VAT Registration No.")));
        }

        field(6231708; Employee720; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(6231709; LastUpdated720; DateTime)
        {
            DataClassification = CustomerContent;
            Caption ='Last update with BusinessInfo720';
        }

    }

    trigger OnDelete()
    var
        regnskab: record RegnskabsTable720;
        warning : Record WarningTable720;
    begin
        //Regnskab delete.
        regnskab.SetRange(regnskab.Vat,rec."VAT Registration No.");
        if regnskab.FindSet() = true then
        repeat
            regnskab.Delete();
            until regnskab.Next() = 0;

        //Warning delete.
        warning.SetRange(warning.Vat, rec."VAT Registration No.");
        if warning.FindSet() = true then
        repeat
        warning.Delete();
        until warning.Next() = 0;
    end;

}