package servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Approver;
import beans.Regularise_Report;
import beans.fjtcouser;
import utils.ApproverDbUtil;
import utils.RegulariseReportDbUtil;

/**
 * Servlet implementation class BusinessTrip
 */
@WebServlet("/BusinessTripReport")
public class BusinessTrip extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ApproverDbUtil approverDbUtil;
    private RegulariseReportDbUtil regulariseReportDbUtil;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BusinessTrip() {
        super();
        // TODO Auto-generated constructor stub
    }
    public void init() throws ServletException {
        super.init();
        this.approverDbUtil = new ApproverDbUtil();
        this.regulariseReportDbUtil = new RegulariseReportDbUtil();
    }
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
            final fjtcouser fjtuser = (fjtcouser)request.getSession().getAttribute("fjtuser");
            if (fjtuser == null) {
                response.sendRedirect("logout.jsp");
            }
            else {
                this.processRequest(request, response);
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
            final fjtcouser fjtuser = (fjtcouser)request.getSession().getAttribute("fjtuser");
            if (fjtuser == null) {
                response.sendRedirect("logout.jsp");
            }
            else {
                this.processRequest(request, response);
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
	}
	protected void processRequest(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException, SQLException {
        final fjtcouser fjtuser = (fjtcouser)request.getSession().getAttribute("fjtuser");
        if (fjtuser.getEmp_code() == null) {
            response.sendRedirect("logout.jsp");
        }
        else {
            final String appr_com_code = fjtuser.getEmp_code();
            final List<Approver> theAppaiseIdList = (List<Approver>)this.approverDbUtil.getSubordinatesDetails(appr_com_code);
            request.setAttribute("SUB_NAME_LIST", (Object)theAppaiseIdList);
        }
        String theDataFromHr = request.getParameter("fjtco");
        if (theDataFromHr == null) {
            theDataFromHr = "list";
        }
        final String s;
        switch (s = theDataFromHr) {
            case "report": {
                try {
                    this.goToDisplayReport(request, response);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                return;
            }
            case "list": {
                try {
                    this.getBusinessTripReport(request, response);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                return;
            }
            default:
                break;
        }
        try {
            this.getBusinessTripReport(request, response);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
	 private void goToDisplayReport(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException, SQLException {
	        final String startdt = request.getParameter("fromdate");
	        final String enddt = request.getParameter("todate");
	        Date frmdate=Date.valueOf(startdt);
			Date todat=Date.valueOf(enddt);
	        final String[] employee_list = request.getParameterValues("slc");
	        if (employee_list.length > 0) {
	            final String emplList = String.join(",", (CharSequence[])employee_list);
	            final List<Regularise_Report> theRegularisationReportList = (List<Regularise_Report>)this.regulariseReportDbUtil.getBusinessTripReport(frmdate, todat, emplList);
	            request.setAttribute("BUSINESSTRP_LIST", (Object)theRegularisationReportList);
	        }
	        else {
	            request.setAttribute("UPDATE_MSG", (Object)"<div class=\"alert alert-info\">\r\n  <strong>Info!</strong> Please Complete Selection\r\n</div> ");
	        }
	        this.getBusinessTripReport(request, response);
	    }
	    
	    private void getBusinessTripReport(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
	        final RequestDispatcher dispatcher = request.getRequestDispatcher("/businesstrip_report.jsp");
	        dispatcher.forward((ServletRequest)request, (ServletResponse)response);
	    }

}
