pageextension 6231702 VendorListExt720 extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
    }
    
    actions
    {
        addfirst(processing)
        {
            action(OpenBuisnessInfo720)
            {
                ApplicationArea = all;
                Caption = 'Buisness info720';
                Image = EmployeeAgreement;
                trigger OnAction()
                var
                begin
                    page.Run(6231704);
                end;
            }
        }
        addfirst(Promoted)
        {
            actionref(BuisnessInfo720Aref720; OpenBuisnessInfo720)
            {
            }
        }

    }

}