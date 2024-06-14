package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import beans.Logistic;
import beans.LogisticDelivery;
import beans.SipJihDues;
import beans.fjtcouser;
import utils.LogisticDashboardDbUtil;
import utils.LogisticDeliveryDbUtil;

/**
 * Servlet implementation class LogisticDeliveryController
 */
@WebServlet("/LogisticDeliveryController")
public class LogisticDeliveryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LogisticDashboardDbUtil logisticDashboardDbUtil;
	private LogisticDeliveryDbUtil logisticDeliveryDbUtil;
	public LogisticDeliveryController() throws ServletException {
		super.init();
		logisticDashboardDbUtil = new LogisticDashboardDbUtil();
		logisticDeliveryDbUtil =  new LogisticDeliveryDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser"); 
		if (fjtuser.getEmp_code() == null || fjtuser == null) {
			response.sendRedirect("logout.jsp");
		} else {
			String userRole = fjtuser.getRole();
			String employeeCode = fjtuser.getEmp_code();
			String division = fjtuser.getEmp_divn_code();
			String empname = fjtuser.getUname();
			String requestType = request.getParameter("action");
			String deliveryType = request.getParameter("dlvryType");
		//	System.out.println(division);
			if (requestType == null) { requestType = "def"; }
			switch (requestType) {
			case "def":
				try {
				 checkUserLogisticPortalPermission(request, response, employeeCode, division, userRole, deliveryType);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updudea":// update division user data entry action
				try {
					String emailId = fjtuser.getEmailid(); 
				    updateDivisionDeliveryDetails(request, response, employeeCode, division, emailId, empname);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "upfudea":// update finance user data entry action
				try {
					String emailId = fjtuser.getEmailid(); 
				    updateFinancePoDetails(request, response, employeeCode, division, empname, emailId);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			
			case "upludea":// update logistic user data entry action
				try {
				    updateLogisticDeliveryDetails(request, response, employeeCode, division, empname);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "rmrkHstry"://  get Remarks
				try {
				    getRemarksHistory(request, response, employeeCode, division, empname);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					 checkUserLogisticPortalPermission(request, response, employeeCode, division, userRole, deliveryType);					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

 

	private void getRemarksHistory(HttpServletRequest request, HttpServletResponse response, String employeeCode,
			String division, String empname) throws JsonIOException, IOException, SQLException {
		String id = request.getParameter("d0"); 
		
		List<LogisticDelivery> details =logisticDeliveryDbUtil.getRemarksHistory(id);
		response.setContentType("application/json");
		new Gson().toJson(details,response.getWriter());  
		
	   }

	//1.  Check the User Permission to access FJ Logistic Portal -- only for 'authorised divisionn user', all finance user and all logistic user..
	private void checkUserLogisticPortalPermission(HttpServletRequest request, HttpServletResponse response, String empCode, String division, String userRole, String deliveryType) throws IOException, ServletException {
		try { 
			
			if(division.equalsIgnoreCase("FN") || division.equalsIgnoreCase("LG") || userRole.equalsIgnoreCase("mg")) {
				//System.out.println("FN LG MG");
				getDeliveryDetails(request, response, "ALL", division, empCode, deliveryType);
			}else if(logisticDeliveryDbUtil.checkDMLogisticDashbaordAccess(empCode)){
				//System.out.println("DM");
				getDeliveryDetails(request, response, "DM", division, empCode, deliveryType);
			}else {
				//System.out.println("DIVN");
				Logistic permissionData = logisticDeliveryDbUtil.getDivsionEmployeeAccessStatus(empCode);
				int permissionFlag = permissionData.getUserPermission();
				if(permissionFlag == 1) { 
					getDeliveryDetails(request, response, permissionData.getTxnCode(), division, empCode, deliveryType);
				}else{ 
					response.sendRedirect("homepage.jsp");
				}
			}   
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block			
			e.printStackTrace();
			response.sendRedirect("logout.jsp");
		}finally {
			//response.sendRedirect("logout.jsp");
			
			} 
	}
	
	//2.  update division user details.
	private void updateDivisionDeliveryDetails(HttpServletRequest request, HttpServletResponse response, String empCode, String division, String emailId, String empName) throws IOException, ServletException, SQLException {		 
			int successVal = 0, remarksDbOtn = 0;			
			if(!division.equalsIgnoreCase("FN") && !division.equalsIgnoreCase("LG") ) {
				String id = request.getParameter("podd0");
				String paymentTerm = request.getParameter("podd1");
				String paymentStatus = request.getParameter("podd2");
				String contactName = request.getParameter("podd3");
				String contactNumber = request.getParameter("podd4");
				String location = request.getParameter("podd5"); 
				
				String expDlvryDate = request.getParameter("podd6"); 
				String divRemarks = request.getParameter("podd7"); 
				String numTypVhcles = request.getParameter("podd8");  
				String invoiceNo = request.getParameter("podd10"); 
				int actionType = Integer.parseInt(request.getParameter("podd9"));   
				if(id != null && expDlvryDate != null && contactName != null && contactNumber != null && location != null && !id.isEmpty() && !expDlvryDate.isEmpty() && !contactName.isEmpty() &&  !contactNumber.isEmpty() && !location.isEmpty() ) {
					LogisticDelivery dlvryDetails = new LogisticDelivery(id, paymentTerm, paymentStatus, contactName, contactNumber, location,   expDlvryDate,  numTypVhcles, divRemarks, empCode, empName, invoiceNo);
				  if( actionType == 0 || actionType == 1 ) {
				  successVal = logisticDeliveryDbUtil.updateDeliveryDetailsByDivision(dlvryDetails);
				  }
				   
				if(successVal == 1) {
						  remarksDbOtn =  logisticDeliveryDbUtil.updateDeliveryRemarksGeneral(id, divRemarks , empCode, division ); 
						  if(remarksDbOtn == 1) {
							  logisticDeliveryDbUtil.sendmailToFinanceTeam(dlvryDetails, emailId, actionType);
							  
						  }else {
							  successVal = 0; // update not success
						  } 	 
				}else {
					successVal = 40; // logistic team already take action or entry restricted
				}  
			}else {
				successVal = 0; // update not success
			}  
			response.setContentType("text/html;charset=UTF-8");	
			response.getWriter().write(""+successVal);
		}else {
			response.setContentType("text/html;charset=UTF-8");	
			response.getWriter().write(""+successVal);
		} 
	}
	//3.  update finance user details.
		private void updateFinancePoDetails(HttpServletRequest request, HttpServletResponse response, String empCode, String division, String empName, String emailId) throws IOException, ServletException, SQLException {	 
				int successVal = 0, remarksDbOtn = 0;			
				if(division.equalsIgnoreCase("FN")) {
					String id = request.getParameter("podf0"); 
					String status = request.getParameter("podf1"); 	
					String remarks = request.getParameter("podf2"); 
					String invoiceNo = request.getParameter("podf3");  
					
					String contactName = request.getParameter("podf4");
					String contactNumber = request.getParameter("podf5");
					String location = request.getParameter("podf6"); 					
					String expDlvryDate = request.getParameter("podf7");  
					String numTypVhcles = request.getParameter("podf8");   
					LogisticDelivery dlvryDetails = new LogisticDelivery(id, status, remarks, empCode, empName, invoiceNo, contactName, contactNumber, location, expDlvryDate, numTypVhcles);
					  successVal = logisticDeliveryDbUtil.updateDeliveryDetailsByFinance(dlvryDetails); 
					  if(successVal == 1) {
						  remarksDbOtn =  logisticDeliveryDbUtil.updateDeliveryRemarksGeneral(id, remarks , empCode, division ); 
						  if(remarksDbOtn == 1 && status.equalsIgnoreCase("OK")) {
							  logisticDeliveryDbUtil.sendmailToLogisticTeam(dlvryDetails, emailId);
						  }else if(remarksDbOtn == 1 && status.equalsIgnoreCase("NOT OK")) {
							  successVal = 1;// update success
						  }else {
							  successVal = 0; // update not success
						  }  
					  }
					  response.setContentType("text/html;charset=UTF-8");	
					  response.getWriter().write(""+successVal);
				}else {
					  response.setContentType("text/html;charset=UTF-8");	
					  response.getWriter().write(""+successVal);
				}   
				 
		}
		//4.  update logistic user details.
		private void updateLogisticDeliveryDetails(HttpServletRequest request, HttpServletResponse response, String empCode, String division, String logEmpName) throws IOException, ServletException, SQLException {		 
				int successVal = 0, remarksDbOtn =  0;			
				if(division.equalsIgnoreCase("LG") ) {
					String id = request.getParameter("podl0");
					String status = request.getParameter("podl1"); 
					String remarks = request.getParameter("podl2"); 
					String invoiceNo = request.getParameter("podl3"); 	
					String divnEmpName = request.getParameter("podl4"); 
					String divnUpdatedBy = request.getParameter("podl5"); 
					LogisticDelivery dlvryDetails = new LogisticDelivery(divnEmpName, 0, id, status,  remarks, empCode,  logEmpName, invoiceNo, divnUpdatedBy);
					 if( !empCode.isEmpty() && empCode != null && empCode != "" && empCode.length() == 7 ) {
						 successVal = logisticDeliveryDbUtil.updateDeliveryDetailsByLogistic(dlvryDetails); 
						 if(successVal == 1) {
							  remarksDbOtn =  logisticDeliveryDbUtil.updateDeliveryRemarksGeneral(id, remarks , empCode, division );
							 if(remarksDbOtn == 1) {
								 remarksDbOtn = logisticDeliveryDbUtil.sendMailToDivisionTeam(dlvryDetails);
								 }else {successVal = 0;}
						 }	 
						 response.setContentType("text/html;charset=UTF-8");	
						 response.getWriter().write(""+successVal);
					 
				}else {
					  response.setContentType("text/html;charset=UTF-8");	
					  response.getWriter().write(""+successVal);
				}   
				 
		}
		}
	//4. COMPLETE DETAILS OF A DELIVERY DETAILS
	private void getDeliveryDetails(HttpServletRequest request, HttpServletResponse response, String txnCode, String divnCode, String empCode, String deliveryType) throws SQLException, ServletException, IOException {  
		List<LogisticDelivery>  poLists = null ; 		
		if(deliveryType == null || !deliveryType.equalsIgnoreCase("Y")) {deliveryType = "N";} 
		request.setAttribute("SDLVRYTYP", deliveryType); 		
		switch(txnCode) {
			case "ALL":
				try {
					poLists=  logisticDeliveryDbUtil.getCompleteDeliveryDetails(divnCode, deliveryType);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "DM":
				try {
					poLists = logisticDeliveryDbUtil.getDeliveryDetailsforTXNCodeForDM(empCode, deliveryType);	
					request.setAttribute("lgPermission", "view"); 
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					poLists = logisticDeliveryDbUtil.getDeliveryDetailsforTXNCode(empCode, deliveryType);			
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		request.setAttribute("DVRYLST", poLists); 
		RequestDispatcher dispatcher = request.getRequestDispatcher("/logistic/delivery.jsp");		
		dispatcher.forward(request, response);
		
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