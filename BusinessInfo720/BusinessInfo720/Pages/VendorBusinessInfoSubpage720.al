page 6231705 VendorBusinessInfoSubpage720
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = BuisnessInfo720;
    Caption = 'Vendor list';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Rec.SearchName)
                {
                    Caption = 'Name';
                }

                field("VAT Registration No."; Rec.SearchCvr)
                {
                    Caption = 'Vat';
                }

                field(Address; Rec.Address)
                {

                }

                field(Postcode; Rec.Postcode)
                {

                }

                field(City; Rec.City)
                {

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(OpretKunde)
            {
                ApplicationArea = all;
                Caption = 'Create vendor';
                Image = AddContacts;
                Enabled = IsEnabled;
                trigger OnAction()
                var
                begin
                    CreateVendor(Rec);
                end;
            }
        }
    }

    procedure InsertData(result: list of [Text])
    var
        i: Integer;
        jsontokne: JsonToken;
        jsontok: JsonToken;
    begin
        if not rec.IsEmpty then
            rec.DeleteAll();

        IsEnabled := true;
        for i := 1 to result.Count() do begin
            clear(jsontokne);
            jsontokne.ReadFrom(result.Get(i));
            jsontokne.SelectToken('$.vat', jsontok);
            clear(rec);
            rec.SearchCvr := jsontok.AsValue().AsText();

            jsontokne.SelectToken('$.name', jsontok);
            rec.SearchName := jsontok.AsValue().AsText();

            jsontokne.SelectToken('$.address', jsontok);
            rec.Address := jsontok.AsValue().AsText();

            jsontokne.SelectToken('$.postCode', jsontok);
            rec.Postcode := jsontok.AsValue().AsText();

            jsontokne.SelectToken('$.city', jsontok);
            rec.City := jsontok.AsValue().AsText();

            rec.Id := i;
            rec.Insert();
        end;
        if rec.FindFirst() then;
    end;

    local procedure CreateRegnskab(vat: Text)
    var
        resultArray: list of [Text];
        VatApiMgt: Codeunit VatApiMgt720;
        regnskab: Record RegnskabsTable720;

        JsonTok: JsonToken;
        jsonTokTemp: JsonToken;
        jsonObj: JsonObject;
        FinArray: JsonArray;

        i: Integer;
    begin
        resultArray := VatApiMgt.RunTest(vat);
        jsonTok.ReadFrom(ResultArray.Get(1));
        jsonTok.SelectToken('$.financialYear', jsonTokTemp);
        regnskab.financialYear := jsonTokTemp.AsValue().AsInteger();

        jsonTok.SelectToken('$.financialStatementLastReport', jsonTokTemp);
        regnskab.financialStatementLastReport := jsonTokTemp.AsValue().AsDate();

        JsonTok.SelectToken('$.financialStatementLastChange', jsonTokTemp);
        regnskab.financialStatementLastChange := jsonTokTemp.AsValue().AsDateTime();

        jsonObj.ReadFrom(resultArray.Get(1));

        if jsonObj.Contains('financialStatement') then begin



            jsonObj.Get('financialStatement', JsonTok);
            FinArray := JsonTok.AsArray();
            for i := 1 to FinArray.Count() - 1 do begin
                FinArray.Get(i, JsonTok);

                JsonTok.SelectToken('$.lastChange', jsonTokTemp);
                regnskab.lastChange := jsonTokTemp.AsValue().AsDateTime();

                JsonTok.SelectToken('$.caseNumber', jsonTokTemp);
                regnskab.caseNumber := jsonTokTemp.AsValue().AsCode();

                JsonTok.SelectToken('$.startDate', jsonTokTemp);
                regnskab.startDate := jsonTokTemp.AsValue().AsDate();

                JsonTok.SelectToken('$.endDate', jsonTokTemp);
                regnskab.endDate := jsonTokTemp.AsValue().AsDate();

                JsonTok.SelectToken('$.grossProfit', jsonTokTemp);
                regnskab.grossProfit := jsonTokTemp.AsValue().AsInteger();

                JsonTok.SelectToken('$.profitBeforeTax', jsonTokTemp);
                regnskab.profitBeforeTax := jsonTokTemp.AsValue().AsInteger();

                JsonTok.SelectToken('$.equity', jsonTokTemp);
                regnskab.equity := jsonTokTemp.AsValue().AsInteger();

                JsonTok.SelectToken('$.currentAssets', jsonTokTemp);
                regnskab.currentAssets := jsonTokTemp.AsValue().AsBigInteger();

                JsonTok.SelectToken('$.shorttermLiabilitiesOtherThanProvisions', jsonTokTemp);
                regnskab.shorttermLiabilities := jsonTokTemp.AsValue().AsBigInteger();

                JsonTok.SelectToken('$.profitLossFromOrdinaryOperatingActivities', jsonTokTemp);
                regnskab.profitLossOperatingActivities := jsonTokTemp.AsValue().AsBigInteger();

                JsonTok.SelectToken('$.liabilitiesAndEquity',jsonTokTemp);
                regnskab.liabilitiesAndEquity := jsonTokTemp.AsValue().AsBigInteger();

                JsonTok.SelectToken('$.profitLoss',jsonTokTemp);
                regnskab.profitLoss := jsonTokTemp.AsValue().AsBigInteger();

                regnskab.Vat := vat;

                if regnskab.Insert() then;
            end;
        end;
    end;

    local procedure CreateVendor(bInfoTable: Record BuisnessInfo720)
    var
        VendorTemplate: Record "Vendor Templ.";
        VendorMgt: Codeunit "Vendor Templ. Mgt.";
        Vendor: Record Vendor;
        ResultArray: list of [Text];
        VatApiMgt: Codeunit VatApiMgt720;
        jsontok: JsonToken;
        jsontok2: JsonToken;

        //Dialog
        Question: Text;
        Answer: Boolean;
        VendorNo: Integer;
        text000: Label '';
        text001: Label 'Kunde oprettet';

    begin
        ResultArray := VatApiMgt.RunTest(rec.SearchCvr);
        VendorMgt.CreateVendorFromTemplate(Vendor, IsHandled);

        Clear(jsontok);
        jsonTok.ReadFrom(ResultArray.Get(1));

        jsonTok.SelectToken('$.name', jsonTok2);
        Vendor.Name := jsontok2.AsValue().AsText();

        Vendor."VAT Registration No." := rec.SearchCvr;

        jsonTok.SelectToken('$.name2', jsonTok2);
        Vendor."Name 2" := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.address', jsonTok2);
        Vendor.Address := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.address2', jsonTok2);
        Vendor."Address 2" := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.postCode', jsonTok2);
        Vendor."Post Code" := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.city', jsonTok2);
        Vendor.City := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.phoneNo', jsonTok2);
        Vendor."Phone No." := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.eMail', jsonTok2);
        Vendor."E-Mail" := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.industryCode', jsonTok2);
        Vendor.IndustryCode720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.industryName', jsonTok2);
        Vendor.IndustryName720 := jsontok2.AsValue().AsText();

        //Employee mangler at blive indsat her. måske?

        jsonTok.SelectToken('$.businessTypeCode', jsonTok2);
        Vendor.businessCode720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.businessTypeName', jsonTok2);
        Vendor.businessName720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.businessStatus', jsonTok2);
        Vendor.BusinessStatus720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.vies', jsonTok2);
        Vendor.Vies720 := jsontok2.AsValue().AsText();

        if (Vendor.Vies720 <> '1') or (Vendor.BusinessStatus720 <> 'NORMAL') then begin
            if Vendor.Vies720 <> '1' then
                Question := 'Denne virksomhed er ikke VIES registreret. Ønsker du stadig at oprette den?';

            if Vendor.BusinessStatus720 <> 'NORMAL' then
                Question := 'Denne virksomheds status er: ' + Vendor.BusinessStatus720 + '.' +
                'Ønsker du stadig at oprette den?';

            if (Vendor.Vies720 <> '1') and (Vendor.BusinessStatus720 <> 'NORMAL') then
                Question := 'Denne virksomheds status er: ' + Vendor.BusinessStatus720 + ', og den er ikke VIES registreret. Ønsker du stadig at oprette den?';

            VendorNo := rec.Id;
            Answer := Dialog.Confirm(Question, true, VendorNo);
            if Answer = true then
                Message(text001, Answer)
            else begin
                Message('Kunden blev ikke oprettet', Answer);
                exit
            end;
        end;

        CreateRegnskab(Rec.SearchCvr);
        Vendor.Modify();
        Page.Run(26, Vendor);
        exit;
    end;

    var
        IsHandled: Boolean;
        IsEnabled: Boolean;
}