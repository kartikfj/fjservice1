<%-- 
    Document   : HR MANUAL 
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
.navbar {
    
    margin-bottom: 8px !important;
    }
  table.google-visualization-orgchart-table{
        border-collapse: separate !important;
    }
    .google-visualization-orgchart-node-medium{font-size: 0.74em !important;}
</style>
<%@include file="mainview.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html><head>


<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('43', {packages:["orgchart"]});
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawChart2);
      google.charts.setOnLoadCallback(drawChart3);

      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('string', 'Manager');
        data.addColumn('string', 'ToolTip');

        // For each orgchart box, provide the name, manager, and tooltip to show.
        data.addRows([
          [{v:'fjt', f:'<div style="color:blue; font-style:italic">FAISAL JASSIM TRADING LLC</div>'},'', 'Company Name'],   
 [{v:'sub1', f:'PRESIDENT'}, 'fjt', ''], 
    [{v:'cd', f:'CORPORATE DIVISION'},
           'fjt', ''],
 [{v:'sub2', f:'COO'}, 'fjt', ''],
 
 [{v:'sub1.1', f:'RAPHAEL KHLAT'},'sub1', ''],
  [{v:'sub2.1', f:'KRIKOR OHANION'},'sub2', ''],
    [{v:'cd1', f:'FINANCE'},'cd', ''],    [{v:'cd3', f:'MARKETING'},'cd', ''],  [{v:'cd4', f:'QUALITY'},'cd', ''], 
[{v:'cd5', f:'IT'},'cd', ''], 
[{v:'cd6', f:'LOGISTICS'},'cd', ''],
[{v:'cd7', f:'HR'},'cd', ''],
[{v:'cd1.1', f:'JEEMON JOSE'},'cd1', ''], 
[{v:'cd2.1', f:'PRASHANTH BS IYENGAR'},'cd3', ''],
[{v:'cd3.1', f:'KASHIF HASSAN'},'cd4', ''],
[{v:'cd4.1', f:'ARUN KUMAR MOHTA'},'cd5', ''],
[{v:'cd5.1', f:'JAYAND RAJAN'},'cd6', ''],
[{v:'cd7.1', f:'LARA ALWAN'},'cd7', '']
         
        ]);
        // Create the chart.
        var chart = new google.visualization.OrgChart(document.getElementById('org_div'));
        // Draw the chart, setting the allowHtml option to true for the tooltips.
        chart.draw(data, {allowHtml:true});
      }
      
     

      function drawChart2() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('string', 'Manager');
        data.addColumn('string', 'ToolTip');

        // For each orgchart box, provide the name, manager, and tooltip to show.
        data.addRows([
          [{v:'fjt', f:'<div style="color:blue; font-style:italic">FAISAL JASSIM TRADING LLC</div>'},'', 'Company Name'],   
 [{v:'sbu', f:'SBU'}, 'fjt', ''],

    [{v:'sbu1', f:'FJ CARE'},'sbu', ''], 
[{v:'sbu2', f:'LIGHTING'},'sbu', ''], 
[{v:'sbu3', f:'FJES'},'sbu', ''],
[{v:'sbu4', f:'EUROCLIMA'},'sbu', ''],
[{v:'sbu5', f:'FLOWTECH & FANS'},'sbu', ''], 
[{v:'sbu6', f:'E.C.S'},'sbu', ''],
[{v:'sbu7', f:'PUMPS'},'sbu', ''],
[{v:'sbu8', f:'A.C'},'sbu', ''],
[{v:'sbu10', f:'DCSERVE'},'sbu', ''],
[{v:'sbu11', f:'ALPHADUCT'},'sbu', '']
          ,

          [{v:'sbu1.1', f:'FIRAS AL RIFAI'},'sbu1', ''], 
      [{v:'sbu2.1', f:'NEGEB DEBS'},'sbu2', ''], 
      [{v:'sbu3.1', f:'KHALID MISMAR'},'sbu3', ''],
      [{v:'sbu4.1', f:'BHARTESH GANGADHAR TAMSE'},'sbu4', ''],
      [{v:'sbu5.1', f:'IYAD DIB'},'sbu5', ''], 
      [{v:'sbu6.1', f:'K.M JOHN'},'sbu6', ''],
      [{v:'sbu7.1', f:'BINOJ AMACADU'},'sbu7', ''],
      [{v:'sbu8.1', f:'LAMAAT AL KHATIB'},'sbu8', ''],
      [{v:'sbu10.1', f:'RENNIE SEQUEIRA'},'sbu10', ''],
      [{v:'sbu11.1', f:'RAMI KHAYRALLAH'},'sbu11', ''],
         
        ]);
        // Create the chart.
        var chart = new google.visualization.OrgChart(document.getElementById('deprt_org_div'));
        // Draw the chart, setting the allowHtml option to true for the tooltips.
        chart.draw(data, {allowHtml:true});
      }
      
      function drawChart3() {
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Name');
          data.addColumn('string', 'Manager');
          data.addColumn('string', 'ToolTip');

          // For each orgchart box, provide the name, manager, and tooltip to show.
          data.addRows([
            [{v:'fjt', f:'<div style="color:blue; font-style:italic">FAISAL JASSIM TRADING LLC</div>'},'', 'Company Name'],   
   [{v:'sbu', f:'FAISAL JASSIM REGIONAL OFFICES'}, 'fjt', ''],

      [{v:'sbu1', f:'QATAR'},'sbu', ''], 
  [{v:'sbu2', f:'IRAQ'},'sbu', ''], 
  [{v:'sbu3', f:'OMAN'},'sbu', ''],
  [{v:'sbu4', f:'KSA'},'sbu', ''],
  
            [{v:'sbu1.1', f:'FAZHUL KAREEM'},'sbu1', ''], 
        [{v:'sbu2.1', f:'SADDAD FAKRI'},'sbu2', ''], 
        [{v:'sbu3.1', f:'RUQAIYA ABDUL HUSAIN'},'sbu3', ''],
        [{v:'sbu4.1', f:'NEGIB DEBS'},'sbu4', '']
      
           
          ]);
          // Create the chart.
          var chart = new google.visualization.OrgChart(document.getElementById('office_org_div'));
          // Draw the chart, setting the allowHtml option to true for the tooltips.
          chart.draw(data, {allowHtml:true});
        }
   </script>

  <style>
  
  .nav1 > .mn {
  list-style:none;
  padding:0px;
  }
  .col-sm-3 >  h4, .nav1 >  h4 {
      font-size: 15px;
      font-weight: bold;
  }
  
  .mn li a {
    text-decoration: none;
    display: block;
    color: #0066b3;
    }
  .mn li a:hover, .mn li a:focus {
    color: #000000;
    background-color: #cccccc;
  }
  
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
<script type="text/javascript">
$(document).ready(function () {
    $('.nav1 ul li:first').addClass('active');
    $('.tab-content:not(:first)').hide();
    $('.nav1 ul li a').click(function (event) {
        event.preventDefault();
        var content = $(this).attr('href');
        $(this).parent().addClass('active');
        $(this).parent().siblings().removeClass('active');
        $(content).show();
        $(content).siblings('.tab-content').hide();
    });
});

$(document).ready(function (){
    $("a").click(function (){
        $('html, body').animate({
            scrollTop: $("body").offset().top
        }, 100);
    });
});
</script>
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
</style>
    </head>
    <c:choose>
	<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
  	<body>
 		<div class="container">
 			 <div class="row">
    		<div class="panel panel-default small">
    		
    
                    <div class="panel-heading" style="padding:4px 8px !important;">
                    <h4 class="text-center">HR Manual
                    <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a></h4>
                    </div>
                    
            </div>
 		
 		</div>
 		
 		<div class="row">
 		<div class="col-sm-3" style="z-index: 0;
   padding-top: 10px;
    padding-bottom: 10px;
    background-color: #f1f1f1;
    border-style: none;
    border-color: #666666;">
 		
 			
     <h4>INTRODUCTION</h4>

<div class="nav1">
    <ul class="mn">
        <li><a target="_top" href="#section-profile">COMPANY PROFILE</a></li>
        <li><a target="_top" href="#section-services">PRODUCTS AND SERVICES</a></li>
        <li><a target="_top" href="#section-vision">VISION, MISSION AND VALUE</a></li>
        <li><a target="_top" href="#section-chart">ORGANIZATION CHART</a></li>     
    </ul>
    <h4>WORKFORCE PLANNING AND RECRUITMENT</h4>

    
    <ul class="mn">
        <li><a target="_top" href="#section-wpro">OVERVIEW</a></li>
        <li><a target="_top" href="#section-sourcing">SOURCING</a></li>
        <li><a target="_top" href="#section-selection">SELECTION</a></li>
        <li><a target="_top" href="#section-reference">REFERENCE CHECKS</a></li>
        <li><a target="_top" href="#section-orientation">ORIENTATION & ON BOARDING</a></li>
        <li><a target="_top" href="#section-probation">PROBATIONARY PERIOD	</a></li>
        <li><a target="_top" href="#section-employeeReferral">EMPLOYEE REFERRAL</a></li>
        <li><a target="_top" href="#section-temporaryEmployment">TEMPORARY EMPLOYMENT</a></li>
        <li><a target="_top" href="#section-transfers">TRANSFERS</a></li>
         </ul>
         <h4> PERFORMANCE MANAGEMENT</h4>
    <ul class="mn">
        <li><a target="_top" href="#section-goalSetting">GOAL SETTING</a></li>
        <li><a target="_top" href="#section-careerDevelopment">CAREER DEVELOPMENT AND SUCCESSION PLANNING</a></li>
        <li><a target="_top" href="#section-trainingEducation">TRAINING AND EDUCATION</a></li>

         </ul>
         <h4> PRIVACY POLICY</h4>
          <ul class="mn">
        <li><a target="_top" href="#section-protectingprivacyPolicy">PROTECTING CONFIDENTIAL INFORMATION POLICY</a></li>
        <li><a target="_top" href="#section-dataprivacyPolicy">DATA PROTECTION & PRIVACY</a></li>
       

         </ul>
         <p></p>
           <h4>WORK SCHEDULE AND LEAVE POLICY</h4>
           
    <ul class="mn">
        <li><a target="_top" href="#section-workOverview">OVERVIEW</a></li>
        <li><a target="_top" href="#section-workSchedule">WORK SCHEDULE</a></li>
        <li><a target="_top" href="#section-workLeave">LEAVE POLICY</a></li>

         </ul>
                <h4>CODE OF CONDUCT AND ETHICS POLICY</h4>
    <ul class="mn">
        <li><a target="_top" href="#section-codeOverview">OVERVIEW</a></li>
        <li><a target="_top" href="#section-cc">CODE OF CONDUCT</a></li>
        <li><a target="_top" href="#section-dressCode">DRESS CODE POLICIES</a></li>
  		 <li><a target="_top" href="#section-codeCategory">CATEGORY OF VIOLATIONS OF FJTCO ETHICS POLICIES</a></li>

         </ul>
         
           <h4>DISCIPLINARY ACTION</h4>
    <ul class="mn">
        <li><a target="_top" href="#section-disciplinaryOverview">OVERVIEW</a></li>
        <li><a target="_top" href="#section-disciplinaryAction">DISCIPLINARY ACTION</a></li>
        <li><a target="_top" href="#section-disciplinaryPenalties">PENALTIES AND CONTRAVENTION	</a></li>
  		 </ul>
        <h4>SEPARATION POLICY</h4>
    <ul class="mn">
         <li><a target="_top" href="#section-separationOverview">OVERVIEW</a></li>
        <li><a target="_top" href="#section-separationProcedure">SEPARATION PROCEDURE</a></li>
		   </ul>
		</ul>
        <h4>GRIEVANCE POLICY</h4>
    <ul class="mn">
		 <li><a target="_top" href="#section-GrivanceIntroduction">INTRODUCTION</a></li>
		 <li><a target="_top" href="#section-GrivanceProcedure">GRIEVANCE PROCEDURE</a></li>
  		 </ul>
		<br/>   
</div>

</div><div id="start" class="col-sm-9"  style="font: 400 16px/24px Roboto,sans-serif !important;">
<div id="section-profile" class="tab-content">
    <h4>Company Profile</h4>
    <p>M/s FAISAL JASSIM TRADING CO. L.L.C. was established in 1988, as a partnership between a number of qualified engineers, specialized in the Electrical & Mechanical fields related to the building services industry.  In just over a decade, Faisal Jassim has forged for itself a venerable reputation of expertise and excellence in its fields.  It is a veritable achievement considering the fiercely competitive market that diversifies almost as swiftly as it develops.  Our strength lies in the commitment and dedication of Faisal Jassim’s staff and the vision to foresee and adapt to changing industry trends & demands.  This attitude is appreciated by our patrons and partners alike, and is reflected in a glowing track record and countless satisfied customers. Our activities are spread between the following divisions:</p>
    <ol>
    <li>Air Handling Unit</li>
    <li>Air Conditions</li>
	<li>Boilers, Calorifiers & Solar Systems</li>
	<li>Cooling Towers</li>
	<li>Electrical Control Panels and Switch Gears</li>
	<li>Grills & Diffusers</li>
	<li>Heat Exchangers</li>
	<li>Insulation</li>
	<li>Plumbing</li>
	<li>Pump</li>
	<li>Pre-Insulated Panels</li>
	<li>Pre-Insulated Fabricated Ducts</li>
	<li>Valves</li>
 </ol>
 <p>Each of the above division is associated with a number of leading manufacturers and these are world-renowned for their reliability and backed by audited quality procedures.</p>
<p>Our sales engineers have received adequate training on the different products we represent. We strive to evaluate the client’s specification and provide adequate response to meet their requirement. </p>
<p>Faisal Jassim understands the importance of having excellent service back up and workshop facility.  We have ensured that our technicians are experienced and well-equipped with tools and machinery to execute quality work.  We keep adequate spares, enabling us to attend to after-sales service to guarantee the quality of our supplied equipment. </p>
<p>Faisal Jassim employs over a 1000 staff on their permanent employment.  </p>
<p>Our head office, warehouse and production facilities are in located in Dubai Investment Park and Jebel Ali and our showroom and sales office is located in Al Qusais Dubai. We have sales offices at Abu Dhabi, Saudi Arabia, Iraq, Oman and Qatar. FJTCO is constantly working on improving its services and enlarging its line of products to ensure a comprehensive coverage of the building service industry. We have geared up our local manufacturing and expanded our production to cater for the increased demand in UAE and the neighboring GCC countries. </p>
<p>Attached is the list of products that we are currently distributing.  For further information please visit our web site <a href="http://www.faisaljassim.ae/" target="_blank"> www.faisaljassim.ae</a></p>

 
</div>
<div id="section-services" class="tab-content">
    <h4>Vision, Mission & Values</h4>
    <table border="1" class="table table-striped small">
										<thead>
										<tr><th colspan="5" style="text-align:center;">
	 LINE OF PRODUCTS</th></tr></thead><tr><td>
	SBU</td><td>	AGENCIES</td><td>ORIGIN</td><td>DESCRIPTION</td><td>DIVISION MANAGER</td></tr>
	<tr><th colspan="5" style="text-align:center;">PUMPING EQUIPMENT & PACKAGES</th></tr><tr><td rowspan="6">
	PUMPS</td><td>PUMPS & HYDRONIC EQUIPMENT</td><td>USA</td><td>PUMPS & HYDRONIC EQUIPMENT</td><td rowspan="6">NADIR ILMAS</td></tr>
    
    <tr><td>XYLEM A/C FIRE PUMP</td><td>USA</td><td>FIRE FIGHTING PUMPS</td></tr>
     <tr><td>XYLE VOGEL</td><td>AUSTRIA</td><td>HIGH PRESSURE PUMPS</td></tr>
      <tr><td>WESTERN ELECTRIC</td><td>AUSTRALIA</td><td>MOTORS</td></tr>
       <tr><td>AQUAFLOW</td><td>EUROPE/UAE</td><td>BOOSTER & TRANSFER PACKAGES</td></tr>
        <tr><td>FAGGLOLATI PUMPS</td><td>ITALY</td><td>SUBMERSIBLE & SEWAGE PUMPS</td></tr>
  
	 <tr><th colspan="5" style="text-align:center;">AIR HANDLING, FAN COIL UNITS & FANS</th></tr>   
    
<tr><td>  EUROCLIMA</td><td>	EUROCLIMA	</td><td>ITALY	</td><td>DOUBLE SKIN AHU'S & FCU'S</td><td>	GIORGIO BASSO</td></tr>  
    
<tr><td>FANS</td><td>GREENHECK</td><td>USA	</td><td>DOMESTIC, COMMERCIAL & SMOKE EMERGENCY FANS (ABU DHABI MARKET ONLY)	</td><td>MOHD. ABULWAFA</td></tr>      
<tr><th colspan="5" text-align="center">AIR CONDITIONERS</th></tr>   
    
<tr><td> AC</td><td>SAMSUNG</td><td>S.KOREA</td><td>A/C SPLIT UNITS & PACKAGE, FCU, CHILLERS</td><td>TAHER HAMDIE</td></tr>  				
 <tr><th colspan="5" style="text-align:center;">HVAC DUCT WORK, TERMINALS & ACCESSORIES</th></tr>   
    
<tr><td rowspan="2"> FLOWTECH</td><td>ARMACELL
</td><td>ITALY</td><td>RUBBER INSULATION</td><td rowspan="2">KRIKOR OHANIAN</td></tr>  
    
<tr><td>FLOW-TECH</td><td>USA</td><td>GRILLES, DIFFUSERS, DAMPERS & LOUVRES</td></tr> 

<tr><th colspan="5" style="text-align:center;">VALVES & DISTRICT COOLING EQUIPMENTS</th></tr>   
    
<tr><td>VALVES</td><td>TOUR & ANDERSSON	</td><td>SWEDEN	</td><td>BUTTERFLY, DIFFUSERS VALVES & TOTAL  LINE OF VALVES</td><td rowspan="4">RENNIE SEQUEIRA</td></tr>  
    
<tr><td rowspan="3">DC SERVE</td><td>SONDEX</td><td>DENMARK</td><td>PLATE HEAT EXCHANGERS</td></tr>
<tr><td>GEA POLACEL</td><td>NETHERLANDS</td><td>COOLING TOWERS</td></tr> 
<tr><td>LAKOS</td><td>USA</td><td>SAND SEPERATOR</td></tr>  

 
 
 <tr><th colspan="5" style="text-align:center;">ELECTRICAL CONTROL PANEL & SWITCHGEARS</th></tr>   
<tr><td rowspan="4">ECS</td><td>ABB</td><td>EUROPE</td><td>SWITCHGEARS, CONTROL & AUTOMATION PANELS</td><td rowspan="3">K.M. JOHN</td></tr>
<tr><td>PROMASTER</td><td>UAE ASSEMBLES</td><td>COOLING TOWERS</td></tr> 
<tr><td>BUSBAR</td><td>IRELAND/UAE</td><td>BUSBAR SYSTEMS</td></tr>  
 

<tr><th colspan="5" style="text-align:center;">BOILER, SOLAR SYSTEM, PLUMBING EQUIPMENT & VALVES</th></tr>   
<tr><td rowspan="7">BOILER</td><td>CLEAVER BROOKS</td><td>USA</td><td>STEAM & HOT WATER BOILERS (GAS 7 OIL FIRED)</td><td rowspan="7">KHALED MISMAR</td></tr>
<tr><td>LACAZE	</td><td>FRANCE</td><td>GLASS & STAINLESS STEEL 316 L CALORIFIERS</td></tr> 
<tr><td>RADIANT</td><td>EUROPE</td><td>GLASS & STAINLESS STEEL CALORIFIERS & SOLAR SYSTEMS</tr>  
<tr><td>GIORDANO</td><td>FRANCE</td><td>SOLAR SYSTEM</td></tr> 
<tr><td>ITT HOFFMAN MCDONNEL & MILLER</td><td>USA</td><td>STEAM & BOILER ACCESSORIES</td></tr> 
<tr><td>JRG SANIPEX BRONZE</td><td>SWITZERLAND</td><td>DOMESTIC WATER PIPING SYSTEM (BRONZE)</td></tr> 
<tr><td>HONEYWELL</td><td>GERMANY</td><td>PRESSURE REDUCING VALVES</td></tr>  	 	
			


<tr><th colspan="5" style="text-align:center;">LIGHTING</th></tr>   
<tr><td rowspan="5">DISANO</td><td>CLEAVER BROOKS</td><td  rowspan="5">ITALY/BELGIUM/FRANCE/EUROPE</td><td  rowspan="5">INDOOR & OUTDOOR LIGHINTG FIXTURES</td><td rowspan="5">NEGIB DEBS</td></tr>
<tr><td>FOSNOVA</td></tr> 
<tr><td>TAL</td></tr>  
<tr><td>SWITCHMADE</td></tr> 
<tr><td>ALTIED/PHILIPS</td></tr> 
				
		
 	


</table>
</div>
<div id="section-vision" class="tab-content">
    <h4>Vision</h4>
	<p>To be the market leader in every product we supply to the Building Service Industry.</p>

	<h4>Mission</h4>
	<p>Providing to our Clients Competitive and Premium Quality Equipment and Services. <br/>
	Maintaining close Relationships with Clients / Consultants and Strong Market Coverage. <br/>
	Trained, Knowledgeable and Committed Staff with Strong Synergy. <br/>
	Seeking Growth Through New Ideas, Products and Market Expansion.<br/>
	Continuous Improvement of Business Processes. <br/>
	Prompt and Efficient After Sales Service. <br/>
	Developing a Manufacture Base. </p>

<p>FJTCO is committed to forge a corporate culture comprising of:  </p><ul>
<li>Honoring our Commitment to Customers with helpful and cooperative attitude.</li>
<li>Integrity in dealing with Suppliers and Society. </li>
<li>A persistent pledge to Health & Safety. </li>
<li>An enduring promotion of Ownership, Continual Improvement and Accountability. </li>
<li>Commitment to quality & pride in the products we offer. </li>



</ul>

</div>
<div id="section-chart" class="tab-content">
    <h4>Organization Chart</h4>
          <div id="org_div"></div><br/>
          <div id="deprt_org_div"></div><br/>
       <div><center><div id="office_org_div"></div></center></div> 
   <!--  <p><center><img src="resources/appraisal/chart1.png" alt="Appraisal Tab" width="auto"></center></p> 
    <p><center><img src="resources/appraisal/chart2.png" alt="Appraisal Tab" width="auto"></center></p>
    <p><center><img src="resources/appraisal/chart3.png" alt="Appraisal Tab" width="auto"></center></p>-->
</div>
<div id="section-wpro" class="tab-content">
    <h4>Workforce Planning and Recruitment</h4>
    <p>
    Workforce planning is a yearly exercise in FJTCO and is finalized by the respective divisions by the beginning of the year. It is done in accordance to the manpower budgets or the annual budgets decided by the division managers. 
    </p>
    <p>
    Once the plan is in place, the recruitments are carried out accordingly. 
Recruitments also take place to fill the vacancies of employees who separate from FJTCO. However, it has to be checked when the replacement has to be filled. This decision rests with the concerned Division manager and the COO.
    </p>
    <p><center><img src="resources/appraisal/wpro.png" alt="Appraisal Tab" width="auto"></center></p>
    
</div>

<div id="section-sourcing" class="tab-content">
    <h4>Sourcing</h4>
    <p>FJTCO will recruit employees either directly or through recruitment agents. <br/>
This will include the following sources:
    </p>
  <ul></ul><li>Direct recruitment</li>
Advertisement in appropriate media<br/>
CV’s received by applicants on the company’s website. <br/>

<li>Recruitment Agents</li>
Local agents<br/>
Overseas agents
</ul>

	<br/>Recruitment agents, both local and overseas, are appointed, as required, based on FJTCO’s recruiting needs and after proper evaluation of their terms and conditions and based on past experience.  Suitable guidelines setting out the desired framework and process of recruitment will be provided to recruitment agents.
    
    
</div>


<div id="section-selection" class="tab-content">
    <h4>Selection</h4>
   	<p>The selection process seeks to identify the best candidate based on merit. Human Resources ensures that there is no discrimination. Nevertheless, Human Resources have discretion in the relative weighting of selection criteria (criteria are based on the responsibilities, duties, skills, and competencies specified in the job description), the judgment of the merits of candidates against those criteria, and in the assessment of potential or ability to perform other duties. </p>

<p>Candidates being considered for positions at FJTCO must fulfill the following basic conditions:</p>
<ul>
<li>	Satisfy position requirements as described in the Recruitment request Form and/or job description.</li>
<li>	Possess all original documents showing past experience and qualifications, which is duly authenticated by concerned authorities.</li>
<li>	Pass health and medical requirements as determined by the management and be in good physical condition.</li>
<li>	Possess a clean record of behavior and have satisfactory references.</li>
<li>	Comply with all necessary FJTCO rules and visa requirements.</li>
<li>	Former employees may be considered for reinstatement if they fulfill the position requirements and left FJTCO on an amicable terms.</li>
</ul>

</div>


<div id="section-reference" class="tab-content">
    <h4>Reference Checks</h4>
    <p>	All recruitment is subject to reference checks from previous employers. 
	The selection of the employers will be as per HR Department request. 
  </p>
</div>

<div id="section-orientation" class="tab-content">
    <h4>Orientation & On Boarding</h4>
     <ol>
<li> All employees joining FJTCO from abroad, are intimated well in advance about their travel details and provided with air tickets to travel. Their visa is also forwarded to them along with the tickets. 
	
<li>On-boarding information includes, travel arrangements details, visa, transportation to and from airport, relocation basic information, country/culture awareness information, and any other useful tips the new employee needs to know. 

</li><li>Employee orientation is an ongoing learning process, ideally starting on the employee’s first day, to help understand the job and performance expectations, division and department goals and priorities, corporate goals and government priorities. 
	
</li><li> On the joining date, HR Department shall conduct a brief orientation session with the new employee to complete necessary employment documents and joining formalities. The employee will be given the employment contract and offer letter (hard copy). 

</li><li>The orientation program is the responsibility of the HR Department, in coordination with other Departments, whenever applicable. 

</li><li>The orientation program should include all corporate components of FJTCO (and the particular facility if applicable) information which should cover, but not limited to: 
</li><ul>
<li>An overview of the vision, mission and values of FJTCO. 
</li><li>Organizational structure of FJTCO.
</li><li>Information about MEP industry practices in UAE. 
</li><li>Overview of FJTCO culture, legislations, corporate policies, management manuals, corporate planning, business planning, licenses procedures, and UAE Labor law. 
</li></ul>
<li>As part of the orientation program, employees are also introduced to the UAE culture, geography, and other information that will help them understand the local culture. 

</li><li>Separately, the department Managers conduct the development of the Department component of employee orientation. 
</li>This information includes: <ul>
<li>Overview of the Department’s vision, mission, strategies, and values.
</li><li>Information about the Department’s structure, including its sections.
</li><li>Overview of the Department’s goals, priorities and business plan.
</li><li>Information about Department’s specific policies and procedures. 
</li><li>Overview of the programs and services delivered by the Department.
</li><li>Overview of the Department organizational chart.
</li>
</ul>



<li>The division Managers will also lead the development of the job-specific component to employee orientation. </li>

This information may include the following: <ul>

<li>Overview of the job description.
</li><li>Information about the roles and responsibilities, goals, and priorities of the division and the employee’s work unit.
</li><li>Introduction to key contacts and team members.
</li><li>Information about work assignments, and client groups.
</li><li>Review of performance management cycles for the division, including performance review timelines.
</li><li>Review of applicable dress code.
</li><li>Tour of work space.
</li><li>Equipment orientation and training. 
</li><li>Occupational Health & Safety information. 
</li><li>Review of security procedures.
</li><li>Information about mandatory training for the position. </li>

</ul>





</ol>
</div>

<div id="section-probation" class="tab-content">
    <h4>Probationary Period</h4>
    <ol>
    
   <li>	All new hires and all re-hires must serve a probation period of six months which can be extended up to another three months till satisfactory performance is achieved.

</li><li>	Employment can be terminated by either party during a Probationary Period without notice within the 3 months’ timeframe. Termination by FJTCO will be done in a formal manner and the employee will be notified in writing at the time of the end of probation review meeting.

</li><li>	In no case, an employee serving a Probationary Period can avail a paid leave. However, he/she may avail unpaid Leave working days. 

</li><li>	All Expatriate employees who are terminated by FJTCO during their Probationary Period will have their visas cancelled and they will be repatriated back to their home countries (as per their mobilization tickets entitlement) as per their contractual terms. 

</li><li>	One week before the end of the probationary period, the HR Department initiates the End of Probation Review process and requests the division Manager to conduct this review within the 6 months’ time frame of Probationary Period. The decision to confirm or end the employment relationship is based on the outcomes of this review, and should be documented. 

</li><li>	The Division Manager should also discuss and agree on performance objectives with the New hires who are confirmed as FJTCO employees at the end of their Probationary period, using the appropriate form, as per the Performance Management policy. 

</li><li>	FJTCO reserves the right to extend a Probationary Period in order to better assess the employee for an extended Probationary Period. Extension of a Probationary Period can only be done with the Division Manager’s approval and the employee must be notified of the decision by HR in writing. 
</li>
    
    </ol>
</div>

<div id="section-reference" class="tab-content">
    <h4>Reference Checks</h4>
    <p>	All recruitment is subject to reference checks from previous employers. 
	The selection of the employers will be as per HR Department request. 
  </p>
</div>
<div id="section-employeeReferral" class="tab-content">
    <h4> Employee Referral</h4>
    <p>Employees are encouraged to refer, whenever applicable, any candidate they find matching the job requirements for an advertised vacancy within FJTCO. 
	 <br/>A monetary reward will be paid to the employee who refers a candidate for each placement i.e. upon the candidate completing the probation period with success. 
    </p>
</div>
<div id="section-temporaryEmployment" class="tab-content">
    <h4>Temporary Employment</h4>
    <p>Temporary appointments are used to compensate for the absence of a permanent employee on emergency or long-term leave, or to assist in special projects or workloads. </p>
<p>	Temporary employment on temporary posts may be occupied by “referred employees” recruited through referrals and CV’s selected from the CV bank of the company. </p>
<p>Temporary staff are provided with an offer letter with the starting and ending date of their employment. Their salaries are paid along with other staff at the end of the month. </p>
</div>
<div id="section-transfers" class="tab-content">
    <h4>Transfers</h4>
    <p>An employee may ask, subject to FJTCO’S approval, or be asked to move from one department to another depending on the nature and availability of work. </p>
     <p>For an Internal Transfer from one division to another, approval must be obtained from the division manager to whose division he is transferred to. </p>
      <p>The salary cost center account is thereafter transferred to the respective division where the employee is transferred to.  </p>
</div>
<div id="section-goalSetting" class="tab-content">
    <h4>Goal Setting </h4>
  
<p>The appraisal system in FJTCO is conducted from January 1st to December 31st in FJTCO. It is built on an online platform in the FJHR portal and developed internally by the IT department and, aims to provide employees with real time feedback about their performance. </p>
<p>The KPI’s are designed for preliminarily 2 types of goals– strategic goals and individual goals. </p>
<p>The strategic goals are deemed most important to the current and future health of a business and they are the key ingredients upon which the employee’s work revolves around. </p><p>
<strong>For Eg,</strong> for an accountant, the strategic goals could be to ensure steady cash flow and to maintain adequate bank balance. </p><p>
Individual goals comprise of tasks which have to be completed on a more frequent basis, however, they play an important role in getting the work done in the respective department. </p><p> 
<strong>For Eg, ,</strong>  the individual goals for an accountant can be to check invoices, approving bills, maintaining internal reports and timely disbursement of salary every month. </p><p>
Initially, each employee has to discuss their KPI’s with their reporting manager and thereafter upload them in the online portal before the expiry of the deadline. Thereafter, it is the reporting manager’s responsibility to approve the KPI’s, after which the system is locked till the mid-term appraisal review. </p><p> 
New Joiners whose probation period ends on or after 31st July, will be a part of the final appraisal only, however, those who finish their probation previous to July 31st, will be part of both mid-term and final appraisal. </p><p>

The final appraisal review is conducted between October and December 31st. </p><p>

The following rating scale is to be used to appraise all employees: </p>
<strong>“Excellent” </strong></br>
<strong>“Good” </strong></br>
<strong>“Satisfactory” </strong></br>
<strong>“Needs improvement” </strong></br>

<p>The Line Manager shall support the poor performers by guiding them through a performance improvement plan to be followed over a defined time period. </p><p>
A poor rating in two consecutive annual review cycles in any one year may result in termination. </p>

</div>
<div id="section-careerDevelopment" class="tab-content">
    <h4>Career Development and succession planning</h4>
    <p>FJTCO management encourages all employees to have a long and successful career with the company. 
In lieu of their dedicated efforts and services, the employees are recognized and awarded for the same. An employee who completes 5 years with FJTCO is awarded with a long service award and is considered to be a part of the succession planning of the company. 
    </p>
</div>
<div id="section-trainingEducation" class="tab-content">
    <h4>Training and Education</h4>
    <p>The training needs of employees are based on the following criteria: </p><ul>
<li>Requirements of their present job 
</li><li>Career Development 
</li><li>Succession Planning 
</li><li>Skills gaps that may have been identified through the Performance Management process or during the course of work by the Line Manager/Department Manager. 

</ul><p>The HR department along with the concerned department conducts trainings for all employees based on the training calendar. While the departments conduct trainings to enhance the work-skills of their employees, the HR department conducts trainings for behavioral improvements and holistic growth. </p>

</div>
<div id="section-protectingprivacyPolicy" class="tab-content">
    <h4>Protecting Confidential Information Policy</h4>
    <p>This policy sets forth the affirmative obligation of each employee to protect the Company's confidential information. Each employee should take steps to ensure that confidential information is protected. This applies to the Company's confidential information, as well as to the confidential information of our customers and suppliers.</p><p>

All information related to the Company's business should be considered confidential and employees must take steps to protect not only the Company's confidential information but that
of customers and suppliers as well.</p><p>
Maintaining the confidentiality of information regarding the Company's products, operations,
activities and plans is a very important responsibility of every employee.</p><p>

The obligation to protect confidential information continues even after an individual is no longer
an employee of the Company.</p><p>

As a general rule, all information related to the Company's business should be considered
confidential and marked as such.</p><p>

Examples of confidential information include: </p><ul>
<li>Financial information such as results of operations, profit margins or budgets.
</li><li>Strategic business and operating plans.
</li><li>Sales and marketing information, including pricing information, customer lists, contacts,
sales techniques, plans and surveys.
</li><li>Operations information, including vendors and suppliers, production methods and
production requirements and specifications.
</li><li>Terms of agreements, including pricing with customers, suppliers and other companies.
</li><li>Product requirements, specifications, designs, materials, components and test results.
</li><li>Electronic files such as business communication and any other on-line documentation.</li>
</ul>
    
</div>
<div id="section-dataprivacyPolicy" class="tab-content">
    <h4>Data Protection and Privacy</h4>
    <p>The purpose of this policy is to ensure the security, confidentiality and appropriate use of all data processed, stored, maintained, or transmitted on FJTCO computer systems and networks.  </p><p>
This includes protection from unauthorized modification, destruction, transmittal or disclosure, whether intentional or accidental. This policy is intended to serve as a general overview on the topic and may be supplemented by other specific policies required by local government laws. </p><p>
It is the responsibility and duty of any individual who has access to FJTCO computer systems and networks, to protect FJTCO data resources in whatever form, from unauthorized modification, destruction, transmittal or disclosure. Without limiting the forgoing, all individuals granted access to FJTCO Information Technology resources are expected to adhere to the following principles: </p><ol>

<li>Refrain from any deliberate violation of FJTCO or departmental policy and/or any state or federal law governing information privacy and use.
</li><li>Refrain from attempting to access confidential or proprietary data on FJTCO computer systems, or in any other manner, except when it is in keeping with the specific assigned duties as an FJTCO employee.
</li><li>Appropriately maintain and protect the confidentiality of any data to which access has been granted, regardless of the method used to retrieve or display it.
</li><li>Refrain from making any unauthorized alterations (add/change/delete) to any data which is accessible either through legitimate granted access or any incidental access.
</li><li>Prevent the download, distribution, and installation of pirated software and copyrighted or proprietary materials for which the user has not acquired rights, and will strive to prevent the download, distribution, and installation of software and such materials without a valid license or the installation of a single user license on multiple machines. 
</li><li>Refrain from remotely or physically logging into or attempting to log into another user's machine or attempt to access another user's files without the individual's permission, except when necessary in the course of performing specific assigned duties as an employee.
</li><li>Refrain from attempting to compromise the security of the FJTCO network or devices attached to the network.
</li><li>Insure the proper disposal of all confidential or proprietary information in whatever form, in accordance with FJTCO or departmental policy.
</li><li>Refrain from unauthorized copying, transmittal or disclosure of business or project information to external parties, which would incur a loss of revenue to the company.
</li><li>Strictly follow the departmental or FJTCO IT guidelines, for the storage and retrieval of information related to business and/or personal information of FJTCO employees.</ol>
</li>
<p>Deliberate violation of this policy will be considered, a serious infraction under the FJTCO company policy and is subject to disciplinary action, up to and including dismissal. </p>
    
</div>
<div id="section-workOverview" class="tab-content">
    <h4>Overview</h4>
    <p>Work schedule and leave policy addresses the working hours and types of leave that FJTCO employees are entitled to. </p>
</div>
<div id="section-workSchedule" class="tab-content">
    <h4>Work schedule</h4>
    <p>The normal work schedule of FJTCO is from Saturday through Thursday. Working hours are from 8 am to 6 pm. However, at times it may be necessary for employees to work overtime, including Fridays and official holidays. Overtime pay will be in accordance to FJTCO policy and will be received by the employee upon the prior approval from their Division Manager.
 </p><p>Office timings during the holy month of Ramadan will be intimated through an official memo. Similarly, public holidays will be intimated in the same manner. 
    </p>
</div>


<div id="section-workLeave" class="tab-content">
    <h4><strong>Leave Policy</strong></h4/>
  <p>  The leave policy defines the scope of leave laid out for all FJTCO employees. Each type of leave and their categories are mentioned as follows:

</p>

<div class="panel-group" id="accordion">
<div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                     <a class="accordion-toggle collapsed"  data-toggle="collapse" data-parent="#accordion" href="#annualLeave">Annual Leave</a>
		                </h4>
		            </div>
		            <div id="annualLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		                   <p><u><strong>Definition:</strong></u></p><p>
			Annual leave is a provision for FJTCO employees to avail paid leave for 22 working days in a year. Employees are only entitled to avail the annual leave after completion of their probation period or 6 months in the company whichever is later. </p>
			<p>A staff cannot avail more than 30 calendar days at a stretch however, blue collar staff may avail a maximum of 60 annual leave days at a stretch.</p>
			<u><strong>How to apply for annual leave:</strong></u>
			<p>
			Annual leave should be applied in the FJHR portal three weeks in advance. After the application, leave salary is processed for that particular employee. This practice should be followed to avoid last minute rush.
			</p>
			<u><strong>
			Planning the annual leave:</strong> </u>
			<p>Employees should plan their annual leave well in advance and the plan should be submitted to the concerned person in the division by the first week of January. </p><p>
			Subsequently, each division should submit their annual leave plan to HR by 15th of January each year. </p><u><strong>
			Advance annual leave salary:</strong></u><p>
			The salary for the period of annual leave applied is paid in advance before the date of travel, i.e. if an employee has applied for annual leave from 1st April 2017 to 30th April 2017, the leave salary for the month of April will be provided in advance along with the salary of March 2017. </p><u>
			<strong>Return from Annual leave:</strong></u>
			<p>
			Annual leave cannot be clubbed with any other leave, and the employee is expected to report on duty on the particular day that the leave ends. 
			In case a public holiday is declared on the day that an employee is re-joining back from annual leave, the date for re-joining from annual leave will be when the public holidays are over. 
			The days of the public holiday will not be counted in the annual leave
			</p>
			<p>
			For example; If the date of re-joining from annual leave is on 30th April 2017, and the same date is declared as a public holiday, the joining will be on 1st May
			</p>
			<u><strong>Cancellation of annual leave:</strong></u><p>
			Once annual leave is applied in the system and leave salary is processed, it is registered in the Orion system. Ideally the leave cannot be cancelled, 
			however, due to unforeseen situations, if an employee wants to cancel his leave, the request for the same has to be submitted to HR, with prior approval of division manager. 
			The request is thereafter forwarded to the IT manager for cancellation. </p>
			<p>
			The leave days are then reversed back to the employee’s account and the leave salary is adjusted with the current or subsequent month’s salary. </p>
			<p>
			In case employees decide to prematurely end their annual leave and return back to work, they will be paid only the Basic salary for the rest of the days 
			worked within the annual leave period. However, the balance days will not be reversed back in the employee’s account.  </p><p>
			For example; If the annual leave is applied from 1st April to 30th April, and the employee returns to work on 15th April, basic pay will be provided for 
			the days worked from 15th April to 30th April. </p>
			<u><strong>Accumulation and encashment of annual leave: </strong></u>
			<p>
			In order to maintain a proper balance and record of annual leave, the following procedures have been implemented with effect 1st January 2020. </p>
			<p>
			<p>
			<ol>
			<li>Annual leave structure has been changed from 30 calendar days to <b>22 working days</b> in a year</li>
			<li>Leave encashment <b>will not</b> be permitted to any staff with effect 1.1.2020.</li>
			<li>The carry forward of annual leave balance to the following year will be managed accordingly. <br/>
			<table class="table table-striped small" border="1" style="width:max-content !important;">
										<thead>
										<tr>
										<th>Year</th>
										<th>Allowed annual leave carry forward</th>
										</tr>
										</thead>
										<tr>
										<td><b>2020 to 2021</b></td>
										<td>35 days</td>
										</tr>
										<tr>
										<td><b>2021 to 2022</b></td>
										<td>25 days</td>
										</tr>
										<tr>
										<td><b>2022 to 2023</b></td>
										<td>10 days</td>
										</tr>
										<tr>
										<td><b>2023 to 2024 and onwards</b></td>
										<td>5 days</td>
										</tr>
			   </table>
			
			
			</li>
			<li>No staff will be allowed to go into negative leave balances at any point in time whatsoever.</li>
			</ol>
			</p>
			<p>Annual leave procedure for blue collar employees will remain the same.  </p>
			
		      </div>
		            </div>
		        </div>
		        
		        
		  <div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#sickLeave">Sick Leave</a>
		                </h4>
		            </div>
		            <div id="sickLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		                <p><u><strong>
						Definition:</strong> </u></p><P>
						Sick leave is a leave of absence provide to employees because of an illness. </p><P>
						<u><strong>Sick leave provision: </strong></u></p><P>
						All FJTCO employees are entitled up-to a total of 10 non-consecutive days for minor illnesses and 45 calendar days as sick leave for major illnesses. </p><P><u>
						<strong>Applying for Sick leave: </strong></u></p><P>
						Employees must apply for sick leave in the FJHR portal immediately after resuming work. Reporting managers must be notified by telephone or e-mail prior to availing a sick leave. Employees suffering from major illnesses and travelling to their native location for medical treatment must produce valid doctor certificates and receipts to apply for sick leave. In case of minor illnesses, employees must be treated in UAE. </p><P><u>
						<strong>Conditions for availing Sick leave:</strong> </u></p><P>
						The company approves 10 non-consecutive days of sick leave per annum for minor illness. However, from the 4th non-consecutive sick leave, medical certificates need to be provided even for a single day sick leave. </p><P>
						Consecutive sick leave due to minor illness in excess of two days (including Saturday's & Sunday's), must be accompanied by a medical report and certificate duly signed by a Doctor from an approved medical center. </p><P>
						Employees suffering from major illnesses or injuries are allowed to avail up to 45 calendar days as sick leave. During the leave period, full salary will be paid for the first 15 days and the balance 30 days will be paid as Basic salary. </p><P>
						In case an employee is unable to rejoin work beyond the allotted 45 days of sick leave, all further leave will be treated as leave without pay. </p>
		                </div>
		                </div>
		           </div> 
		    <div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#compassionateLeave">Compassionate leave</a>
		                </h4>
		            </div>
		            <div id="compassionateLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		              <p><u>

				Definition: </u></p><p>
				Compassionate leave  provision for employees to avail immediate leave for instances involving the demise of a family member.
				Compassionate leave starts from the <b><u>date of death</u></b> and is as per the guidelines below:
				<ul>
						<li>5 calendar days for spouse, children, mother, father.</li>
						<li>3 calendar days for brother, sister, grandchildren, grandparents.</li>
				</ul>
				Any additional days can be availed from annual leave subject to manager approval.
				Compassionate leave must be supported by an <b><u>legally attested death certificate</u></b> otherwise the whole leave will be considered as annual leave or 
				unpaid should there be no sufficient leave balance
				Leave must be routed via HR for approval.
				Compassionate leave can be availed more than once should there be more than one instance of family members death within the same year.</p>
		                </div>
		                </div>
		           </div>
		    
		         <div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#emergencyLeave">Emergency leave</a>
		                </h4>
		            </div>
		            <div id="emergencyLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		              <p><u>

				Definition: </u></p><p> Emergency leave is a provision for employees to avail immediate leave for instances involving life-threatening illness, injury or emergency. <b>Emergency leave is deducted from the annual leave entitlement.</b></p>
				<p><u>Applying for emergency leave:</u></p>
				<p>
				Employees must apply for emergency leave in the FJHR portal before availing the leave and it must be approved by the reporting manager. </p>
		        <p><u>Conditions for availing emergency leave:</u></p>
		         <p> 
		         While applying for emergency leave, employees should avail a minimum of 3 days and maximum of 7 days.
		         </p> 
		          <p>
		       Emergency leave applied for less than 3 days will not be approved.<br/>
		       Employees are entitled to emergency leave only after they successfully complete their probationary period with FJTCO.
		         </p>
		         
		                </div>
		        
		                </div>
		           </div>
		        <div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#paternityLeave">Paternity  leave</a>
		                </h4>
		            </div>
		            <div id="paternityLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		               <p><u> Definition: </u> </p>
				<p> Paternity leave is a period of absence from work granted to a father before and after the birth of his child. 
				</p>
				<p><u> Applying for Paternity leave:</u> </p>
				<p>Employees must apply for paternity leave in the FJHR portal before availing the leave and it must be approved by the reporting manager. Employees are eligible to avail 5 calendar days of fully paid paternity leave, however, in case the employee extends his leave beyond the allotted 5 days, it will be considered as leave without pay or annual leave.</p>
		           <p><u> Conditions for availing paternity leave:</u> </p>
		            <p>Employees must complete 1 year in the company to avail the paternity leave. An attested birth certificate must be provided</p>
		                </div>
		                </div>
		           </div>
		     <div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#maternityLeave">
								Maternity Leave</a>
		                </h4>
		            </div>
		            <div id="maternityLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		             
				<p><u>
				Definition: </u></p><p>
				Maternity leave is a period of absence from work granted to a mother before and after the birth of her child. </p><p><u>
				Applying for Maternity leave: </u></p><p>
				Employees must apply for maternity leave in the FJHR portal before availing the leave and it must be approved by the reporting manager. Employees are eligible to avail 45 days of fully paid maternity leave, however, in case the employee extends her leave beyond the allotted 45 days, it will be considered as leave without pay. </p><p><u>
				Conditions for availing maternity leave: </u></p><p>
				Employees must complete 1 year in the company to avail the maternity leave. </p>
		                </div>
		                </div>
		           </div>
		        
		        
		        <div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#pointLeave">Point to Observe for Leave Applications</a>
		                </h4>
		            </div>
		            <div id="pointLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		                          
				<p><ul><li>
All leave application except sick leave must be applied in advance in the FJHR Portal. </li><li>
Reporting managers may rightfully reject leave applications applied after availing the leave, without their prior consent. </li></ul></p>
		                </div>
		                </div>
		           </div>
		        
		        <div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#ruleLeave">
		                   Rules for Regularization of Attendance</a>
		                </h4>
		            </div>
		            <div id="ruleLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		      <p>Working hours according to FJTCO policy, are from 8am to 6pm and all staff must use the punching machine at these times to record their attendance. This record is thereafter reflected in the FJHR portal of each employee. </p><p>
				A grace period of half an hour is provided till 8.30am to all employees within which they should record their attendance. </p><p>
				However, in some exceptional cases, when the finger punching is not registered, employees should regularize their attendance. </p><p>
				These cases may be as follows: </p><ul><li>
				Arriving to office after 8.30am. </li><li>
				Leaving office before 6pm. </li><li>
				Failure to record the finger swipe/single swipe. </li></ul>

		                </div>
		                </div>
		           </div>
		        
		        
 			<div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#observeLeave">
		                   Point to Observe while Regularizing the Attendance</a>
		                </h4>
		            </div>
		            <div id="observeLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		     <p><ul><li>
25th of every month is considered as the cut-off date for attendance and, employees should regularize their attendance before the cut-off date. </li><li>
The portal closes every current month, hence attendance regularization for the current month should be completed within that particular month only. The FJHR portal does not allow for back dated regularizations. </li><li>
Failure to regularize the attendance before the cut-off date may result in loss of pay, since the data from FJHR portal reflects the day as absent. </li><li>
Employees going out for meetings or to attend other work-related appointments must mention the reason along with the name of the client and place of meeting for regularizing their attendance. </li><li>
Employees must regularize their attendance on a weekly basis to avoid the last-minute confusion, since reporting managers are often flooded with regularization mails and it is difficult to approve all the regularizations before the due date. </li></ul></p>

		                </div>
		                </div>
		           </div>
		      
		      
		      
 			<div class="panel panel-default">
		            <div class="panel-heading">
		                <h4 class="panel-title">
		                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#casesLeave">
		                   Cases when regularization Requests will not be Accepted</a>
		                </h4>
		            </div>
		            <div id="casesLeave" class="panel-collapse collapse">
		                <div class="panel-body">
		       <p><ul><li>
			Regularization against a leave of absence.  </li><li>
			Arrival in office following 1 pm or departure from office prior to 1 pm. </li></ul></p><p>
			These situations will be considered as half day leave and should be applied in the FJHR portal accordingly. </p>
		                </div>
		                </div>
		           </div>  
		 		
</div>


    
</div>
			<div id="section-codeOverview" class="tab-content">
			    <h4>Overview</h4>
			    <p>The objective of this policy is to establish the principles of ethical and disciplinary conduct by which FJTCO employees must administer themselves. </p>
			</div>
			<div id="section-cc" class="tab-content">
			    <h4>Code of Conduct</h4>
			    <p>FJTCO will treat all its employees equally and without any favor or prejudice. The employees, on their part, will treat other employees without any favor or prejudice irrespective of color, race or creed. </p><p>
		The employees will be required to interact with other employees, including senior personnel and their subordinates, within the framework of guidelines of FJTCO. </p><p>
		Employees are expected to show proper deference to senior personnel and consideration to colleagues and subordinates. They should also, by informal interaction, attempt to resolve misunderstandings, differences of opinion, etc. amongst themselves or with the assistance of senior personnel, before initiating formal action. </p><p>
		Employees are required to abide by the rules and regulations of FJTCO, and execute the instructions of their Reporting Manager. Any behavior to the contrary will be subject to disciplinary action. </p><p>
		Employees must devote their official time to perform official duties accurately and faithfully, and must obtain the permission from their reporting manager in case they wish to leave office during/before work hours. </p><p>
		The employees should observe all security regulations of FJTCO. </p><p>
		Employees are not authorized to remove FJTCO property from the work area without the permission of the Managing Director. Use of FJTCO property, including computers and office equipment, for personal entertainment or profit is specifically prohibited. </p><p>
		All FJTCO employees shall conduct themselves in a manner that promotes and maintains a professional environment. Employees should aim to keep a high level of performance and behavior, which is deemed acceptable by FJTCO. Proper conduct is a condition of continued employment. Improper conduct may result in disciplinary action or termination. Senior personnel should advise and assist newer employees, to follow FJTCO’s standards. The standards expected are those of: </p><p>
		<ul>
		<li>Competence.
		</li><li>Good Time Keeping.
		</li><li>Courtesy.
		</li><li>Commitment.
		</li><li>Confidentiality.
		</li><li>Safety Consciousness.
		</li><li>Honesty and Integrity.</li></ul></p><p>
		
		Proprietary and confidential data belonging to FJTCO or to clients should not be removed from the work premises, divulged to unauthorized parties, or used for personal gain. All employees are expected to respect confidentiality. Employees are not to discuss prospects; contracts or their values with anybody. Employees must ensure that confidential information, in their possession, is not accessed by any outside party or organization. Confidential information is not to be left where non-FJTCO personnel might access it. </p><p>
		All employees should conduct the duties and responsibilities that are assigned to them precisely, honestly and within the required time frame. Employees should also conduct any duties, which are assigned to them by their superiors and any other official assignments he/she is asked to do. </p><p>
		While interacting with outside agencies, clientele etc., employees will behave in a courteous and proper manner.  They shouldn’t act in any way that will offend the outsider’s feelings or cause harm to FJTCO’s reputation. </p><p>
		Outside the office premises, the employees will not indulge in any acts that will adversely affect FJTCO’s image and standing. </p><p>
		Employee’s will not disclose any confidential information, proprietary information or trade secrets belonging to FJTCO or any organizations affiliated to it, or to any third party. </p><p>
		FJTCO employees are not permitted to have part time work outside the working hours of FJTCO. </p>
		 
			</div>
			
			
			<div id="section-dressCode" class="tab-content">
			    <h4>Dress Code Policies</h4>
			    <p>The following criteria will generally dictate the dress code for FJTCO employees:</p><ul>
<li>Work environment requirement
</li><li>Safety
</li><li>General appearance</li></ul><p>
Employees should wear formal attire from Sunday through Wednesday and on Thursdays are allowed to dress in smart casuals. </p><p>
Employees are expected to respect the dress code required and conform to the generally accepted dress practices of the office.</p><p>
Employees are expected to display a professional image and dress in accordance with the protocol of FJTCO.</p>

			</div>
			
			
			<div id="section-codeCategory" class="tab-content">
			    <h4>Category of Violations of FJTCO ethics policies</h4>
			    <p>Faisal Jassim practices a strict code of conduct and Ethics policy. Violation of FJTCO codes are seen as serious offence and may attract penalties for offenders. </p>
			    
			    <ul>
			<li>Willfully or negligently causing damage of FJTCO property.
			</li><li>Selling, soliciting, or collecting contributions on FJTCO property for any purpose whatsoever without specific prior written permission from FJTCO management.
			</li><li>Not reporting a serious contagious disease, which may endanger other employees.
			</li><li>Creating a safety hazard by obstructing aisles, fire exits and equipment locations.
			</li><li>Smoking inside FJTCO’s premises.
			</li><li>Causing injury to another employee due to carelessness, negligence or horseplay.
			</li><li>Quarrelling, or using loud abusive language in the work place.
			</li><li>Using FJTCO time, materials or equipment for un-authorized work.
			</li><li>Leaving the work place during work hours without permission or without notifying the reporting manager.
			</li><li>Being convicted of a crime affecting honor, honesty, or morality.
			</li><li>Use of fraud, including misrepresentation of credentials, qualifications, and previous employment for the purpose of obtaining employment with FJTCO, or falsifying any FJTCO documents or records.
			</li><li>Divulging in trade secrets, proprietary information, or confidential information belonging to FJTCO or FJTCO clients. Giving or distributing any information or documentation concerned with FJTCO, or its activities, or any organizations affiliated with FJTCO, divulging information to any third parties without written approval from FJTCO. 
			</li><li>Theft or gross misuse of FJTCO property, including computers, FJTCO provided cars and the personal property of other employees.
			</li><li>Accepting kickbacks or financial favors from suppliers, contractors or FJTCO clients. 
			</li><li>Violating FJTCO’s security and copyright regulations.
			</li><li>Belonging to a political group or organization, working for, or distributing/advertising political information.
			</li><li>Working for another organization inside or outside the work hours of FJTCO. </li></ul>
 
			</div>
			
			<div id="section-disciplinaryOverview" class="tab-content">
			    <h4>Overview</h4>
			    <p>Disciplinary actions define a standard procedure to be used by the Management to inform and counsel employees regarding unsatisfactory behavior or job performance. An employee who is deemed to be in breach of any of the FJTCO code of conducts or standards of performance shall be subject to disciplinary measures. </p>
			</div>
			<div id="section-disciplinaryAction" class="tab-content">
			    <h4>Disciplinary Action</h4>
			    <p>The concerned authority, namely the Division Managers or HR shall initiate the disciplinary action.</p>
			    <p>Whenever an employee’s performance or conduct is unsatisfactory, the employee will be notified in writing. Such notification will follow a uniform procedure and be applied through consistent standards and measures. These notifications are indications to the employee of the possibility of disciplinary actions if the employee’s performance or conduct does not improve to FJTCO standards.</p>
			</div>
			
			<div id="section-disciplinaryPenalties" class="tab-content">
			    <h4>Penalties and Contravention</h4>
			    <p>Penalties will be applied to employees who contravene FJTCO’s policies, regulations and work rules, however, no penalty will be imposed without first giving the employee a hearing and examining his defense.</p>
			    <p>The types of penalties that may be imposed, depending on the seriousness of the offence are:</p>
			    <ul>
			    <li>Verbal warning
				</li><li>Written warning 
				</li><li>Suspension of pay 
				</li><li>Dismissal from service</li>
			    
			    </ul>
			</div>
            
			<div id="section-separationOverview" class="tab-content">
			    <h4>Overview</h4>
			    <p>To set the policies and procedures pertaining to the separation of an employee from FJTCO.
			    </p>
			</div>
			
		
			<div id="section-separationProcedure" class="tab-content">
			    <h4>Separation Procedure</h4>
			   

		         <p>  
					 <ul>
					<li>Separation of an employee can take place through FJTCO initiated termination or      
					employee-initiated separation, however, in either case, it should be intimated to HR 
					by mail atleast 30 working days prior to the last working day. </li>
					<li>
					A notice period of minimum 30 days should be served by the employee from the date of resignation. 
					However, the period of notice can be mutually agreed between the employee and the reporting manager until
					 proper hand-over of the existing duties are concluded. During the period of notice being served by the employee he/she 
					 is not entitled to any leave of absence. In case the employee avails such leave, 
					it will be treated as loss of pay and deducted from the end of service settlements. 
					</li>
					<li>
					After the separation is officially decided, the employee has to submit the duly filled <b>EMPLOYEE RELEASE FORM</b> to the HR department. 
					This form is available with the secretaries of each division; however, the employee may also obtain it from the HR department also. 
					The <b>EMPLOYEE RELEASE FORM</b>  is a clearance document, and should be signed by the department heads. The clearance from IT 
					department will be executed on the last working day only, since IT equipment like Laptops and sim cards can only be accepted on the last working day.  
					Please note that HR will not carry out the End of Service formalities without the fully filled <b>EMPLOYEE RELEASE FORM</b>. 
					</li>
					
					<li>
					For the cancellation of resident visa, the employee should submit the original passport, emirates ID and insurance card 
					atleast 5 working days prior to the last working day. In case of blue-collar employees, the concerned department 
					should initiate this process. Employees who sponsor their families, must hold or cancel the visa of their dependents 
					after the cancellation of their labor card, as the case may be. 
					</li>
					<li>
					The employee should allow a minimum of 3 working days after the last working day to avail the end of service entitlement transferred to 
					their bank account. However, incase the employee has to depart to their home country prior to the transfer, 
					they may submit the bank account details of their home country to the finance department and HR. 
					(Final amount will be as per the exchange rate after deducting the transfer charges) 
					</li>
					<li>
					The amount for medical insurance will be fully deducted from the employee’s end of service and upon receiving the credit note from 
					the insurance company, the respective balance will be paid back. For this purpose, the employee should submit the details of the 
					bank account in their home country to Finance and HR department. 
					(Final amount will be as per the exchange rate after deducting the transfer charges) 
					</li>
					<li>
					If the employee was using a company car, AED 1,000 will be kept aside by logistics department in lieu of any traffic fines that may arise 
					against the vehicle. This amount will be released after 6 months following the adjustment of the balance against traffic violations if any.
					</li>
					<li>
					Every employee will be provided with the most economical repatriation ticket available at the time of travel.
					 However, if all the available flights on the date of travel are costlier than the average ticket rates, 
					 the HR department may ask the employee to change the date of departure upto a maximum of 5 working days or 
					 issue a hopping flight to the employee’s home country only. In all cases, 
					only a repatriation ticket will be provided to the home country and no reimbursement is allowed.  
					</li>
					<li>
					If the employee wishes to transfer his/her division, it must be mutually agreed between the division managers of both 
					the division and a confirmation must be sent to the HR department atleast 15 working days before the transfer. 
					</li>
					</ul>
					                 
                 </p>
		    
				   </div>
				   
				   <div id="section-GrivanceIntroduction" class="tab-content">
					   <h4>Introduction</h4>
					   <p>Although we seek to provide a workplace in which all employees feel that they are an important part of
						<br/><b>Faisal Jassim Trading Co LLC</b>, and where employees feel fairly treated, there may be times when you have a
						dispute with a supervisor or the Company which can best be resolved through a formal procedure for dispute
						resolution. All disputes between any employee and the Company are to be resolved by in accordance with the
						following procedure. Please note, however, that the Company reserves the right to modify this procedure at
						any time and nothing in this procedure should be construed to constitute a contract between you and the
						Company or to constitute any part of a contract between you and the Company.
					   </p>
					   <p>Any dispute between you and the Company may be resolved using this grievance procedure, with the
						exception of oral reprimands which are not recorded in your personnel file.</p>
				   </div>
				   <div id="section-GrivanceProcedure" class="tab-content">
					<h4>Grievance Procedure</h4>
					<p>
						<p>
							<b>Preliminary Step</b><br/>
							You must first address your grievance with your immediate supervisor. This may be done orally in informal
							discussion. If your informal attempts to resolve the matter are not successful, you may implement the formal
							grievance process.
						</p>	
						<p>
								<b>Step 1 : </b><br/>
								You must first submit your grievance in writing to your immediate supervisor. Grievances must be submitted
within [30] calendar days following the date you first knew or should have known of the grievance. If you do
not submit the grievance within the [30] day period, you waive your right to assert it.<br/>
Your supervisor will respond in writing within ten (10) days following receipt of your grievance. All grievances
and replies in Step 1 must be in writing. If the grievance is not settled in Step 1, then you may proceed to Step
2.
							</p>	
							<p>
									<b>Step 2 :</b><br/>
									Within ten (10) days following your receipt of the written answer to your Step 1 grievance from your
supervisor, you may appeal the disposition of your grievance by your supervisor to your Department Head.
The Department Head will then undertake an investigation of your grievance and the underlying facts. Within
15 business days following receipt of your grievance the Department Head will meet with you in person to
discuss your grievance.
								</p>
								<p>
										<b>Step 3 :</b><br/>
										If you are not satisfied with the response of the Department Head at Step 2, you may submit your grievance to
the HR Manager of the company for review within five (5) days following the response from your Department
Head. The HR will review the grievance and provide a written response within 15 business days following
receipt of the Step 3 grievance.
									</p>	<br/><br/>
									
									Confidentiality of genuine whistleblower is maintained and no one will be protected from retribution
					</p>
				  </div>
				   
<div id="section-test" class="tab-content">
    <h2></h2>
    <p></p>
</div>

</div>
<div class="footer-copyright py-3 text-center">
        © 2020 Copyright:
        <a href="http://www.faisaljassim.ae/">Faisal Jassim Group </a>
    </div>

		 		
 		       
<!--  test -->	
 		
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