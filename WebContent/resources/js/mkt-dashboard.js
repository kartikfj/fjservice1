
$(function(){ 
	 $('#laoding').hide();	
     $("#fromdate").datepicker({ "dateFormat" : "dd-mm-yy", yearRange: "2020:2030"});
     $("#todate").datepicker({"dateFormat" : "dd-mm-yy",maxDate : 0 });     
	 $(".knob").knob({ draw: function (){}});
	 $(".toggler").click(function(e){
	        e.preventDefault();
	        $('.lead-data'+$(this).attr('data-lead-cat')).toggle();
	    });
	    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	        $($.fn.dataTable.tables(true)).DataTable()
	           .columns.adjust()
	           .responsive.recalc();
	    }); 	
});

function setDeafultToDate(){
	$( "#todate" ).datepicker("option", "minDate", $("#fromdate").datepicker('getDate')); 	 
}

