page 6231700 RegnSkabFactBox720
{
    PageType = Cardpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = RegnskabsTable720;


    layout
    {
        area(Content)
        {
            group(Upper)
            {
                Caption = '';
                field(financialYear; Rec.financialYear)
                {
                    Caption = 'Financial Year';
                }

                field(financialStatementLastReport; Rec.financialStatementLastReport)
                {
                    Caption = 'Last Report';
                }

                field(financialStatementLastChange; Rec.financialStatementLastChange)
                {
                    Caption = 'Last change';
                }

                field(caseNumber; Rec.caseNumber)
                {
                    Caption = 'Casenumber';
                }

                field(ShowMore; Rec.ShowMore)
                {
                    Caption = 'Show additional reports';
                    DrillDownPageId = ReportsPage720;
                    DrillDown = true;
                }
                usercontrol(GaugeLikvid; GaugeAddin720)
                {
                    ApplicationArea = all;
                    trigger Ready()
                    begin
                        CurrPage.GaugeLikvid.SetLikviditetGauge(LikviditetsGrad * 100);
                        CurrPage.GaugeLikvid.SetAfkastGauge(afkastningsGrad * 100);
                        CurrPage.GaugeLikvid.SetSoliditetGauge(SoliditetsGrad * 1001);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    begin

        LikviditetsGrad := ((rec.currentAssets * 100) / rec.shorttermLiabilities) / 100;

        afkastningsGrad := ((rec.profitLossOperatingActivities * 100) / rec.liabilitiesAndEquity) / 100;

        SoliditetsGrad := ((rec.equity * 100) / rec.liabilitiesAndEquity) / 100;

        EgenkapitalsForentning := ((rec.profitLoss * 100) / rec.equity);

    end;

    var
        LikviditetsGrad: Decimal;

        afkastningsGrad: Decimal;

        SoliditetsGrad: Decimal;

        EgenkapitalsForentning: Decimal;
}