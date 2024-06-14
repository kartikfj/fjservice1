/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function showRegularisationRequest(event,theDayStr,theDate,swipeDetails, custVstCount){   
	//alert("custVstCount== "+custVstCount);
	alrdyUpdtdVstCnt = parseInt(custVstCount); 
	regOptnSts = 0;//regularisation only
	var title = "Regularisation";
   // console.log("here3");
   //FOR CUST VISIT START 
    clearCustomerVisitDetails(); 
   //FOR CUST VISIT END 
    var msgbox = document.getElementById("requestformdiv");     
    if(msgbox ==null) return; 
    var outerdiv = document.getElementById("day_"+theDate);    
    if(outerdiv == null)return;
    msgbox.style.display="block"; 
    document.getElementById("thereason").value=""; 
    var custVstbox = document.getElementById("custRqstBox");
    if(custVstbox != null && custVstbox != 'undefined' && custVstbox != ''){	custVstbox.style.display="block"; enableClickOnCustomerVisitDiv();	}
 
    if($.trim(swipeDetails) == "Present"){
    	var title = "Cust-Visit"; 
    	disableRegularisationTab();
    	regOptnSts = 2;//customer visit only  
    }else if($.trim(swipeDetails) == "Future"){
		var title = "Cust-Visit Planner"; 
		if(alrdyUpdtdVstCnt > 0 && alrdyUpdtdVstCnt < 7){
	    		disableRegularisationTab();
	    		regOptnSts = 3;//customer visit with regularization 
	    	}else if(alrdyUpdtdVstCnt > 0 && alrdyUpdtdVstCnt == 7){
	    		disableRegularisationTab();
	    		disableNewVisitBtn();
	    		regOptnSts = 3;//customer visit with regularization 
	    	} else{
				regOptnSts = 3;
				disableRegularisationTab();
			}	
	}
	else{
    	if(alrdyUpdtdVstCnt > 0 && alrdyUpdtdVstCnt < 7){
    		disableRegularisationTab();
    		regOptnSts = 1;//customer visit with regularization 
    	}else if(alrdyUpdtdVstCnt > 0 && alrdyUpdtdVstCnt == 7){
    		disableRegularisationTab();
    		disableNewVisitBtn();
    		regOptnSts = 1;//customer visit with regularization 
    	}else{
    		enableRegularisationTab();
    	}  	
    }    
    var theform = document.getElementById("requestform");
    theform.style.display = "block";
    setFormParams(title, theDayStr, theDate, swipeDetails);
    msgbox.style.position="absolute";     
    msgbox.style.left =event.clientX+"px";
    msgbox.style.top=event.clientY+"px"; 
}
function setFormParams(title, theDayStr, theDate, swipeDetails){
    var heading = document.getElementById("formheading");
    if($.trim(swipeDetails) == "Future"){
    heading.innerHTML= ""+title+" for "+theDayStr;
    }else{
	heading.innerHTML= ""+title+" request for "+theDayStr;
	}
    var dtfld = document.getElementById("regularise_date");
    dtfld.value = theDayStr;
    document.getElementById("idate").value = theDate;
    document.getElementById("ichkin").value = swipeDetails;
}
function closeRequestWindow(){
    //console.log("here2");   
    var msgbox = document.getElementById("requestformdiv");
    msgbox.style.display="none";
    
}

function Apply(button){
	var respStatus = 0;
	//console.log("Operation : "+regOptnSts);
   // event.preventDefault();
    //console.log("here");
    var theUrl= "regularisationRequest.jsp";
    var params = '';
    button.disabled=true;
    var thedate = document.getElementById("regularise_date").value;    
    var encoded_dt = encodeURI(thedate)
    var thereason = document.getElementById("thereason").value;
    var thechkin = document.getElementById("ichkin").value;  
    if(thedate = null || thedate == '' ){
        alert("Please refresh the page and try again!");
        button.disabled=true;
        return;
    }   
    var  dateForCV = thedate; 
    if(regOptnSts == 0){ // regularisation only
    	 if(thereason == null){
    	        alert("Please fill the reason"); 
    	        button.disabled=false;
    	        thereason.focus();
    	        return;
    	    }
    	    thereason=thereason.trim();
    	     if(thereason == ""){
    	        alert("Please fill the reason");
    	        button.disabled=false;
    	        return;
    	    }
    	  params = "regularise_date="+encoded_dt+"&reason="+thereason+"&chkin="+thechkin+"&regOptnSts="+regOptnSts;
    	  disableClickOnCustomerVisitDiv();
    }else if(regOptnSts == 1){ 
    	 if(cvDetails.length == 0 && alrdyUpdtdVstCnt == 0){ 
    		 alert("Please add atleast one customer visit details (Maximum 7).");
    		 button.disabled = false;
    		 return;
    	 }else{
    		var alertMessage = getRegulariztnCustVstAlrtMssg(alrdyUpdtdVstCnt, cvDetails.length);
    		  		
    		 preSendLoaderStyle();
    		 document.getElementById("alrdyUpdtdVsts").value = alrdyUpdtdVstCnt; 
    		 if(confirm(alertMessage)){
    			 var jsonDetails = encodeURIComponent(JSON.stringify((cvDetails)));
    	    	 params = "regularise_date="+encoded_dt+"&reason="+thereason+"&chkin="+thechkin+"&regOptnSts="+regOptnSts+"&details="+jsonDetails+"&alrdyUpdtdVsts="+alrdyUpdtdVstCnt;
    	    	 disableClickOnCustomerVisitDiv();
   		  }
   		  else {enableClickOnCustomerVisitDiv(); return; }   		  	 
    	 }
    }else if(regOptnSts == 2 || regOptnSts == 3){
    	 if(cvDetails.length == 0){
    		 alert("Please add atleast one customer visit details (Maximum 7).");
    		 button.disabled=false; 
    		 return;
    	 }else{
    		 preSendLoaderStyle();
    		 if(regOptnSts == 2){
		    	 if(confirm("You will not be able to  modify this customer visit later. Do you still want to update ?")){
		    		      var jsonDetails = encodeURIComponent(JSON.stringify((cvDetails)));
		    		      params = "regularise_date="+encoded_dt+"&reason="+thereason+"&chkin="+thechkin+"&regOptnSts="+regOptnSts+"&details="+jsonDetails+"&alrdyUpdtdVsts="+alrdyUpdtdVstCnt;
		    		      disableClickOnCustomerVisitDiv();
		    		  }	    		  
	    		  else { enableClickOnCustomerVisitDiv(); return; }
	    		  }else{
					if(confirm("This is Customer Visit Planner.You will be able to change till one day prior.")){
		    		      var jsonDetails = encodeURIComponent(JSON.stringify((cvDetails)));
		    		      params = "regularise_date="+encoded_dt+"&reason="+thereason+"&chkin="+thechkin+"&regOptnSts="+regOptnSts+"&details="+jsonDetails+"&alrdyUpdtdVsts="+alrdyUpdtdVstCnt;
		    		      disableClickOnCustomerVisitDiv();
		    		  }	    		  
	    		  else { enableClickOnCustomerVisitDiv(); return; }
	               }	    	
    	 } 
    	 
    }else{
    	 alert("Please refresh the page and try again!");
    	 button.disabled=true;
    	 return;
    } 
       
   // var jsonDetails = CryptoJS.enc.Base64.parse(encodeURIComponent(JSON.stringify((cvDetails))));
           
    var heading = document.getElementById("formheading");
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
        
        if(regOptnSts == 0){
        	var msgbox = document.getElementById("requestform");
            msgbox.style.display="none";
        	document.getElementById("thereason").value="";
        	hideCustVisitBox(); 
        }else{        	 
        	hideCustVisitBox();   	
        }
                 
        var idate=document.getElementById("idate").value;
        var outerdiv = document.getElementById("day_"+idate);  
        replaceResponseImage(outerdiv, regOptnSts); 
        /////////
         if (outerdiv.removeEventListener) {                   
            outerdiv.removeEventListener("click", showRegularisationRequest,false);
        } else if (outerdiv.detachEvent) {                    // For IE 8 and earlier versions
            outerdiv.detachEvent("onclick", showRegularisationRequest);
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

function disableClickOnCustomerVisitDiv(){
	var cvisitbox = document.getElementById("custRqstBox");  
	if(cvisitbox != null)
	   cvisitbox.style.pointerEvents = 'none';
}
function enableClickOnCustomerVisitDiv(){ 
	$("#custvisit").css({"opacity": "1", "background": "none"});
	var cvisitbox = document.getElementById("custRqstBox"); 	
	cvisitbox.style.pointerEvents = 'auto'; 
	
	var applyBtn1 = document.getElementById("apply_btn2");
	if(applyBtn1 != null)
		applyBtn1.disabled = false;
	
	var applyBtn2 = document.getElementById("apply_btn3"); 
	if(applyBtn2 != null)
		applyBtn1.disabled = false;
}
function hideCustVisitBox(){
	var visitbox = document.getElementById("custRqstBox");
	if(visitbox != null){
		clearAllFields();
		visitbox.style.display="none"; 
	}
}
function preSendLoaderStyle(){ $("#custvisit").css({"opacity": "0.7", "background": "url(resources/images/fjpre.gif) no-repeat 50% 50%", "background-size": "60px 60px"});}
function getRegulariztnCustVstAlrtMssg(alrdyUpdtdVstCnt, currentVstsCnt){
	var alertMessage="";
	if(alrdyUpdtdVstCnt > 0 && currentVstsCnt == 0){
		alertMessage = "Now system will send reularization mail to your DM with  Already updated customer visits ("+alrdyUpdtdVstCnt+") details. You will not be able to add/modify  customer visit & regularisation later.  Do you still want to continue ?";
	}else if(alrdyUpdtdVstCnt == 0 && currentVstsCnt > 0){
		alertMessage = "Now system will send reularization mail to your DM with customer visits ("+currentVstsCnt+") details. You will not be able to add/modify this customer visit & regularisation later.  Do you still want to continue ?";
	}else if(alrdyUpdtdVstCnt > 0 && currentVstsCnt > 0){
		var totalVisits = currentVstsCnt + alrdyUpdtdVstCnt;
		alertMessage = "Now system will send reularization mail to your DM with customer visits ("+totalVisits+") details. You will not be able to add/modify this customer visit & regularisation later.  Do you still want to continue ?";
	}else{
		alertMessage = "You will not be able to add/modify customer visit & regularisation later. Dou you still want to continue ?";
	}
	return alertMessage;
}
function replaceResponseImage(outerdiv, regOptnSts){
	var regCvDate = document.getElementById("regularise_date").value; 
	var totalVisits = visitCount + alrdyUpdtdVstCnt;
	if(regOptnSts == 0){
		outerdiv.getElementsByTagName("img")[0].src="resources/images/outduty.gif";
	    outerdiv.id= outerdiv.id+"_done"; 
	    $(outerdiv).removeAttr('onclick');
	}else if(regOptnSts == 1){
		$(outerdiv.getElementsByTagName("img")[0]).next('i').remove();
		outerdiv.getElementsByTagName("img")[0].src="resources/images/outduty.gif";
		$('<i class="fa fa-2x  fa-check-square-o" style="color: green;">'+totalVisits+'</i>').insertAfter(outerdiv.getElementsByTagName("img")[0]);
	    outerdiv.id= outerdiv.id+"_done"; 
	    $(outerdiv).removeAttr('onclick');
	}else if(regOptnSts == 2){  		
		if(totalVisits < 7){  
			outerdiv.id= outerdiv.id;
				if(today == regCvDate){
						$(outerdiv).html('<i class="fa fa-2x  fa-check-square-o" style="color: blue;">'+totalVisits+'</i>')
				}else{
						$(outerdiv.getElementsByTagName("img")[0]).next('i').remove();
					    $('<i class="fa fa-2x  fa-check-square-o" style="color: blue;">'+totalVisits+'</i>').insertAfter(outerdiv.getElementsByTagName("img")[0]);	
				} 
		
				createNewCustVstBxOpenHandlerForDay(outerdiv,regCvDate,totalVisits);
		}else if(totalVisits >= 7){  
			outerdiv.id= outerdiv.id+"_done";
			if(today == regCvDate){
				$(outerdiv).html('<i class="fa fa-2x  fa-check-square-o" style="color: green;">'+totalVisits+'</i>')
			}else{
				$(outerdiv.getElementsByTagName("img")[0]).next('i').remove();
			    $('<i class="fa fa-2x  fa-check-square-o" style="color: green;">'+totalVisits+'</i>').insertAfter(outerdiv.getElementsByTagName("img")[0]);	
			}
			$(outerdiv).removeAttr('onclick');
		}else{
			outerdiv.id= outerdiv.id+"_done";
			$(outerdiv).removeAttr('onclick');
		}			
	   
	}else if(regOptnSts == 3){  		
		if(totalVisits < 7){  
			outerdiv.id= outerdiv.id;
				//if(today == regCvDate){
						$(outerdiv).html('<i class="fa fa-2x  fa-check-square-o" style="color: purple;">'+totalVisits+'</i>')
			//	}else{
					//	$(outerdiv.getElementsByTagName("img")[0]).next('i').remove();
					 //   $('<i class="fa fa-2x  fa-check-square-o" style="color: purple;">'+totalVisits+'</i>').insertAfter(outerdiv.getElementsByTagName("img")[0]);	
				//} 
		
				createNewCustVstBxOpenHandlerForDay(outerdiv,regCvDate,totalVisits,regOptnSts);
		}/*else if(totalVisits >= 7){  
			outerdiv.id= outerdiv.id+"_done";
			if(today == regCvDate){
				$(outerdiv).html('<i class="fa fa-2x  fa-check-square-o" style="color: green;">'+totalVisits+'</i>')
			}else{
				$(outerdiv.getElementsByTagName("img")[0]).next('i').remove();
			    $('<i class="fa fa-2x  fa-check-square-o" style="color: green;">'+totalVisits+'</i>').insertAfter(outerdiv.getElementsByTagName("img")[0]);	
			}
			$(outerdiv).removeAttr('onclick');
		}*/else{
			outerdiv.id= outerdiv.id+"_done";
			$(outerdiv).removeAttr('onclick');
		}			
	   
	}
	else{  }
	setDeafaultVisitValues();
	
}
function Apply1(button){
    if(document.getElementById("thereason").value == null){
        return false;
    }
}
function createNewCustVstBxOpenHandlerForDay(outerdiv,regCvDate,totalVisits,regOptnSts){  
	var dateToCustVstRglrzn = moment(regCvDate,"DD/MM/YYYY").format("D");
	$(outerdiv).removeAttr('onclick'); 
	if(regOptnSts == 3){
		outerdiv.setAttribute("onclick", "showRegularisationRequest(event,'"+regCvDate+"', "+dateToCustVstRglrzn+", 'Future',"+totalVisits+")");
	}else{
		outerdiv.setAttribute("onclick", "showRegularisationRequest(event,'"+regCvDate+"', "+dateToCustVstRglrzn+", 'Present',"+totalVisits+")");
	}
}
function setDeafaultVisitValues(){
	alrdyUpdtdVstCnt = 0;
	visitCount = 0;
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
	$('#newVst').click(function(e) {
	   if((visitCount + alrdyUpdtdVstCnt) < 7){
		   clearAllFields();  
	   }else{
		   clearAllFields();
		   $("#modal-new-visit").modal('hide');
		   alert("Maximum number of customer visit entry exceeded!. Please remove a cstomer visit   to add new customer.")
	   }
	     
	});
	  $("#custvisit").addClass("divinactive");  
	//document.getElementById('custvisit').style.display = 'none'; 
	 $("#rother, #rcustvst").addClass('custVstChkBox'); 
	if ($("#rother").prop("checked")) { 
		 $("#otherlabel").addClass("tabactive"); 	
		 $("#custlabel").addClass("tabinactive");
		}
	if ($("#rcustvst").prop("checked")) {
		 $("#custlabel").addClass("tabactive"); 
		 
		} 
	
	//cust visit save and remove start
	
	 
	$('#save').click(function(){
	 clearErrorMessage();
	 setAction();
	 setCustName();
	 setactionDesc();
	 setCustContctNo();
	 setTime(); 
	 if(visitDetailsValidate() && (visitCount + alrdyUpdtdVstCnt) < 7){
		  
	   if($.trim($('#save').text()) == 'Save')
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
	    $("#modal-new-visit").modal('hide');
	    if((visitCount + alrdyUpdtdVstCnt) >= 7){
	    	 $('#newVst').prop('disabled', true);
			 $('#newVst').css( { display:'none'}); 
	    }
	    $('#user_data').append(output);
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
	    	 $('#newVst').prop('disabled', false);
			 $('#newVst').css( { display:'block'}); 
	    }
	  }
	  else
	  {
	   return false;
	  }
	 });
	 
	//cust visit save and remove end
	});
function disableNewVisitBtn(){
	 $('#newVst').prop('disabled', true);
	 $('#newVst').css( { display:'none'}); 
}
function otherBox(id){ 
	      regOptnSts = 0;//regularisation only 
		  document.getElementById("rcustvst").checked = false; 
		  $('#otherlabel').removeClass("tabinactive");  
		  $('#custlabel').removeClass("tabactive");
		  $("#custlabel").addClass("tabinactive");
		  $("#otherlabel").addClass("tabactive"); 
		  $('#custvisit').removeClass("divactive");
		  $('#other').removeClass("divinactive");
		  $("#custvisit").addClass("divinactive");  
		  $("#other").addClass("divactive"); 
		  clearCustomerVisitDetails();
		  document.getElementById("thereason").value="";
}



function custVisitBox(){
	    regOptnSts = 1;//regularisation & Customer visit together 
	 	document.getElementById("rother").checked = false; 
		$('#otherlabel').removeClass("tabactive");  
		$('#custlabel').removeClass("tabinactive");
		$("#otherlabel").addClass("tabinactive");  
		$("#custlabel").addClass("tabactive");  
		$('#other').removeClass("divactive");
		$('#custvisit').removeClass("divinactive");
		$("#other").addClass("divinactive");  
		$("#custvisit").addClass("divactive");
		clearCustomerVisitDetails();
		document.getElementById("thereason").value="";		
}



function checkVisitType(){ 
	clearErrorMessage();  
	  var type = parseInt(document.getElementById("vstTyp").value);	 
	  if(type == 2){ 
		  clearGeneralMandatFields();
		  $('#gnrlBlck').css('display','none');	
		  getProjectDetails();
		  $('#flwUpBlck').css('display','block'); 		  
	  }else if(type == 1){
		  clearFolloupMandatFields();
		  party = "-";
		  $('#flwUpBlck').css('display','none');
		  $('#gnrlBlck').css('display','block'); 		 
	  }else{		 
		  $('#flwUpBlck, #gnrlBlck').css('display','none');		 
	  }
}
function clearGeneralMandatFields(){  
	document.getElementById("genProject").value = "";
}
function clearFolloupMandatFields(){ 
	party = "";
	if(prjectsTable != null && prjectsTable != '' && prjectsTable != 'undefined'){
	prjectsTable.$('tr.selected').removeClass('selected');
	}
}
function getProjectDetails(){
	var table = "<table id='prjctDtls' class='table display bordered small'><thead><tr>"+
				"<th></th><th>Doc-Id</th><th>Party Name</th><th class='remove-clmn'>Contact</th><th>Project</th><th class='remove-clmn'>Proj. Stage</th><th class='remove-clmn'>Consultant</th>"+
				"</tr></thead><tboady>";
	if(projects == null || projects == 'undefined' || typeof projects === undefined || projects == ''){    
		$.ajax({ type: 'POST', url: 'sip', 
			 data: {fjtco: "gs2pdforrcv"}, 
			 dataType: "json", 
			 success: function(data) {  
				 projects = data; 
				  projects.map( (item)=> {  
					  table +=  "<tr><td></td><td>"+$.trim(item.documentId)+"</td><td>"+$.trim(item.partyName)+"</td>"+
				 				    "<td class='remove-clmn'>"+$.trim(item.contact)+"</td><td>"+$.trim(item.project)+"</td>"+
				 				    "<td class='remove-clmn'>"+$.trim(item.projectStage)+"</td><td class='remove-clmn'>"+$.trim(item.consultant)+"</td>"+
				 				    "</tr>";
				 	});  
					
				    setProjectTable(table);	
					   
			 },error:function(data,status,er) { 
				  table +="</tboady></table>";
				  alert("please logout and login, then try again");  
				 }
		}); 
	}else{ 
	table += getFollowupProjects(); 
	setProjectTable(table);	 	
	}	 
		  
} 
function setProjectTable(table){
	table +="</tboady></table>";
	$("#flUpContent").html(table);
	 prjectsTable = $('#prjctDtls').DataTable( {
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
	 
	 $('#prjctDtls tbody').on('click', 'tr td.select-checkbox', function () {	
		 	clearErrorMessage(); 
	        if (!$(this).parents('tr').hasClass('selected')) {//temp fix
	        	    var data = prjectsTable.row($(this).parents('tr')).data();		        		        
			        docId = data[1];
			        party = data[2];
			        projectName = data[4];
			        visitTpe = 1; 				        
			        fromTime = document.getElementById("fromTime").value;
			        toTime = document.getElementById("toTime").value;
			        actionDesc =  document.getElementById("actionDesc").value;	
			        custName = document.getElementById("custName").value;
			    	custContctNo = document.getElementById("custContctNo").value
	       } else {
	    	    docId = "";
		        party = "";
		        projectName = "";  			        
	       }
	        
	    } ); 
}
function getFollowupProjects(){
	var result = ""; 
	projects.map( (item)=> {  
	 	  result +=  "<tr><td></td><td>"+$.trim(item.documentId)+"</td><td>"+$.trim(item.partyName)+"</td>"+
	 				    "<td class='remove-clmn'>"+$.trim(item.contact)+"</td><td>"+$.trim(item.project)+"</td>"+
	 				    "<td class='remove-clmn'>"+$.trim(item.projectStage)+"</td><td class='remove-clmn'>"+$.trim(item.consultant)+"</td>"+
	 				    "</tr>";
	 	}); 
	return result; 
	

}
function visitDetailsValidate(){
	clearErrorMessage(); 
	visitTpe = parseInt(document.getElementById("vstTyp").value);
	custName = document.getElementById("custName").value;
	custContctNo = document.getElementById("custContctNo").value;	
	if(visitTpe == 1){
		docId = "General"; 
		projectName = document.getElementById("genProject").value; 
		
	       if($.trim(action) == null || $.trim(action) == ''){
		    	$('#errMsg').html("Please select visit action...");
		    	document.getElementById("visitActn").focus();
		    	return false;		  
		    }else if(!validateTiming(fromTime, toTime)){
		    	$('#errMsg').html("<b>To Time</b> should greater or equal to <b>From Time</b> time...");
		    	document.getElementById("toTime").focus();
		    	return false; 
		    }else if($.trim(custName) == null || $.trim(custName) == ''){
		    	console.log("cust name "+custName);
		    	$('#errMsg').html("Please enter Contact Person Name...");   
		    	document.getElementById("custName").focus();
		    	return false;   	
		    }else if($.trim(custName).length > 100){
		    	$('#errMsg').html('Maximum 100 Character  for   Contact Person Name.');
		    	document.getElementById("custName").focus();
		    	return false;  	    	
		    }else if($.trim(custContctNo) == null || $.trim(custContctNo) == ''){
		    	$('#errMsg').html("Please enter Contact Person Number...");   
		    	document.getElementById("custContctNo").focus();
		    	return false;   	
		    }else if($.trim(custContctNo).length < 9){
		    	$('#errMsg').html('Please enter atleast 9 character for Contact Person Number.');
		    	document.getElementById("custContctNo").focus();
		    	return false;   	
		    }else if($.trim(custContctNo).length > 20){
		    	$('#errMsg').html('Maximum 20 Character  for  Contact Person Number.');
		    	document.getElementById("custContctNo").focus();
		    	return false;  
		    	
		    }else if($.trim(actionDesc) == null || $.trim(actionDesc) == ''){
		    	$('#errMsg').html("Please enter action description...");   
		    	document.getElementById("actionDesc").focus();
		    	return false;   	
		    }else if($.trim(actionDesc).length < 10){
		    	$('#errMsg').html('Please enter atleast 10 character for  action description.');
		    	document.getElementById("actionDesc").focus();
		    	return false;   	
		    }else if($.trim(actionDesc).length > 200){
		    	$('#errMsg').html('Maximum 200 Character  for  action description.');
		    	document.getElementById("actionDesc").focus();
		    	return false;  
		    }else if( $.trim(projectName) == '' || $.trim(projectName) == null ){
			    $('#errMsg').html("Please enter project/party details..");
			    document.getElementById("genProject").focus();
			    return false;
			}else if($.trim(projectName).length < 10){
		    	$('#errMsg').html('Please enter atleast 10 character for  project/party details.');
		    	document.getElementById("genProject").focus();
		    	return false;   	
	    	}else if($.trim(projectName).length > 200){
		    	$('#errMsg').html('Maximum 200 Character  for  project/party details.');
		    	document.getElementById("genProject").focus();
		    	return false; 	
		    }else{
		    	clearErrorMessage();  
		    	return true;
		    } 
	}else if(visitTpe == 2){
			
	    if($.trim(visitTpe) == null || $.trim(visitTpe) == '' || $.trim(docId) == null || $.trim(docId) == ''  ||  $.trim(projectName) == '' || $.trim(projectName) == null ){
	    	$('#errMsg').html("Please selet a project...");
	    	return false;
	    }else if($.trim(action) == null || $.trim(action) == ''){
	    	$('#errMsg').html("Please select visit action...");
	    	document.getElementById("visitActn").focus();
	    	return false;
	    }else if(!validateTiming(fromTime, toTime)){
	    	$('#errMsg').html("<b>To Time</b> should greater than <b>From Time</b>...");
	    	document.getElementById("toTime").focus();
	    	return false; 
	    }else if($.trim(custName) == null || $.trim(custName) == ''){
	    	$('#errMsg').html("Please enter Contact Person Name...");   
	    	document.getElementById("custName").focus();
	    	return false;   	
	    }else if($.trim(custName).length < 10){
	    	$('#errMsg').html('Please enter atleast 10 character for Contact Person Name.');
	    	document.getElementById("custName").focus();
	    	return false;   	
	    }else if($.trim(custName).length > 100){
	    	$('#errMsg').html('Maximum 100 Character  for   Contact Person Name.');
	    	document.getElementById("custName").focus();
	    	return false;  	    	
	    }else if($.trim(custContctNo) == null || $.trim(custContctNo) == ''){
	    	$('#errMsg').html("Please enter Contact Person Number...");   
	    	document.getElementById("custContctNo").focus();
	    	return false;   	
	    }else if($.trim(custContctNo).length < 10){
	    	$('#errMsg').html('Please enter atleast 10 character for Contact Person Number.');
	    	document.getElementById("custContctNo").focus();
	    	return false;   	
	    }else if($.trim(custContctNo).length > 20){
	    	$('#errMsg').html('Maximum 20 Character  for  Contact Person Number.');
	    	document.getElementById("custContctNo").focus();
	    	return false;  
	    }else if($.trim(actionDesc) == null || $.trim(actionDesc) == ''){
	    	$('#errMsg').html("Please enter a description...");   
	    	document.getElementById("actionDesc").focus();
	    	return false;   	
	    }else if($.trim(actionDesc).length < 10){
	    	$('#errMsg').html('Please enter atleast 10 character.');
	    	document.getElementById("actionDesc").focus();
	    	return false;   	
	    }else if($.trim(actionDesc).length > 200){
	    	$('#errMsg').html('Maximum 200 Character.');
	    	document.getElementById("actionDesc").focus();
	    	return false;   	
	    }else{
	    	clearErrorMessage();  
	    	return true;
	    } 
	}else{
		$('#errMsg').html("Please selet visit type...");
		document.getElementById("vstTyp").focus();
		return false;
		} 
}

function clearErrorMessage(){	
	$('#errMsg').html("");    
}
function clearErrorTimingMessage(){	
	var fromTime1 = document.getElementById("fromTime").value;
	var toTime1 = document.getElementById("toTime").value;
	if(!validateTiming(fromTime1, toTime1)){
		$('#errMsg').html("<b>To Time</b> should greater or equal to <b>From Time</b> time..."); 
	}else{
		$('#errMsg').html(""); 
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
function setAction(){
	clearErrorMessage();
	action = document.getElementById("visitActn").value;
}
function setactionDesc(){
	clearErrorMessage();
	actionDesc = document.getElementById("actionDesc").value;
}
function setCustName(){
	clearErrorMessage();
	custName = document.getElementById("custName").value;
}	
function setCustContctNo(){
	clearErrorMessage();
	custContctNo = document.getElementById("custContctNo").value;
}	


function setTime(){
	clearErrorMessage();
	fromTime = document.getElementById("fromTime").value;
	toTime = document.getElementById("toTime").value;
}
function clearAllFields(){ 
	clearErrorMessage();
	docId = ""; party = ""; projectName = "";fromTime="08:00"; toTime="18:00"; 
	if(prjectsTable != null && prjectsTable != '' && prjectsTable != 'undefined'){ prjectsTable.$('tr.selected').removeClass('selected'); } 
	document.getElementById("custName").value = "";
	document.getElementById("custContctNo").value = "";
	document.getElementById("actionDesc").value = "";
	document.getElementById("fromTime").value = "08:00";
	document.getElementById("toTime").value = "18:00"; 
	document.getElementById("genProject").value = "";
	document.getElementById("visitActn").selectedIndex = 0; 
	document.getElementById("vstTyp").selectedIndex = 0;  
	
	$('#gnrlBlck').css('display','none');	
	$('#flwUpBlck').css('display','none');				
}
function clearCustomerVisitDetails(){
	cvDetails.splice(0, cvDetails.length);
	visitCount = 0;
	if(visitCount == 0){
   	 $('#newVst').prop('disabled', false);
		 $('#newVst').css( { display:'block'}); 
    }
	clearAllFields();
	$('#user_data tbody').html("");
}

function disableRegularisationTab(){
	var btn1 = document.getElementById("otherlabel");
	
	if(btn1 != null){
		btn1.style.display = "none";
		}
	
	var btn2 = document.getElementById("custlabel");
	if(btn2 != null)
		btn2.style.display = "none";
	
		$('#otherlabel').removeClass("tabactive");  
		$('#custlabel').removeClass("tabinactive");
		$("#otherlabel").addClass("tabinactive");  
		$("#custlabel").addClass("tabactive");  
		$('#other').removeClass("divactive");
		$('#custvisit').removeClass("divinactive");
		$("#other").addClass("divinactive");  
		$("#custvisit").addClass("divactive");  
}
function enableRegularisationTab(){
		var btn1 = document.getElementById("otherlabel");
		if(btn1 != null)
			btn1.style.display = "inline-block";
		
	 	var btn2 = document.getElementById("custlabel");
	 	if(btn2 != null)
			btn2.style.display = "inline-block";
	 	
		$('#otherlabel').removeClass("tabinactive");  
		$('#custlabel').removeClass("tabactive");
		$("#otherlabel").addClass("tabactive");  
		$("#custlabel").addClass("tabinactive");	
		$('#other').removeClass("divinactive");
		$('#custvisit').removeClass("divactive");
		$("#other").addClass("divactive");  
		$("#custvisit").addClass("divinactive");  
	
}
function reloadPage(){
	 window.top.location.href="logout.jsp"
}
