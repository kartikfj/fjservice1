// TO AVOID RE-SUBMISSION START
if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
//TO AVOID RE-SUBMISSION END
$(function(){ 
	 $('#laoding-stage2').hide();	    
	 var count = 0;

	/* $('#add').click(function(){
			// $("#processOne")[0].reset(); 
		// $("#type").val([]);
		 //$("#type option[selected]").removeAttr("selected");    
		
		// var x = document.forms["processOne"]["typ"];
		// x.remove(x.selectedIndex);
	 });
*/
	 $('#save').click(function(){
		// alert(document.document.getElementsByClassName('prjctCode1').textContent);
	  if(formValidate()){ 		  
		     var d1=document.forms["newLeadForm"]["typ"].value;
		     var d2=document.forms["newLeadForm"]["seg"].value;
		     var d3=document.forms["newLeadForm"]["consultant"].value;
		     var d4=document.forms["newLeadForm"]["divn"].value;
			 var d5=document.forms["newLeadForm"]["leadRemarks"].value;
			 var d6=document.forms["newLeadForm"]["prjctDtls"].value;
			 var d7=document.forms["newLeadForm"]["contractor"].value;
			 var d8=document.forms["newLeadForm"]["leadCode"].value;
			 var d9=document.forms["newLeadForm"]["segDtls"].value;
			 var d10 = $.trim($("#typ").children("option:selected").text())
		     var d11 = $.trim($("#typ").children("option:selected").attr('class'));
			 var d12 = getSeletedDivisions();
			 var d13 = document.forms["newLeadForm"]["s2PjctCode"].value;
			 if(d1 != 'SL013'){d12=''; d13 = '';}
	   if($('#save').text() == 'Save')
	   {  
	    count = count + 1;
	    output = '<tr id="row_'+count+'">';
	    output += '<td>FJMKT'+d8+' <input type="hidden" name="hidden_lead_code[]" id="lead_code'+count+'" class="lead_code" value="'+d8+'" /></td>';
	    output += '<td>'+d10+' <input type="hidden" name="hidden_lead_type[]" id="lead_type'+count+'" class="lead_type" value="'+d1+'" /><input type="hidden" name="hidden_leadType_desc[]" id="lead_typeDesc'+count+'" class="lead_typeDesc" value="'+d10+'" /><input type="hidden" name="hidden_no_of_process[]" id="no_ofProcess'+count+'" class="no_ofProcess" value="'+d11+'" /></td>';
	    output += '<td>'+d4+' <input type="hidden" name="hidden_division[]" id="division'+count+'" class="division" value="'+d4+'" /></td>';
	    output += '<td>'+getSeletedval()+' <input type="hidden" name="hidden_products[]" id="products'+count+'" class="products" value="'+getSeletedval()+'" /></td>';
	    output += '<td>'+d9+' <input type="hidden" name="hidden_segCode[]" id="seg'+count+'" class="seg" value="'+d2+'" /><input type="hidden" name="hidden_segDtls[]" id="segDtls'+count+'" class="segDtls" value="'+d9+'" /></td>';
	    output += '<td>'+d6+' <input type="hidden" name="hidden_project_details[]" id="project_details'+count+'" class="project_details" value="'+d6+'" /></td>';
	    output += '<td>'+d7+' <input type="hidden" name="hidden_contractor[]" id="contractor'+count+'" class="contractor" value="'+d7+'" /></td>';
	    output += '<td>'+d3+' <input type="hidden" name="hidden_consultant[]" id="contractor'+count+'" class="consultant" value="'+d3+'" /></td>';
	    output += '<td>'+d5+' <input type="hidden" name="hidden_remarks[]" id="contractor'+count+'" class="remarks" value="'+d5+'" /></td>';
	    output += '<td>'+d12+' <input type="hidden" name="hidden_qtd_divisions[]" id="qtdDivisions'+count+'" class="qtdDivisions" value="'+d12+'" /></td> <input type="hidden" name="hidden_s2_prjctCode[]" id="s2pCode'+count+'" class="s2pCode" value="'+d13+'" />';
	    output += '<td><button type="button" name="remove_details" class="btn btn-danger btn-xs remove_details" id="'+count+'">Remove</button></td>';
	    output += '</tr>';
	    $("#modal-new-lead").modal('hide');
	    $('#user_data').append(output);
	   }
	   else
	   {
	    var row_id = $('#hidden_row_id').val();
	    output = '<td>'+d1+' <input type="hidden" name="hidden_lead_code[]" id="lead_code'+row_id+'" class="lead_code" value="'+d1+'" /></td>';
	    output += '<td><button type="button" name="remove_details" class="btn btn-danger btn-xs remove_details" id="'+row_id+'">Remove</button></td>';
	    $('#row_'+row_id+'').html(output);
	   }

	  // $('#user_dialog').dialog('close');
	  }else{
		  alert("Please Complete The Lead Form!");
	  }
	 });

	 $(document).on('click', '.remove_details', function(){
	  var row_id = $(this).attr("id");
	  if(confirm("Are you sure you want to remove this row data?")){
	   $('#row_'+row_id+'').remove();
	  }
	  else
	  {
	   return false;
	  }
	 });

/*

	 $('#processOne').on('submit', function(event){
	//  event.preventDefault();
	  var count_data = 0;
	  $('.lead_code').each(function(){
	   count_data = count_data + 1;
	  });
	 // alert(count_data);
	  if(count_data > 0 && count_data <= 5 ){		
	     if((confirm('Are You sure, You Want to submit this lead to sales engineer!'))){
	    	 
	    	preLoader();  
	  	    var form_data = $(this).serialize();
	  	   $.ajax({
	  	    url:"SalesLeads",
	  	    method:"POST",
	  	    data:form_data,
	  	    success:function(data)
	  	    {
	  	     $('#user_data').find("tr:gt(0)").remove();
	  	     $('#action_alert').html('<p>Data Inserted Successfully</p>');
	  	    // $('#action_alert').dialog('open');
	  	    }
	  	   });
	  	   
	     }else{
	    	 return false;
	     }
	   
	  }else{
		  if(count_data > 5){
		  $('#action_alert').html('<p>Maximum 5 entries.</p>');
		  }else{
	      $('#action_alert').html('<p>Please Add atleast one data</p>');
		  }
	   return false;
	  // $('#action_alert').dialog('open');
	  }
	 });
	 
*/

	    var newDate = new Date();
		var currentYear = newDate.getFullYear();
	 if ( window.history.replaceState ) {//script to avoid page resubmission of form on reload
	        window.history.replaceState( null, null, window.location.href );
	    }
	 $('#laoding').hide();
	
	 $('#processOne').submit(function(evnt) {
		  var count_data = 0;
		  $('.lead_code').each(function(){
		   count_data = count_data + 1;
		  });
		if(count_data > 0 && count_data <= 5 ){	
		 if ((confirm('Are You sure, You Want to submit this lead to sales engineer!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		}else{
		 if(count_data > 5){			 
			$('#action_alert').html('<div class="alert alert-danger alert-dismissible fade in"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>Maximum 5 entries!</strong> Please remove other entries. </div>');
			return false;
		}else{			
			 $('#action_alert').html('<div class="alert alert-danger alert-dismissible fade in"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>Please Add atleast one data!</strong> </div>');
			 return false;
		     }			
		}
		});

	 $('#processTwo').submit(function(evnt) {		
		 if ((confirm('Are You sure, You Want to acknowledge this lead!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	 $('#processThree').submit(function(evnt) {
		 var workingStatus = $('#p3Update').val();
		 var previousProcess = $('#lastProccssedFp').val();	
		 if(valiDateSEFollowUp(previousProcess, workingStatus)){
		 if ((confirm('Are You sure, You Want to updated the details!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		 }else{
			 alert('Please fill mandatory fields.');
			 return false;
		 }
		});
	 
	 $('#processFour').submit(function(evnt) {
		 if ((confirm('Are You sure, You Want to cose this lead!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	 
	$('.select2').select2();
	 //Date picker
 /*
     $('#closedate, #intDate').datepicker({
      autoclose: true
    });
 */  
    //dynamic select tag division to product mapping
    $('#productsOpt').multiselect({
    	nonSelectedText: 'Select Products',
        includeSelectAllOption: true
    });
    getProducts();
    
    
    
   
    $('#qtdDivns_list').multiselect({
    	nonSelectedText: 'Select already Qtd. Divisions',
        includeSelectAllOption: true
    });
    
});
function getSeletedDivisions(){	
    var selectedValues = [];    
    $("#qtdDivns_list :selected").each(function(){
        selectedValues.push($(this).val()); 
    });
   // alert(selectedValues) ;
   // return true;
    return selectedValues;   

}
function validateS2EntryLead(d1, d2){	
	  if($.trim(d1) != '' && $.trim(d1) != null && $.trim(d2) != '' && $.trim(d2) != null  && $.trim(d2) != 'undefined'  ){
		  return true;
	  }else{return false;}

	}
function getAckText(){	
	var description = $.trim($("#p2Update").children("option:selected").text());
	 $("#p2ackDesc").val(description);   
}
function getFollowUpAckText(){
	var description = $.trim($("#p3Update").children("option:selected").text());
	var mailStatus = $.trim($("#p3Update").children("option:selected").attr('class'));
	$("#p3FupAckDesc").val(description); 
	$("#p3FupMailYn").val(mailStatus);
	//alert(description+" -> "+mailStatus);
}
function getSeletedval(){	
    var selectedValues = [];    
    $("#productsOpt :selected").each(function(){
        selectedValues.push($(this).val()); 
    });
   // console.log(selectedValues);
    //return true;
    return selectedValues;   
}

function getStage2ProjectDetails(){
	$('#stage2Div2').css('display','none');
	var projectCode = document.getElementById('orionPCode').value;
	//alert(projectCode);
	if(projectCode  != ''){	
		 $('#laoding-stage2').show();
		$.ajax({ type: 'POST', url: 'SalesLeads',
       	 data: {action: "stage2Project", cd1:projectCode },  dataType: "json",	 
       		 success: function(data) {      			
       			 $('#laoding-stage2').hide();
       			 var output="<table class='table table-hover small marketing-dtls-table dataTable no-footer'>"+
	  			 "<tr><thead style='backgrond:gray;'>"+
		        "<th>Project Code</th> <th>Project Name</th> <th>Consultant Code</th> <th>Consultant Name</th>"+
		        "<th>Main Contractor Code</th> <th>Main Contractor Name</th> <th>MEP Contractor Code</th> <th>MEP Contractor Name</th>"+
		        "<th>Zone</th> <th>Client</th> <th>Division - S.Eng.</th>"+ 
		        "</tr></thead><tbody>";	  
	  			 var j=0; 
	  			 for (var i in data) { j=j+1;
	  			  if(j == 1){ $('#s2PjctCode').val(data[i].prjctCode);}
		        	output += "<tr><td>" + data[i].prjctCode + "</td><td>" + data[i].projectDetails+ "</td><td>" + data[i].consultantCode + "</td>" +
		        			"<td>" + data[i].consultantName + "</td><td>" + data[i].mainContCode + "</td><td>" + data[i].mainContName + "</td>" +
		        			"<td>" + data[i].mepContCode + "</td><td>" + data[i].mepContName + "</td>" +
		        			"<td>" + data[i].zone + "</td><td>" + data[i].client + "</td><td>" + data[i].segDivDetails + "</td></tr>";
	  			 } 
	  			 output+="</tbody></table>";  
       			
	  			 $('#stage2Div2').css('display','block');
	  			 
	  			 if(j > 0 ){
	  				 $('#stage2Div3').css('display','block');
	  				 $("#stage2DivDtls").html(output);
	  				 $('#leadMjrDtls').fadeTo('slow',1);
	  				  $("#leadMjrDtls").find("input,select,textarea,button").prop("disabled",false);
	       		}else{
	       			$('#action_alert').html("<b style='color:red;'>No result found for this project code</b>");
	       			}
	  },
	  error:function(data,status,er) {	        		
	    console.log("NO Products");
	   }
	 });
  } else{
	  $('#stage2Div2').css('display','block');
	  $("#stage2DivDtls").html("<b style='color:red;'>Please enter a project code</b>");
	  }

}
function checkLeadType(){
	  var d1=document.forms["newLeadForm"]["typ"].value;
	  $('#s2PjctCode').val("");

	  if(d1=='SL013'){
		 // alert(d1);  
		  //$("#leadMjrDtls").children().attr("disabled","disabled");
		  $('#stage2Div1').css('display','block');
		  //$('#leadMjrDtls').css('display','none');
		  $('#leadMjrDtls').fadeTo('slow',.6);
		  $("#leadMjrDtls").find("input,select,textarea,button").prop("disabled",true);
	  }else{
		 
		  $('#stage2Div1, #stage2Div2, #stage2Div3').css('display','none');
		  $('#leadMjrDtls').fadeTo('slow',1);
		  $("#leadMjrDtls").find("input,select,textarea,button").prop("disabled",false);
		 
	  }
	   
	// 1.check leade type code 
	// 2. if SLO13 
	// 2.1 prevent default, hide all other details
	//     a. show product code entry
	//       b. get Product details from oRION
	//       c.if details is there change div and inser dats in form fields
	//       d. if not keep hide
	// 2.2 continue
}
function formValidate(){
	
	var d1=document.forms["newLeadForm"]["typ"].value;
	var d2=document.forms["newLeadForm"]["seg"].value;
	var d4=document.forms["newLeadForm"]["divn"].value;
	var d5=document.forms["newLeadForm"]["prodct"].value;
	var d6=document.forms["newLeadForm"]["leadRemarks"].value;
	var d7=document.forms["newLeadForm"]["prjctDtls"].value;
	var d8=document.forms["newLeadForm"]["leadCode"].value;
	var d12 = getSeletedDivisions();
	var d13 = document.forms["newLeadForm"]["s2PjctCode"].value;
	//alert(d13);
	if($.trim(d1) != null && $.trim(d1) != '' && $.trim(d2) != null && $.trim(d2) !=''  && $.trim(d4) != null && (d4) !=''  && $.trim(d5) != null && (d5) !=''  && $.trim(d6) != null && (d6) !=''   && $.trim(d7) != null && (d7) !='' && getSeletedval() !== null && getSeletedval() != ''  && $.trim(d8) != null && (d8) !='' )
	{		
		return (d1=='SL013')?validateS2EntryLead(d12, d13):true;	
	}else{return false;}
	
}
function updateSegDetails(seg){ $('#segDtls').val($.trim($("#seg option:selected" ).text()));}
function getProducts(){
	 $('select[name=divn]').change(function(){ 
		 $('#laoding-stage2').show();
	      var division = $(this).val();
	  	  if(division  != ''){	
	  		 
		    	 $.ajax({	        	    
		    		 //'async': false,
		     		 type: 'POST',
		        	 url: 'SalesLeads',
		        	 data: {action: "prdctlist", cd1:division},
		        	 beforeSend: function() {
		        		 $('#productsOpt').empty(); 
		        	    },
			  		 success: function(data) {
			  			 $('#laoding-stage2').hide();
			  		  var toAppend = ""; 
			  		  $.each(data,function(i,o){
			  	         toAppend += '<option value="'+data[i].product+'">'+data[i].product+'</option>';
			  			$('#productsOpt').html(data[i].product);
			  	      });
			  	      $('#productsOpt').append(toAppend);	
			  	      
			  	    
			        $('#productsOpt').multiselect('rebuild');
			  	      
			  	     
			  },
			  error:function(data,status,er) {	        		
				  $('#laoding-stage2').hide();console.log("NO Products");
			   }
			 });
	       }
	  	  else{$('#productsOpt').empty(); $('#laoding-stage2').hide();}
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
	//alert(soNo+" "+prjctCode+" "+statusVal);
	if(soNo != '' && soNo != null && prjctCode != '' && prjctCode != null && statusVal == 1){
		 $('#mktcmnt').val('Lead Success');
		// document.getElementById("mktcmnt").disabled = true;
		//alert('so num avail');
		return true;
	}
	else{
		return false
	}
}
function preLoader(){ $('#laoding').show();}	

function valiDateSEFollowUp(previousProcess, workingStatus){
	//alert(previousProcess+" "+workingStatus);
	
	var d1  = document.forms["processThree"]["prjctCode"].value;
	var d2  = document.forms["processThree"]["offerval"].value;
	var d3  = document.forms["processThree"]["seremarks"].value;
	var d4  = document.forms["processThree"]["loi"].value;
	var d5  = document.forms["processThree"]["soNum"].value;
	var d6  = document.forms["processThree"]["lpo"].value;	
	var alertMessage = "";
//	alert("loi "+d4+" lpo "+d6+" pcode "+d1);
	if(previousProcess == 0 && workingStatus == 3){
		if( $.trim(d1) != null && $.trim(d1) !='' && $.trim(d2) != null && $.trim(d2) !='' && $.trim(d3) != null && $.trim(d3) !=''  ){
			//alert("stage 0");
	      return true;
	}else{
	    	 return false;
	 }
	}else if(previousProcess == 1 &&  workingStatus == 3){
		if( $.trim(d1) != null && $.trim(d1) !='' && $.trim(d2) != null && $.trim(d2) !='' && $.trim(d3) != null && $.trim(d3) !='' && $.trim(d4) != null && $.trim(d4) !='' && $.trim(d4) == 1 ){
			//alert("stage 1 true");
		      return true;
		      }else{
		    		//alert("stage 1 false");
		    	  return false;
		    	  }
	}else if(previousProcess == 2 && workingStatus == 1){
		if( $.trim(d1) != null && $.trim(d1) !='' && $.trim(d2) != null && $.trim(d2) !='' && $.trim(d3) != null && $.trim(d3) !='' && $.trim(d4) != null && $.trim(d4) !='' && $.trim(d5) != null && (d5) !='' && $.trim(d4) == 1 && $.trim(d6) == 1){
			//alert("stage 2 true");
		      return true;
		      }else{
		    	//  alert("stage 2 true");
		    	  return false;
		    	  }
	}else if(workingStatus == 2){
		if( $.trim(d3) != null && $.trim(d3) !=''  ){
			//alert("working status 2");
	      return true;
	}else{
	    	  return false;
	 }
	}else{
		console.log('Follow up is not valid');
		return false;
	}
	
	
}	

function loiCkChange(ckType){	
	//alert(ckType.value);
	if(ckType.checked){
		document.forms["processThree"]["loi"].value= 1;	
	}else{
		document.forms["processThree"]["loi"].value= 0;		
	}	
}

function lpoCkChange(ckType){	
	//alert(ckType.checked);
	if(ckType.checked){
		document.forms["processThree"]["lpo"].value= 1;	
	}else{
		document.forms["processThree"]["lpo"].value= 0;		
	}	
}
function setDeafultToDate(){
	$( "#todate" ).datepicker("option", "minDate", $("#fromdate").datepicker('getDate')); 	 
}