pageextension 6231700 CustomerCardExt720 extends "Customer Card"
{
    layout
    {

        addfirst(factboxes)
        {
            part(FactBox720; RegnSkabFactBox720)
            {
                Caption = 'Finances';
                ApplicationArea = all;
                SubPageLink = Vat = field("VAT Registration No.");
                SubPageView = sorting(endDate) order(descending);

            }

            part(Chart720 ; BusinessChart720)
            {
                ApplicationArea = all;
                Caption = 'Financial chart';
                SubPageLink = Vat = field("VAT Registration No.");
            }
        }

        addlast(content)
        {
            usercontrol(SetFocus720; SetFieldFocus720)
            {
                ApplicationArea = All;
                trigger Ready()
                begin
                end;
            }
        }

        addlast(General)
        {
            field(IndustryCode720; Rec.IndustryCode720)
            {
                ApplicationArea = all;
                Importance = Additional;
                Caption = 'Industry Code';
                Editable = false;
            }

            field(IndustryName720; Rec.IndustryName720)
            {
                ApplicationArea = all;
                Caption = 'Industry Name';
                Editable = false;

            }

            field(businessCode720; Rec.businessCode720)
            {
                ApplicationArea = all;
                Importance = Additional;
                Caption = 'Business Code';
                Editable = false;

            }

            field(businessName720; Rec.businessName720)
            {
                ApplicationArea = all;
                Importance = Additional;
                Caption = 'Business Name';
                Editable = false;

            }

            field(BusinessStatus720; Rec.BusinessStatus720)
            {
                ApplicationArea = all;
                Importance = Additional;
                Caption = 'Business Status';
                Editable = false;

            }

            field(Vies720; Rec.Vies720)
            {
                ApplicationArea = all;
                Importance = Additional;
                Caption = 'VIES';
                Editable = false;

            }

            field(Employee720; Rec.Employee720)
            {
                ApplicationArea = all;
                Importance = Additional;
                Caption = 'No Of Employees';
                Editable = false;
            }

            field(LastUpdated720; Rec.LastUpdated720)
            {
                ApplicationArea = all;
                Importance = Additional;
                Caption = 'Last update with BusinessInfo720';
                Editable = false;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(OpenPage720)
            {
                ApplicationArea = all;
                Caption = 'Update with BusinessInfo720';
                trigger OnAction()
                var
                begin
                    UpdateCustomer720(Rec);
                end;
            }
        }
        addlast(Promoted)
        {
            actionref(UpdateInfo720; openpage720)
            {

            }
        }

    }

    procedure UpdateCustomer720(Customer: Record Customer)
    var
        VatApiMgt: Codeunit VatApiMgt720;
        resultArray: list of [Text];
        jsontok: JsonToken;
        jsontok2: JsonToken;
        warning: Record WarningTable720;
        regnskab: record RegnskabsTable720;
        DialogConf: Dialog;
        Answer: Boolean;
        i: Integer;
        checkRegnskab: Boolean;
    begin
        if rec."VAT Registration No." = '' then begin
            Message('VAT Registration No. cannot be empty');
            CurrPage.SetFocus720.SetFocusOnField('VAT Registration No.');
            exit
        end;

        Answer := Dialog.Confirm('Do you want to update this customer with BusinessInfo720?' +
        '\ BusinessInfo720 will not override any existing data', Answer);
        if Answer = false then
            exit;

        resultArray := VatApiMgt.RunTest(rec."VAT Registration No.");
        jsonTok.ReadFrom(ResultArray.Get(1));

        if Rec.Name = '' then begin
            jsonTok.SelectToken('$.name', jsonTok2);
            Rec.Name := jsontok2.AsValue().AsText();
        end;

        if rec."Name 2" = '' then begin
            jsonTok.SelectToken('$.name2', jsonTok2);
            Rec."Name 2" := jsontok2.AsValue().AsText();
        end;

        if rec.Address = '' then begin
            jsonTok.SelectToken('$.address', jsonTok2);
            Rec.Address := jsontok2.AsValue().AsText();
        end;

        if rec."Address 2" = '' then begin
            jsonTok.SelectToken('$.address2', jsonTok2);
            Rec."Address 2" := jsontok2.AsValue().AsText();
        end;

        if rec."Post Code" = '' then begin
            jsonTok.SelectToken('$.postCode', jsonTok2);
            Rec."Post Code" := jsontok2.AsValue().AsText();
        end;

        if rec.City = '' then begin
            jsonTok.SelectToken('$.city', jsonTok2);
            Rec.City := jsontok2.AsValue().AsText();
        end;

        if rec."Phone No." = '' then begin
            jsonTok.SelectToken('$.phoneNo', jsonTok2);
            Rec."Phone No." := jsontok2.AsValue().AsText();
        end;

        if rec."E-Mail" = '' then begin
            jsonTok.SelectToken('$.eMail', jsonTok2);
            Rec."E-Mail" := jsontok2.AsValue().AsText();
        end;


        jsonTok.SelectToken('$.industryCode', jsonTok2);
        Rec.IndustryCode720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.industryName', jsonTok2);
        Rec.IndustryName720 := jsontok2.AsValue().AsText();

        jsontok.SelectToken('$.employee', jsontok2);
        if jsontok2.AsValue().AsText() <> '' then
        Rec.Employee720 := jsontok2.AsValue().AsInteger()
        else
        Rec.Employee720 := 0;
        Rec.LastUpdated720 := CurrentDateTime;

        jsonTok.SelectToken('$.businessTypeCode', jsonTok2);
        Rec.businessCode720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.businessTypeName', jsonTok2);
        Rec.businessName720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.businessStatus', jsonTok2);
        Rec.BusinessStatus720 := jsontok2.AsValue().AsText();

        jsonTok.SelectToken('$.vies', jsonTok2);
        Rec.Vies720 := jsontok2.AsValue().AsText();

        if Rec.BusinessStatus720 <> 'NORMAL' then begin
            Message('Denne virksomheds status er: ' + Rec.BusinessStatus720);
            warning.FirmaNavn := Rec.Name;
            warning.Status := Rec.BusinessStatus720;
            warning.Vat := Rec."VAT Registration No.";
            if warning.Insert() then;
        end;

        rec.Modify();

        for i := 1 to regnskab.Count do begin
            if regnskab.Vat.Contains(rec."VAT Registration No.") then
                checkRegnskab := true;
        end;

        if checkRegnskab = false then
            CreateRegnskab(rec."VAT Registration No.");
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

        OStream: OutStream;
        InStream: InStream;
        filename: Text;
        i: Integer;
        pdfBase64Text: Text;
    begin
        resultArray := VatApiMgt.RunTest(vat);

        regnskab.FindFirst();
        regnskab.SetRange(regnskab.Vat, rec."VAT Registration No.");
        if regnskab.FindSet(true) then
            repeat
                regnskab.Delete();
            until regnskab.Next() = 0;

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

                JsonTok.SelectToken('$.pdfBase64', jsonTokTemp);

                regnskab.CalcFields(regnskab.pdfBase);
                regnskab.pdfBase.CreateOutStream(OStream, TextEncoding::UTF8);
                OStream.Write(jsonTokTemp.AsValue().AsText());

                regnskab.Vat := vat;

                regnskab.Insert();
            end;
        end;
    end;
}