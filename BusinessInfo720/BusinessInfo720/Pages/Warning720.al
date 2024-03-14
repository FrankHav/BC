page 6231710 Warning720
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WarningTable720;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                Visible = Rec.IsChecked;
                field(Firmanavn; Rec.Firmanavn)
                {
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    Caption = 'Business Status';
                    StyleExpr = colorStatus;
                    Editable = false;

                }

                field(Check; Rec.IsChecked)
                {
                    Editable = true;
                    Enabled = true;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }

                field(CheckedBy; Rec.CheckedBy)
                {

                }

            }
            repeater(GroupNam1e)
            {
                Visible = not Rec.IsChecked;
                field(Firman1avn; Rec.Firmanavn)
                {
                    Editable = false;
                }

                field(Stat1us; Rec.Status)
                {
                    Caption = 'Business Status';
                    StyleExpr = colorStatus;
                    Editable = false;
                }

                field(Chec1k; Rec.IsChecked)
                {
                    Editable = true;
                    Enabled = true;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        rec.CheckedBy := UserId;
                        CurrPage.Update();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        colorStatus := 'Favorable';
        if rec.Status <> 'NORMAL' then
            colorStatus := 'Unfavorable'
        else
            colorStatus := 'Favorable';
    end;

    var
        colorStatus: text;

        visible: Boolean;

}