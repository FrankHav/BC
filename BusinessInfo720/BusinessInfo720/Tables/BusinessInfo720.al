table 6231700 BuisnessInfo720
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; Id; Integer)
        {
        }

        field(2; SearchName; Text[150])
        {
            Editable = true;
        }

        field(3; SearchCvr; Text[20])
        {
            Editable = true;
        }

        field(4; Address; Text[100])
        {
        }

        field(5; Postcode; Text[4])
        {
        }

        field(6; City; Text[100])
        {
        }
    }

    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }
}