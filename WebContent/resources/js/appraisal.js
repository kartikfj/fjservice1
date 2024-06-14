function showGoals() {
   document.getElementById('goalFormDiv').style.display = "block";
}
function  getCompany(){
	
	var xz = document.getElementById("cmptype").value;
    document.getElementById("fjc_cmp").value = xz;
}

function appraisalType() {
    var x = document.getElementById("aprsltype").value;
    document.getElementById("fjtco").value = x;
}
function editDates(){alert("val");}
function yearValidation(year,ev) {
	
	  var text = /^[0-9]+$/;
	  if(ev.type=="blur" ||  ev.keyCode == 9 ) {
	    if (year != "") {
	        if ((year != "") && (!text.test(year))) {

	            alert("Please Enter Numeric Values Only");
	            return false;
	        }

	        if (year.length != 4) {
	            alert("Year is not proper. Please check");
	            return false;
	        }
	        var current_year=new Date().getFullYear();
	        if(year < current_year )
	            {
	            alert("Year should be in range  to current year");
	            return false;
	            }
	        return true;
	    }
	    else{
	    	 alert("Please Enter a Year");
	            return false;
	    }
	   return true;
	  }
	}

function compareDate()
{
	//alert("testing");
    var startDt = document.getElementById("fromdate").value;
    var endDt = document.getElementById("todate").value;

    if(Date.parse(endDt) <= Date.parse(startDt) )
    {
    	document.getElementById("date_validation_output").innerHTML="<span style='color:red;'>End Date must greater than Start Date..</span>";
    }
    else{document.getElementById("date_validation_output").innerHTML="";}
}

function validateForm1() {
    
        alert(document.forms["edit_appraisal_hr"]["gs_fromdate"].value);
        alert(document.forms["edit_appraisal_hr"]["mid_fromdate"].value);
       
    
}

