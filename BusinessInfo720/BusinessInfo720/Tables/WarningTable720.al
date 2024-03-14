table 6231705 WarningTable720
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;FirmaNavn; Text[150])
        {

        }

        field(2; Status; Text[150])
        {

        }

        field(3; Vat; Text[150])
        {
        }

        field(4; Counter; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(WarningTable720 where(IsChecked = const(false)));
        }

        field(5; CheckedBy; Code[100])
        {
            DataClassification = CustomerContent;
        }

        field(6; IsChecked; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = false;
        }
    }
    
    keys
    {
        key(PK; Vat)
        {
            Clustered = true;
        }
    }
}