pageextension 6231701 CustomerListExt720 extends "Customer List"
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
                Caption = 'Business info720';
                Image = EmployeeAgreement;
                trigger OnAction()
                var
                begin
                    Run(6231701);
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