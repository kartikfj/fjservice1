/**
 * Customer Visit Planner
 */
 function userIsOrigOrNot(user1,user2){
	if(user1 !== user2){return true;}
	else{return false;}	
}

 function Apply(button){
    var theUrl= "regularisationRequest.jsp";
    var params = '';
    button.disabled=true;
    var thedate = document.getElementById("regularise_date").value; 
    var selected_date = document.getElementById("selected_date").value;    
    var encoded_dt = encodeURI(thedate);
     // var thereason = document.getElementById("thereason").value;
   // var thechkin = document.getElementById("ichkin").value;  
    if(thedate = null || thedate == '' ){
        alert("Please refresh the page and try again!");
        button.disabled=true;
        return;
    } 
  
   if(regOptnSts == 3){
    	 if(cvDetails.length == 0){
    		 alert("Please add atleast one customer visit details (Maximum 7).");
    		 button.disabled=false; 
    		 return;
    	 }else{
    		// preSendLoaderStyle();    		
	    	 if(confirm("This is Customer Visit Planner.You will be able to change till one day prior.")){
	    		      var jsonDetails = encodeURIComponent(JSON.stringify((cvDetails)));
	    		      params = "regularise_date="+encoded_dt+"&regOptnSts="+regOptnSts+"&details="+jsonDetails+"&alrdyUpdtdVsts="+alrdyUpdtdVstCnt;
	    		     // disableClickOnCustomerVisitDiv();
	    		  }
	    		  else { enableClickOnCustomerVisitDiv(); return; }	    	
    	 } 
    	 
    }else{
    	 alert("Please refresh the page and try again!");
    	 button.disabled=true;
    	 return;
    } 
       
   // var jsonDetails = CryptoJS.enc.Base64.parse(encodeURIComponent(JSON.stringify((cvDetails))));
           
    var heading = document.getElementById("formheading");
  //  heading.innerHTML="Being processed.."
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
      //  var bodytxt = xhttp.responseText.substring(start,end);
      //  heading.innerHTML=bodytxt;               	 
         //hideCustVisitBox();  
        var idate=document.getElementById("idate").value;
        var outerdiv = document.getElementById("day_"+idate);  
           $("#createEventModal").modal('hide');
          
            var i = 0;
           // cvDetails = cvDetails.filter( obj => obj.id !== row_id);
           while (i < cvDetails.length) { 
        //    alert(cvDetails[i].fromTime+' '+cvDetails[i].actionType);              
  		     $("#calendar").fullCalendar('renderEvent',	        
  		    	 {
  			    	  title  : cvDetails[i].fromTime+' '+cvDetails[i].actionType,
  			          description:cvDetails[i].actnDesc,
  			          sdtime: cvDetails[i].fromTime,
  			          edtime: cvDetails[i].toTime,
  			          start  : moment(selected_date).format('YYYY-MM-DD'),
  			          end    : moment(selected_date).format('YYYY-MM-DD'),
  			          docId : cvDetails[i].documentId,
  			          contactPerson : cvDetails[i].customerName,
  			          contactNumber : cvDetails[i].customerContactNo,
  			          project : cvDetails[i].project,  			         
  			          backgroundColor: 'green', 
  		              borderColor    : 'green', 
  		              allday:true		              
  			      },
  		        true); 	
                   $("#calendar").fullCalendar("unselect");
                  i++;
                  alrdyUpdtdVstCnt++;
                  document.getElementById("alrdyUpdtdVsts").value = alrdyUpdtdVstCnt; 
                  document.getElementById("previous_date").value = document.getElementById("regularise_date").value;
                }                
              //  alrdyUpdtdVstCnt = alrdyUpdtdVstCnt+cvDetails.length;
                clearCustomerVisitDetails();
                //setDeafaultVisitValues();
        	//replaceResponseImage(outerdiv, regOptnSts); 
        // if (outerdiv.removeEventListener) {                   
         //   outerdiv.removeEventListener("click", showRegularisationRequest,false);
       // } else if (outerdiv.detachEvent) {                    // For IE 8 and earlier versions
      //      outerdiv.detachEvent("onclick", showRegularisationRequest);
      //  }
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
function closeRequestWindow(){
    //console.log("here2");   
    var msgbox = document.getElementById("requestformdiv");
    msgbox.style.display="none";
    
}
function replaceResponseImage(outerdiv, regOptnSts){
	var regCvDate = document.getElementById("regularise_date").value; 
	var totalVisits = visitCount + alrdyUpdtdVstCnt;
	//setDeafaultVisitValues();
	
}
function hideCustVisitBox(){
	var visitbox = document.getElementById("custRqstBox");
	if(visitbox != null){
		clearAllFields();
		visitbox.style.display="none"; 
	}
}
function disableClickOnCustomerVisitDiv(){
	var cvisitbox = document.getElementById("custRqstBox");  
	if(cvisitbox != null)
	   cvisitbox.style.pointerEvents = 'none';
}
function preSendLoaderStyle(){ $("#custvisit").css({"opacity": "0.7", "background": "url(resources/images/fjpre.gif) no-repeat 50% 50%", "background-size": "60px 60px"});}
 function custVisitBox(){
	    regOptnSts = 3;//regularisation & Customer visit together 
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
function dateDiffInDaysForCustVisitPr(today,selectDay){	
	var a = moment(today,'YYYY/M/D');
	var b = moment(selectDay,'YYYY/M/D');
	var diffDays = b.diff(a, 'days');
    return diffDays;	
}
function checkVisitType(){
	clearErrorMessage();  
	  var type = parseInt(document.getElementById("vstTyp").value);	 
	  //alert("type== "+document.getElementById("vstTyp").value);
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
		$.ajax({ type: 'POST', url: 'CustomerVisitPlanner', 
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
	        if (!$(this).parents('tr').hasClass('selected')) {
	        	    var data = prjectsTable.row($(this).parents('tr')).data();		        		        
			        docId = data[1];
			        party = data[2];
			        projectName = data[4];
			        visitTpe = 1; 				        
			        fromTime = document.getElementById("fromTime").value;
			        toTime = document.getElementById("toTime").value;
			        actionDesc =  document.getElementById("actionDesc").value;	
			        custName = document.getElementById("custName").value;
			    	custContctNo = document.getElementById("custContctNo").value;
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
	custContctNo = document.getElementById("custContctNo").value
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
	if(btn1 != null)
		btn1.style.display = "none";
	
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

$(document).ready(function(){  
	  $("[rel='tooltip']").tooltip();
	  alrdyUpdtdVstCnt = 0;
	$('#newVst').click(function(e) {
	   if((visitCount + alrdyUpdtdVstCnt) < 7){
		   clearAllFields();  
	   }else{
		   clearAllFields();
		   $("#modal-new-visit").modal('hide');
		   alert("Maximum number of customer visit entry exceeded!.");		  
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
	
	
function updateEditEventController(updateEvent){
      var descCrte=updateEvent.description.split("<br/>").join("\n");
      var docId= updateEvent.docId;
      console.log("docId== "+docId.includes("General"));
     console.log(updateEvent.title.substring(6));
     console.log(updateEvent.docId);
     console.log(updateEvent.sdtime);
     console.log(updateEvent.edtime);
     console.log("id== "+updateEvent.sysid);
     console.log(updateEvent.customer);
     console.log(updateEvent.project);
     console.log(updateEvent.contactPerson);
     console.log(updateEvent.contactNumber);
     console.log(updateEvent.description);
	  $("#updateEventModal .modal-title").html("Update Task Details of "+moment(updateEvent.start).format('YYYY-MM-DD').split("-").reverse().join("/"));		  
	 // $("#updateEventModal .modal-body #vstTyp").html(descCrte);
	//  $("#updateEventModal .modal-body #pyttu").val(updateEvent.title.substring(6));
	  $("#updateEventModal .modal-body #upvstTyp").val(updateEvent.docId);
	  $("#updateEventModal .modal-body #upvisitActn").val(updateEvent.title.substring(6));
	  $("#updateEventModal .modal-body #upfromTime").val(updateEvent.sdtime);
	  $("#updateEventModal .modal-body #uptoTime").val(updateEvent.edtime);	 
	  $("#updateEventModal .modal-body #upcustContctNo").val(updateEvent.contactNumber);
	  $("#updateEventModal .modal-body #upcustName").val(updateEvent.contactPerson);
	  $("#updateEventModal .modal-body #upactionDesc").val(updateEvent.description);	 
	  if(docId.includes("General")){
		 $("#updateEventModal .modal-body #upgenProject").val(updateEvent.project);
	   }else{
	    $('#updateflwUpBlck').css('display','none');
	    $('#updateEventModal .modal-body #upgenProject').prop('disabled', true);
		$("#updateEventModal .modal-body #upgenProject").val(updateEvent.project);
		}
	  $("#updateEventModal .modal-body #upsysid").val(updateEvent.sysid);
		  if(updateEvent.docId.includes("General")){
			$('#flwUpBlck').css('display','none');
			$('#updateflwUpBlck').css('display','none');
		  	$('#gnrlBlck').css('display','block'); 	
			$("#updateEventModal .modal-body #genProject").val(updateEvent.project);
		  }
	    
	  $("#updateEventModal").modal('show');
	  $('#updateButton').on('click', function(e){ 
		  e.preventDefault();  
		  $('#errMsgup').html(''); 
           var updateData = "0";
       if($.trim($("#updateEventModal .modal-body #upactionDesc").val()).length < 10){
	    	$('#errMsgup').html('Minimum 10 character required!');
	    	return false;
	    }else{ 
	           updateData = doUpdate();
	  	     if(updateData.trim()==="1"){
			        updateCalendar(updateEvent);
				    $("#evntDtls").empty();
				    alert("Task Updated successfully");}
				 else{  
					 alert("Please refresh the page to update your task");
					 //alert("Task is Not Uppdated, Please try again later"); 
				 $("#updateEventModal").modal('hide');
				 }
			   
	   		}
      });  
}
function doUpdate(){
	  var startTimetmp=$('#upfromTime').val();
      var endTimetmp=$('#uptoTime').val(); 
      var descCrte=$('#upactionDesc').val().split("\n").join("<br/>");
      var genProject=$('#upgenProject').val();
      var sysid=$('#upsysid').val();
      console.log(genProject);   
       console.log(sysid);  
      var output=null;
     // var tid=$('#ditu').val();
      if(typeof genProject === 'undefined' || genProject == ''){
    	  output="0";
    	  return output;  
    	  }else{
   // if(checkTextValidOrNot($('#csedtu').val().split("\n"))){	  
		  $.ajax({
			 'async': false,
	 		 type: 'POST',
	     	 url: 'CustomerVisitPlanner', 
	     	 data: {fjtco: "tnveetdpu", utd1:startTimetmp, utd2:endTimetmp,utd3:descCrte,utd4:genProject,utd5:sysid},
	         success: function(data) { 
		     output=data;
	  },error:function(data,status,er) { 
		  alert("please click again");
		  output=data;
		 // console.log(output+":error")
		  }
	  });
   // }
	  return output; 
	
    	  }
	// console.log(output+":return")
	     
}
function removeCalendar(event,sysid){
		 $('#calendar').fullCalendar('removeEvents',event.id);
		// $('#calendar').fullCalendar('removeEvents', sysid);
		 $("#updateEventModal").modal('hide');
	 }
function updateCalendar(event){

	 event.description = $("#updateEventModal .modal-body #upactionDesc").val();
	 event.project = $("#updateEventModal .modal-body #upgenProject").val();
	 event.title =$("#updateEventModal .modal-body #upfromTime").val()+' '+$("#updateEventModal .modal-body #upvisitActn").val();
	 event.sdtime =$("#updateEventModal .modal-body #upfromTime").val();
	 event.edtime = $("#updateEventModal .modal-body #uptoTime").val();
	 event.backgroundColor= '#795548';
	 event.borderColor= '#795548'; 
	 $('#calendar').fullCalendar('updateEvent', event);
	 $("#updateEventModal").modal('hide');
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
function markitasvisitedController(updateEvent){ 
      var sysid = updateEvent.sysid;
       $.ajax({
			 'async': false,
	 		 type: 'POST',
	     	 url: 'CustomerVisitPlanner', 
	     	 data: {fjtco: "itmarkvisited",utd1:sysid},
	         success: function(data) { 
		     output=data;
		    
		     removeCalendar(updateEvent,sysid);
		     $("#evntdesc_"+sysid).empty();
		    // $("#evntDtls").empty();
		     
	  },error:function(data,status,er) { 
		  alert("please click again");
		  output=data;
		 // console.log(output+":error")
		  }
	  }); 
}
function visitdetails(cvList,day,alreadyupdatedcnt,date){
	//FOR CUST VISIT START 
    clearCustomerVisitDetails(); 
   //FOR CUST VISIT END 	

 if(alreadyupdatedcnt == null || alreadyupdatedcnt == 0){	
  cvList.map( item => { 
	 for (var key in item.categoryMapping) { 
		    if(key == day){
			    console.log('Key: ' + key + '. Value: ' + item.categoryMapping[key]);
			     alrdyUpdtdVstCnt = item.categoryMapping[key];	
			     break;		   
			    }else{
					 alrdyUpdtdVstCnt = 0;
					 console.log('Key: ' + key + '. Value: ' + item.categoryMapping[key]);
				}   
			}
		});		
	}else{
		alrdyUpdtdVstCnt = alreadyupdatedcnt;
	}
		
		if(alrdyUpdtdVstCnt >= 7){
			$("#createEventModal").modal('hide');
			alert("You have already added maximum no.of visits");
		}else{		
			 var heading = document.getElementById("custlabel");	
			  heading.innerHTML="Cust-Visit Planner for "+date;
			$("#createEventModal").modal('show');
		}
	
}

function doSubmit(selectedDay,selectedMonth,selectedYr,tempname,tempcmp){ 
		    var startTimetmp=$('#strtTime').val();
	        var endTimetmp=$('#endTime').val(); 
	
	      if(checkTextValidOrNot($('#desc').val())){
	        var descCrte=$('#desc').val().split("\n").join("<br/>");
            //console.log(descCrte);
	        $.ajax({
	 	    		 type: 'POST',
	 	        	 url: 'DailyTask', 
	 	        	 data: {fjtco: "tnveetrc", td1:$('#typ').val() , td2:descCrte,
	 	        		    td3:moment(selectedDay).format('YYYY-MM-DD'),td4:startTimetmp,td5:endTimetmp,td6:selectedMonth,td7:selectedYr,td8:tempname,td9:tempcmp},
			         success: function(data) {  
			        	
			        	 if (parseInt(data) == 1) {			              
			        		   $("#createEventModal").modal('hide');
			      		     $("#calendar").fullCalendar('renderEvent',		        
			      		    	 {
			      			    	  title  : startTimetmp+' '+$('#typ').val(),
			      			          description: $('#desc').val(),
			      			          sdtime:startTimetmp,
			      			          edtime:endTimetmp,
			      			          start  : moment(selectedDay).format('YYYY-MM-DD'),
			      			          end    : moment(selectedDay).format('YYYY-MM-DD'),
			      			          docId : '' ,
			      			          project : '',
			      			          backgroundColor: 'green', 
			      		              borderColor    : 'green', 
			      		              allday:true		              
			      			      },
			      		        true);
			        		 
			                }else{alert("Your Task is Not Updated,Please login and  Try gain.");
			                window.location.href = 'logout.jsp';}
			         },error:function(data,status,er) { 
			        	 alert("Your Task is Not Updated,Please Rfresh the page."); }
			       });
	        }
		  
}
function setDeafaultVisitValues(){
	alrdyUpdtdVstCnt = 0;
	visitCount = 0;
}

function goToNewCalendarDate(goYear,goMonth){
	 var edCpme=$.trim($('#sid').val());
	$('#calendar').fullCalendar('removeEvents');
	$("#evntDtls").empty();
   if(goMonth<10){goMonth="0"+goMonth;}
	var goDate=goYear+"-"+goMonth+"-01";
	 $.ajax({  type: 'POST',
    	 url: 'CustomerVisitPlanner', 
		 data: {fjtco: "yampfltsncp", td1:goYear , td2:goMonth,td3:edCpme}, 
		 dataType: "json",
		 success: function(data) {			
			 var events = [];		
			  for (var i in data) { 
				  events.push( {
		          title  : data[i].tst09+' '+data[i].ttyp07,
		          description: data[i].tdesc08,
		          id : data[i].tid01,
		          sdtime:data[i].tst09,
		          edtime:data[i].tet10,
		          start  : moment(data[i].twd05).format('YYYY-MM-DD'),
		          end    : moment(data[i].twd05).format('YYYY-MM-DD'),
		          docId : data[i].cvdid,
 		          project : data[i].cvpopn,
		          backgroundColor: 'green', 
	              borderColor    : 'green', 
	              allday:true
		        });	
				  
				  
				  
			  }	
		         $('#calendar').fullCalendar('addEventSource', events);			    
				 $('#calendar').fullCalendar('gotoDate', goDate);
		
				 
				 var output="<table id='dailytask_table' style='display:none;'><thead><tr><th>Task</th><th>Emp: Name</th><th>Date</th><th>Time</th><th>Details</th></tr></thead><tbody>";
				 for (var i in data) { output+="<tr><td>" + $.trim( data[i].ttyp07) + "</td><td>" + $.trim( data[i].tendb11) + "</td><td>" + moment(data[i].twd05).format('YYYY-MM-DD')+ "</td>"+
				 "<td>"+data[i].tst09+" to "+data[i].tet10+"</td><td>" + $.trim(data[i].tdesc08) + "</td></tr>";
				 } 
				 output+="</tbody></table>";
				 
				 newDateExcelExport(output,goYear,goMonth,edCpme)
				
				   
			},error:function(data,status,er) {
				 e.preventDefault();
				alert("please click again");}
			});	
}