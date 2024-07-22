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
import com.google.gson.reflect.TypeToken;

import beans.ServicePortalReportStaffs;
import beans.ServicePortalStaffs;
import beans.ServiceRequest;
import beans.fjtcouser;
import utils.ServicePortalDbUtil;

/**
 * @author nufail.a Servlet implementation class FJ PUMP SERVICE REQUESTS
 */

@WebServlet("/ServiceController")
public class ServicePortalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ServicePortalDbUtil servicePortalDbUtil;
	public ServicePortalController() throws ServletException {
		super.init();
		servicePortalDbUtil = new ServicePortalDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");
		} else {
			 // String userRole = fjtuser.getRole();
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
			case "prjctRef":
				try {
					getProjectRefrenceDetails(request, response);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "newSR":
				try {
					createNewServiceRequest(request, response, employeeCode);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "fldVw":
				try {
					goToFieldDetailsView(request, response,employeeCode);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "newVisit":
				try {
					addNewFieldVisit(request, response,employeeCode);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateRqst":
				try {
					updateRequestStatus(request, response,employeeCode);					
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "oview":
				try {
					getCompleteDetailsOfSingleServiceRqst(request, response, employeeCode,0);	// Complete details for View => o				
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "oupdate":
				try {
					getCompleteDetailsOfSingleServiceRqst(request, response, employeeCode,1);	// Complete details for edit/Update => 1				
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "rmvSr":
				try {
					deleteSingleServicerEquest(request, response, employeeCode);					
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
			case "rmvFv":
				try {
					deleteSingleFieldVisit(request, response, employeeCode);					
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
			default:
				try {
					ServiceRequest filterOptions = getFilerDetails(null, null, 0,  "Default");
					goToView(request, response, "FU", employeeCode, filterOptions);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	
	

	private void getFieldAssistantVisitDetails(HttpServletRequest request, HttpServletResponse response,
			String employeeCode) throws SQLException, JsonIOException, IOException { 
				String visitId = request.getParameter("vd0"); 
				List<ServicePortalStaffs> visitList = servicePortalDbUtil.viewFieldAssistantVisitDetails(visitId);
				response.setContentType("application/json");
				new Gson().toJson(visitList, response.getWriter());
		
	}

	private void getServiceRequestDetailsForCustomDate(HttpServletRequest request, HttpServletResponse response,
			String employeeCode) throws ServletException, IOException, SQLException {
		 String startDate = request.getParameter("fromdate");
		 String endDate = request.getParameter("todate");
		 int requestType = Integer.parseInt(request.getParameter("status"));
		 //System.out.println(startDate+" "+" "+endDate+" "+requestType);
		 String userType = request.getParameter("usrTyp"); 
		 String division = request.getParameter("divn");
		 ServiceRequest filterOptions = getFilerDetails(startDate, endDate, requestType, division);
		 goToView(request, response, userType, employeeCode, filterOptions);
	}
	

	//1.  Check the User Permission to access FJ Service Portal -- user type..
	private void checkUseServicePortalPermission(HttpServletRequest request, HttpServletResponse response, String empCode) throws IOException, ServletException {
		
		try {
			ServiceRequest userDtls = servicePortalDbUtil.getUserType(empCode);	
			//System.out.println("USER PRMSSN "+userDtls.getUser_type());
			if(userDtls == null) {
				response.sendRedirect("homepage.jsp");
				return;
			}else {
				String userType = userDtls.getUser_type();
				//String divn = userDtls.getDivnCode();								
				request.setAttribute("USRTYP", userType);	
				
				String division = "Default";
				if(userType.equals("VU") || userType.equals("OU")) {
					division = servicePortalDbUtil.getDefaultDivisionForManager(empCode);
				}
				// go to the  page
				ServiceRequest filterOptions = getFilerDetails(null, null, 0, division); 
				goToView(request, response, userType, empCode, filterOptions);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block			
			e.printStackTrace();
			response.sendRedirect("logout.jsp");
		}finally {
			//response.sendRedirect("logout.jsp");
			}
	}
	
	 
	
	//2.  Get Project References
	private void getProjectRefrenceDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// get stage 2 project list
		String soCodeNo = request.getParameter("cd1");
		//  System.out.println("PROJECT CODE "+soCodeNo);
		List<ServiceRequest> projectList = servicePortalDbUtil.getStage2ProjectDetails(soCodeNo);
		response.setContentType("application/json");
		new Gson().toJson(projectList, response.getWriter());

	}
	
	//3. DETAILS VIEW OF A SERVICE REQUEST
	private void goToFieldDetailsView(HttpServletRequest request, HttpServletResponse response, String empCode) throws SQLException, ServletException, IOException {
			
			String serviceHeaderId =  request.getParameter("fldid");
			String userType =  request.getParameter("userType");
			ServiceRequest singleServiceRequest= servicePortalDbUtil.getSingleSeriveRequest(serviceHeaderId, empCode);
			List<ServiceRequest>  fldVisitLists = servicePortalDbUtil.getEntryVisitofServiceRquest(serviceHeaderId, empCode);
			request.setAttribute("FLDUSRS",servicePortalDbUtil.getFieldAssistants(empCode));// field assitants
			request.setAttribute("SYSID", serviceHeaderId);
			request.setAttribute("SRVSRQST", singleServiceRequest); 
			request.setAttribute("FLDVSTLSTS", fldVisitLists);  
			request.setAttribute("USRTYP", userType);	
			RequestDispatcher dispatcher = request.getRequestDispatcher("/service/FieldStaffEntry.jsp");		
			dispatcher.forward(request, response);
		}
			
	//4.  Create New Service Request
	
	private void createNewServiceRequest(HttpServletRequest request, HttpServletResponse response, String empCode) throws ServletException, IOException, NumberFormatException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		// 1 check the user permission to create a service request
		double materialCost = 0, laborCost = 0, otherCost =0 ;
		String userType = request.getParameter("usrTyp");
		String soCodeNo = request.getParameter("_data_pcode");
		String projectName = request.getParameter("_data_pname");
		String custName = request.getParameter("_data_pcust");
		String consultName = request.getParameter("_data_pconsult");
		String location = request.getParameter("location");
		String visitType = request.getParameter("serviceTyp");
		String remarks = request.getParameter("remarks");
		String fldUsrId = request.getParameter("flduser");
		String region = request.getParameter("serviceRgion");
		String division =   servicePortalDbUtil.getDefaultDivisionForManager(empCode);
		try {
			materialCost = Double.parseDouble( request.getParameter("materialCost"));
			laborCost = Double.parseDouble( request.getParameter("laborCost"));
			otherCost = Double.parseDouble( request.getParameter("otherCost"));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		String fldUsrName = servicePortalDbUtil.getEmpNameByUid(fldUsrId);
		String ofcUsrId =  fjtuser.getEmp_code();
		String ofcUsrName =  fjtuser.getUname();
		//System.out.println(userType+" "+soCodeNo);
		
		ServiceRequest serviceDetails = new ServiceRequest(soCodeNo, projectName, custName, consultName, location, visitType, materialCost, laborCost, otherCost, remarks, ofcUsrId, ofcUsrName, fldUsrId, fldUsrName, region );
		int insertStatus  = servicePortalDbUtil.insertNewServiceRequest(serviceDetails);
		
		if(insertStatus == 1) {
			servicePortalDbUtil.sendMailToFieldEngineer(serviceDetails, fjtuser.getEmailid());
			request.setAttribute("MSG", " <div class=\"alert alert-success alert-dismissible\"> " + 
					" <button type=\"button\" class=\"close cls-btn-cust\" data-dismiss=\"alert\" aria-hidden=\"true\" >×</button> " + 
					" <span><i class=\"icon fa fa-check\"></i> Service Request Created Successfully!</span> " + 
					" </div>");
		}else {
			request.setAttribute("MSG", " <div class=\"alert alert-danger alert-dismissible\"> " + 
					" <button type=\"button\" class=\"close cls-btn-cust\" data-dismiss=\"alert\" aria-hidden=\"true\" >×</button> " + 
					" <span><i class=\"icon fa fa-exclamation-triangle\"></i> Not Inserted, Something went wrong, Please ty again later or contact IT team.</span> " + 
					" </div>"); 
		}  
		ServiceRequest filterOptions = getFilerDetails(null, null, 0, division);
		goToView(request, response, userType, empCode, filterOptions);
	}
	
	//5. Create a visit Entry against a service request  - FLD STAFF
	
	private void addNewFieldVisit(HttpServletRequest request, HttpServletResponse response, String employeeCode) throws IOException {
	  	 String requestId = request.getParameter("vd0");
   	 String checkIn = request.getParameter("vd1");
   	 String checkOut = request.getParameter("vd2");// task type
   	 String remark = request.getParameter("vd3");// task description.
   	 String visitDate = request.getParameter("vd4");
   	 int fieldVisitStatus = Integer.parseInt(request.getParameter("vd5"));
   	 int noAssistants = Integer.parseInt(request.getParameter("vd6"));
   	 int totMinutes = Integer.parseInt(request.getParameter("vd7"));  	 
   	 String asstntVstDetails = request.getParameter("vd8");
   	 int fldEngnrHrlyRate = Integer.parseInt(request.getParameter("vd9")); 
   	
   //	System.out.println("dtls "+asstntVstDetails);
    Gson gson = new Gson(); 
   	List<ServicePortalStaffs> assistantVisitsList = gson.fromJson(asstntVstDetails, new TypeToken<List<ServicePortalStaffs>>() {}.getType());
   	
   // int assistantCount = assistantVisitsList.size(); 
   // System.out.println("Assistant Count "+assistantCount);
    
   	 int successVal = 0;
   	 ServiceRequest visit_Details =new ServiceRequest(requestId, checkIn, checkOut, remark, noAssistants, visitDate, fieldVisitStatus, employeeCode, totMinutes, fldEngnrHrlyRate);
   	 //System.out.println("Field Visit Ststus = "+fieldVisitStatus);
   	 if(fieldVisitStatus == 1) {
   		 // field  visit completed for the particular service request ID.....     
   		 successVal = servicePortalDbUtil.updateFieldVistStusInMasterTable(requestId, fieldVisitStatus);
   		 //System.out.println("Master table update sttus = "+successVal);
   		 if(successVal == 1) {
   			 successVal = updateFieldVisitEntryInMasterAndTxn(visit_Details, assistantVisitsList);
   			// System.out.println("FLD VST table update status C = "+successVal);
   		 }
   	 }else {
   		// field visit not completed/Continue.. for the particular service request ID.
   		 successVal = updateFieldVisitEntryInMasterAndTxn(visit_Details, assistantVisitsList);
   		 //System.out.println("FLD VST table update status NC = "+successVal);
   		 
   	 }
   	 
	    response.setContentType("text/html;charset=UTF-8");	
	   	response.getWriter().write(""+successVal);
		
	}
	private int updateFieldVisitEntryInMasterAndTxn(ServiceRequest visit_Details, List<ServicePortalStaffs> assistantVisitsList) {
		int updateOptn = 0;
		ServicePortalStaffs insertOptnFirst = servicePortalDbUtil.insertNewFieldVisit(visit_Details);
		if(insertOptnFirst.getVisitOptnFlag() == 1 && insertOptnFirst.getVisitDtlsId() > 0) {
			updateOptn = servicePortalDbUtil.updateFieldVistStusInMasterTableForAll(insertOptnFirst.getVisitDtlsId(), visit_Details); // if return value 1, then success update & insert optn
			if(updateOptn == 1 && assistantVisitsList.size() > 0  ) {
				int updateAsstntVstsOptn = servicePortalDbUtil.updateAssitantVstsTxn(insertOptnFirst.getVisitDtlsId(), visit_Details.getVisitDate(), assistantVisitsList);
	   			//System.out.println("Master update optn =  "+updateOptn+" Asstnt visit oprn = "+updateAsstntVstsOptn );
	   			if(updateAsstntVstsOptn != assistantVisitsList.size()) {
	   				try {
	   					updateOptn = 0;// set the fld vst oprtion value to zero then delete the master fld visit
						int deleteOptn = servicePortalDbUtil.deleteFieldVisit(visit_Details.getId()+"", insertOptnFirst.getVisitDtlsId()+"", visit_Details.getFieldUserId());
						System.out.println("deleting fld visit master id "+insertOptnFirst.getVisitDtlsId()+"due failed  fld asstnt vst txn insertion optn response "+deleteOptn);
					} catch (SQLException e) {
						System.out.println("Error while deleting fld visit master id due failed  fld asstnt vst txn insertion");
						e.printStackTrace();
					}
	   			}
	   		 }

   			return updateOptn;
		}else {
			 return updateOptn;// optn not success
		} 
		
		
	}
		
	//6. COMPLETE DETAILS OF A SINGLE  SERVICE REQUEST
	private void getCompleteDetailsOfSingleServiceRqst(HttpServletRequest request, HttpServletResponse response, String empCode,int editSatus) throws SQLException, ServletException, IOException {
		String serviceHeaderId =  request.getParameter("rqid");
		String userType = request.getParameter("usrTyp");
		ServiceRequest singleServiceRequest = null;
		//log("EDIT/UPDATE STATUS "+editSatus);
		if(userType.equals("VU")) {
			singleServiceRequest= servicePortalDbUtil.getSingleSeriveRequestForViewUser(serviceHeaderId);
		}else {
			/*
			if(editSatus == 1) {
				request.setAttribute("FSRATES", servicePortalDbUtil.getHourlyRateFieldStaffs());
			}
			*/
			singleServiceRequest= servicePortalDbUtil.getSingleSeriveRequestForOfficeStaff(serviceHeaderId, empCode);
		}
		List<ServiceRequest>  fldVisitLists = servicePortalDbUtil.getEntryVisitofServiceRquestForOffcStaff(serviceHeaderId);
		request.setAttribute("SYSID", serviceHeaderId);
		request.setAttribute("SRVSRQST", singleServiceRequest); 
		request.setAttribute("FLDVSTLSTS", fldVisitLists); 
		request.setAttribute("USRTYP", userType);
		request.setAttribute("FLDUSRS",servicePortalDbUtil.getFieldAssistants(empCode));// field user list with hrly allowance
		RequestDispatcher dispatcher = request.getRequestDispatcher("/service/OfficeStaffEntry.jsp");		
		dispatcher.forward(request, response);
		
	}

	
	//7.  DELETE  Service Request
	private void deleteSingleServicerEquest(HttpServletRequest request, HttpServletResponse response,
			String employeeCode) throws SQLException, ServletException, IOException { 
		String serviceHeaderId =  request.getParameter("rqid");
		String userType = request.getParameter("usrTyp"); 
		String division = servicePortalDbUtil.getDefaultDivisionForManager(employeeCode);
		int deleteStatus  = servicePortalDbUtil.deleteServiceRqst(serviceHeaderId, employeeCode);
		
		if(deleteStatus == 1) {
			
			request.setAttribute("MSG", " <div class=\"alert alert-success alert-dismissible\"> " + 
					" <button type=\"button\" class=\"close cls-btn-cust\" data-dismiss=\"alert\" aria-hidden=\"true\" >×</button> " + 
					" <span><i class=\"icon fa fa-check\"></i> Service Request Deleted Successfully!</span> " + 
					" </div>");
		}else {
			request.setAttribute("MSG", " <div class=\"alert alert-danger alert-dismissible\"> " + 
					" <button type=\"button\" class=\"close cls-btn-cust\" data-dismiss=\"alert\" aria-hidden=\"true\" >×</button> " + 
					" <span><i class=\"icon fa fa-exclamation-triangle\"></i> Not Deleted, Something went wrong, Please ty again later or contact IT team.</span> " + 
					" </div>"); 
		}
		request.setAttribute("USRTYP", userType);				
		// go to the  page
		ServiceRequest filterOptions = getFilerDetails(null, null, 2, division);
		goToView(request, response, userType, employeeCode, filterOptions);
	}

	  
	
	//8.  Delete a visit entry  - FLD STAFF
	private void deleteSingleFieldVisit(HttpServletRequest request, HttpServletResponse response, String employeeCode) throws SQLException, ServletException, IOException { 
		
		int deleteStatus = -2;
		String serviceHeaderId =  request.getParameter("vd0");
		String visitId =  request.getParameter("vd1");
		String userType = request.getParameter("vd2");
		int noOfAsstnts = Integer.parseInt(request.getParameter("vd3"));
		//System.out.println("FIELD DLT FUNCTION"+userType);
		//System.out.println("FIELD DLT FUNCTION, no of assitants = "+noOfAsstnts);
		if(userType.equals("FU")) {
	   
	    if( noOfAsstnts > 0) {
	    	int asstDeleteStatus = servicePortalDbUtil.deleteFieldAssistantVisit(visitId);
	    	//System.out.println("FLD VST ASSTNTS Entries delte status = "+asstDeleteStatus);
	    	if(asstDeleteStatus == noOfAsstnts) {
	    		deleteStatus  = servicePortalDbUtil.deleteFieldVisit(serviceHeaderId, visitId, employeeCode);
	    	}
	    }else {
	    	 deleteStatus  = servicePortalDbUtil.deleteFieldVisit(serviceHeaderId, visitId, employeeCode);
	    }
	    
		}
	    response.setContentType("text/html;charset=UTF-8");	
	   	response.getWriter().write(""+deleteStatus);
	}
	
	//9. UPDATE A VST & RQST STATUS  BY OFFICE STAFF - LAYER -3
	private void updateRequestStatus(HttpServletRequest request, HttpServletResponse response, String employeeCode) throws IOException {
		 String requestId = request.getParameter("rd0");
   	 double materialCost = Double.parseDouble(request.getParameter("rd1"));
   	 double laborCost = Double.parseDouble(request.getParameter("rd2")); 
   	 double otherCost = Double.parseDouble(request.getParameter("rd3")); 
   	 String remark = request.getParameter("rd4");  
   	 int offcFinaltatus = Integer.parseInt(request.getParameter("rd5")); 
   	 int successVal = 0;
   	 int fldStatus = 1;
   	 ServiceRequest finslRqst_Details =new ServiceRequest(requestId, materialCost, laborCost, otherCost, remark,   offcFinaltatus, employeeCode);
   	 if(offcFinaltatus == 2) {
   		  // Transfer Request FROM FLD STAFF TO OFFICE STAF -   - FLD_STATUS = 0 AND  FINAL_STATUS = 2
   		 // return to field user for more confirmation  
   		 // update fldstatus = 0 
   		 fldStatus = 0;
   		 successVal = servicePortalDbUtil.updateFinalRqstStusInMasterTable(fldStatus, finslRqst_Details );
   		 
   	 }else if(offcFinaltatus == 1){
   		// REQUEST STATUS  COMPLETED BY OFFICE STAFF , FINAL_STATUS = 1
   		 fldStatus = 1;
   		 successVal = servicePortalDbUtil.updateFinalRqstStusInMasterTable(fldStatus, finslRqst_Details );
   	 }else {
   		 successVal = 0;
   	 }
   	 
	    response.setContentType("text/html;charset=UTF-8");	
	   	response.getWriter().write(""+successVal);
		
	}

	  
	
	
	//11.  FILER DETAILS  
	
	private ServiceRequest getFilerDetails(String startDate, String toDate, int filterStatus, String division) {
		ServiceRequest filterOptions = null; 
		if(division.equalsIgnoreCase("Default")) {
			division = "PP";
		}
		if(startDate == null || startDate.equals("") || toDate == null || toDate.equals("") ){
			int currYear = Calendar.getInstance().get(Calendar.YEAR);
			int currMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
			int currDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
			if (currMonth < 10) {
				 startDate = "01/01/"+currYear;
				 toDate = currDay+"/0"+currMonth+"/"+currYear;
			} else {
				 startDate = "01/01/"+currYear;
				 toDate = currDay+"/"+currMonth+"/"+currYear;
			} 
		} 
	   filterOptions = new ServiceRequest(startDate, toDate, filterStatus, division ); 
	   return filterOptions;
	}
	
	//12. DEFAULT VIEW FOR USER, DM & MANAGMENT 
	private void goToView(HttpServletRequest request, HttpServletResponse response, String userType, String empCode, ServiceRequest filterOptions) throws ServletException, IOException, SQLException { 
		RequestDispatcher dispatcher;
		List<ServiceRequest> requestList;   
		List<ServicePortalReportStaffs> divisionList = servicePortalDbUtil.getDivisionList(userType, empCode); 
		switch(userType) {
		case "VU" : 
					requestList = servicePortalDbUtil.getSeriveRequestList(filterOptions);
					dispatcher = request.getRequestDispatcher("/service/OfficeStaffHome.jsp");
					break;
		case "MU" : 
			requestList = servicePortalDbUtil.getSeriveRequestList(filterOptions);
			dispatcher = request.getRequestDispatcher("/service/OfficeStaffHome.jsp");
			break;
					
		case "OU":	// OU CAN SEE ALL SERVICE REQUEST CREATED BY OTHER OU
					requestList = servicePortalDbUtil.getSeriveRequestListOfficeUser(empCode, filterOptions);
					request.setAttribute("RGNS",servicePortalDbUtil.getRegions());
					request.setAttribute("FLDUSRS",servicePortalDbUtil.getFldEngineersList(empCode));// main field staff who assign field labours
					request.setAttribute("VTYPES", servicePortalDbUtil.getVisitType());
					dispatcher = request.getRequestDispatcher("/service/OfficeStaffHome.jsp");
					break;
					
		case "FU":	
					requestList = servicePortalDbUtil.getSeriveRequestListFieldUser(empCode, filterOptions);
					dispatcher = request.getRequestDispatcher("/service/FieldStaffHome.jsp");
					break;
					
		default:	
					requestList = null;
					dispatcher = request.getRequestDispatcher("/service/OfficeStaffHome.jsp");
					break;
		}
		request.setAttribute("USRTYP", userType);
		request.setAttribute("filters", filterOptions);
		request.setAttribute("SRVSRQSTS", requestList); 
		request.setAttribute("SDIVN", filterOptions.getDivnCode());
		request.setAttribute("DIVNLST", divisionList);
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
