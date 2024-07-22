// 
// Decompiled by Procyon v0.5.36
// 

package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletResponse;
import javax.servlet.ServletRequest;
import java.util.Calendar;
import beans.AppraisalReport;
import java.util.List;
import beans.fjtcouser;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import utils.AppraisalReportDbUtil;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet({ "/AppraisalReport" })
public class AppraisalReportController extends HttpServlet
{
    private static final long serialVersionUID = 1L;
    private AppraisalReportDbUtil appraisalReportDbUtil;
    
    public AppraisalReportController() {
        this.appraisalReportDbUtil = new AppraisalReportDbUtil();
    }
    
    protected void processRequest(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        final fjtcouser emp_id = (fjtcouser)request.getSession().getAttribute("fjtuser");
        if (emp_id.getEmp_code() == null || emp_id.getEmp_code().isEmpty()) {
            response.sendRedirect("logout.jsp");
        }
        String theDataFromHr = request.getParameter("fjtco");
        if (theDataFromHr == null) {
            theDataFromHr = "list";
        }
        final String s;
        switch (s = theDataFromHr) {
            case "list": {
                try {
                    System.out.println("defalt pge");
                    this.defaultAppraisalReport(request, response);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                return;
            }
            case "gdlfc": {
                try {
                    System.out.println("by cc for div");
                    this.getDivisionListByCompanyCode(request, response);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                return;
            }
            case "fjaprslrprt": {
                try {
                    System.out.println("appraisal Report");
                    this.divisiontAppraisalReport(request, response);
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
            this.goToAppraisalReport(request, response);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void getDivisionListByCompanyCode(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        final String selected_cmp_code = request.getParameter("comp_code_sel");
        request.setAttribute("selected_cmp_code", (Object)selected_cmp_code);
        final List<AppraisalReport> theAppraisalRprtList = (List<AppraisalReport>)this.appraisalReportDbUtil.getDivisionList(selected_cmp_code);
        request.setAttribute("DVN_LIST", (Object)theAppraisalRprtList);
        final List<AppraisalReport> theAppraisalYearsList = (List<AppraisalReport>)this.appraisalReportDbUtil.getAppraisalYear();
        request.setAttribute("APRYR", (Object)theAppraisalYearsList);
        this.companyList(request, response);
        this.goToAppraisalReport(request, response);
    }
    
    private void defaultAppraisalReport(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        this.companyList(request, response);
        this.goToAppraisalReport(request, response);
    }
    
    private void companyList(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        final List<AppraisalReport> theAppraisalRprtList = (List<AppraisalReport>)this.appraisalReportDbUtil.getCompanyList();
        System.out.println("company list" + theAppraisalRprtList);
        request.setAttribute("CMPNY_LIST", (Object)theAppraisalRprtList);
    }
    
    private void divisiontAppraisalReport(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        String year1 = new StringBuilder(String.valueOf(Calendar.getInstance().get(1))).toString();
        final String division = request.getParameter("aprdivn");
        System.out.println("Division " + division);
        final String company = request.getParameter("aprcmp");
        request.setAttribute("selectedDiv", (Object)division);
        if (request.getParameter("syr") != null) {
            year1 = request.getParameter("syr");
        }
        final List<AppraisalReport> theDivnList = (List<AppraisalReport>)this.appraisalReportDbUtil.getDivisionList(company);
        request.setAttribute("DVN_LIST", (Object)theDivnList);
        final List<AppraisalReport> theAppraisalYearsList = (List<AppraisalReport>)this.appraisalReportDbUtil.getAppraisalYear();
        request.setAttribute("APRYR", (Object)theAppraisalYearsList);
        this.companyList(request, response);
        request.setAttribute("selected_cmp_code", (Object)company);
        request.setAttribute("selected_divnLst", (Object)division);
        request.setAttribute("selected_apyear", (Object)year1);
        final List<AppraisalReport> theAppraisalRprtList = (List<AppraisalReport>)this.appraisalReportDbUtil.getReportDetailsAllEmployee(year1, division, company);
        System.out.println("company list" + theAppraisalRprtList);
        request.setAttribute("HR_APPR_LIST", (Object)theAppraisalRprtList);
        this.goToAppraisalReport(request, response);
    }
    
    private void goToAppraisalReport(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        final RequestDispatcher dispatcher = request.getRequestDispatcher("/appraisalreport.jsp");
        dispatcher.forward((ServletRequest)request, (ServletResponse)response);
    }
    
    protected void doGet(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        try {
            final fjtcouser fjtuser = (fjtcouser)request.getSession().getAttribute("fjtuser");
            if (fjtuser == null) {
                response.sendRedirect("logout.jsp");
            }
            else {
                this.processRequest(request, response);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    protected void doPost(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        final fjtcouser fjtuser = (fjtcouser)request.getSession().getAttribute("fjtuser");
        if (fjtuser == null) {
            response.sendRedirect("logout.jsp");
        }
        else {
            try {
                this.processRequest(request, response);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
