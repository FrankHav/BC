page 6231702 BusinessInfoSubPage720
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = BuisnessInfo720;
    Caption = 'Customer list';
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
                Caption = 'Opret kunde';
                Image = AddContacts;
                Enabled = IsEnabled;
                ShortcutKey = 'Shift+Enter';
                trigger OnAction()
                var
                begin
                    CreateCustomer(Rec);
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

    // Vi henter templates til opsætningen af customer carden ved hjælp af Customer template recorden
    //og sætter den så med vores Customer templ. mgt Coudeunit.

    local procedure CreateRegnskab(vat: Text)
    var
        resultArray: list of [Text];
        VatApiMgt: Codeunit VatApiMgt720;
        regnskab: Record RegnskabsTable720;

        JsonTok: JsonToken;
        jsonTokTemp: JsonToken;
        jsonObj: JsonObject;
        FinArray: JsonArray;

        OStream: OutStream;
        InStream: InStream;
        filename: Text;
        i: Integer;
        pdfBase64Text: Text;
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
                regnskab.grossProfit := jsonTokTemp.AsValue().AsBigInteger();

                JsonTok.SelectToken('$.profitBeforeTax', jsonTokTemp);
                regnskab.profitBeforeTax := jsonTokTemp.AsValue().AsBigInteger();

                JsonTok.SelectToken('$.equity', jsonTokTemp);
                regnskab.equity := jsonTokTemp.AsValue().AsBigInteger();

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

                JsonTok.SelectToken('$.pdfBase64', jsonTokTemp);

                regnskab.CalcFields(regnskab.pdfBase);
                regnskab.pdfBase.CreateOutStream(OStream, TextEncoding::UTF8);
                OStream.Write(jsonTokTemp.AsValue().AsText());

                regnskab.Vat := vat;

                if regnskab.Insert() then;
            end;
        end;
    end;

    local procedure CreateCustomer(bInfoTable: Record BuisnessInfo720)
    var
        customerTemplate: Record "Customer Templ.";
        cus: Codeunit "Customer Templ. Mgt.";
        ResultArray: list of [Text];
        VatApiMgt: Codeunit VatApiMgt720;
        jsontok: JsonToken;
        jsontok2: JsonToken;
        Customer: Record Customer;

        CurrDate: Date;

        //Dialog
        Question: Text;
        Answer: Boolean;
        CustomerNo: Integer;
        text000: Label '';
        text001: Label 'Kunde oprettet';
        warning: Record WarningTable720;
    begin
        ResultArray := VatApiMgt.RunTest(rec.SearchCvr);
        cus.SelectCustomerTemplate(customerTemplate);
        Clear(jsontok);
        jsonTok.ReadFrom(ResultArray.Get(1));

        jsonTok.SelectToken('$.name', jsonTok2);
        Customer.Name := jsontok2.AsValue().AsText();

        Customer."VAT Registration No." := rec.SearchCvr;

        jsonTok.SelectToken('$.name2', jsonTok2);
        Customer."Name 2" := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.address', jsonTok2);
        Customer.Address := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.address2', jsonTok2);
        Customer."Address 2" := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.postCode', jsonTok2);
        Customer."Post Code" := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.city', jsonTok2);
        Customer.City := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.phoneNo', jsonTok2);
        Customer."Phone No." := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.eMail', jsonTok2);
        Customer."E-Mail" := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.industryCode', jsonTok2);
        Customer.IndustryCode720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.industryName', jsonTok2);
        Customer.IndustryName720 := jsontok2.AsValue().AsText();

        jsontok.SelectToken('$.employee', jsontok2);
        if jsontok2.AsValue().AsText() <> '' then
            Customer.Employee720 := jsontok2.AsValue().AsInteger()
        else
            Customer.Employee720 := 0;

        Customer.LastUpdated720 := CurrentDateTime;

        jsonTok.SelectToken('$.businessTypeCode', jsonTok2);
        Customer.businessCode720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.businessTypeName', jsonTok2);
        Customer.businessName720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.businessStatus', jsonTok2);
        Customer.BusinessStatus720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.vies', jsonTok2);
        Customer.Vies720 := jsontok2.AsValue().AsText();

        if (Customer.Vies720 <> '1') or (Customer.BusinessStatus720 <> 'NORMAL') then begin
            if Customer.Vies720 <> '1' then
                Question := 'Denne virksomhed er ikke VIES registreret. Ønsker du stadig at oprette den?';

            if Customer.BusinessStatus720 <> 'NORMAL' then begin
                Question := 'Denne virksomheds status er: ' + Customer.BusinessStatus720 + '.' +
                'Ønsker du stadig at oprette den?';

                    warning.FirmaNavn := Customer.Name;
                    warning.Status := customer.BusinessStatus720;
                    warning.Vat := Customer."VAT Registration No.";
                    if warning.Insert() then;
                end;

                if (Customer.Vies720 <> '1') and (Customer.BusinessStatus720 <> 'NORMAL') then
                    Question := 'Denne virksomheds status er: ' + Customer.BusinessStatus720 + ', og den er ikke VIES registreret. Ønsker du stadig at oprette den?';

                CustomerNo := rec.Id;
                Answer := Dialog.Confirm(Question, true, CustomerNo);
                if Answer = true then
                    Message(text001, Answer)
                else begin
                    Message('Kunden blev ikke oprettet', Answer);
                    exit
                end;
            end;


            Customer.Insert(true);
            cus.ApplyCustomerTemplate(Customer, customerTemplate);
            CreateRegnskab(Rec.SearchCvr);
            page.Run(21, Customer);
            exit;
        end;

    var
        IsEnabled: Boolean;

}