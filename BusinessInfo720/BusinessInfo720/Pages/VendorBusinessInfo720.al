page 6231704 VendorBusinessinfo720
{
    PageType = Card;
    DataCaptionExpression = '';
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Business info720 Vendor';

    layout
    {
        area(Content)
        {
            field(SerachVar;SerachVar)
            {
                ApplicationArea = all;
                Caption = 'Search';
            }

            part(VendorBusinessInfo720Subpage; VendorBusinessInfoSubpage720)
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

        CurrPage.VendorBusinessInfo720Subpage.Page.InsertData(resultArray);
    end;


    var
        KundeAPiMgt: Codeunit KundeApiMgt720;
        fieldvalue: Text;

        SerachVar: Text;

}