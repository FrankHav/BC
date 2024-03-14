// Liquidity Gauge
var LikvidCanvas = document.createElement("canvas");
LikvidCanvas.id = 'LikvidCanvas';
LikvidCanvas.height = 75;
LikvidCanvas.width = 85;

var AfkastCanvas = document.createElement("canvas");
AfkastCanvas.id = 'AfkastCanvas';
AfkastCanvas.height = 75;
AfkastCanvas.width = 85;

var SoliditetCanvas = document.createElement("canvas");
SoliditetCanvas.id = 'SoliditetCanvas';
SoliditetCanvas.height = 75;
SoliditetCanvas.width = 85;


var LikvidText = document.createElement("p");
LikvidText.id = 'LikvidText';
LikvidText.innerHTML = 'Liquidity' +'<br>' +'Ratio';

var LikvidData = document.createElement("p");
LikvidData.id = 'LikvidData';
LikvidData.style.fontWeight = 'bold';


var AfkastText = document.createElement("p");
AfkastText.id = 'AfkastText';
AfkastText.innerHTML = 'Return On <br> Investment';

var AfkastData = document.createElement("p");
AfkastData.id = 'AfkastData';
AfkastData.style.fontWeight = 'bold';


var SoliditetText = document.createElement("p");
SoliditetText.id = 'SoliditetText';
SoliditetText.innerHTML = 'Solvency <br> Ratio';

var SoliditetData = document.createElement("p");
SoliditetData.id = 'SoliditetData';
SoliditetData.style.fontWeight = 'bold';

// Create div containers for each gauge group
var likvidContainer = document.createElement('div');
var afkastContainer = document.createElement('div');
var soliditetContainer = document.createElement('div');

likvidContainer.classList.add('gauge-container');
afkastContainer.classList.add('gauge-container');
soliditetContainer.classList.add('gauge-container');

likvidContainer.appendChild(LikvidText);
likvidContainer.appendChild(LikvidData);
likvidContainer.appendChild(LikvidCanvas);

afkastContainer.appendChild(AfkastText);
afkastContainer.appendChild(AfkastData);
afkastContainer.appendChild(AfkastCanvas);

soliditetContainer.appendChild(SoliditetText);
soliditetContainer.appendChild(SoliditetData);
soliditetContainer.appendChild(SoliditetCanvas);

// Append the gauge containers to the parent element (elem)
const elem = document.getElementById('controlAddIn');

elem.appendChild(likvidContainer);
elem.appendChild(afkastContainer);
elem.appendChild(soliditetContainer);



Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('Ready', []);