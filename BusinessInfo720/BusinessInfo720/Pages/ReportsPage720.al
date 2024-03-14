page 6231703 ReportsPage720
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = RegnskabsTable720;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field(endDate; Rec.endDate)
                {
                    Caption = 'Year';
                }

                field(grossProfit; Rec.grossProfit)
                {
                    Caption = 'Gross Profit';
                }

                field(profitBeforeTax; Rec.profitBeforeTax)
                {
                    Caption = 'Profits Before Taxes';
                }

                field(equity; Rec.equity)
                {
                    Caption = 'Equity';
                }
            }
        }
        area(FactBoxes)
        {
            part(factBox720; ReportsFactBox720)
            {
                Caption = 'Annual report';
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(OpenPdfExt)
            {
                ApplicationArea = All;
                Caption = ' Open Pdf';
                Image = SendAsPDF;
                trigger OnAction()
                var
                begin
                    CurrPage.factBox720.Page.OpenPdfExt(base64);
                end;
            }
        }
        area(Promoted)
        {
            actionref(OpenPdf;OpenPdfExt)
            {

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        InStream: InStream;
    begin
        rec.CalcFields(pdfBase);
        rec.pdfBase.CreateInStream(InStream, TextEncoding::UTF8);
        InStream.ReadText(base64);
        CurrPage.factBox720.Page.GiveBase(base64);
    end;

    var
        base64: Text;

}