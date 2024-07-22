package servlets;

import java.io.IOException;
import java.sql.SQLException; 
import java.util.Calendar; 
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import beans.ServicePortalReportStaffs;
import beans.ServicePortalStaffs;
import beans.ServiceReport;
import beans.ServiceRequest;
import beans.fjtcouser;
import utils.ServicePortalDbUtil;

/**
 * @author nufail.a Servlet implementation class FJ PUMP SERVICE REQUESTS
 */

@WebServlet("/ServiceReports")
public class ServicePortalReportsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ServicePortalDbUtil servicePortalDbUtil;
	public ServicePortalReportsController() throws ServletException {
		super.init();
		servicePortalDbUtil = new ServicePortalDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters.
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters.
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");
		} else { 
			String employeeCode = fjtuser.getEmp_code();
			String requestType = request.getParameter("action");  
			
			if (requestType == null) { requestType = "def"; }
			switch (requestType) {
			case "def":
				try {
					checkUseServicePortalPermission(request, response, employeeCode);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			  
			case "custVw":
				try {
					getServiceRequestDetailsForCustomDate(request, response, employeeCode);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "viewFv":
				try {
					getFieldAssistantVisitDetails(request, response, employeeCode);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {  
					ServiceReport filterOptions = getFilerDetails(null, null, "All", 0,  "Default");
					goToView(request, response, "VU", employeeCode, filterOptions);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	private void getFieldAssistantVisitDetails(HttpServletRequest request, HttpServletResponse response,
			String employeeCode) throws SQLException, JsonIOException, IOException { 
				String vserviceId = request.getParameter("vd0"); 
				List<ServicePortalStaffs> visitList = servicePortalDbUtil.viewCompleteVisitTimeDetails(vserviceId);
				response.setContentType("application/json");
				new Gson().toJson(visitList, response.getWriter());
		
	}

	private void getServiceRequestDetailsForCustomDate(HttpServletRequest request, HttpServletResponse response,
			String employeeCode) throws ServletException, IOException, SQLException {
		 String startDate = request.getParameter("fromdate");
		 String endDate = request.getParameter("todate");  
		 String userType = request.getParameter("usrTyp"); 
		 String  employee = request.getParameter("slc"); 
		 String  division = request.getParameter("divn"); 
		 ServiceReport filterOptions = getFilerDetails(startDate, endDate, employee, 1, division);
		
		 goToView(request, response, userType, employeeCode, filterOptions);
	}
	 
	//1.  Check the User Permission to access FJ Service Portal -- user type..
	private void checkUseServicePortalPermission(HttpServletRequest request, HttpServletResponse response, String empCode) throws IOException, ServletException { 
		try {
			ServiceRequest userDtls = servicePortalDbUtil.getUserType(empCode);	 
			if(userDtls == null) {
				response.sendRedirect("homepage.jsp");
				return;
			}else {
				String userType = userDtls.getUser_type(); 	
				String division = "Default";
				if(userType.equals("VU")) {
					division = servicePortalDbUtil.getDefaultDivisionForManager(empCode);
				}
				
				if(userType.equals("VU") || userType.equals("MU") || userType.equals("OU")){
					request.setAttribute("USRTYP", userType); 
					ServiceReport filterOptions = getFilerDetails(null, null, "All", 0,  division);
					goToView(request, response, userType, empCode, filterOptions);
				  }else {
					  response.sendRedirect("logout.jsp");
				  }
				
			}
		} catch (SQLException e) { 	
			e.printStackTrace();
			response.sendRedirect("logout.jsp");
		}finally {
			//response.sendRedirect("logout.jsp");
			}
	}  
	//   FILER DETAILS  	
	private ServiceReport getFilerDetails(String startDate, String toDate, String fieldUser, int fldStaffCount, String division) {
		ServiceReport filterOptions = null;
		if(division.equalsIgnoreCase("Default")) {
			division = "PP";
		}
		if(startDate == null || startDate.equals("") || toDate == null || toDate.equals("") ){
			int currYear = Calendar.getInstance().get(Calendar.YEAR);
			int currMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
			int currDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
			if (currMonth < 10) {
				startDate = "01/0"+currMonth+"/"+currYear;
				toDate = currDay+"/0"+currMonth+"/"+currYear;
			} else {
				startDate =  "01/"+currMonth+"/"+currYear;
				toDate = currDay+"/"+currMonth+"/"+currYear;
			}
			filterOptions = new ServiceReport(startDate, toDate, fieldUser, fldStaffCount, division);
		}else {
			filterOptions = new ServiceReport(startDate, toDate, fieldUser, fldStaffCount, division);
		}	
		return filterOptions;
	}
	
	//12. DEFAULT VIEW FOR USER, DM & MANAGMENT 
	private void goToView(HttpServletRequest request, HttpServletResponse response, String userType, String empCode, ServiceReport filterOptions) throws ServletException, IOException, SQLException { 
		if(userType.equals("VU") || userType.equals("MU") || userType.equals("OU")){ 
		List<ServiceReport> requestList = servicePortalDbUtil.getSeriveReportTableForCustDate(filterOptions);
		List<ServiceReport> holidayList = servicePortalDbUtil.getHolidayListforCustomeDateRange(filterOptions);	
		List<ServicePortalReportStaffs> filedStaffList = servicePortalDbUtil.getFieldEngineers(empCode, userType, filterOptions);
		List<ServicePortalReportStaffs> divisionList = servicePortalDbUtil.getDivisionList(userType, empCode); 
		int siteVsttedUnqFldStffCount = servicePortalDbUtil.getVisitedFieldStaffUniqueCount(filterOptions); 
		request.setAttribute("USRTYP", userType);//c
		request.setAttribute("filters", filterOptions);
		request.setAttribute("holyDYS", holidayList);    
		request.setAttribute("SRVSRPRTS", requestList);		
		request.setAttribute("FUSR", filedStaffList);	
		request.setAttribute("DIVNLST", divisionList);
		request.setAttribute("UNQFLDSTFCOUNT", siteVsttedUnqFldStffCount);// number of unique  field staff who visited the site in particular date range 
		request.setAttribute("selected_id", filterOptions.getFieldStaffList());
		request.setAttribute("SFSL", filterOptions.getFieldStaffList());
		request.setAttribute("SDIVN", filterOptions.getDivision());
		/*
		if(filterOptions.getFieldStaffList().equalsIgnoreCase("All") || filedStaffList.size() == filterOptions.getFldStaffCount() || filterOptions.getFldStaffCount() == 0 ) {
			request.setAttribute("SFSL", "All");//selected Fields Staff List
		}else {
			request.setAttribute("SFSL", servicePortalDbUtil.getFieldStaffNames(filterOptions.getFieldStaffList())); //selected Fields Staff List
		}
		*/
		RequestDispatcher dispatcher = request.getRequestDispatcher("/service/reports.jsp");			  
		dispatcher.forward(request, response);
	  }else {
		  response.sendRedirect("logout.jsp");
	  }
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			if (fjtuser == null) {
				response.sendRedirect("logout.jsp");
			} else {
				processRequest(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			if (fjtuser == null) {
				response.sendRedirect("logout.jsp");
			} else {
				processRequest(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
