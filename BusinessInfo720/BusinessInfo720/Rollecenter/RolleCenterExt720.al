pageextension 6231704 RolleCenterExt720 extends "Business Manager Role Center"
{
    layout
    {
        addfirst(rolecenter)
        {
            part(BusinessInfo720; WarningCuePage720)
            {
                ApplicationArea = all;
            }
        }
    }
}