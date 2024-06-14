 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
.navbar {
    
    margin-bottom: 8px !important;
    }
</style>
<%@include file="mainview.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html><head>


<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>

  <style>
  
   table{
    display: block !important;
    
    overflow-x:auto !important;
    }
  #page-wrap th{
	background-color:#065685 !important;
	color:#fff;
	}
	#page-wrap th{
	padding:10px;
	}
	
.navbar-brand {
  padding: 0px;
}
.navbar-brand>img {
  height: 100%;
  width: auto;
}
<!-- Custom style form control-->

.container-fluid  .form-control
{
 width:100% !important;
}

 
  hr {
    border: none;
    height: 10px;
    width: 75%;
    height: 50px;
    margin-top: 0;
    border-bottom: 1px solid #cccccc;
    box-shadow: 0 20px 20px -20px #aaa;
    margin: -48px auto 10px;
    }
  
   h4 {
     color:#0066b3 !important;
     
  }
 
  
  
   .table{
    display: block !important;
    overflow-x:auto !important;
    }
    
    
  .panel-default>.panel-heading {
   
    background-color: #ffff !important;
    }
  
  .fjtco-table {
    background-color: #ffff;
    padding: 0.01em 16px;
    margin: 12px 0;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    }
  .row {
   margin-left: 0px;
   margin-right: 0px;
  }
  .panel-body {
    padding: 10px;
}
  .panel-heading {
    padding: 5px 10px !important;
    }
  .panel {
    margin-bottom: 5px;
    }
   .panel-default>.panel-heading{
    color: #333;
    background-color: #fff; 
    border-color: #065685;
   }
.navbar-brand {
  padding: 0px;
}
.navbar-brand>img {
  height: 100%;
  width: auto;
}

</style>
<style>
    .faqHeader {
        font-size: 27px;
        margin: 20px;
    }

    .panel-heading [data-toggle="collapse"]:after {
        font-family: 'FontAwesome';
        content:"\f13a"; this icon is "fa-chevron-circle-down";
        float: right;
        color: #0066b3;
        font-size: 18px;
        line-height: 22px;
        /* rotate "play" icon from > (right arrow) to down arrow */
        -webkit-transform: rotate(-90deg);
        -moz-transform: rotate(-90deg);
        -ms-transform: rotate(-90deg);
        -o-transform: rotate(-90deg);
        transform: rotate(-180deg);
        
    }

    .panel-heading [data-toggle="collapse"].collapsed:after {
        /* rotate "play" icon from > (right arrow) to ^ (up arrow) */
        -webkit-transform: rotate(360deg);
        -moz-transform: rotate(360deg);
        -ms-transform: rotate(360deg);
        -o-transform: rotate(360deg);
        transform: rotate(360deg);
        color: #454444;
    }
    .smaple th,.smaple td {border:1px solid #2196f3;padding:5px;text-align:center;}
    
    .nav-tabs { border-bottom: 1px solid #2196F3;}
    .nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
    color: #009688;
    text-transform: uppercase;
    font-weight: 600;
    cursor: default;
    background-color: #fff;
    border: 1px solid #2196f3;
    border-top: 3px solid #2196f3;
}

.nav-tabs>li>a {
    margin-right: 2px;
    line-height: 1.42857143;
    border: 1px solid transparent;
    border-radius: 4px 4px 0 0;
    color: #F44336;
}


</style>
    </head>
    <c:choose>
	<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
  	<body>
 		<div class="container">
 			 <div class="row">
    		<div class="panel panel-default small">
    		
    
                    <div class="panel-heading" style="padding:4px 8px !important;">
                    <h4 class="text-center">Sample Goals</h4>
                    </div>
                    
            </div>
 		
 		</div>
 		
 		<div class="row">
 		
 		
 		
 	<ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#finance">Finance</a></li>
    <li><a data-toggle="tab" href="#logistics">Logistics</a></li>
    <li><a data-toggle="tab" href="#hr">HR</a></li>
    <li><a data-toggle="tab" href="#secretary">Secretary</a></li>
    <li><a data-toggle="tab" href="#application">Application Engineering</a></li>
    <li><a data-toggle="tab" href="#commissioning">Commissioning & Service Eng.</a></li>
    <li><a data-toggle="tab" href="#productionmg">Production Manager</a></li>
    <li><a data-toggle="tab" href="#sales">Sales</a></li>
  </ul>

  <div class="tab-content">
    <div id="finance" class="tab-pane fade in active">
     <!--  <h3>Finance</h3> --> 
      <p>
      
      <table class="smaple">
      <tr><th rowspan="3"  style=" border-top: none; ">Sl No.</th><th colspan="2"  style=" border-top: none; ">INDIVIDUAL GOALS</th><th colspan="2"  style=" border-top: none; ">STRATEGIC GOALS</th></tr>
      <tr><th colspan="2">SHORT TERM GOALS</th><th colspan="2">LONG TERM GOALS</th></tr>
      <tr><th>GOALS</th><th>TARGET</th><th>GOALS</th><th>TARGET</th></tr>
      <tr><td>1</td><td>Suggest 3 original improvement to save cost</td><td>The imporvements should be suggested by 30 March 2019</td><td>Improve overall cost of finance.</td><td>10%</td></tr>
      <tr><td>2</td><td>Daily digital filing.</td><td>Reduce your paper usage. </td><td>Spread knowledge of different payment & finance method to team</td><td>Implement trainings for financial processes</td></tr>
      <tr><td>3</td><td>Build better relation with sales team</td><td>Weekly/monthly collection meetings to understand the issues</td><td>Go online  </td><td>Customers checking their account</td></tr>
      <tr><td>4</td><td>Submission of reports</td><td>All reports to be submitted as per schedule</td><td>Meet and establish strong rapport with customers</td><td>Meet 3 customers monthly. </td></tr>
      <tr><td>5</td><td>Implement safe financial processes in the company </td><td>Identify risky/bad processes within the company & correct them </td><td>Issue reports related to measurement of financial health and performance   </td><td>Issue quarterly measurement of performance related to capital usage, salary/sales/profit, ratios - debt/equity, profit/equity </td></tr>
      <tr><td>6</td><td> </td><td> </td><td>Report cash flow for each divison  </td><td>on monthly basis </td></tr>
      </table>
      
      </p>
    </div>
    <div id="logistics" class="tab-pane fade">
      <!-- <h3>Logistics</h3>--> 
      <p>
         <table class="smaple">
      <tr><th rowspan="3"  style=" border-top: none; ">Sl No.</th><th colspan="2"  style=" border-top: none; ">INDIVIDUAL GOALS</th><th colspan="2"  style=" border-top: none; ">STRATEGIC GOALS</th></tr>
      <tr><th colspan="2">SHORT TERM GOALS</th><th colspan="2">LONG TERM GOALS</th></tr>
      <tr><th>GOALS</th><th>TARGET</th><th>GOALS</th><th>TARGET</th></tr>
      <tr><td>1</td><td>Suggest 3 original improvement to save cost</td><td>The imporvements should be suggested by 30 March 2019</td><td>Make delivery status information easily assessible to the client </td><td>All information should be on the system readable by client directly. </td></tr>
      <tr><td>2</td><td>Daily digital filing.</td><td>Reduce your paper usage. </td><td>Make a yearly tender</td><td>To improve cost by 15% for all supplier</td></tr>
      <tr><td>3</td><td>Answer mails </td><td>within 12 hours</td><td>Improve stores / visibility</td><td>Remove/sell extra materials not required </td></tr>
      <tr><td>4</td><td>Get more sources of quotations</td><td>Minimum 3</td><td>Optimize space and warehouse storage costs. Negotiate for best market prices </td><td>Drop storage cost per sqm by 20% </td></tr>
      <tr><td>5</td><td>Control all car expenses</td><td>use GPS technology</td><td></td><td></td></tr>
      
      </table>
      </p>
    </div>
    <div id="hr" class="tab-pane fade">
      <!-- <h3>HR</h3>--> 
      <p>  <table class="smaple">
      <tr><th rowspan="3"  style=" border-top: none; ">Sl No.</th><th colspan="2"  style=" border-top: none; ">INDIVIDUAL GOALS</th><th colspan="2"  style=" border-top: none; ">STRATEGIC GOALS</th></tr>
      <tr><th colspan="2">SHORT TERM GOALS</th><th colspan="2">LONG TERM GOALS</th></tr>
      <tr><th>GOALS</th><th>TARGET</th><th>GOALS</th><th>TARGET</th></tr>
      <tr><td>1</td><td>Suggest 3 original improvement to save cost</td><td>The imporvements should be suggested by 30 March 2019</td><td>Set up a training manual</td><td>For every staff & maintain progress</td></tr>
      <tr><td>2</td><td>Daily digital filing.</td><td>Reduce your paper usage. </td><td>Determine staff capability</td><td>Run a test to evaluate staff capability and suggest course of action</td></tr>
      <tr><td>3</td><td>All HR requests to be handled</td><td>within 24 hours of request</td><td>Improve synergy between divisions</td><td>Propose a program to improve the synergy by mid-term</td></tr>
      <tr><td>4</td><td>Report HR expenses</td><td>Monthly expenses for Visas/rent renewal/fees</td><td>Control expense & report monthly</td><td>Set up a budget for operation to control expenses & report monthly</td></tr>
      <tr><td>5</td><td>Give access to training manual</td><td>Over the internet</td><td>Drive and support implementation of HR online objectives setting and appraisal system</td><td>All staff to complete process of objective setting by 15th December, mid year review, year end final review and rating </td></tr>
      <tr><td>6</td><td>Civil defense and other registrations renewals </td><td>on time </td><td></td><td></td></tr>
      </table></p>
    </div>
    <div id="secretary" class="tab-pane fade">
     <!--  <h3>Secretary</h3>--> 
      <p>  <table class="smaple">
      <tr><th rowspan="3"  style=" border-top: none; ">Sl No.</th><th colspan="2"  style=" border-top: none; ">INDIVIDUAL GOALS</th><th colspan="2"  style=" border-top: none; ">STRATEGIC GOALS</th></tr>
      <tr><th colspan="2">SHORT TERM GOALS</th><th colspan="2">LONG TERM GOALS</th></tr>
      <tr><th>GOALS</th><th>TARGET</th><th>GOALS</th><th>TARGET</th></tr>
      <tr><td>1</td><td>Suggest 3 original improvement to save cost</td><td>The imporvements should be suggested by 30 March 2019</td><td>Build data base for customer using business cards & quotations</td><td>750/year</td></tr>
      <tr><td>2</td><td>Daily digital filing.</td><td>Reduce your paper usage. </td><td>Get to know the product & be ready to make a small presentation</td><td>Attend trainings on product </td></tr>
      <tr><td>3</td><td>Submission of time sheet for labors</td><td>time sheet to be completed monthly</td><td></td><td></td></tr>
      <tr><td>4</td><td>Submission of important invoices/quotations/reports</td><td>Before the deadline</td><td></td><td></td></tr>
      <tr><td>5</td><td>Registration of Quotations</td><td>Ensure every quotation is registered in system with reference</td><td></td><td></td></tr>
      <tr><td>6</td><td>Quotations to be sent </td><td>within 24 hours</td><td></td><td></td></tr>
      </table></p>
    </div>
     <div id="application" class="tab-pane fade">
     <!--  <h3>Application Engineering</h3>--> 
      <p>   <table class="smaple">
      <tr><th rowspan="3"  style=" border-top: none; ">Sl No.</th><th colspan="2"  style=" border-top: none; ">INDIVIDUAL GOALS</th><th colspan="2"  style=" border-top: none; ">STRATEGIC GOALS</th></tr>
      <tr><th colspan="2">SHORT TERM GOALS</th><th colspan="2">LONG TERM GOALS</th></tr>
      <tr><th>GOALS</th><th>TARGET</th><th>GOALS</th><th>TARGET</th></tr>
      <tr><td>1</td><td>Suggest 3 original improvement to save cost</td><td>The imporvements should be suggested by 30 March 2019</td><td>Aim to gradute into a sales engineer</td><td>1 - 2 years from joining date. </td></tr>
      <tr><td>2</td><td>Daily digital filing.</td><td>Reduce your paper usage. </td><td>Go out to approve submittals</td><td>1 - 2 years from joining date. </td></tr>
      <tr><td>3</td><td>Acknowledging the order to the customer</td><td>Within 2 days</td><td>Reduce the number of paper filing. </td><td>Go digital; scan the papers and keep e-copies. </td></tr>
      <tr><td>4</td><td>Co-ordinating for the delivery schedule with the customer</td><td>Ensure delivery on the promised date. Incase of delay, inform the customer and comunicate on the new delivery date. </td><td>Support and help to create client data base</td><td>By June 2019</td></tr>
      <tr><td>5</td><td>Making budget sheet and estimation of profit2 days from PO</td><td>Suggest process improvement</td><td>Suggest process improvement</td><td>atleast 2 suggestions per year</td></tr>
      <tr><td>6</td><td>Prepare price & quotations</td><td>within 2 to 5 days (each division to set target based on product)</td><td></td><td></td></tr>
      <tr><td>7</td><td>Report work activities </td><td>On daily basis</td><td></td><td></td></tr>
      </table></p>
    </div>
     <div id="commissioning" class="tab-pane fade">
      <!-- <h3>Commissioning & Service Engineering.</h3>--> 
      <p>   <table class="smaple">
      <tr><th rowspan="3"  style=" border-top: none; ">Sl No.</th><th colspan="2"  style=" border-top: none; ">INDIVIDUAL GOALS</th><th colspan="2"  style=" border-top: none; ">STRATEGIC GOALS</th></tr>
      <tr><th colspan="2">SHORT TERM GOALS</th><th colspan="2">LONG TERM GOALS</th></tr>
      <tr><th>GOALS</th><th>TARGET</th><th>GOALS</th><th>TARGET</th></tr>
      <tr><td>1</td><td>Suggest 3 original improvement to save cost</td><td>The imporvements should be suggested by 30 March 2019</td><td>Reporting to the site</td><td>Go only to resolve a problem by intorducing check list before goin to site</td></tr>
      <tr><td>2</td><td>Daily digital filing.</td><td>Reduce your paper usage. </td><td>Measure work performance </td><td>hours/job value</td></tr>
      <tr><td>3</td><td>Report to the site after request</td><td>48 hours from request</td><td>Submit improvement ideas</td><td>3 ideas per year</td></tr>
      <tr><td>4</td><td>Keep/maintain tools</td><td>Carry tools of maintenance</td><td>Learn new techniques</td><td>2 new technique per year</td></tr>
      <tr><td>5</td><td>Handover to operation and quality their service visit reports inlcuding customer sign off and feedback on service </td><td>within 24 hours from completion of work </td><td>List problems</td><td>Issue a list of recurring problems for design team to eliminate</td></tr>
      <tr><td>6</td><td></td><td></td><td>Report major client recommendations</td><td>10 during the year</td></tr>
      <tr><td>7</td><td></td><td></td><td>Attend training at Principal</td><td>2 trainings per quarter</td></tr>
      </table></p>
    </div>
     <div id="productionmg" class="tab-pane fade">
      <!-- <h3>Production Manager</h3>--> 
      <p>    <table class="smaple">
      <tr><th rowspan="3"  style=" border-top: none; ">Sl No.</th><th colspan="2"  style=" border-top: none; ">INDIVIDUAL GOALS</th><th colspan="2"  style=" border-top: none; ">STRATEGIC GOALS</th></tr>
      <tr><th colspan="2">SHORT TERM GOALS</th><th colspan="2">LONG TERM GOALS</th></tr>
      <tr><th>GOALS</th><th>TARGET</th><th>GOALS</th><th>TARGET</th></tr>
      <tr><td>1</td><td>Suggest 3 original improvement to save cost</td><td>The imporvements should be suggested by 30 March 2019</td><td>Maintain an injury free workshop</td><td>No injuries to be reported in the year</td></tr>
      <tr><td>2</td><td>Daily digital filing.</td><td>Reduce your paper usage. </td><td>suggest improvements to save money</td><td>3 suggestions by February</td></tr>
      <tr><td>3</td><td>Maintain production area</td><td>Keep clean the paints and walls</td><td>Measure all workers performace </td><td>daily/weekly</td></tr>
      <tr><td>4</td><td>Safety of all labors</td><td>All labors need to wear safety gear/dress at all times</td><td>Measure every order from file open to ready for delivery</td><td>time needed against value</td></tr>
      <tr><td>5</td><td>Maintain all required safety procedures</td><td>conduct safety checks every day and maintain report</td><td>QA inspection</td><td>Above 90%</td></tr>
      <tr><td>6</td><td>Organize stores</td><td>Provide stores report every month</td><td>Keep list of all tools</td><td>Maintain list per technician</td></tr>
      <tr><td>7</td><td>Improve sales team efficiency</td><td>Report after sales team recurrent visit to resolve a problem with hours needed. </td><td>Log machine maintenance</td><td>For all machinces in the factory</td></tr>
      <tr><td>8</td><td>Keep record/filing</td><td>maintain proper filing</td><td></td><td></td></tr>
      </table></p>
    </div>
     <div id="sales" class="tab-pane fade">
      <!-- <h3>Sales</h3>--> 
      <p>    <table class="smaple">
      <tr><th rowspan="3"  style=" border-top: none; ">Sl No.</th><th colspan="2"  style=" border-top: none; ">INDIVIDUAL GOALS</th><th colspan="2"  style=" border-top: none; ">STRATEGIC GOALS</th></tr>
      <tr><th colspan="2">SHORT TERM GOALS</th><th colspan="2">LONG TERM GOALS</th></tr>
      <tr><th>GOALS</th><th>TARGET</th><th>GOALS</th><th>TARGET</th></tr>
      <tr><td>1</td><td>Suggest 3 original improvement to save cost</td><td>The imporvements should be suggested by 30 March 2019</td><td>Sales of a specific product</td><td>Target in volume (Target to be set by Divison)</td></tr>
      <tr><td>2</td><td>Daily digital filing.</td><td>Reduce your paper usage. </td><td>Perfect your product presentation</td><td>2019 march</td></tr>
      <tr><td>3</td><td>Work exclusively through SIP program</td><td>Execute all process on SIP</td><td>Specify product with cosnsultant </td><td>3  new per month</td></tr>
      <tr><td>4</td><td>Dress to impress customers</td><td>Wear smart formals on client meetings</td><td>Learn design of your product within installation criteria</td><td>Within July 2019</td></tr>
      <tr><td>5</td><td>Visit existing clients.Start business with new clients</td><td>3 to 5  clients daily  1 new client monthly </td><td>Be known for best technicality in the team</td><td>Undergo technical training</td></tr>
      <tr><td>6</td><td>Follow up collections </td><td>LC sign off within 1 week from delivery PDC Collection on time </td><td>Be ready for technical meetings/presentations</td><td>Have a file for technicality (info/research)</td></tr>
      <tr><td>7</td><td>Submit quotations</td><td>Within 3 days</td><td></td><td></td></tr>
      </table></p>
    </div>
  </div>
 		
 		
 		
 	
 
 		
 		
 		</div>
 		
 		</div>
	</body>
	

	</c:when>
	<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
	</c:otherwise>
	</c:choose>