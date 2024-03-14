page 6231709 BusinessInfoSettingsPage720
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SettingsTable720;
    Caption = 'Business info720 settings';
    Editable = true;
    SaveValues = true;
    DataCaptionExpression = '';


    layout
    {
        area(Content)
        {
            group(Bools)
            {
                Caption = 'Things to show on warrning page';
                field(StatusBool;Rec.StatusBool)
                {

                }

                field(ViesBool; Rec.ViesBool)
                {

                }
                field(GrossProfitBool; Rec.GrossProfitBool)
                {

                }

                field(PrfoitBeforeTaxBool; Rec.PrfoitBeforeTaxBool)
                {

                }
                field(EquityBool; Rec.EquityBool)
                {

                }

            }
        }
    }
}