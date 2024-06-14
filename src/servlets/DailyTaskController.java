package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import beans.BusinessTripLVApplication;
import beans.CustomerVisit;
import beans.DailyTask;
import beans.fjtcouser;
import utils.DailyTaskDbUtil;

/**
 * Servlet implementation class DailyTaskController
 */
@WebServlet("/DailyTask")
public class DailyTaskController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DailyTaskDbUtil dailyTaskDbUtil;  
	private BusinessTripLVApplication businesstripusers;

    public DailyTaskController() {
        super();
        dailyTaskDbUtil=new DailyTaskDbUtil();
        businesstripusers = new BusinessTripLVApplication(); 
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
    	request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser=(fjtcouser) request.getSession().getAttribute("fjtuser");
		if(fjtuser.getEmp_code()==null ){response.sendRedirect("logout.jsp");}
		else {		
			
			 String emp_code= fjtuser.getEmp_code();  
			 String curr_year=Calendar.getInstance().get(Calendar.YEAR)+"";
			 					 
			 if(fjtuser.getSubordinatelist()!=null){
					List<DailyTask> theSubordinatesList=dailyTaskDbUtil.getSubordinatesDetails(emp_code);
					request.setAttribute("SUB_EMP_LIST",theSubordinatesList);
					}
			 String theDataFromUsr=request.getParameter("fjtco");
				if(theDataFromUsr == null) {theDataFromUsr="task_dafult";}
				 
				switch(theDataFromUsr) {
				
				case "task_dafult":
					try {displayDefaultMonthTasks(request,response,emp_code,curr_year);
					} catch (Exception e) {e.printStackTrace();}
					break;
				case "tnveetrc"://create event or task
					 
					try {
						 String salesCode = null;
						 String emp_divn= "IT";
						 
				    	 if(fjtuser.getSales_code()!=null) {salesCode=fjtuser.getSales_code();}
						 createnewTask(request,response,emp_code,salesCode,emp_divn);
					} catch (Exception e) {e.printStackTrace();}
					break;
				case "tnvetld"://create event or task
					 
					try {
						
						 deleteTask(request,response,emp_code,curr_year);
					} catch (Exception e) {e.printStackTrace();}
					break;
				case "yampfltsn"://new task list for selected month and year
					 
					try {
						
						displaySelectedMonthTasks(request,response);
					} catch (Exception e) {e.printStackTrace();}
					break;	
					
				case "tnveetdpu"://update event or task
					 
					try {
						
						 updateExistingTask(request,response);
					} catch (Exception e) {e.printStackTrace();}
					break;
				case "cedtrsd"://complete emplyees daily task report for single day					 
					try {						
						getCompleteUsersSingleDayDailyTaskReportForDM(request,response);
					} catch (Exception e) {e.printStackTrace();}
					break;
				case "cvdfser"://customer visit details for sales engineers regularization				 
					try {						
						getCompleteUsersSingleCustVstReportForRegularisation(request,response);
					} catch (Exception e) {e.printStackTrace();}
					break;
				case "tburser"://Business trip users			 
					try {	
						getBusinessTripLVRegularisation(request,response);												
					} catch (Exception e) {e.printStackTrace();}
					break;
				default:
					try {displayDefaultMonthTasks(request,response,emp_code,curr_year);
					} catch (Exception e) {e.printStackTrace();}
					
					
					
				}
			 
			
		}
	}
    private void getCompleteUsersSingleCustVstReportForRegularisation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {   	
	     String se_emp_code = request.getParameter("seId");
	   	 String theDate = request.getParameter("rdate");
	   	 // System.out.println("REG DATE : sjg "+theDate+" "+se_emp_code);
	      List<CustomerVisit> theVisitList= dailyTaskDbUtil.getCustomerVisitDetailsForSingleDay(theDate, se_emp_code);			 
			response.setContentType("application/json");
		 	new Gson().toJson(theVisitList, response.getWriter());  	  		 	 
}
    private void getBusinessTripLVRegularisation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {   	
	     String sub_emp_code = request.getParameter("seId");
	   	 String loginusr = request.getParameter("empid");
	   	 String fromDate = request.getParameter("fromdate");
	   	 String toDate = request.getParameter("todate");
	   	 // System.out.println("REG DATE : sjg "+theDate+" "+se_emp_code);
	      List<BusinessTripLVApplication> businestrpList= businesstripusers.getBusinessTripLVApplication(loginusr, sub_emp_code,fromDate,toDate);			 
			response.setContentType("application/json");
		 	new Gson().toJson(businestrpList, response.getWriter());  	  		 	 
  }
    private void getCompleteUsersSingleDayDailyTaskReportForDM (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {   	
    	     String dm_code = request.getParameter("td1");
    	   	 String theDate = request.getParameter("td2");
    	   	 //System.out.println("DATE : sjg "+theDate);
    	    	List<DailyTask> thetaskList= dailyTaskDbUtil.getDivisionStaffsDailyTaskReport(dm_code, theDate);
    			 
    			response.setContentType("application/json");
    		 	new Gson().toJson(thetaskList, response.getWriter());  	  		 	 
    }
    
    private void updateExistingTask(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
    	String taskId=request.getParameter("utd1");
        if(taskId==null) {
        	response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("Refresh the page, Then try to delete.");
        	
        }
        else {
        	 String type = request.getParameter("utd2");//update task type
        	 String descrptn = request.getParameter("utd3");//update task description
        	 String startTime = request.getParameter("utd4");//update task start time
        	 String endTime = request.getParameter("utd5");//update task description
        	// System.out.println("type : "+type+" start : "+startTime+" end : "+endTime);
        	 DailyTask task_Details =new DailyTask(type,descrptn,startTime,endTime,taskId);
       
       	int successVal=dailyTaskDbUtil.updateEmployeeTask(task_Details);
       	if(successVal==1){
    			response.setContentType("text/html;charset=UTF-8");
    	        response.getWriter().write(""+successVal);
    		    
    		}
    		else {
    			response.setContentType("text/html;charset=UTF-8");
    	        response.getWriter().write(""+successVal);
    			
    		}
        }
		
	}
	private void deleteTask(HttpServletRequest request, HttpServletResponse response,String emp_id,String year) throws ServletException, IOException, SQLException {
    String taskId=request.getParameter("dit");
    if(taskId==null) {
    	response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("Refresh the page, Then try to delete.");
    	
    }
    else {
    //long task_id = Long.parseLong(taskId);
   
   	int successVal=dailyTaskDbUtil.deleteATask(taskId);
   	if(successVal==1){
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("task  deleted  Successfully.");
		    
		}
		else {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("task Not deleted, Please try again.");
			
		}
    }
	 }
    private void createnewTask(HttpServletRequest request, HttpServletResponse response,String emp_code,String salesCode,String division) throws ServletException, IOException, SQLException {
    	 
    	 String workDay = request.getParameter("td3");
    	 String month = request.getParameter("td6");
    	 String type = request.getParameter("td1");//task type
    	 String descrptn = request.getParameter("td2");// task description
    	 String startTime = request.getParameter("td4");
    	 String endTime = request.getParameter("td5");
    	 String year = request.getParameter("td7");
    	 String emp_name = request.getParameter("td8");
    	 String emp_company = request.getParameter("td9");
    	 String emp_divn = dailyTaskDbUtil.employeeDivision(emp_code);
    	
    	DailyTask task_Details =new DailyTask(year,emp_code,emp_name,emp_company,emp_divn,salesCode,workDay,month,type,descrptn,startTime,endTime);
    	int successVal=dailyTaskDbUtil.createnewEmployeeTask(task_Details);
    /*	if(successVal==1){
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("New Task  Created  Successfully.");
		    
		}
		else {
			response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().write("Task Not Created, Please try again.");
			
		}*/
     response.setContentType("text/html;charset=UTF-8");	
   	 response.getWriter().write(""+successVal);
	 }
    private void displaySelectedMonthTasks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
     String sales_man_code = "";
     List<DailyTask> resultList = new ArrayList<DailyTask>();
     String emp_code = request.getParameter("td3");
   	 String curr_year = request.getParameter("td1");
   	 int month = Integer.parseInt(request.getParameter("td2"));
  	 List<DailyTask> thetaskList=dailyTaskDbUtil.getEmployeeTaskforCurrentMonth(emp_code, curr_year,month);
  	 resultList.addAll(thetaskList);
  	
  	 DailyTask userSalesStatus = dailyTaskDbUtil.getSalesStausWithCode(emp_code);
	 //System.out.println("CUSTOME OUT VISIT = "+userSalesStatus.getSalesVisitStstus()+" SALES CODE = "+userSalesStatus.getSalesCode()+" emp code = "+userSalesStatus.getEmp_code() );
	 if(userSalesStatus.getSalesVisitStstus().equalsIgnoreCase("y") && userSalesStatus.getSalesCode() != null) {
		  sales_man_code = userSalesStatus.getSalesCode();
		  if(sales_man_code != null && sales_man_code != "") { resultList.addAll(dailyTaskDbUtil.getCustomerVisitDetails(curr_year, month, emp_code, sales_man_code));}		  
	  }  	 		 
		response.setContentType("application/json");
	 	new Gson().toJson(resultList, response.getWriter());
	 }
    private void displayDefaultMonthTasks(HttpServletRequest request, HttpServletResponse response,String emp_code,String curr_year) throws ServletException, IOException, SQLException {
    	  String sales_man_code = "";
    	  Calendar cal = Calendar.getInstance();
    	  int month = cal.get(Calendar.MONTH)+1; 
    	  List<DailyTask> resultList = new ArrayList<DailyTask>();
    	  List<DailyTask> thetaskList= dailyTaskDbUtil.getEmployeeTaskforCurrentMonth(emp_code, curr_year,month);
    	  resultList.addAll(thetaskList);
    	  
    	  DailyTask userSalesStatus = dailyTaskDbUtil.getSalesStausWithCode(emp_code);
    	 // System.out.println("OUT VISIT = "+userSalesStatus.getSalesVisitStstus()+" SALES CODE = "+userSalesStatus.getSalesCode()+" emp code = "+userSalesStatus.getEmp_code() );
    	  if(userSalesStatus.getSalesVisitStstus().equalsIgnoreCase("y") && userSalesStatus.getSalesCode() != null) {
    		  sales_man_code = userSalesStatus.getSalesCode();
    		  if(sales_man_code != null && sales_man_code != "") {
    	    		 resultList.addAll(dailyTaskDbUtil.getCustomerVisitDetails(curr_year, month, emp_code, sales_man_code));
    	    		 }
    		  
    	  }
    	   	 
		 request.setAttribute("EMPTSKLIST", resultList);
		 goToDailyTask(request,response);
		 
	 }
    
    private void goToDailyTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("/dailyTask.jsp");
   	    dispatcher.forward(request,response);
		
	 }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        	fjtcouser fjtuser=(fjtcouser) request.getSession().getAttribute("fjtuser");
        	if(fjtuser == null) {response.sendRedirect("logout.jsp");
        	}else {processRequest(request, response);}	
		} catch (SQLException e) {e.printStackTrace();}
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {fjtcouser fjtuser=(fjtcouser) request.getSession().getAttribute("fjtuser");
        	if(fjtuser == null) {response.sendRedirect("logout.jsp");}
        	else {processRequest(request, response);}
		} catch (SQLException e) {e.printStackTrace();}
    }
}
