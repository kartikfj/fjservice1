
$(document).ready(function(){ 
	 $('#laoding').hide();
	
	 $(".knob").knob({
	    	
		    
 	    
	    	
 		
	    	
	    	
	      /*change : function (value) {
	       //console.log("change : " + value);
	       },
	       release : function (value) {
	       console.log("release : " + value);
	       },
	       cancel : function () {
	       console.log("cancel : " + this.value);
	       },*/
	      draw: function () {

	    
	      
	      }
	    });
	 $(".toggler").click(function(e){
	        e.preventDefault();
	        $('.lead-data'+$(this).attr('data-lead-cat')).toggle();
	    });
	 $(".toggler").click(function(e){
	        e.preventDefault();
	        $('.lead-mth-data'+$(this).attr('data-mth-lead-cat')).toggle();
	    });
	 
	 

	    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	        $($.fn.dataTable.tables(true)).DataTable()
	           .columns.adjust()
	           .responsive.recalc();
	    }); 
	 $('#mkt-dashboard-table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: #065685; font-size: 1.5em;">Export</i>',
	                filename: 'FJ-Marketing Dashboard Sales lead Anlysys Details - Yearly ',
	                title: 'FJ-Marketing Dashboard Sales lead Anlysys Details - Yearly ',
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	 $('#mkt-mth-dashboard-table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: #065685; font-size: 1.5em;">Export</i>',
	                filename: 'FJ-Marketing Dashboard Sales lead Anlysys Details - Monthly',
	                title: 'FJ-Marketing Dashboard Sales lead Anlysys Details - Monthly',
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	 
	 
	 
});



