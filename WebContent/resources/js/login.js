/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function verifyUid(){
    var uid = document.getElementById('fjuid').value;       
        if(uid!=null)
        uid = uid.trim();   
        if(uid.length == 0)
        {
            alert("Please enter login details");
            document.getElementById('fjuid').focus();
            return false;
        }
         return true;  
}
function verifyEnter(event){
    if (event.which === 13) {
        event.stopPropagation();
        event.preventDefault();
        var uid = document.getElementById('fjuid').value;       
        if(uid!=null)
        uid = uid.trim();   
        if(uid.length == 0)
        {
            alert("Please enter login details");
            return false;
        }
           document.getElementById('fjpwd').focus();
        }
}

function verifyEnterInPwd(event){
    if (event.which === 13) {
        event.stopPropagation();
        //event.preventDefault();//commented for rk singl login rqrmnt
        var uid = document.getElementById('fjpwd').value;       
        if(uid!=null)
        uid = uid.trim();   
        if(uid.length == 0)
        {
            alert("Please enter login details");
            return false;
        }
          document.getElementById('login_but').focus();
        }
}

function checklogin(){
    var uid = document.getElementById('fjuid').value;
    if(uid!=null)
        uid = uid.trim();
    var thetype = document.getElementById('subtype').value;
    var pwd = document.getElementById('fjpwd').value;
    if(thetype == 'uidchk' && uid.length == 0 ){
        alert("Please enter login details!");
        return false;
    }
    else if(thetype == 'pwd'){
      
        if(pwd !=null)
            pwd.trim();
        if(uid.length == 0 || pwd.length ==0)
        {
            alert("Please enter login details");
            return false;
        }
    }
    else{
        if(uid.length == 0 || pwd.length ==0)
        {
            alert("Please enter login details");
            return false;
        }
    }
    
    /*if(uid.charAt(0) == 'e'){
    var newuid = 'E'+uid.substr(1);
    document.getElementById('fjuid').value = newuid;

    }*/
    return true;
}

function setFields(){
    document.getElementById('fjuid').focus();
    return true;
}

function focusPwd(){
    document.getElementById('fjpwd').focus();
    return true;
}

function pad(num, size) {
    var s = num+"";
    while (s.length < size) s = "0" + s;    
    return "E"+s;
}

function checkUid(uidbox){
   //var uid = document.getElementById('fjuid').value;  
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
       // alert("valid format");//subtype
       document.getElementById('subtype').value="uidchk";
      // console.log(uidbox.form);
      window.sessionStorage.setItem("lastlogin",uid);
       uidbox.form.submit();
       return true;
    }
    else if(reg2.test(uid)){
        var newuid = pad(uid,6);
        uidbox.value = newuid;
       document.getElementById('subtype').value="uidchk";
      // console.log(uidbox.form);
      window.sessionStorage.setItem("lastlogin",uid);
       uidbox.form.submit();
       
       // alert(newuid);
        return true;
    }
    else{
        alert("invalid format for ID ");
         uidbox.value="";
        return false;
    }  
}


function setSubType(){
   document.getElementById('subtype').value="pwd";
        return true;  
}