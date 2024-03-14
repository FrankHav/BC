page 6231708 ReportsFactBox720
{
    PageType = Cardpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = RegnskabsTable720;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = '';
                usercontrol(pdf; PDFControl720)
                {
                    ApplicationArea = all;
                    trigger OnControlReady()
                    var

                    begin
                        isReady := true;
                        if txt <> '' then
                            CurrPage.pdf.ShowPdf('data:application/pdf;base64,' + txt);
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenPdf)
            {
                Image = SendAsPDF;
                Caption = 'Open PDF';
                trigger OnAction()
                var
                begin
                    CurrPage.pdf.ShowExternally('data:application/pdf;base64,' + txt);
                end;
            }
        }
    }

    procedure OpenPdfExt(base: Text)
    var
    begin
        CurrPage.pdf.ShowExternally('data:application/pdf;base64,' + base);
    end;


    procedure GiveBase(base: Text)
    var
        InStream: InStream;
    begin
        txt := base;
        if isReady = true then
            CurrPage.pdf.ShowPdf('data:application/pdf;base64,' + base);
    end;

    var
        isReady: Boolean;
        txt: Text;
}