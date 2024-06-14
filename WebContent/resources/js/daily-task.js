function userIsOrigOrNot(user1,user2){
	if(user1 !== user2){return true;}
	else{return false;}	
}

function dateDiffInDays(today,selectDay){	
	var a = moment(today,'YYYY/M/D');
	var b = moment(selectDay,'YYYY/M/D');
	var diffDays = a.diff(b, 'days');
    return diffDays;	
}
function goToNewCalendarDate(goYear,goMonth){
	 var edCpme=$.trim($('#sid').val());
	$('#calendar').fullCalendar('removeEvents');
	$("#evntDtls").empty();
   if(goMonth<10){goMonth="0"+goMonth;}
	var goDate=goYear+"-"+goMonth+"-01";
	 $.ajax({  type: 'POST',
    	 url: 'DailyTask', 
		 data: {fjtco: "yampfltsn", td1:goYear , td2:goMonth,td3:edCpme}, 
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

function newDateExcelExport(output,year,month,user){
	 $("#export").html(output);
	   $('#dailytask_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: "Employee : "+user+" Daily Task Details - "+month+"/"+year,
	                title: "Employee : "+user+" Daily Task Details - "+month+"/"+year,
	                messageBottom: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
}

function updateEventController(updateEvent){
	      var descCrte=updateEvent.description.split("<br/>").join("\n");
	    
		  $("#updateEventModal .modal-title").html("Update Task Details of "+moment(updateEvent.start).format('YYYY-MM-DD').split("-").reverse().join("/"));		  
		  $("#updateEventModal .modal-body #csedtu").html(descCrte);
		  $("#updateEventModal .modal-body #pyttu").val(updateEvent.title.substring(6));
		  $("#updateEventModal .modal-body #tstu").val(updateEvent.sdtime);
		  $("#updateEventModal .modal-body #tetu").val(updateEvent.edtime);
		  $("#updateEventModal .modal-body #ditu").val(updateEvent.id);
		  $("#updateEventModal").modal('show');
		  $('#updateButton').on('click', function(e){ 
			  e.preventDefault();  
			  $('#errMsgup').html(''); 
               var updateData = "0";
           if($.trim($("#updateEventModal .modal-body #csedtu").val()).length < 10){
   		    	$('#errMsgup').html('Minimum 10 character required!');
   		    	return false;
   		    }else{
           
           /*
           else if(!pattern.test($("#updateEventModal .modal-body #csedtu").val())){
   		    	$('#errMsgup').html('');
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
               }else{
            	   $('#errMsgup').html("Special characters <b>( \' \? \= \| \" \; \` \^ \/ < > ~ | )</b>  not Allowed!"); 
            	   return false;
               } 
            */  
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
	  
function removeEventController(taskId){	 
		  $.ajax({
	    		 type: 'POST',
	        	 url: 'DailyTask', 
	        	 data: {fjtco: "tnvetld", dit:taskId},
		         success: function(data) { $('#close'+taskId+'').parent().remove(); $("#evntDtls").empty();
			              alert(data);
		         },error:function(data,status,er) { 
			     alert("please click again");
			    }
		  });			  	  
	  }
	  
function closeEventController(taskId){ $('#'+taskId+'').parent().remove(); }

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

function updateCalendar(event){

		 event.description = $("#updateEventModal .modal-body #csedtu").val();
		 event.title =$("#updateEventModal .modal-body #tstu").val()+' '+$("#updateEventModal .modal-body #pyttu").val();
		 event.sdtime =$("#updateEventModal .modal-body #tstu").val();
		 event.edtime = $("#updateEventModal .modal-body #tetu").val();
		 event.backgroundColor= '#795548';
		 event.borderColor= '#795548'; 
		 $('#calendar').fullCalendar('updateEvent', event);
		 $("#updateEventModal").modal('hide');
	 }

function doUpdate(){
	  var startTimetmp=$('#tstu').val();
      var endTimetmp=$('#tetu').val(); 
      var descCrte=$('#csedtu').val().split("\n").join("<br/>");
      var output=null;
      var tid=$('#ditu').val();
      if(typeof tid === 'undefined' || tid == ''){
    	  output="0";
    	  return output;  
    	  }else{
    if(checkTextValidOrNot($('#csedtu').val().split("\n"))){	  
	  $.ajax({
		 'async': false,
 		 type: 'POST',
     	 url: 'DailyTask', 
     	 data: {fjtco: "tnveetdpu", utd1:$('#ditu').val(), utd2:$('#pyttu').val(),utd3:descCrte,
     		   utd4:startTimetmp,utd5:endTimetmp},
         success: function(data) { 
	     output=data;
	     //console.log(output+":success");
	     
	     
  },error:function(data,status,er) { 
	  alert("please click again");
	  output=data;
	 // console.log(output+":error")
	  }
  });
    }
	  return output; 
	
    	  }
	// console.log(output+":return")
	     
}


 function validateForm(){
	 
	 var ts=$('#strtTime').val();
     var fs=$('#endTime').val();
	
	 var startTime, endTime, timeArr;
	 // split the hours and minutes
	 timeArr = ts.split(':');
	 // Hours is in timeArr[0]; minutes in timeArr[1];
	 startTime = (timeArr[0] * 60) + timeArr[1];
	 // do the same for end time:
	 timeArr = fs.split(':');
	 endTime = (timeArr[0] * 60) + timeArr[1];
	 // Now you can compare them
	 return startTime >= endTime;
 }
 
function validateUpdateForm(){
	 
	 var desc=$('#csedtu').val();
	
	if(desc !=null){ return; }
	else{return false;}
	
 }

function getEmplyeeeDailyTaskReport(){
	var day=$('#reportDate').val().split("-").reverse().join("-");
	var dm_code=$('#dmCode').val();
	//alert(day);
	if( day ==null || typeof day === 'undefined' || day == ''){
		alert('Please select a date.'); 
		return false; 
	}else{
	 $('#laoding').show();	      
	 $.ajax({  type: 'POST',
   	 url: 'DailyTask', 
		 data: {fjtco: "cedtrsd", td1:dm_code , td2:day}, 
		 dataType: "json",
		 success: function(data) {					 	
			 $('#laoding').hide();
			 $("#report-modal .modal-title").html('Employees Daily Task Report for '+$('#reportDate').val());	
			 var output="<table id='dailyTaskReport' class='table table-bordered small'><thead><tr><th>Company</th><th>Division</th><th>Emp. ID</th><th>Emp. Name</th><th>Date </th><th>Type</th><th>Time</th><th>Task Description</th>"+
		 "</tr></thead><tbody>";		 
		 var j=0; for (var i in data) { j=j+1;		 
		 output+="<tr><td>" + data[i].tecmp12 + "</td><td>"+ data[i].tedvn13 + "</td>"+
		 "<td>" + data[i].emp_code + "</td><td>" + data[i].emp_name+ "</td>"+ "<td>" + moment(data[i].twd05).format('DD-MM-YYYY') + "</td><td>" + data[i].ttyp07 + "</td>"+
		 "<td>" + data[i].tst09 + " - " + data[i].tet10+ "</td>"+ "<td>" + data[i].tdesc08 +
		 "</tr>"; } 
		 output+="</tbody></table>";		 
		 $("#report-modal .modal-body").html(output);
		 $("#report-modal").modal("show");			 
			    $('#dailyTaskReport').DataTable( {
			    	dom: 'Bfrtip',
			        "paging":   true,       
				        buttons: [
				            {
				                extend: 'excelHtml5',
				                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1.4em;">Export</i>',
				                filename: 'Employees Daily Task Report for '+$('#reportDate').val(),
				                title: 'Employees Daily Task Report for '+$('#reportDate').val(),
				                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'				                				                
				            }				          				           
				        ]
				    } );
				   
			},error:function(data,status,er) {
				 e.preventDefault();
				alert("please click again");}
			});	
	}
}
function checkTextValidOrNot(taskDetails){
	if(/^[a-zA-Z0-9- ,_\n.]*$/.test(taskDetails) == false){
		alert("Please avoid special character from your  comment except  - , _  . ");
	    return false
	}else{
		if(taskDetails.length > 300){
			alert("Maximum characters allowed is 300 ");
		}else{
			return true;
		}
		
	}
}

