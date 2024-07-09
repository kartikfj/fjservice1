// Function to open the request window
function openRequestWindow(data) {
    if (data.event.target.id == data.id) {
        selectedSeCode = data.seCode;
        selectedRow = data.row;
        selectedId = data.event.target.id;
        const singleFilteredRowItem = stage23List.filter(item => selectedId === item.cqhSysId)[0];
        const status = checkValue(singleFilteredRowItem.status);
        const priority = checkValue(singleFilteredRowItem.priority);
        const remarks = checkValue(singleFilteredRowItem.remarks);
        var topDimn = '' + (data.event.clientY - 60) + 'px';
        var msgbox = document.getElementById("requestWindow");
        var reasonbox = document.getElementById("reasonbox");
        if (msgbox == null) return;
        document.getElementById("remarks").value = remarks;
        var heading = document.getElementById("reasonheading");
        heading.innerHTML = "Stage-" + selectedStage + " followup";
        $("#requestWindow").css({ background: '#795548', opacity: 1, display: 'block', position: 'absolute', top: topDimn, right: '6%' });
        $("#reasonbox").css({ display: 'block' });
        setFilterSelectorSub(selectedStage, "statusUpdt", status, 'Status');
        setFilterSelectorSub(selectedStage, "priorityUpdt", priority, 'Priority');

        // Attach event listeners for individual updates
        document.getElementById("statusUpdt").addEventListener('change', applyIndividualUpdate);
        document.getElementById("priorityUpdt").addEventListener('change', applyIndividualUpdate);
        document.getElementById("remarks").addEventListener('input', applyIndividualUpdate);
    }
}

// Function to handle individual updates
function applyIndividualUpdate() {
    const data = {
        row: selectedRow,
        id: selectedId,
        stage: $.trim(selectedStage),
        status: $.trim($('#statusUpdt').val()),
        priority: $.trim($('#priorityUpdt').val()),
        remarks: $.trim($('#remarks').val()),
        seCode: selectedSeCode
    };
    if (data.status && data.remarks) {
        updateStage(data);
    } else {
        alert("Please select a status and enter remarks");
    }
}
