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

import beans.ProjectStatusDetails;
import beans.fjtcouser;
import utils.ProjectStatusDbUtil;

/**
 * Servlet implementation class ProjectStatus
 */
@WebServlet("/ProjectStatus")
public class ProjectStatusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProjectStatusDbUtil projectStatusDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProjectStatusController() {
		super();
		projectStatusDbUtil = new ProjectStatusDbUtil();
		// TODO Auto-generated constructor stub
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (fjtuser.getEmp_code() == null) {
			// only access for users who have sales code
			response.sendRedirect("logout.jsp");
		} else {

			String requestType = request.getParameter("action");
			String empCode = fjtuser.getEmp_code();

			if (requestType == null) {
				requestType = "def";
			}
			switch (requestType) {
			case "def":
				try {
					goToView(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToView(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void goToView(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException {
		List<ProjectStatusDetails> projectStatusDetails = null;
		try {
			projectStatusDetails = projectStatusDbUtil.getProjectStatusDetails();
//			if (fjtuser.getRole().equalsIgnoreCase("mg") || fjtuser.getRole().equalsIgnoreCase("mkt")) {
//				projectStatusDetails = projectStatusDbUtil.getProjectStatusDetails();
//			} else {
//				projectStatusDetails = projectStatusDbUtil.getProjectStatusDetails(empCode);
//			}
			request.setAttribute("COMPLTEMPDTLS", projectStatusDetails);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/projectStatus.jsp");
		dispatcher.forward(request, response);

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
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
