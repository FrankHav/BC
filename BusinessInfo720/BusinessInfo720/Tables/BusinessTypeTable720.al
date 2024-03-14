table 6231701 BusinessTypeTable720
{
    DataClassification = CustomerContent;
        
    fields
    {
        field(1;BusinessCode; Code[10])
        {
        }

        field(2; BusinessTypeName; Text[100])
        {
        }
    }
    
    keys
    {
        key(PK; BusinessCode)
        {
            Clustered = true;
        }
    }
}