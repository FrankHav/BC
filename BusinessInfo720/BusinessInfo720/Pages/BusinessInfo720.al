page 6231701 BusinessInfo720
{
    PageType = Card;
    DataCaptionExpression = '';
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Business info720 Customer';

    layout
    {
        area(Content)
        {
            field(SerachVar;SerachVar)
            {
                ApplicationArea = all;
                Caption = 'Search';
            }
            part(BuisnessInfo720SubPage; BusinessInfoSubPage720)
            {

            }

            usercontrol(Search720; SearchField720)
            {
                ApplicationArea = all;
                trigger Ready()
                var
                begin
                    CurrPage.Search720.AttachFieldListener();
                end;

                trigger GetFieldValue(data : Text)
                var
                begin
                    FieldValue := data;
                    SearchCompany(FieldValue);      
                end;
            }

        }
    }


    // Søger efter et firma med enten navn eller cvr som paramater.
    local procedure SearchCompany(fieldValue: Text)
    var
        resultArray: list of [Text];
        RegexMgt: Codeunit Regex;
        pattern: text;
        numberPattern: text;
    begin
        numberPattern := '\d{8}';
        if RegexMgt.IsMatch(fieldValue, numberPattern, 0) then
            resultArray := KundeAPiMgt.RunVat(fieldValue)
        Else
            resultArray := KundeAPiMgt.RunName(fieldValue);

        CurrPage.BuisnessInfo720SubPage.Page.InsertData(resultArray);
    end;


    var
        KundeAPiMgt: Codeunit KundeApiMgt720;
        SerachVar: Text;
        isready: Boolean;
        FieldValue: Text;


}