table 6231704 SettingsTable720
{
    DataClassification = CustomerContent;
    fields
    {
        field(1;StatusBool; Boolean)
        {

        }

        field(2;ViesBool; Boolean)
        {

        }
        field(3;GrossProfitBool; Boolean)
        {

        }

        field(4;PrfoitBeforeTaxBool; Boolean)
        {

        }
        field(5;EquityBool; Boolean)
        {

        }
        
        field(6; Id; Integer)
        {
            AutoIncrement = true;
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