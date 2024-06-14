/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
// TO avoid re submission start
  if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
//TO avoid re submission  end
function invokeCalculate(){
    var leaveselect = document.getElementById("leavetype");
    if(leaveselect.options[leaveselect.selectedIndex].value == 'LENC' || leaveselect.options[leaveselect.selectedIndex].value == 'LWP' )
        return;
    var theform = document.getElementById("theform");
    theform.submitted = 'calculate';
    
    if(evalFieldsForCalculatebtn(theform)){
        console.log("invokeCalculate :"+document.getElementById("calbutton").value);
    theform.submit();
    }
}

function invokeApply(button){
    button.disabled = true;
    var theform = document.getElementById("theform");
    theform.submitted = 'apply';
    if(evalFieldsForCalculatebtn(theform)){
        console.log(document.getElementById("calbutton").value);
        theform.submit();
    }else{
        button.disabled = false; 
    }
}
function evalFieldsForCalculatebtn(form1){
 var oprn = document.getElementById("calbutton");
    if(form1.submitted == 'calculate'){
    var fromfld = document.getElementById("datepicker-13").value;
    if(fromfld !=null)
        fromfld = fromfld.trim();
    
    if(fromfld.length == 0)
    {
        alert("Enter from date.");
        return false;
    }
    oprn.value="Calculate";
    
    return true;
}
else if(form1.submitted == 'apply' ){
    var leaveselect = document.getElementById("leavetype").value;    
    //console.log('apply');
    var fromdt = document.getElementById("datepicker-13").value;
    var todt = document.getElementById("datepicker-14").value;
    var resn = document.getElementById("reason").value;
    var leave = document.getElementById("leaveaddr").value;
    var nolvd = document.getElementById("nolvdays").value;
    var totallv = document.getElementById("totalleave").value; 
    var totalDays = document.getElementById("totaldays").value;
    var joiningdate;
    if(document.getElementById("joiningdate")!=null && document.getElementById("joiningdate").value!==null)
    {
        joiningdate = document.getElementById("joiningdate").value;
    } 
    
   
    //var maxAccrualLeave = document.getElementById("ttlmaxaccrvllv").value; //maximum accrued leave value -- null error -- nufail
    //alert(totalDays);
    document.getElementById("nolvdays").disabled=false;
    document.getElementById("totaldays").disabled=false;
   // console.log('read '+fromdt+" "+todt+" "+resn+" "+leave);
   if(leaveselect == 'LENC'){
       if(fromdt ==null || resn == null || nolvd == null || totallv ==null){
            alert("Please fill the leave encashment application details fully.");
        return false;
       }
   }
   else{
   if(fromdt == null || todt ==null || resn==null || leave==null || totallv ==null ){
       alert("Please fill the leave application details fully.");
       return false;
   }
   if(fromdt.trim().length == 0 || todt.trim().length ==0 || resn.trim().length==0 || leave.trim().length==0 || totallv.trim().length ==0) {
       // console.log('read '+fromdt+" "+todt+" "+resn+" "+leave);
       alert("Please fill the leave application details fully.");
       return false;
   }
   var resumedtv = document.getElementById("resumedate").value;
   if(resumedtv.trim().length == 0 || nolvd.trim().length == 0){
       alert("Please fill the halfday detils properly.");
       return false;
   }
   }
   
    totallv = totallv.trim();
    nolvd = nolvd.trim();
    totalDays = totalDays.trim();
    //maxAccrualLeave=maxAccrualLeave.trim();
    
   // console.log('Maximum accrual leave value based on selected date'+maxAccrualLeave);
   // var tot = parseInt(totallv,10);
   // var noofdays = parseInt(nolvd,10); 
  // alert("total lv "+totallv+"nolvd "+nolvd+" total days "+totalDays);
   var tot = Number(totallv);
  // console.log('total  '+tot);
    var noofdays = Number(nolvd); 
  //  console.log('No: of leav days applied '+noofdays);
    if(isNaN(tot) || isNaN(noofdays)){
        alert("Invalid leave days!");
        return false;
    }
    if(noofdays <= 0){
       alert("Invalid leave days value");
       return false;
    }
   if( tot < noofdays && leaveselect !='AN30' && leaveselect !='AN60' && leaveselect !='AN15' || tot < noofdays ||  tot <= 0){
       alert("Not enough leave balance.");
       return false;
    } 
    //Added for Not allowing annual leaves before 6 months of joining..(Issue raised by Lara)
     if( leaveselect =='AN30' || leaveselect =='AN60' || leaveselect =='AN15' || leaveselect =='AN30FJC'){
			var lvfrdate=fromdt.split("/").reverse().join("-");
			var joiningdate = new Date(joiningdate);
			var lvfromdate  = new Date(lvfrdate);
			const _MS_PER_DAY = 1000 * 60 * 60 * 24;
		    var joiningdate2=new Date(joiningdate.getFullYear(), joiningdate.getMonth(), joiningdate.getDate());
		    joiningdate2.setMonth(joiningdate2.getMonth()+6);
		    var lvfromdate2 = new Date(lvfromdate.getFullYear(), lvfromdate.getMonth(), lvfromdate.getDate());
		    const utc1 = Date.UTC(joiningdate.getFullYear(), joiningdate.getMonth(), joiningdate.getDate());
		    const utc2 = Date.UTC(lvfromdate.getFullYear(), lvfromdate.getMonth(), lvfromdate.getDate());
			if(joiningdate2>lvfromdate2){
				alert("You can't avail annual leave for the first 6 months of your joining.");
				return false;
			}
		
    } 
    
    if(noofdays < 3 && leaveselect == 'COMPASIONATE'){
        alert("Compassionate  leave : Minimum 3 days must be availed.");
        return false;
    } 

    if(noofdays < 3 && leaveselect == 'ELV'){
        alert("Emergency leave : Minimum 3 days must be availed.");
        return false;
    }
    
     oprn.value="Apply";
    var lvbal = document.getElementById("leavebalance");
    lvbal.value=totallv;
  return true;
}
 return false;
}

function manageFormElements(type){
    var leaveselect = document.getElementById("leavetype");
    var chkbx = document.getElementById("h_chkbox");
    var r1 = document.getElementById("radiohf");
    var r2 = document.getElementById("radiohs");
    r1.checked=false;
    r2.checked=false;
    r1.disabled = true;
    r2.disabled = true;
    chkbx.checked = false;  
    
    if(leaveselect.value== 'LENC'){ 
        console.log("LENC");
        $( "#datepicker-13" ).datepicker('enable');
        $( "#datepicker-14" ).datepicker('disable');
        $( "#datepicker-14" ).datepicker('setDate', null);
        document.getElementById("leaveaddr").disabled = true;
        document.getElementById("frdt_label").innerHTML  = "Effective date<span>*</span>";
        document.getElementById("nolvdays").disabled = false;
        var lvdaysfld = document.getElementById("nolvdays");//tabIndex 
        lvdaysfld.disabled = false;
        lvdaysfld.className='enabled_input';
        lvdaysfld.tabIndex = 0;
   }else if(leaveselect.value == 'CASUAL' || leaveselect.value == 'CHRISTMAS' || leaveselect.value == 'AN30' || leaveselect.value == 'AN60'  || leaveselect.value == 'AN15'){ //-- nufail start
	   $("#datepicker-13").datepicker("option", "minDate", 0);//new changes for handling  Annual Leave ,casual and ocassional leave , set default date today, no backdate  entry
       $( "#datepicker-14" ).datepicker("option", "minDate", $("#datepicker-13").datepicker('getDate'));//new - set default  minimum date for "to" date
       $( "#datepicker-14" ).datepicker('enable');
       $( "#datepicker-14" ).datepicker('setDate', null);
       document.getElementById("leaveaddr").disabled = false;
       document.getElementById("frdt_label").innerHTML  = "From Date<span>*</span>";
       var lvdaysfld = document.getElementById("nolvdays");//tabIndex 
       lvdaysfld.disabled = true;
       lvdaysfld.className='disabled_input';
       lvdaysfld.tabIndex = -1;
	   }//-- nufail end
   else{
	  // console.log(lvDfltYear);//default levae current year -- nufail
	   $("#datepicker-13").datepicker( "option", "minDate", new Date(lvDfltYear, 1 - 1, 1) );// disabling minimum date  (back end date ) restriction for other leave types
	   $( "#datepicker-13" ).datepicker('enable');
       $( "#datepicker-14" ).datepicker('enable');
       $( "#datepicker-14" ).datepicker('setDate', null);
       document.getElementById("leaveaddr").disabled = false;
       document.getElementById("frdt_label").innerHTML  = "From Date<span>*</span>";
       var lvdaysfld = document.getElementById("nolvdays");//tabIndex 
       lvdaysfld.disabled = true;
       lvdaysfld.className='disabled_input';
       lvdaysfld.tabIndex = -1;
   }
    if(!isHalfDayApplicable()){
        chkbx.disabled = true;
   }
   else{
       chkbx.disabled = false;   
   }
   updateLeaveBalance();
   
   return true;
 
}
function isHalfDayApplicable(){
    var d1 = $("#datepicker-13").datepicker('getDate');
    var d2 = $('#datepicker-14').datepicker('getDate');
    if(d1 ==null || d2==null){
        document.getElementById("nolvdays").value="";
        document.getElementById("totaldays").value="";
        document.getElementById("balancedays").value="";
        document.getElementById("resumedate").value="";
        return false;
    }
    diff = Math.floor((d2.getTime() - d1.getTime()) / 86400000);                                  
    if(diff == 0){
        var currentleavesel = document.getElementById("leavetype").value;
        if(currentleavesel== 'CASUAL' || currentleavesel== 'SLV' || currentleavesel== 'SLVI' || currentleavesel == 'COMPASIONATE'){       
           return true;
        }else {    
            document.getElementById("nolvdays").value="1";
            var d2 = $('#datepicker-14').datepicker('getDate');
            var nextDayDate = new Date();
            nextDayDate.setDate(d2.getDate() + 1);
            $('#resumedate').val($.datepicker.formatDate('dd/mm/yy',nextDayDate));
            return false;
        }
    }
    else
        return false;
}

function changeRadios(chk){
    var r1 = document.getElementById("radiohf");
    var r2 = document.getElementById("radiohs");
    
    if(chk.checked == true){
        r1.disabled = false;
        r2.disabled = false;
        document.getElementById("nolvdays").value="0.5";
        document.getElementById("resumedate").value="";
    }
    else{
        r1.disabled = true;
        r2.disabled = true;
        r1.checked=false;
        r2.checked=false;
        document.getElementById("nolvdays").value="1";
        var d2 = $('#datepicker-14').datepicker('getDate');
        var nextDayDate = $('#datepicker-14').datepicker('getDate');
        nextDayDate.setDate(d2.getDate() + 1);       
        $('#resumedate').val($.datepicker.formatDate('dd/mm/yy',nextDayDate));
    }
}

function setHalfDay(rb){
    
    if(rb.value == 'first'){
       document.getElementById("resumedate").value=document.getElementById("datepicker-14").value; 
    }
    if(rb.value == 'second' ){
        var d2 = $('#datepicker-14').datepicker('getDate');
        var nextDayDate = $('#datepicker-14').datepicker('getDate');
        nextDayDate.setDate(d2.getDate() + 1);
        $('#resumedate').val($.datepicker.formatDate('dd/mm/yy',nextDayDate));
    }
}

function updateLeaveBalance(){
    var leaveselect = document.getElementById("leavetype");
    /*if(leaveselect.options[leaveselect.selectedIndex].value == 'LENC' || leaveselect.options[leaveselect.selectedIndex].value == 'LWP' ){
       document.getElementById("calbutton").disabled = true;
    }
    else{
        document.getElementById("calbutton").disabled = false;
    }*/
    var balance=leaveselect.options[leaveselect.selectedIndex].getAttribute("data-bal");
    var msgdiv = document.getElementById("initbalance");
    msgdiv.innerHTML = "Current "+leaveselect.options[leaveselect.selectedIndex].text+ " balance : "+balance+" <input type='hidden' name='currentLeaveBalance' id='currentLeaveBalance' value="+balance+" disabled class='disabled_input'/>";
    var totallv = document.getElementById("totalleave");
    totallv.value = balance;   
 
}

function setDateToCurrentDate(){
	  $('#datepicker-13').datepicker({ dateFormat: 'dd/mm/yyyy' });
	  $('#datepicker-13').datepicker('setDate', new Date());
}
function checkvalue(){
     var nolvd = document.getElementById("nolvdays").value;
    // console.log(nolvd);
     //var noofdays = parseInt(nolvd,10); 
     var noofdays = Number(nolvd); 
    // console.log(noofdays);
    if(isNaN(noofdays)){
        alert("Invalid number!");
        document.getElementById("nolvdays").focus();
        return false;
    }
    if(noofdays <= 0){
       alert("Invalid leave days value");
       document.getElementById("nolvdays").focus();
       return false;
    }
    return true;
}
