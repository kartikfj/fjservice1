/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function verifyUid(){
    var uid = document.getElementById('empCode').value;       
        if(uid!=null)
        uid = uid.trim();   
        if(uid.length == 0)
        {
            alert("Please enter login details");
            document.getElementById('empCode').focus();
            return false;
        }
         return true;  
}
function verifyEnter(event){
    if (event.which === 13) {
        event.stopPropagation();
        event.preventDefault();
        var uid = document.getElementById('empCode').value;       
        if(uid!=null)
        uid = uid.trim();   
        if(uid.length == 0)
        {
            alert("Please enter employee code");
            return false;
        }
           document.getElementById('datetoregularise').focus();
        }
}



function setFields(){
    document.getElementById('empCode').focus();
    return true;
}

 

function pad(num, size) {
    var s = num+"";
    while (s.length < size) s = "0" + s;    
    return "E"+s;
}

function checkUid(uidbox){
	document.getElementById("validEmpDetails").innerHTML="";
   var uid = uidbox.value;
   if(uid!=null)
        uid = uid.trim();
    if(uid.length == 0)
    {
       // alert("Please enter user id!");
        return false;
    }
 
    var reg = /^[eE]\d{6}$/;            //new RegExp('^[eE]\d{6}$');
    var reg2 = /^\d{1,6}$/;             //new RegExp('/^\d{1,6}$/');
    if(reg.test(uid)){
        //valid format - send it to server to check if it is a new user
       //alert("valid format");//subtype
       showEmployeeDetails(uid);
       document.getElementById('datetoregularise').focus(); 
       
       return true;
    }
    else if(reg2.test(uid)){
        var newuid = pad(uid,6);
        uidbox.value = newuid;
        showEmployeeDetails(newuid);
        document.getElementById('datetoregularise').focus(); 
         
        return true;
    }
    else{
        alert("invalid format for Employee Code ");
        uidbox.value="";
        setFields();
        return false;
    }  
}
function showEmployeeDetails(uid){ 
	preLoader();
	 $.ajax({  
		 type: 'POST', url: 'HrRegularisationCorrectionController',
		 data: {action: "validateEmployee", id:uid}, 
		 dataType: "json", 
		 success: function(data) { 
			 $('#laoding').hide();
			 document.getElementById("validEmpDetails").innerHTML=`${data}`;
	 },error:function(data,status,er) {
		 $('#laoding').hide(); 
		 alert("please logout and login again");
		 }});
	
}

function setSubType(){
   document.getElementById('subtype').value="pwd";
        return true;  
}

function preLoader(){ $('#laoding').show();}	
function checkValidOrNot(value){
	 if(typeof value === 'undefined' || value == '' || value === null){
		 return false;
	 }else{
		 return true;
	 }
}