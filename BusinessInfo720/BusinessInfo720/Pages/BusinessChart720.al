page 6231707 BusinessChart720
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = RegnskabsTable720;
    Caption = 'Charts';
    
    layout
    {
        area(Content)
        {
            usercontrol(Chart720; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = all;
                trigger AddInReady()
                var
                Buffer : Record "Business Chart Buffer" temporary;
                I : Integer;
                begin
                    Buffer.Initialize();
                    // Index 0
                    Buffer.AddMeasure('Equity',1,Buffer."Data Type"::Decimal,Buffer."Chart Type"::Line.asinteger());
                    // Index 1
                    Buffer.AddMeasure('Gross Profit',1,Buffer."Data Type"::Decimal,Buffer."Chart Type"::Line.asinteger());
                    // Index 2
                    Buffer.AddMeasure('Profit Before Taxes',1,Buffer."Data Type"::Decimal,Buffer."Chart Type"::Line.asinteger());

                    Buffer.SetXAxis('Year',Buffer."Data Type"::String);
                    if rec.FindSet(false,false) then
                    repeat
                        Buffer.AddColumn(rec.endDate);
                        //Den første parameter er Index på de Measures vi har defineret ovenover.
                        //Den tæller fra 0 af en eller anden grund.
                        Buffer.SetValueByIndex(0,I,rec.equity);
                        Buffer.SetValueByIndex(1,I,rec.grossProfit);
                        Buffer.SetValueByIndex(2,I,rec.profitBeforeTax);
                        i += 1;
                    until rec.Next() = 0;
                    Buffer.Update(CurrPage.Chart720);

                end;

                trigger DataPointClicked(point: JsonObject)
                var
                p : Page ReportsPage720;
                regnskab : Record RegnskabsTable720;
                JsonToken : JsonToken;
                ValueString : Text;
                
                begin
                    if point.Get('XValueString',JsonToken) then begin
                    ValueString := Format(JsonToken);
                    ValueString := DelChr(ValueString,'=','"');
                    regnskab.SetFilter(endDate,ValueString);
                    regnskab.SetFilter(Vat,rec.Vat);
                    p.SetTableView(regnskab);
                    p.Run();
                    end;
                end;
            }
        }
    }

}