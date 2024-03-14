controladdin GaugeAddin720
{
    RequestedHeight = 225;
    RequestedWidth = 350;

    Scripts =
        'BusinessInfo720\ControlAddins\JS\Gauge.js',
        'https://bernii.github.io/gauge.js/dist/gauge.min.js';
    StartupScript = 'BusinessInfo720\ControlAddins\JS\StartupGauge.js';
    StyleSheets = 'BusinessInfo720\ControlAddins\Css\GridContainer.css';
    event Ready()

    procedure SetLikviditetGauge(num: Decimal);

    procedure SetAfkastGauge(num: Decimal);

    procedure SetSoliditetGauge(num: Decimal);

}