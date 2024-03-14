Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('Ready', '');

let inputTimer;

function AttachFieldListener() {
    const search = window.parent.document.querySelector('div[controlname="SerachVar"]');
    const fieldToMonitor = search.querySelector('input');
    console.log('Enter');
    if (fieldToMonitor) {
        fieldToMonitor.addEventListener('input', function () {
            const fieldValue = fieldToMonitor.value;
            console.log('Field value changed to:', fieldValue);

            clearTimeout(inputTimer);

            inputTimer = setTimeout(function () {
                console.log('No change for 1 second. Invoking GetFieldValue with:', fieldValue);
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('GetFieldValue', [fieldValue]);
            }, 500);
        });
    } else {
        console.error('Element with ID "searchVar" not found.');
    }
}
