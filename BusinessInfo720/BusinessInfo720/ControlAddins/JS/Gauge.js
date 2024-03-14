Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('Ready', '');
function mapValueToRange(value, fromLow, fromHigh, toLow, toHigh) {
  return (value - fromLow) / (fromHigh - fromLow) * (toHigh - toLow) + toLow;
}

function CalculateAfkast(value) {
  // Calculate gaugeValue based on the percentage for different ranges
  if (value <= 1) {
    return value * 20;
  } else if (value > 1 && value <= 6) {
    return mapValueToRange(value, 1, 6, 20, 40);
  } else if (value > 6 && value <= 10) {
    return mapValueToRange(value, 6, 10, 40, 60);
  } else if (value > 10 && value <= 15) {
    return mapValueToRange(value, 10, 15, 60, 80);
  } else return 100
}

function CalculateSoliditet(value) {
  if (value <= 3) {
    return mapValueToRange(value, 0, 3, 0, 20);
  } else if (value > 3 && value <= 9) {
    return mapValueToRange(value, 3, 9, 20, 40);
  } else if (value > 9 && value <= 17) {
    return mapValueToRange(value, 9, 17, 40, 60);
  } else if (value > 17 && value <= 40) {
    return mapValueToRange(value, 17, 40, 60, 80);
  } else return 100
}

var Likviditetsgrad = {
  angle: -0.125, // The span of the gauge arc
  lineWidth: 0.22, // The line thickness
  radiusScale: 0.5, // Relative radius
  pointer: {
    length: 0.6, // // Relative to gauge radius
    strokeWidth: 0.035, // The thickness
    color: '#000000' // Fill color
  },
  limitMax: true,     // If false, max value increases automatically if value > maxValue
  limitMin: true,     // If true, the min value of the gauge will be fixed
  colorStart: '#6FADCF',   // Colors
  colorStop: '#8FC0DA',    // just experiment with them
  strokeColor: '#E0E0E0',  // to see which ones work best for you
  generateGradient: true,
  highDpiSupport: true,     // High resolution support

  staticLabels: {
    font: "0px sans-serif",  // Specifies font
    labels: [0, 50, 100, 150, 200, 250],  // Print labels at these values
    color: "#000000",  // Optional: Label text color
    fractionDigits: 0  // Optional: Numerical precision. 0=round off.
  },

  staticZones: [
    { strokeStyle: "#e73c42", min: 0, max: 50 },
    { strokeStyle: "#fbb72a", min: 50, max: 100 },
    { strokeStyle: "#aed39a", min: 100, max: 150 },
    { strokeStyle: "#4bae49", min: 150, max: 200 },
    { strokeStyle: "#1a8c37", min: 200, max: 250 }

  ],

};

var Afkastsgrad = {
  angle: -0.123, // The span of the gauge arc
  lineWidth: 0.22, // The line thickness
  radiusScale: 0.5, // Relative radius
  pointer: {
    length: 0.6, // // Relative to gauge radius
    strokeWidth: 0.035, // The thickness
    color: '#000000' // Fill color
  },
  limitMax: true,     // If false, max value increases automatically if value > maxValue
  limitMin: true,     // If true, the min value of the gauge will be fixed
  colorStart: '#6FADCF',   // Colors
  colorStop: '#8FC0DA',    // just experiment with them
  strokeColor: '#E0E0E0',  // to see which ones work best for you
  generateGradient: true,
  highDpiSupport: true,     // High resolution support

  staticLabels: {
    font: "0px sans-serif",  // Specifies font
    labels: [0, 20, 40, 60, 80, 100],  // Print labels at these values
    color: "#000000",  // Optional: Label text color
    fractionDigits: 0  // Optional: Numerical precision. 0=round off.
  },

  staticZones: [
    { strokeStyle: "#e73c42", min: 0, max: 20 },
    { strokeStyle: "#fbb72a", min: 20, max: 40 },
    { strokeStyle: "#aed39a", min: 40, max: 60 },
    { strokeStyle: "#4bae49", min: 60, max: 80 },
    { strokeStyle: "#1a8c37", min: 80, max: 100 }
  ],

};


var Soliditetsgrad = {
  angle: -0.123, // The span of the gauge arc
  lineWidth: 0.22, // The line thickness
  radiusScale: 0.5, // Relative radius
  pointer: {
    length: 0.6, // // Relative to gauge radius
    strokeWidth: 0.035, // The thickness
    color: '#000000' // Fill color
  },
  limitMax: true,     // If false, max value increases automatically if value > maxValue
  limitMin: true,     // If true, the min value of the gauge will be fixed
  colorStart: '#6FADCF',   // Colors
  colorStop: '#8FC0DA',    // just experiment with them
  strokeColor: '#E0E0E0',  // to see which ones work best for you
  generateGradient: true,
  highDpiSupport: true,     // High resolution support

  staticLabels: {
    font: "0px sans-serif",  // Specifies font
    labels: [0, 20, 40, 60, 80, 100],  // Print labels at these values
    color: "#000000",  // Optional: Label text color
    fractionDigits: 0  // Optional: Numerical precision. 0=round off.
  },

  staticZones: [
    { strokeStyle: "#e73c42", min: 0, max: 20 },
    { strokeStyle: "#fbb72a", min: 20, max: 40 },
    { strokeStyle: "#aed39a", min: 40, max: 60 },
    { strokeStyle: "#4bae49", min: 60, max: 80 },
    { strokeStyle: "#1a8c37", min: 80, max: 100 }
  ],

};


function SetLikviditetGauge(GaugeValue) {
  var target = document.getElementById('LikvidCanvas'); // your canvas element
  var gauge = new Gauge(target).setOptions(Likviditetsgrad); // create sexy gauge!

  var lastIndex = Likviditetsgrad.staticLabels.labels.length - 1;
  gauge.maxValue = Likviditetsgrad.staticLabels.labels[lastIndex];
  gauge.setMinValue(0);  // Prefer setter over gauge.minValue = 0
  //gauge.animationSpeed = 1; // set animation speed (32 is default value)
  var roundedVal = Math.round(GaugeValue);
  gauge.set(roundedVal); // set actual value
  var LikvidData = document.getElementById('LikvidData');
  LikvidData.textContent = roundedVal + '%';
  console.log(roundedVal);

  if (roundedVal < 50) {
    LikvidData.style.color = '#9c554d';
  } else if (roundedVal <= 100) {
    LikvidData.style.color = '#fbb72a';
  } else if (roundedVal <= 150) {
    LikvidData.style.color = '#aed39a';
  } else if (roundedVal <= 200) {
    LikvidData.style.color = '#4bae49';
  } else {
    LikvidData.style.color = '#1a8c37';
  }

}


function SetAfkastGauge(GaugeValue) {
  var target = document.getElementById('AfkastCanvas'); // your canvas element
  var gauge = new Gauge(target).setOptions(Afkastsgrad); // create sexy gauge!
  var lastIndex = Afkastsgrad.staticLabels.labels.length - 1;
  gauge.maxValue = Afkastsgrad.staticLabels.labels[lastIndex];
  gauge.setMinValue(0);  // Prefer setter over gauge.minValue = 0
  //gauge.animationSpeed = 1; // set animation speed (32 is default value)
  var roundedVal = Math.round(GaugeValue);
  var AfkastData = document.getElementById('AfkastData');
  AfkastData.textContent = roundedVal + '%';

  var ScaledGauge = CalculateAfkast(GaugeValue);
  gauge.set(ScaledGauge);

  if (roundedVal < 1) {
    AfkastData.style.color = '#9c554d';
  } else if (roundedVal <= 5.9) {
    AfkastData.style.color = '#fbb72a';
  } else if (roundedVal <= 9.9) {
    AfkastData.style.color = '#aed39a';
  } else if (roundedVal <= 15) {
    AfkastData.style.color = '#4bae49';
  } else {
    AfkastData.style.color = '#1a8c37';
  }
}

function SetSoliditetGauge(GaugeValue) {
  var target = document.getElementById('SoliditetCanvas'); // your canvas element
  var gauge = new Gauge(target).setOptions(Soliditetsgrad); // create sexy gauge!
  var lastIndex = Soliditetsgrad.staticLabels.labels.length - 1;
  gauge.maxValue = Soliditetsgrad.staticLabels.labels[lastIndex];
  gauge.setMinValue(0);  // Prefer setter over gauge.minValue = 0
  //gauge.animationSpeed = 1; // set animation speed (32 is default value)

  ScaledGauge = CalculateSoliditet(GaugeValue);
  gauge.set(ScaledGauge)

  var roundedVal = Math.round(GaugeValue);
  var SoliditetData = document.getElementById('SoliditetData');
  SoliditetData.textContent = roundedVal + '%';

  if (roundedVal < 3) {
    SoliditetData.style.color = '#9c554d';
  } else if (roundedVal <= 9) {
    SoliditetData.style.color = '#fbb72a';
  } else if (roundedVal <= 17) {
    SoliditetData.style.color = '#aed39a';
  } else if (roundedVal <= 40) {
    SoliditetData.style.color = '#4bae49';
  } else {
    SoliditetData.style.color = '#1a8c37';
  }
}