package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import beans.HrRegularisationCorrection;
import beans.SipJihDues;
import beans.fjtcouser; 
import utils.HrRegularisationCorrectionDbUtil;

/**
 * Servlet implementation class HrRegularisationCorrectionController
 */
@WebServlet("/HrRegularisationCorrectionController")
public class HrRegularisationCorrectionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HrRegularisationCorrectionDbUtil hrRegularisationCorrectionDbUtil;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HrRegularisationCorrectionController() {
        super();
        // TODO Auto-generated constructor stub
        hrRegularisationCorrectionDbUtil =  new HrRegularisationCorrectionDbUtil();
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null ||  !( fjtuser.getRole().equalsIgnoreCase("hr") || fjtuser.getRole().equalsIgnoreCase("hrmgr") ) ) {
			response.sendRedirect("logout.jsp");
		} else {
			String theDataFromHr = request.getParameter("action");
			if (theDataFromHr == null) {
				theDataFromHr = "view";
			}
			switch (theDataFromHr) {
			case "view":
				try {
					goToView(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "getRegDetails":
				try {
					getDetails(request, response, fjtuser.getEmp_code());
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "validateEmployee":
				try {
					getEmployeeDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToView(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}
    private void getEmployeeDetails(HttpServletRequest request, HttpServletResponse response) throws JsonIOException, IOException { 
		String empCode = request.getParameter("id"); 
		String empName = hrRegularisationCorrectionDbUtil.validateIdandGetEmpName(empCode); 
		String message = "";
		if(empName == null || empName.isEmpty()) {
			message = "<div class=\"alert alert-danger alert-dismissible fade in\" >\r\n" + 
					 "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"+
				     "<strong>Employee code '"+empCode+"' is not valid or inactive!</strong></div>";
		}else {
			message = "<div class=\"alert alert-success alert-dismissible fade in\" >\r\n"+
					 "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"+
					"<strong>Employee Name :  "+empName+"!</strong></div>";
		}
		new Gson().toJson(message,response.getWriter());  
		
	}
	private void getDetails(HttpServletRequest request, HttpServletResponse response, String hrEmpCode) throws ServletException, IOException, SQLException, ParseException {
		String empCode = request.getParameter("empCode");
		String datetoregularise = request.getParameter("datetoregularise"); 
		String reason = request.getParameter("reason");  
		String message = "";
		HrRegularisationCorrection finalOut = null, dtlForRegltn = null;
		int regStatus = 0, alreadyRegularised = -1; 
		
		if(!empCode.isEmpty() && empCode.length() == 7 && hrRegularisationCorrectionDbUtil.validateEmployee(empCode)) {
				
				  
				alreadyRegularised = hrRegularisationCorrectionDbUtil.isAlreadyRegularisationRequestSend(empCode, datetoregularise );   
		
				if (alreadyRegularised == 0 && empCode != null   && !empCode.isEmpty() && empCode.length() == 7 && datetoregularise != null   && !datetoregularise.isEmpty() && reason != null   && !reason.isEmpty()) { 
					HrRegularisationCorrection empApprDetails = hrRegularisationCorrectionDbUtil.getEmployeeApproverDetails(empCode);
					
			if(!(hrRegularisationCorrectionDbUtil.checkDateToRegulariseHaveAlreadyLeave(empCode, datetoregularise, empApprDetails.getCompanyCode())) && !(hrRegularisationCorrectionDbUtil.checkDateToRegulariseHaveHoliday(empApprDetails.getCompanyCode(), datetoregularise))) {
							if(empApprDetails != null) { 
							     boolean regularisationRqrdStatus = false;
								// get start time and end time for that day
								  //1. start of Day  time
								       Time startDayTime =  hrRegularisationCorrectionDbUtil.getStaffDayStartValuesOfTheMonth(datetoregularise, empApprDetails.getCompanyCode() );
								  //2. end of Day time
								       Time endDayTime =  hrRegularisationCorrectionDbUtil.getStaffDayEndValuesOfTheMonth(datetoregularise, empApprDetails.getCompanyCode());
								  //3. get actual in-out by employee  in DB Util 
								  //4. compare the timing with actual
								       regularisationRqrdStatus = hrRegularisationCorrectionDbUtil.getDayStatusByCalculation(empCode, datetoregularise, startDayTime, endDayTime);
						       
						       
							if(empApprDetails != null && regularisationRqrdStatus) {
								dtlForRegltn = new HrRegularisationCorrection(empApprDetails.getEmployeeCode(), empApprDetails.getEmployeeName(), empApprDetails.getApproverCode(), empApprDetails.getApproverName(), datetoregularise, reason, hrEmpCode, empApprDetails.getCompanyCode(), empApprDetails.getAccessCrd() );
								regStatus = hrRegularisationCorrectionDbUtil.insertRegularisation(dtlForRegltn);
								if(regStatus == 1) {
									message = "Regularisation sent successfully";
								}else if(regStatus == -1){
									message = "Not regularised, Error in sending mail,  Please inform IT department";
								}else {
									message = "Regularisation Not send, Please try later";
								}
							}else if(!regularisationRqrdStatus && empApprDetails != null ){
								message = "Atendance status is Present,  Regularisation not required";
							}else { 
								message = "Approver details not available"; 
							}
							
							}else {
								message = "Employee code is not  valid...";
							}
					
					}else {
						message = "Regularaisation not required, selected date is Leave/Holiday";
					}
				}else if( empCode != null   && !empCode.isEmpty() && (empCode.length() < 7 || empCode.length() > 7)) {
					message = "Employee code is not valied...";
				}else if( datetoregularise == null  || datetoregularise.isEmpty()) {
					message = "Please Select correct date to regularise..";
				}else if( reason == null  || reason.isEmpty()) {
					message = "Please enter a  reason..";
				}   else {
					message = "Already submitted regularaisation request";
				}
				
				
				
		
		
		
		}else {
			message = "Employee code  is not valid or inactive!";
		}
		
		if(dtlForRegltn == null) {
		 finalOut =  new HrRegularisationCorrection(datetoregularise, reason,  empCode, "", "", "","", "","",  hrEmpCode, regStatus, message);
		}else {
			 finalOut =  new HrRegularisationCorrection(datetoregularise, reason, dtlForRegltn.getEmployeeCode(), dtlForRegltn.getEmployeeName(), dtlForRegltn.getApproverCode(),dtlForRegltn.getApproverName() ,
						dtlForRegltn.getCompanyCode(), dtlForRegltn.getAccessCrd(), "applieddate", hrEmpCode, regStatus, message);
		}
		request.setAttribute("REGOUT", finalOut);
		goToView(request, response);

	}
    private void goToView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher = request.getRequestDispatcher("/hr_regularisation_correction.jsp");
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
