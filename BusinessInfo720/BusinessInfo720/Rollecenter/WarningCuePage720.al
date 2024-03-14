page 6231714 WarningCuePage720
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WarningTable720;
    RefreshOnActivate = true;
    
    layout
    {
        area(Content)
        {
            cuegroup(WarningContainer)
            {
                Caption = 'Warnings';
                field(Counter;Rec.Counter)
                {
                    StyleExpr = color;
                    ApplicationArea = All;
                    DrillDownPageId = Warning720;
                    DrillDown = true;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        color := 'Unfavorable';
       if rec.Counter = 0 then
       color := 'Favorable';
    end;

    var

    color : Text;
    IsVisible : Boolean;
}