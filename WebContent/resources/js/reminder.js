/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function showReminderRequest(event,theDayStr,theDate,swipeDetails, custVstCount,allowVisitPlanner){
	
	alrdyUpdtdVstCnt = parseInt(custVstCount); 
	allowVisitPlanner = parseInt(allowVisitPlanner);
	fregOptnSts = 0;//regularisation only
	var title = "Reminder "; 
    clearCustomerVisitDetails1(); 
   //FOR CUST VISIT END 
    var msgbox = document.getElementById("reminderformdiv");     
    if(msgbox ==null) return; 
    var outerdiv = document.getElementById("day_"+theDate);  
    if(outerdiv == null)return;
    var innderdiv = document.getElementById("innerday_"+theDate);  
    if(innderdiv == null)return;
    msgbox.style.display="block"; 
    document.getElementById("thereminderreason").value=""; 
   
    var custVstbox = document.getElementById("custreminderRqstBox");
    if(custVstbox != null && custVstbox != 'undefined' && custVstbox != ''){	custVstbox.style.display="block"; enableClickOnCustomerVisitDiv1();	}
   // alert("allowVisitPlanner== "+allowVisitPlanner);
   //alert("allowVisitPlanner== "+allowVisitPlanner);
	if(allowVisitPlanner == 1){//alert("in ifff");
		var title = "Reminder/Cust Visit Planner ";	
		if(alrdyUpdtdVstCnt > 0 && alrdyUpdtdVstCnt < 7){//alert("alrdyUpdtdVstCnt");
	    		enableCustomerVisitPlannerTab1();	    		
	    	}else if(alrdyUpdtdVstCnt > 0 && alrdyUpdtdVstCnt == 7){//alert("else iffff");
	    		disableCustomerVisitPlannerTab1();	
	    		disableNewVisitBtn1();   
	    		var title = "Reminder  ";	 		
	    	}else{
				enableCustomerVisitPlannerTab1();
				}
    	}else{//alert("elseeeee");
			/*if(alrdyUpdtdVstCnt > 0 && alrdyUpdtdVstCnt < 7){
	    		disableRegularisationTab1();
	    		//fregOptnSts = 3;//customer visit with regularization 
	    	}else if(alrdyUpdtdVstCnt > 0 && alrdyUpdtdVstCnt == 7){
	    		disableRegularisationTab1();
	    		disableNewVisitBtn1();
	    		//fregOptnSts = 3;//customer visit with regularization 
	    	}else{
				//fregOptnSts = 3;
	    		disableCustomerVisitPlannerTab1();
	    	}  */
	    	disableCustomerVisitPlannerTab1();
	    	//disableNewVisitBtn1();
		}	
    //}   
    var theform = document.getElementById("reminderform");
    theform.style.display = "block";
    setFormParamsPl(title, theDayStr, theDate, swipeDetails);
    msgbox.style.position="absolute";     
    msgbox.style.left =event.clientX+"px";
    msgbox.style.top=event.clientY+"px"; 
}
function setFormParamsPl(title, theDayStr, theDate, swipeDetails){
    var heading = document.getElementById("formreminderheading");
    if($.trim(swipeDetails) == "Future"){
    heading.innerHTML= ""+title+" for "+theDayStr;
    }else{
	heading.innerHTML= ""+title+" for "+theDayStr;
	}
    var dtfld = document.getElementById("regularise_date");
    dtfld.value = theDayStr;
    document.getElementById("idate").value = theDate;
    document.getElementById("ichkin").value = swipeDetails;
}
function closeRequestWindow1(){
    //console.log("here2");   
    var msgbox = document.getElementById("reminderformdiv");
    msgbox.style.display="none";
    
}

function fApply(button){
    var theUrl= "regularisationRequest.jsp";
    var params = '';var tabSel;
    var thereason,visitType,projectName,customerName;
    //button.disabled=true;
    var thedate = document.getElementById("regularise_date").value;    
    var encoded_dt = encodeURI(thedate);    
    if(document.getElementById("thereminderreason") != null && document.getElementById("thereminderreason") != '')
     thereason = document.getElementById("thereminderreason").value;
    var thechkin = document.getElementById("ichkin").value;  
     if(document.getElementById("remindervstTyp") != null && document.getElementById("remindervstTyp") != '')
    	 visitType = document.getElementById("remindervstTyp").value;
     if(document.querySelector('input[name=remindertab]:checked') != null){
     	 tabSel = document.querySelector('input[name=remindertab]:checked').value;  
    	}  	     
     if(tabSel == 1){
		fregOptnSts = 4;
		}else if(tabSel == 2){
			fregOptnSts = 3;
		}else{
			fregOptnSts = 0;
		}
	
    /* if(visitType == 1 && document.getElementById("rprojectName") != null && document.getElementById("rprojectName") != '')
       projectName = document.getElementById("rprojectName").value;   */     
      if(document.getElementById("rcustName") != null && document.getElementById("rcustName") != '')
       customerName = document.getElementById("rcustName").value;
     //alert("thedate"+thedate);
     // var fregOptnSts = document.getElementById("fregOptnSts").value;
    if(thedate = null || thedate == '' ){
        alert("Please refresh the page and try again!");
        button.disabled=true;
        return;
    }
     if(fregOptnSts == 0){ // Reminder for normal user
        thereason=thereason.trim();
    	 if(thereason == null || thereason == ""){
    	        alert("Please fill the reminder"); 
    	        button.disabled=false;
    	        thereason.focus();
    	        return;
    	    }  	   
    	    
    	  params = "regularise_date="+encoded_dt+"&reminderDesc="+thereason+"&chkin="+thechkin+"&regOptnSts=4&userType=0";
    	  disableClickOnCustomerVisitDiv1();
    }else if(fregOptnSts == 4){
    	 if(visitType == null || visitType == ""){
    	        alert("Please Select Visit Type");    	       
    	        //visitType.focus();
    	        return;
    	    }   
    	    if(visitType == 1){	  
				fdocId = 'General';
	    	    /* if(projectName == null || projectName == ""){
	    	        alert("Please fill the ProjectName");
	    	       button.disabled=false;
	    	        return;
	    	    }*/
    	    }
    	    if(customerName == null || customerName == ""){
    	        alert("Please fill the Description");
    	       // button.disabled=false;
    	        return;
    	    }
    	   if(visitType == 2){	//alert("docid "+$.trim(fdocId)+"project "+$.trim(fprojectName))
				projectName = fprojectName;
				
	    	   if($.trim(visitType) == null || $.trim(visitType) == '' || $.trim(fdocId) == null || $.trim(fdocId) == ''  ||  $.trim(fprojectName) == '' || $.trim(fprojectName) == null ){
		    	 alert("Please select a  Project");
		    	 button.disabled=false;
		    	return false;
		    	}
	    	}
	    	 if(visitType == 1){
				 params = "regularise_date="+encoded_dt+"&reason="+thereason+"&regOptnSts="+fregOptnSts+"&reminderDesc="+customerName+"&reminderType="+fdocId+"&userType=1";
			}else{
		 		 params = "regularise_date="+encoded_dt+"&reason="+thereason+"&regOptnSts="+fregOptnSts+"&projectName="+projectName+"&reminderDesc="+customerName+"&reminderType="+fdocId+"&partyName="+fparty+"&userType=1&hsysId="+hsysId;
		 	}
		    disableClickOnCustomerVisitDiv1();
    }else if(fregOptnSts == 1){ 
    	 if(cvDetails.length == 0 && alrdyUpdtdVstCnt == 0){ 
    		 alert("Please add atleast one customer visit details (Maximum 7).");
    		 button.disabled = false;
    		 return;
    	 }else{
    		var alertMessage = getRegulariztnCustVstAlrtMssg1(alrdyUpdtdVstCnt, cvDetails.length);
    		  		
    		 preSendLoaderStyle1();
    		 document.getElementById("alrdyUpdtdVsts").value = alrdyUpdtdVstCnt; 
    		 if(confirm(alertMessage)){
    			 var jsonDetails = encodeURIComponent(JSON.stringify((cvDetails)));
    	    	 params = "regularise_date="+encoded_dt+"&reason="+thereason+"&chkin="+thechkin+"&regOptnSts="+fregOptnSts+"&details="+jsonDetails+"&alrdyUpdtdVsts="+alrdyUpdtdVstCnt;
    	    	 disableClickOnCustomerVisitDiv1();
   		  }
   		  else {enableClickOnCustomerVisitDiv1(); return; }   		  	 
    	 }
    }else if(fregOptnSts == 3){
    	 if(cvDetails.length == 0){
    		 alert("Please add atleast one customer visit details (Maximum 7).sdfsdfdsfsdfsd");
    		 button.disabled=false; 
    		 return;
    	 }else{
    		 preSendLoaderStyle1();
    		 if(fregOptnSts == 2){
		    	 if(confirm("You will not be able to  modify this customer visit later. Do you still want to update ?")){
		    		      var jsonDetails = encodeURIComponent(JSON.stringify((cvDetails)));
		    		      params = "regularise_date="+encoded_dt+"&reason="+thereason+"&chkin="+thechkin+"&regOptnSts="+fregOptnSts+"&details="+jsonDetails+"&alrdyUpdtdVsts="+alrdyUpdtdVstCnt+"&userType=2";
		    		      disableClickOnCustomerVisitDiv1();
		    		  }	    		  
	    		  else { enableClickOnCustomerVisitDiv1(); return; }
	    		  }else{
					if(confirm("This is Customer Visit Planner.You will be able to change till one day prior.")){
		    		      var jsonDetails = encodeURIComponent(JSON.stringify((cvDetails)));
		    		      params = "regularise_date="+encoded_dt+"&reason="+thereason+"&chkin="+thechkin+"&regOptnSts="+fregOptnSts+"&details="+jsonDetails+"&alrdyUpdtdVsts="+alrdyUpdtdVstCnt;
		    		      disableClickOnCustomerVisitDiv1();
		    		  }	    		  
	    		  else { enableClickOnCustomerVisitDiv1(); return; }
	               }	    	
    	 } 
    	 
    }else{
    	 alert("Please refresh the page and try again!");
    	 button.disabled=true;
    	 return;
    } 
       
   // var jsonDetails = CryptoJS.enc.Base64.parse(encodeURIComponent(JSON.stringify((cvDetails))));
           
    var heading = document.getElementById("formreminderheading");
    heading.innerHTML="Being processed.."
    var xhttp;
    if (window.XMLHttpRequest) {
        xhttp = new XMLHttpRequest();
        } else {
        // code for IE6, IE5
        xhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
        button.disabled=false;
     if(xhttp.responseText != null){
        var start = xhttp.responseText.lastIndexOf('<body>')+7;
        var end = xhttp.responseText.lastIndexOf('</body>');
        var bodytxt = xhttp.responseText.substring(start,end);
        heading.innerHTML=bodytxt;
        
        if(fregOptnSts == 0){
        	var msgbox = document.getElementById("reminderform");
            msgbox.style.display="none";
        	document.getElementById("thereminderreason").value="";
        	hideCustVisitBox1(); 
        }else{        	 
        	hideCustVisitBox1();   	
        }
                 
        var idate=document.getElementById("idate").value;
        var outerdiv = document.getElementById("day_"+idate);  
      
        if(fregOptnSts == "0" || fregOptnSts == "4" || fregOptnSts == "0"){
         outerdiv = document.getElementById("innerday_"+idate);         
        }
        replaceResponseImage1(outerdiv, fregOptnSts); 
        /////////
         if (outerdiv.removeEventListener) {                   
            outerdiv.removeEventListener("click", showReminderRequest,false);
        } else if (outerdiv.detachEvent) {                    // For IE 8 and earlier versions
            outerdiv.detachEvent("onclick", showReminderRequest,'','','',1);
        }
        //////////
    }
    }else{
      // maindiv.innerHTML="Error in processing." ;
    }
  };
  xhttp.open("POST", theUrl, true); 
  xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  xhttp.send(params); 
  
}

function disableClickOnCustomerVisitDiv1(){
	var cvisitbox = document.getElementById("custreminderRqstBox");  
	if(cvisitbox != null)
	   cvisitbox.style.pointerEvents = 'none';
}
function enableClickOnCustomerVisitDiv1(){ 
	$("#custvisitplnner").css({"opacity": "1", "background": "none"});
	var cvisitbox = document.getElementById("custreminderRqstBox"); 	
	cvisitbox.style.pointerEvents = 'auto'; 
	
	var applyBtn2 = document.getElementById("fapply_btn2");
	if(applyBtn2 != null)
		applyBtn2.disabled = false;
	
	var applyBtn3 = document.getElementById("fapply_btn3"); 
	if(applyBtn3 != null)
		applyBtn2.disabled = false;
}
function hideCustVisitBox1(){
	var visitbox = document.getElementById("custreminderRqstBox");
	if(visitbox != null){
		clearAllFields1();
		visitbox.style.display="none"; 
	}
}
function preSendLoaderStyle1(){ $("#custvisitplnner").css({"opacity": "0.7", "background": "url(resources/images/fjpre.gif) no-repeat 50% 50%", "background-size": "60px 60px"});}
function getRegulariztnCustVstAlrtMssg1(alrdyUpdtdVstCnt, currentVstsCnt){
	var alertMessage="";	
		alertMessage = "You will not be able to add/modify customer visit & regularisation later. Dou you still want to continue ?";
	return alertMessage;
}
function replaceResponseImage1(outerdiv, fregOptnSts){
	var regCvDate = document.getElementById("regularise_date").value; 
	var totalVisits = visitCount + alrdyUpdtdVstCnt;
	if(fregOptnSts == 0){
		outerdiv.id= outerdiv.id;			
		$(outerdiv).html('<i class="fa fa-2x fa-clock-o"></i>');	
		//createNewCustVstBxOpenHandlerForDay1(outerdiv,regCvDate,totalVisits,fregOptnSts);
	}else if(fregOptnSts == 1){
		$(outerdiv.getElementsByTagName("img")[0]).next('i').remove();
		outerdiv.getElementsByTagName("img")[0].src="resources/images/outduty.gif";
		$('<i class="fa fa-2x  fa-check-square-o" style="color: green;">'+totalVisits+'</i>').insertAfter(outerdiv.getElementsByTagName("img")[0]);
	    outerdiv.id= outerdiv.id+"_done"; 
	    $(outerdiv).removeAttr('onclick');
	}else if(fregOptnSts == 3){
		if(totalVisits < 7){  
			outerdiv.id= outerdiv.id;			
			$(outerdiv).html('<i class="fa fa-2x  fa-check-square-o" style="color: purple;padding-top:10px;">'+totalVisits+'</i>');				
			createNewCustVstBxOpenHandlerForDay1(outerdiv,regCvDate,totalVisits,fregOptnSts);
		}else if(totalVisits >= 7){  
			//outerdiv.id= outerdiv.id+"_done";
				$(outerdiv).html('<i class="fa fa-2x  fa-check-square-o" style="color: purple;padding-top:10px;">'+totalVisits+'</i>');		
				createNewCustVstBxOpenHandlerForDay1(outerdiv,regCvDate,totalVisits,fregOptnSts);
			//$(outerdiv).removeAttr('onclick');
		}else{
			outerdiv.id= outerdiv.id+"_done";
			$(outerdiv).removeAttr('onclick');
		}			
	   
	}else if(fregOptnSts == 4){	
		outerdiv.id= outerdiv.id;			
		$(outerdiv).html('<i class="fa fa-2x fa-clock-o"></i>');		  
	}
	else{  }
	setDeafaultVisitValues1();
	
}
function Apply1(button){
    if(document.getElementById("thereminderreason").value == null){
        return false;
    }
}
function createNewCustVstBxOpenHandlerForDay1(outerdiv,regCvDate,totalVisits,fregOptnSts){  
	var dateToCustVstRglrzn = moment(regCvDate,"DD/MM/YYYY").format("D");
	$(outerdiv).removeAttr('onclick'); 
	/*if(document.querySelector('input[name=remindertab]:checked') != null){
      document.querySelector('input[name=remindertab]:checked').value=1;  
    }*/
     document.getElementById("rreminder").checked = true; 
     
	if(fregOptnSts == 3 && totalVisits < 7){
		outerdiv.setAttribute("onclick", "showReminderRequest(event,'"+regCvDate+"', "+dateToCustVstRglrzn+", 'Future',"+totalVisits+",'1')");
	}else if(fregOptnSts == 3 && totalVisits >= 7){
		outerdiv.setAttribute("onclick", "showReminderRequest(event,'"+regCvDate+"', "+dateToCustVstRglrzn+", 'Future',"+totalVisits+",'0')");
	}else{
		outerdiv.setAttribute("onclick", "showReminderRequest(event,'"+regCvDate+"', "+dateToCustVstRglrzn+", 'Present',"+totalVisits+",'1')");
	}
}
function setDeafaultVisitValues1(){
	alrdyUpdtdVstCnt = 0;
	visitCount = 0;
	//document.querySelector('input[name=remindertab]:checked').value=1;
}
//.START 10-04-2020<--newly added temporary on 08-042020 to handle - HR memo- for regularization without daily task restroction -->
function showDailyTaskMsg(event,theDate){	 
	   $("#regValidationModal .modal-title").html('Daily task for regularization');
	   $("#regValidationModal .modal-body").html("<i class='fa fa-arrow-right'></i> Regularisation not allowed for  "+theDate+" as daily task not entered. <br/><i class='fa fa-arrow-right'></i> Daily task is must for regularization.");
	   $("#regValidationModal").modal("show");
}
//.END <--newly added temporary on 08-042020 to handle - HR memo- for regularization without daily task restroction -->


$(document).ready(function(){  
	  $("[rel='tooltip']").tooltip();
	$('#newVstPl').click(function(e) {
	   if((visitCount + alrdyUpdtdVstCnt) < 7){
		   clearAllFields1();  
	   }else{
		   clearAllFields1();
		   $("#modal-new-visitpl").modal('hide');
		   alert("Maximum number of customer visit entry exceeded!. Please remove a cstomer visit   to add new customer.")
	   }
	     
	});
	  $("#custvisitplnner").addClass("divinactive");  
	//document.getElementById('custvisit').style.display = 'none'; 
	 $("#rreminder, #rcustvstpl").addClass('custVstChkBox'); 
	if ($("#rreminder").prop("checked")) { 
		 $("#reminderlabel").addClass("tabactive"); 	
		 $("#custvstpllabel").addClass("tabinactive");
		}
	if ($("#rcustvstpl").prop("checked")) {
		 $("#custvstpllabel").addClass("tabactive"); 
		 
		} 
	
	//cust visit save and remove start
	
	 
	$('#savepl').click(function(){ 
	 clearErrorMessage();
	 fregOptnSts = document.getElementById("fregOptnSts").value;
	 setActionPl();
	 setCustNamePl();
	 setactionDescPl();
	 setCustContctNoPl();
	 setTimePl();
	  if(visitDetailsValidatePl() && (visitCount + alrdyUpdtdVstCnt) < 7){ 
	   if($.trim($('#savepl').text()) == 'Save')
	   {    		   		   
		visitCount = visitCount + 1;
		var visitId = Math.floor(Math.random()*100);
	    output = '<tr id="_v'+visitId+'">';
	    output += '<td>'+docId+' <input type="hidden" name="hidden_docId[]" id="docId'+visitCount+'" class="docs" value="'+docId+'" /></td>';
	    output += '<td>'+action+' <input type="hidden" name="hidden_action[]" id="action'+visitCount+'" class="action" value="'+action+'" /></td>';
	    output += '<td class="dataView"  rel="tooltip" title="'+projectName+'">'+projectName.slice(0,10)+'...<input type="hidden" name="hidden_project[]" id="project'+visitCount+'" class="project" value="'+projectName+'" /></td>';
	    output += '<td>'+fromTime+' <input type="hidden" name="hidden_fromTime[]" id="fromTime'+visitCount+'" class="from-time" value="'+fromTime+'" /></td>';
	    output += '<td>'+toTime+' <input type="hidden" name="hidden_toTime[]" id="toTime'+visitCount+'" class="to-time" value="'+toTime+'" /></td>'; 
	    output += '<td class="dataView" rel="tooltip" title="'+custName+'">'+custName.slice(0,6)+'...<input type="hidden" name="hidden_custName[]" id="custName'+custName+'" class="cust-Name" value="'+custName+'" /> '; 
	    output += '<td class="dataView" rel="tooltip" title="'+custContctNo+'">'+custContctNo.slice(0,6)+'...<input type="hidden" name="hidden_custContctNo[]" id="custContctNo'+custName+'" class="cust-Contct-No" value="'+custContctNo+'" /> '; 
	    output += '<td class="dataView" rel="tooltip" title="'+actionDesc+'">'+actionDesc.slice(0,10)+'...<input type="hidden" name="hidden_desc[]" id="desc'+visitCount+'" class="action-desc" value="'+actionDesc+'" /> '; 
	    output += '<input type="hidden" name="hidden_party[]" id="party'+visitCount+'" class="party-name" value="'+party+'" /></td>'; 
	    output += '<td><button type="button" name="remove_details" class="btn btn-danger btn-xs remove_details" id="_v'+visitId+'"><i class="fa fa-remove"></i></button></td>';
	    output += '</tr>';
	    cvDetails.push( {"id": '_v'+visitId, "documentId" : $.trim(docId) ,"project": $.trim(projectName), "actionType" : $.trim(action), "fromTime": $.trim(fromTime), "toTime": $.trim(toTime),
	    	"actnDesc": $.trim(actionDesc),"partyName": $.trim(party), "customerName": $.trim(custName),"customerContactNo": $.trim(custContctNo)} );
	    $("#modal-new-visitpl").modal('hide');
	    if((visitCount + alrdyUpdtdVstCnt) >= 7){
	    	 $('#newVstPl').prop('disabled', true);
			 $('#newVstPl').css( { display:'none'}); 
	    }
	    $('#user_reminder_data').append(output);
	   }
	   else
	   {
	    alert("Please Refresh the page and try again");
	   }
 
	  }else{
		  //$('#errMsg').html("");  
	  }
	 });

	 $(document).on('click', '.remove_details', function(){
	  var row_id = $(this).attr("id");
	  if(confirm("Are you sure you want to remove this customer visit details?")){
	   $('#'+row_id+'').remove();
	   cvDetails = cvDetails.filter( obj => obj.id !== row_id);
	   //console.log("removed details"); 
	   visitCount = visitCount - 1;
	   if((visitCount+ alrdyUpdtdVstCnt) < 7){
	    	 $('#newVstPl').prop('disabled', false);
			 $('#newVstPl').css( { display:'block'}); 
	    }
	  }
	  else
	  {
	   return false;
	  }
	 });
	 
	//cust visit save and remove end
	});
function disableNewVisitBtn1(){
	 $('#newVstPl').prop('disabled', true);
	 $('#newVstPl').css( { display:'none'}); 
}
function otherBox1(id){ 
	      fregOptnSts = 0;//regularisation only 
		  document.getElementById("rcustvstpl").checked = false; 
		  $('#reminderlabel').removeClass("tabinactive");  
		  $('#custvstpllabel').removeClass("tabactive");
		  $("#custvstpllabel").addClass("tabinactive");
		  $("#reminderlabel").addClass("tabactive"); 
		  $('#custvisitplnner').removeClass("divactive");
		  $('#reminder').removeClass("divinactive");
		  $("#custvisitplnner").addClass("divinactive");  
		  $("#reminder").addClass("divactive"); 
		  clearCustomerVisitDetails1();
		  document.getElementById("thereminderreason").value="";
}



function custVisitBox1(){
	    fregOptnSts = 3;//regularisation & Customer visit together 
	 	document.getElementById("rreminder").checked = false; 
		$('#reminderlabel').removeClass("tabactive");  
		$('#custvstpllabel').removeClass("tabinactive");
		$("#reminderlabel").addClass("tabinactive");  
		$("#custvstpllabel").addClass("tabactive");  
		$('#reminder').removeClass("divactive");
		$('#custvisitplnner').removeClass("divinactive");
		$("#reminder").addClass("divinactive");  
		$("#custvisitplnner").addClass("divactive");
		clearCustomerVisitDetails1();
		document.getElementById("thereminderreason").value="";		
}



function checkVisitPlType(){ 
	clearErrorMessage();  
	  var type = parseInt(document.getElementById("fvstTyp").value);	 
	  if(type == 2){ 
		  clearGeneralMandatFields1();
		  $('#fgnrlBlck').css('display','none');	
		  getProjectDetails1();
		  $('#fflwUpBlck').css('display','block'); 		  
	  }else if(type == 1){
		  clearFolloupMandatFields1();
		  party = "-";
		  $('#fflwUpBlck').css('display','none');
		  $('#fgnrlBlck').css('display','block'); 		 
	  }else{		 
		  $('#fflwUpBlck, #fgnrlBlck').css('display','none');		 
	  }
}
function clearGeneralMandatFields1(){  
	document.getElementById("fgenProject").value = "";
	//document.getElementById("rprojectName").value = "";
	document.getElementById("rcustName").value = "";
}
function clearFolloupMandatFields1(){ 
	party = "";
	if(prjectsTable1 != null && prjectsTable1 != '' && prjectsTable1 != 'undefined'){
	prjectsTable1.$('tr.selected').removeClass('selected');
	}
}
function getProjectDetails1(reminder){
	var table = "<table id='prjctDtls1' class='table display bordered small'><thead><tr>"+
				"<th></th><th>Doc-Id</th><th>Party Name</th><th class='remove-clmn'>Contact</th><th>Project</th><th class='remove-clmn'>Proj. Stage</th><th class='remove-clmn'>Consultant</th>"+
				"</tr></thead><tbody>";
	if(projects1 == null || projects1 == 'undefined' || typeof projects1 === undefined || projects1 == ''){    
		$.ajax({ type: 'POST', url: 'sip', 
			 data: {fjtco: "gs2pdforrcv"}, 
			 dataType: "json", 
			 success: function(data) {
				 projects1 = data; 
				  projects1.map( (item)=> {
					  table +=  "<tr><td></td><td>"+$.trim(item.documentId)+"</td><td>"+$.trim(item.partyName)+"</td>"+
				 				    "<td class='remove-clmn'>"+$.trim(item.contact)+"</td><td>"+$.trim(item.project)+"</td>"+
				 				    "<td class='remove-clmn'>"+$.trim(item.projectStage)+"</td><td class='remove-clmn'>"+$.trim(item.consultant)+"</td>"+
				 				    "</tr>";
				 	});  
					
				    setProjectTable1(table,reminder);	
					   
			 },error:function(data,status,er) { 
				  table +="</tboady></table>";
				  alert("please logout and login, then try again");  
				 }
		}); 
	}else{ 
	table += getFollowupProjects1(); 
	setProjectTable1(table,reminder);	 	
	}	 
		  
} 
function setProjectTable1(table,reminder){
	table +="</tbody></table>";	
	if(reminder  == null){
		$("#fflUpContent").html(table);
	}else{
	$("#frflUpContent").html(table);
	}
	 prjectsTable1 = $('#prjctDtls1').DataTable( {
        columnDefs: [ {
        	 orderable: false,
             className: 'select-checkbox',
             targets:   0,  
             data: null,
             defaultContent: '',
        } ],
        "pageLength": 5,
        select: {
            style:    'os',
            selector: 'td:first-child'
        },
        order: [[ 1, 'asc' ]], 
    } );
	 
	 $('#prjctDtls1 tbody').on('click', 'tr td.select-checkbox', function () {	
		 	clearErrorMessage(); 
	        if (!$(this).parents('tr').hasClass('selected')) {//temp fix
	        	    var data = prjectsTable1.row($(this).parents('tr')).data();		        		        
			        docId = data[1];
			        party = data[2];
			        projectName = data[4];
			        visitTpe = 1; 				        
			        fromTime = document.getElementById("ffromTime").value;
			        toTime = document.getElementById("ftoTime").value;
			        actionDesc =  document.getElementById("factionDesc").value;	
			        custName = document.getElementById("fcustName").value;
			    	custContctNo = document.getElementById("fcustContctNo").value
	       } else {
	    	    docId = "";
		        party = "";
		        projectName = "";  			        
	       }
	        
	    } ); 
}
function getFollowupProjects1(){
	var result = ""; 
	projects1.map( (item)=> {  
	 	  result +=  "<tr><td></td><td>"+$.trim(item.documentId)+"</td><td>"+$.trim(item.partyName)+"</td>"+
	 				    "<td class='remove-clmn'>"+$.trim(item.contact)+"</td><td>"+$.trim(item.project)+"</td>"+
	 				    "<td class='remove-clmn'>"+$.trim(item.projectStage)+"</td><td class='remove-clmn'>"+$.trim(item.consultant)+"</td>"+
	 				    "</tr>";
	 	}); 
	return result; 
	

}
function visitDetailsValidatePl(){
	clearErrorMessage(); 
	visitTpe = parseInt(document.getElementById("fvstTyp").value);
	custName = document.getElementById("fcustName").value;
	custContctNo = document.getElementById("fcustContctNo").value
	if(visitTpe == 1){
		docId = "General"; 
		projectName = document.getElementById("fgenProject").value; 
		
	       if($.trim(action) == null || $.trim(action) == ''){
		    	$('#ferrMsg').html("Please select visit action...");
		    	document.getElementById("fvisitActn").focus();
		    	return false;		  
		    }else if(!validateTiming(fromTime, toTime)){
		    	$('#ferrMsg').html("<b>To Time</b> should greater or equal to <b>From Time</b> time...");
		    	document.getElementById("ftoTime").focus();
		    	return false; 
		    }else if($.trim(custName) == null || $.trim(custName) == ''){
		    	console.log("cust name "+custName);
		    	$('#ferrMsg').html("Please enter Contact Person Name...");   
		    	document.getElementById("fcustName").focus();
		    	return false;   	
		    }else if($.trim(custName).length > 100){
		    	$('#ferrMsg').html('Maximum 100 Character  for   Contact Person Name.');
		    	document.getElementById("fcustName").focus();
		    	return false;  	    	
		    }else if($.trim(custContctNo) == null || $.trim(custContctNo) == ''){
		    	$('#ferrMsg').html("Please enter Contact Person Number...");   
		    	document.getElementById("fcustContctNo").focus();
		    	return false;   	
		    }else if($.trim(custContctNo).length < 9){
		    	$('#ferrMsg').html('Please enter atleast 9 character for Contact Person Number.');
		    	document.getElementById("fcustContctNo").focus();
		    	return false;   	
		    }else if($.trim(custContctNo).length > 20){
		    	$('#ferrMsg').html('Maximum 20 Character  for  Contact Person Number.');
		    	document.getElementById("fcustContctNo").focus();
		    	return false;  
		    	
		    }else if($.trim(actionDesc) == null || $.trim(actionDesc) == ''){
		    	$('#ferrMsg').html("Please enter action description...");   
		    	document.getElementById("factionDesc").focus();
		    	return false;   	
		    }else if($.trim(actionDesc).length < 10){
		    	$('#ferrMsg').html('Please enter atleast 10 character for  action description.');
		    	document.getElementById("factionDesc").focus();
		    	return false;   	
		    }else if($.trim(actionDesc).length > 200){
		    	$('#ferrMsg').html('Maximum 200 Character  for  action description.');
		    	document.getElementById("factionDesc").focus();
		    	return false;  
		    }else if( $.trim(projectName) == '' || $.trim(projectName) == null ){
			    $('#ferrMsg').html("Please enter project/party details..");
			    document.getElementById("fgenProject").focus();
			    return false;
			}else if($.trim(projectName).length < 10){
		    	$('#ferrMsg').html('Please enter atleast 10 character for  project/party details.');
		    	document.getElementById("fgenProject").focus();
		    	return false;   	
	    	}else if($.trim(projectName).length > 200){
		    	$('#ferrMsg').html('Maximum 200 Character  for  project/party details.');
		    	document.getElementById("fgenProject").focus();
		    	return false; 	
		    }else{
		    	clearErrorMessage();  
		    	return true;
		    } 
	}else if(visitTpe == 2){
			
	    if($.trim(visitTpe) == null || $.trim(visitTpe) == '' || $.trim(docId) == null || $.trim(docId) == ''  ||  $.trim(projectName) == '' || $.trim(projectName) == null ){
	    	$('#ferrMsg').html("Please selet a project...");
	    	return false;
	    }else if($.trim(action) == null || $.trim(action) == ''){
	    	$('#ferrMsg').html("Please select visit action...");
	    	document.getElementById("fvisitActn").focus();
	    	return false;
	    }else if(!validateTiming(fromTime, toTime)){
	    	$('#ferrMsg').html("<b>To Time</b> should greater than <b>From Time</b>...");
	    	document.getElementById("ftoTime").focus();
	    	return false; 
	    }else if($.trim(custName) == null || $.trim(custName) == ''){
	    	$('#ferrMsg').html("Please enter Contact Person Name...");   
	    	document.getElementById("fcustName").focus();
	    	return false;   	
	    }else if($.trim(custName).length < 10){
	    	$('#ferrMsg').html('Please enter atleast 10 character for Contact Person Name.');
	    	document.getElementById("fcustName").focus();
	    	return false;   	
	    }else if($.trim(custName).length > 100){
	    	$('#ferrMsg').html('Maximum 100 Character  for   Contact Person Name.');
	    	document.getElementById("fcustName").focus();
	    	return false;  	    	
	    }else if($.trim(custContctNo) == null || $.trim(custContctNo) == ''){
	    	$('#ferrMsg').html("Please enter Contact Person Number...");   
	    	document.getElementById("fcustContctNo").focus();
	    	return false;   	
	    }else if($.trim(custContctNo).length < 10){
	    	$('#ferrMsg').html('Please enter atleast 10 character for Contact Person Number.');
	    	document.getElementById("fcustContctNo").focus();
	    	return false;   	
	    }else if($.trim(custContctNo).length > 20){
	    	$('#ferrMsg').html('Maximum 20 Character  for  Contact Person Number.');
	    	document.getElementById("fcustContctNo").focus();
	    	return false;  
	    }else if($.trim(actionDesc) == null || $.trim(actionDesc) == ''){
	    	$('#ferrMsg').html("Please enter a description...");   
	    	document.getElementById("factionDesc").focus();
	    	return false;   	
	    }else if($.trim(actionDesc).length < 10){
	    	$('#ferrMsg').html('Please enter atleast 10 character.');
	    	document.getElementById("factionDesc").focus();
	    	return false;   	
	    }else if($.trim(actionDesc).length > 200){
	    	$('#ferrMsg').html('Maximum 200 Character.');
	    	document.getElementById("factionDesc").focus();
	    	return false;   	
	    }else{
	    	clearErrorMessage();  
	    	return true;
	    } 
	}else{
		$('#ferrMsg').html("Please selet visit type...");
		document.getElementById("fvstTyp").focus();
		return false;
		} 
}

function clearErrorMessage(){	
	$('#ferrMsg').html("");    
}
function clearErrorTimingMessage(){	
	var fromTime1 = document.getElementById("fromTime").value;
	var toTime1 = document.getElementById("toTime").value;
	if(!validateTiming(fromTime1, toTime1)){
		$('#ferrMsg').html("<b>To Time</b> should greater or equal to <b>From Time</b> time..."); 
	}else{
		$('#ferrMsg').html(""); 
	} 
	
	  
} 

function validateTiming(fromTm, toTm){
	 var result = false; 
	 var startTime, endTime, timeArr; 
	 timeArr = fromTm.split(':'); 
	 startTime = (timeArr[0] * 60) + timeArr[1]; 
	 timeArr = toTm.split(':');
	 endTime = (timeArr[0] * 60) + timeArr[1]; 
	 result = parseInt(startTime) <= parseInt(endTime);
	 return result;  
}
function setActionPl(){
	clearErrorMessage();
	action = document.getElementById("fvisitActn").value;
}
function setactionDescPl(){
	clearErrorMessage();
	actionDesc = document.getElementById("factionDesc").value;
}
function setCustNamePl(){
	clearErrorMessage();
	custName = document.getElementById("fcustName").value;
}	
function setCustContctNoPl(){
	clearErrorMessage();
	custContctNo = document.getElementById("fcustContctNo").value;
}	


function setTimePl(){
	clearErrorMessage();
	fromTime = document.getElementById("ffromTime").value;
	toTime = document.getElementById("ftoTime").value;
}
function clearAllFields1(){ 
	clearErrorMessage();
	docId = ""; party = ""; projectName = "";fromTime="08:00"; toTime="18:00";fprojectName=""; 	
	if(prjectsTable1 != null && prjectsTable1 != '' && prjectsTable1 != 'undefined'){ prjectsTable1.$('tr.selected').removeClass('selected'); } 
	document.getElementById("fcustName").value = "";
	document.getElementById("fcustContctNo").value = "";
	document.getElementById("factionDesc").value = "";
	document.getElementById("ffromTime").value = "08:00";
	document.getElementById("ftoTime").value = "18:00"; 
	document.getElementById("fgenProject").value = "";
	document.getElementById("fvisitActn").selectedIndex = 0; 
	document.getElementById("fvstTyp").selectedIndex = 0;  
	if(document.getElementById("remindervstTyp") != null && document.getElementById("remindervstTyp") != ''){
	document.getElementById("remindervstTyp").selectedIndex = 0;
	//document.getElementById("rprojectName").value="";	
	document.getElementById("rcustName").value = "";
	}
	
	$('#fgnrlBlck').css('display','none');	
	$('#fflwUpBlck').css('display','none');	
	$('#frflwUpBlck').css('display','none');	
	$('#frgnrlBlck').css('display','none');					
}
function clearCustomerVisitDetails1(){
	cvDetails.splice(0, cvDetails.length);
	visitCount = 0;
	if(visitCount == 0){
   	 $('#newVstPl').prop('disabled', false);
		 $('#newVstPl').css( { display:'block'}); 
    }
	clearAllFields1();
	$('#user_reminder_data tbody').html("");
}

/*function disableRegularisationTab1(){
	var btn1 = document.getElementById("reminderlabel");
	if(btn1 != null)
		btn1.style.display = "none";
	
	var btn2 = document.getElementById("custvstpllabel");
	if(btn2 != null)
		btn2.style.display = "none";
	
		$('#reminderlabel').removeClass("tabactive");  
		$('#custvstpllabel').removeClass("tabinactive");
		$("#reminderlabel").addClass("tabinactive");  
		$("#custvstpllabel").addClass("tabactive");  
		$('#reminder').removeClass("divactive");
		$('#custvisitplnner').removeClass("divinactive");
		$("#reminder").addClass("divinactive");  
		$("#custvisitplnner").addClass("divactive");  
}*/
function disableCustomerVisitPlannerTab1(){
	var btn1 = document.getElementById("reminderlabel");
	if(btn1 != null)
		btn1.style.display = "none";
	
	var btn2 = document.getElementById("custvstpllabel");
	if(btn2 != null)
		btn2.style.display = "none";
	var btn3 = document.getElementById("newVstPl");
	if(btn3 != null)
		btn3.style.display = "none";
    var fapply_btn2 = document.getElementById("fapply_btn2");
	if(fapply_btn2 != null)
		fapply_btn2.style.display = "none";
		$('#reminderlabel').removeClass("tabinactive");  
		//$('#custvstpllabel').removeClass("tabinactive");
		$("#reminderlabel").addClass("tabactive");  
		//$("#custvstpllabel").addClass("tabactive");  
		$('#reminder').removeClass("divinactive");
		//$('#custvisitplnner').removeClass("divinactive");
		$("#reminder").addClass("divactive");  
		//$("#custvisitplnner").addClass("divactive");  
		$("#user_reminder_data").removeClass("divactive"); 
		$("#user_reminder_data").addClass("divinactive"); 
}
/*function enableRegularisationTab1(){
		var btn1 = document.getElementById("reminderlabel");
		if(btn1 != null)
			btn1.style.display = "inline-block";
		
	 	var btn2 = document.getElementById("custvstpllabel");
	 	if(btn2 != null)
			btn2.style.display = "inline-block";
	 	
		$('#reminderlabel').removeClass("tabinactive");  
		$('#custvstpllabel').removeClass("tabactive");
		$("#reminderlabel").addClass("tabactive");  
		$("#custvstpllabel").addClass("tabinactive");	
		$('#reminder').removeClass("divinactive");
		$('#custvisitplnner').removeClass("divactive");
		$("#reminder").addClass("divactive");  
		$("#custvisitplnner").addClass("divinactive");  
	
}*/
function enableCustomerVisitPlannerTab1(){
		var btn1 = document.getElementById("reminderlabel");
		if(btn1 != null)
			btn1.style.display = "inline-block";
		
	 	var btn2 = document.getElementById("custvstpllabel");
	 	if(btn2 != null)
			btn2.style.display = "inline-block";
	 	var fapply_btn2 = document.getElementById("fapply_btn2");
		if(fapply_btn2 != null)
			fapply_btn2.style.display = "inline-block";
		$('#reminderlabel').removeClass("tabinactive");  
		$('#custvstpllabel').removeClass("tabactive");
		$("#reminderlabel").addClass("tabactive");  
		$("#custvstpllabel").addClass("tabinactive");	
		$('#reminder').removeClass("divinactive");
		$('#custvisitplnner').removeClass("divactive");
		$("#reminder").addClass("divactive");  
		$("#custvisitplnner").addClass("divinactive");  
		$("#user_reminder_data").removeClass("divinactive"); 
		$("#user_reminder_data").addClass("divactive"); 
		
}
function reloadPage(){
	 window.top.location.href="logout.jsp"
}

function remindersBox(){ 
	      fregOptnSts = 0;//regularisation only 
		  document.getElementById("rcustvstpl").checked = false; 
		  $('#reminderlabel').removeClass("tabinactive");  
		  $('#custvstpllabel').removeClass("tabactive");
		  $("#custvstpllabel").addClass("tabinactive");
		  $("#reminderlabel").addClass("tabactive"); 
		  $('#custvisitplnner').removeClass("divactive");
		  $('#reminder').removeClass("divinactive");
		  $("#custvisitplnner").addClass("divinactive");  
		  $("#reminder").addClass("divactive"); 
		  clearCustomerVisitDetails1();
		  document.getElementById("thereminderreason").value="";
}



function custVisitPlannerBox(){
	    fregOptnSts = 3;//regularisation & Customer visit together 
	 	document.getElementById("rreminder").checked = false; 
		$('#reminderlabel').removeClass("tabactive");  
		$('#custvstpllabel').removeClass("tabinactive");
		$("#reminderlabel").addClass("tabinactive");  
		$("#custvstpllabel").addClass("tabactive");  
		$('#reminder').removeClass("divactive");
		$('#custvisitplnner').removeClass("divinactive");
		$("#reminder").addClass("divinactive");  
		$("#custvisitplnner").addClass("divactive");
		clearCustomerVisitDetails1();
		document.getElementById("thereminderreason").value="";		
}


function checkReminderVisitType(){
	clearErrorMessage();  
	  var type = parseInt(document.getElementById("remindervstTyp").value);	 
	  if(type == 2){ 
		  clearGeneralMandatFields1();
		  $('#frgnrlBlck').css('display','none');	
		  getProjectDetailsforReminder();
		  $('#frflwUpBlck').css('display','block'); 		  
	  }else if(type == 1){
		  clearFolloupMandatFields1();
		  party = "-";
		  $('#frflwUpBlck').css('display','none');
		  $('#frgnrlBlck').css('display','block'); 		 
	  }else{		 
		  $('#frflwUpBlck').css('display','none');		 
	  }
}
function getProjectDetailsforReminder(){
	var table = "<table id='prjctDtlsFrRemdr' class='table display bordered small'><thead><tr>"+
				"<th></th><th>Doc-Id</th><th>Party Name</th><th class='remove-clmn'>Contact</th><th>Project</th><th class='remove-clmn'>Proj. Stage</th><th class='remove-clmn'>Consultant</th><th></th>"+
				"</tr></thead><tbody>";
	if(projectsfrRmdr == null || projectsfrRmdr == 'undefined' || typeof projectsfrRmdr === undefined || projectsfrRmdr == ''){    
		$.ajax({ type: 'POST', url: 'sip', 
			 data: {fjtco: "followupforreminders"}, 
			 dataType: "json", 
			 success: function(data) {
				 projectsfrRmdr = data; 
				  projectsfrRmdr.map( (item)=> {
					  table +=  "<tr><td></td><td>"+$.trim(item.documentId)+"</td><td>"+$.trim(item.partyName)+"</td>"+
				 				    "<td class='remove-clmn'>"+$.trim(item.contact)+"</td><td>"+$.trim(item.project)+"</td>"+
				 				    "<td class='remove-clmn'>"+$.trim(item.projectStage)+"</td><td class='remove-clmn'>"+$.trim(item.consultant)+"</td>"+
				 				  // "<td><input type='hidden' id='docId_"+$.trim(item.hsysId)+"' value='"+$.trim(item.hsysId)+"'/></td>"+
				 				   "<td style='visibility:hidden'>"+$.trim(item.hsysId)+"</td>"+
				 				   // '<input type="hidden"  id="party'+visitCount+'" class="party-name" value="'+party+'" /></td>'; 
				 				 //  "<input type='hidden' id='hsysId' value='"+$.trim(item.hsysId)+"'/>"+
				 				    "</tr>";
				 	});  
					
				    setProjectTableFrRemdr(table);	
					   
			 },error:function(data,status,er) { 
				  table +="</tboady></table>";
				  alert("please logout and login, then try again");  
				 }
		}); 
	}else{ 
	table += getFollowupProjectsFrRemdr(); 
	setProjectTableFrRemdr(table);	 	
	}	 
		  
} 
function getFollowupProjectsFrRemdr(){
	var result = ""; 
	projectsfrRmdr.map( (item)=> {  
	 	  result +=  "<tr><td></td><td>"+$.trim(item.documentId)+"</td><td>"+$.trim(item.partyName)+"</td>"+
	 				    "<td class='remove-clmn'>"+$.trim(item.contact)+"</td><td>"+$.trim(item.project)+"</td>"+
	 				    "<td class='remove-clmn'>"+$.trim(item.projectStage)+"</td><td class='remove-clmn'>"+$.trim(item.consultant)+"</td>"+
	 				    "<td style='visibility:hidden'>"+$.trim(item.hsysId)+"</td>"+
	 				    "</tr>";
	 	}); 
	return result; 
	

}
function setProjectTableFrRemdr(table){
	table +="</tbody></table>";		
	$("#frflUpContent").html(table);	
		 prjectsTableRemdr = $('#prjctDtlsFrRemdr').DataTable( {
        columnDefs: [ {
        	 orderable: false,
             className: 'select-checkbox',
             targets:   0,  
             data: null,
             defaultContent: '',
        } ],
        "pageLength": 5,
        select: {
            style:    'os',
            selector: 'td:first-child'
        },
        order: [[ 1, 'asc' ]], 
    } );
	 
	 $('#prjctDtlsFrRemdr tbody').on('click', 'tr td.select-checkbox', function () {
		 	clearErrorMessage(); 
	        if (!$(this).parents('tr').hasClass('selected')) {//temp fix
	        	    var data = prjectsTableRemdr.row($(this).parents('tr')).data();		        	       	         		        
			        fdocId = data[1];
			        fparty = data[2];
			        fprojectName = data[4];
			        visitTpe = 1;
			        hsysId = data[7];
	       } else {
	    	    docId = "";
		        party = "";
		        projectName = "";  	
		        hsysId ="";		        
	       }
	        
	    } ); 
	  
}
function showRemindersForToday(event,theDayStr,theDate){

 var ttl ="Reminder Details for the Day "+theDayStr;
	var output="<table id='cvDetails_tbl'><thead><tr><th>Reminder Date</th><th>Description</th>"+
				"</tr></thead><tbody>";
   		$.ajax({ type: 'POST', url: 'CustomerVisitPlanner', 
			 data: {fjtco: "remindersfortheday",theDate:theDayStr}, 
			 dataType: "json", 
		 success: function(data) {
			 for (var i in data) {  
				 output+="<tr><td>" + theDayStr + "</td><td>" + $.trim(data[i].actnDesc)+ "</td></tr>";
				 } 		          	
				 output+="</tbody></table>";
				 $("#cvDetails .modal-title").html(ttl);
				 $("#cvDetails .modal-body").html(output);
				 $("#cvDetails").modal("show");
			},error:function(data,status,er) {
				 e.preventDefault();
				alert("Please Log out and try again.");}
			});	
	 
}
