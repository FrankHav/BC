controladdin SetFieldFocus720
{
    RequestedHeight = 1;
    MinimumHeight = 1;
    MaximumHeight = 1;
    RequestedWidth = 1;
    MinimumWidth = 1;
    MaximumWidth = 1;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts =
        'BusinessInfo720/ControlAddins/JS/SetFocusOnField.js';
    event Ready()

    procedure SetFocusOnField(FieldNo: Text)
}