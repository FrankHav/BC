table 6231702 IndustryTable720
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;IndustryCode; Code[10])
        {
        }

        field(2; IndustryName; Text[100])
        {
        }
    }
    
    keys
    {
        key(PK; IndustryCode)
        {
            Clustered = true;
        }
    }
    
   
}