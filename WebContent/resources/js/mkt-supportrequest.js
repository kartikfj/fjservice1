// TO AVOID RE-SUBMISSION START
if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
//TO AVOID RE-SUBMISSION END
$(document).ready(function() {
	var newDate = new Date();
	var currentYear = newDate.getFullYear();
	 if ( window.history.replaceState ) {//script to avoid page resubmission of form on reload
	        window.history.replaceState( null, null, window.location.href );
	    }
	 $('#laoding').hide();
	 
	 $('#processOne').submit(function(evnt) {
		 if ((confirm('Are You sure You Want to submit this support request to marketing team'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	 $('#processTwo').submit(function(evnt) {
		 if ((confirm('Are You sure, You Want to acknowledge this support request!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	 $('#processThree').submit(function(evnt) {
		 if ((confirm('Are You sure, You Want to submit follow-up to sales engineer!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	 $('#processFour').submit(function(evnt) {
		 if ((confirm('Are You sure, You Want to close this support request!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
    
    //dynamic select tag division to product mapping
    $('#productsOpt').multiselect({
    	nonSelectedText: 'Select Products',
        includeSelectAllOption: true
    });
    getProducts();
    
    $('#displayLeads').DataTable( {
        dom: 'Bfrtip',
        "paging":   true,
        "ordering": false,
        "info":     false,
        "searching": true,
        "lengthMenu": [[ 5, 10, 15, 25, -1], [ 5, 10, 15, 25, "All" ]], 
         columnDefs:[{targets:[4,8,9, 10,12, 14,  15,   17, 18],className:"remove"},
        {targets:[0,1, 2, 3, 5, 6, 7, 11,13 ,16],className:"truncate"}],
        createdRow: function(row){
           var td = $(row).find(".truncate");
           td.attr("title", td.html());
      },
        buttons: [
            {
                extend: 'excelHtml5',
                text:      '<i class="fa fa-cloud-download" style="color: green; font-size: 1.5em;">Export</i>',
                filename: "Support Request Details - "+currentYear,
                title: "Support Request  Details -  "+currentYear,
                messageTop: 'The information in this file is copyright to Faisal Jassim Group.',
                exportOptions: {
                    columns: ':not(:last-child)',
                  }
                
                
            }
          
           
        ]
    } );
   
});
function getSeletedval(){
	
    var selectedValues = [];    
    $("#productsOpt :selected").each(function(){
        selectedValues.push($(this).val()); 
    });
    return true;
    //alert(selectedValues);
   
  
}
function formValidate(){
	var d1=document.forms["processOne"]["typ"].value;
	var d2=document.forms["processOne"]["seg"].value;
	var d3=document.forms["processOne"]["consultant"].value;
	var d4=document.forms["processOne"]["divn"].value;
	var d5=document.forms["processOne"]["prodct"].value;
	var d6=document.forms["processOne"]["iniDt"].value;
	var d7=document.forms["processOne"]["clsDt"].value;
	if($.trim(d1) != null && $.trim(d1) != '' && $.trim(d2) != null && $.trim(d2) !=''  && $.trim(d3) != null && $.trim(d3) !=''  && $.trim(d4) != null && (d4) !=''  && $.trim(d5) != null && (d5) !=''  && $.trim(d6) != null && (d6) !=''   && $.trim(d7) != null && (d7) !='' )
	{
		alert("Please Complete The Lead Form!");
		return false;
	}else{return true;}
	
}
function updateSegDetails(seg){ $('#segDtls').val($.trim($("#seg option:selected" ).text()));}
function getProducts(){
	 $('select[name=divn]').change(function(){ 
	      var division = $(this).val();
	  	  if(division  != ''){	
		    	 $.ajax({	        	    
		    		 'async': false,
		     		 type: 'POST',
		        	 url: 'SupportRequest',
		        	 data: {action: "prdctlist", cd1:division},
		        	 beforeSend: function() {
		        		 $('#productsOpt').empty(); 
		        	    },
			  		 success: function(data) {
			  			  var toAppend = ""; 
				  		  $.each(data,function(i,o){
				  	         toAppend += '<option value="'+data[i].product+'">'+data[i].product+'</option>';
				  			$('#productsOpt').html(data[i].product);
				  	      });
				  	      $('#productsOpt').append(toAppend);	
				  	      
				  	    
				        $('#productsOpt').multiselect('rebuild');		    			    
			  },
			  error:function(data,status,er) {	        		
			    console.log("NO Products");
			   }
			 });
	       }
	  	  else{$('#productsOpt').empty();}
	    });
}

function checkSuccesStatusValidation(soNo, prjctCode){ 
	var statusVal =$("#mktStatSlct option:selected" ).val();
	if(soNo != '' && soNo != null && prjctCode != '' && prjctCode != null && statusVal == 1){
		 //$('#mktcmnt').val('Lead Success');
		 $('#mktcmnt').val('Lead Success');
		 $('#mktcmnt').attr('readonly', true);
		 //document.getElementById("mktcmnt").disabled = true;
	}
	else{
		$('#mktcmnt').val('')
		 $('#mktcmnt').attr('readonly', false);
	}
}

function checkSuccessValidation(soNo, prjctCode){ 
	var statusVal =$("#mktStatSlct option:selected" ).val();
	alert(soNo+" "+prjctCode+" "+statusVal);
	if(soNo != '' && soNo != null && prjctCode != '' && prjctCode != null && statusVal == 1){
		 $('#mktcmnt').val('Lead Success');
		 document.getElementById("mktcmnt").disabled = true;
		alert('so num avail');
		return true;
	}
	else{
		return false
	}
}
	
function preLoader(){ $('#laoding').show();}	
