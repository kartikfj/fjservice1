/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function startAjax(event,theA){
    event.preventDefault();    
    $('.action-btn').css({'pointer-events':'none','opacity': '.65'});   
    theUrl= theA.href;
    var maindiv = theA.parentNode.parentNode;
    var xhttp;
    if (window.XMLHttpRequest) {
        xhttp = new XMLHttpRequest();
        } else {
        // code for IE6, IE5
        xhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
    	$('.action-btn').css({'pointer-events':'auto','opacity': '1'});   
     if(xhttp.responseText != null){
        var start = xhttp.responseText.lastIndexOf('<body>')+7;
        var end = xhttp.responseText.lastIndexOf('</body>');
        var bodytxt = xhttp.responseText.substring(start,end);
        maindiv.innerHTML=bodytxt;
    }
    }else{
      // maindiv.innerHTML="Error in processing." ;
    }
  };
  xhttp.open("GET", theUrl, true);
   xhttp.send();
  maindiv.innerHTML="Being processed.."
}

function getCustVisitDetails(sename, uid, cvDate, theA){ 
	var ttl ="Customer Visit Details of "+sename+" for "+cvDate;
	var output="<table id='cvDetails_tbl'><thead><tr><th>Doc. Id</th><th>Visit Date</th><th>Action Type</th><th>Action Desc.</th><th>Time</th><th>Customer name</th><th>Customer Contact No.</th><th>Party</th><th>Project</th>"+
				"</tr></thead><tbody>";
    $.ajax({  type: 'POST',
   	 url: 'DailyTask', 
		 data: {fjtco: "cvdfser", seId:uid , rdate:cvDate },     
		 dataType: "json",
		 success: function(data) {		 	
			 for (var i in data) {  
				 output+="<tr><td>" + $.trim( data[i].documentId) + "</td><td>" + $.trim(data[i].visitDate)+ "</td>"+
				 "<td>"+data[i].actionType+"</td><td>"+data[i].actnDesc+"</td><td>" + $.trim(data[i].fromTime) + "-"+$.trim(data[i].toTime)+"</td><td>"+$.trim(data[i].customerName)+"</td><td>"+$.trim(data[i].customerContactNo)+"</td><td>"+$.trim(data[i].partyName)+"</td><td>"+$.trim(data[i].project)+"</td></tr>";
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

function getBusinessTripDetails(sename, fromdate, todate, subuid, loginuid, theA){ 
	var ttl ="Business Trip Details of "+sename;
	var output="<table id='cvDetails_tbl'><thead><tr><th>From Date</th><th>To Date</th><th>Country Visited</th><th>Company Name/Project Details</th><th>Purpose</th><th>Other Details</th>"+
				"</tr></thead><tbody>";
    $.ajax({  type: 'POST',
   	 url: 'DailyTask', 
		 data: {fjtco: "tburser", empid: loginuid, seId:subuid, fromdate:fromdate, todate:todate },     
		 dataType: "json",
		 success: function(data) {		 	
			 for (var i in data) {  
				 var frmdate = new Date(data[i].fromdate);
				 var tdate = new Date(data[i].todate);							
				 var fromdateString = new Date(frmdate.getTime() - (frmdate.getTimezoneOffset() * 60000 )).toISOString().split("T")[0];
				 var todateString = new Date(tdate.getTime() - (tdate.getTimezoneOffset() * 60000 )).toISOString().split("T")[0];
				 var  [fyear, fmonth, fday] = fromdateString.split('-');
				 var  [tyear, tmonth, tday] = todateString.split('-');
				 var fromdateString2 = `${fday}-${fmonth}-${fyear}`;
				 var todateString2 = `${tday}-${tmonth}-${tyear}`;
				 output+="<tr><td>" + $.trim( fromdateString2) + "</td><td>" + $.trim(todateString2)+ "</td>"+
				 "<td>"+data[i].country+"</td><td>"+data[i].projectDetails+"</td><td>" + $.trim(data[i].purpose) + "</td><td>"+$.trim(data[i].otherDetails)+"</td></tr>";
				 } 		          	
				 output+="</tbody></table>";
				 $("#businesstrpDetails .modal-title").html(ttl);
				 $("#businesstrpDetails .modal-body").html(output);
				 $("#businesstrpDetails").modal("show");
			},error:function(data,status,er) {
				 e.preventDefault();
				alert("Please Log out and try again.");}
			});	
}
