package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletResponse;
import javax.servlet.ServletRequest;
import java.sql.SQLException;
import java.io.IOException;
import beans.fjtcouser;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import utils.FeedbackDbUtil;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet({ "/Feedback" })
public class FeedbackController extends HttpServlet
{
    private static final long serialVersionUID = 1L;
    private FeedbackDbUtil feedbackDbUtil;
    
    public void init() throws ServletException {
        super.init();
        this.feedbackDbUtil = new FeedbackDbUtil();
    }
    
    protected void processRequest(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException, SQLException {
        final fjtcouser fjtuser = (fjtcouser)request.getSession().getAttribute("fjtuser");
        if (fjtuser.getEmp_code() == null) {
            response.sendRedirect("logout.jsp");
        }
        else {
            final String empCode = fjtuser.getEmp_code();
            String theDataFromHr = request.getParameter("fjtco");
            if (theDataFromHr == null) {
                theDataFromHr = "view";
            }
            final String s;
            switch (s = theDataFromHr) {
                case "view": {
                    try {
                        this.getDefaultFeedbackPage(request, response);
                    }
                    catch (Exception e) {
                        e.printStackTrace();
                    }
                    return;
                }
                case "fdbackRgstn": {
                    try {
                        this.updateFeedback(request, response, empCode);
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
                this.getDefaultFeedbackPage(request, response);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    private void updateFeedback(final HttpServletRequest request, final HttpServletResponse response, final String empCode) throws ServletException, IOException, SQLException {
        final String details = request.getParameter("fdbDtls");
        final String feedbackType = request.getParameter("typ");
        final int result = this.feedbackDbUtil.inserFeedbackData(details, feedbackType, empCode);
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(new StringBuilder().append(result).toString());
    }
    
    private void getDefaultFeedbackPage(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException, SQLException {
        this.goToFeedbackPage(request, response);
    }
    
    private void goToFeedbackPage(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        final RequestDispatcher dispatcher = request.getRequestDispatcher("/feedbacks.jsp");
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
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    protected void doPost(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
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
}