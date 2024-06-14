package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import beans.HrDashbaordEmployeeCompleteDetails;
import beans.HrDashbaordEmployeeMoreDetails;
import beans.fjtcouser;
import utils.HrDashbaordDbUtil;

/**
 * Servlet implementation class HrEmployeeProfileController
 */
@WebServlet("/profile")
public class HrEmployeeProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HrDashbaordDbUtil hrDashbaordDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HrEmployeeProfileController() {
		super();
		// TODO Auto-generated constructor stub
		hrDashbaordDbUtil = new HrDashbaordDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (fjtuser.getEmp_code() == null || fjtuser.getEmp_code().length() < 7 || fjtuser.getEmp_code().length() > 7
				|| fjtuser.getEmp_code().isEmpty()) {
			response.sendRedirect("logout.jsp");
		} else {
			// String userRole = fjtuser.getRole();
			String empCode = fjtuser.getEmp_code();
			;
			String requestType = request.getParameter("action");

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
			case "upupdtls":
				try {
					updateEmployeeDetails(request, response, empCode);
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

		try {
			HrDashbaordEmployeeCompleteDetails employeeCompleteDetails = hrDashbaordDbUtil
					.employeeCompleteSelfDetails(empCode);
			request.setAttribute("COMPLTEMPDTLS", employeeCompleteDetails);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/hr/profile.jsp");
		dispatcher.forward(request, response);

	}

	private void updateEmployeeDetails(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException, SQLException {
		int successVal = 0;
		HrDashbaordEmployeeMoreDetails empMoreExisitingDetails = hrDashbaordDbUtil.getEmployeeExsistingDetails(empCode);

		String office_Mobile_Number = request.getParameter("d1");
		String emirates_Id_Number = request.getParameter("d2");
		String emirates_Id_Expiry_Date = request.getParameter("d3");
		String visa_Number = request.getParameter("d4");
		String date_Of_Issue = request.getParameter("d5");
		String visa_Expiry_Date = request.getParameter("d6");
		String uid_Number = request.getParameter("d7");
		String uID_Expiry_Date = request.getParameter("d8");
		String passport_Number = request.getParameter("d9");
		String passport_Expiry_Date = request.getParameter("d10");
		String medical_Insurance_Category = request.getParameter("d11");
		String emergency_Contact_Full_Name = request.getParameter("d12");
		String emergency_Contact_Mobile_Number = request.getParameter("d13");
		String emergency_Contact_Relationship = request.getParameter("d14");
		String end_Of_Service_Nomination = request.getParameter("d15");
		String end_Of_Service_Mobile_Number = request.getParameter("d16");
		String religion = request.getParameter("d17");
		String education1 = request.getParameter("d18");
		String education2 = request.getParameter("d19");
		String education3 = request.getParameter("d20");
		String eduDuration1 = request.getParameter("d21");
		String eduDuration2 = request.getParameter("d22");
		String eduDuration3 = request.getParameter("d23");

		HrDashbaordEmployeeMoreDetails empMoreNewDetails = new HrDashbaordEmployeeMoreDetails(empCode,
				office_Mobile_Number, emirates_Id_Number, emirates_Id_Expiry_Date, visa_Number, date_Of_Issue,
				visa_Expiry_Date, uid_Number, uID_Expiry_Date, passport_Number, passport_Expiry_Date,
				medical_Insurance_Category, emergency_Contact_Full_Name, emergency_Contact_Mobile_Number,
				emergency_Contact_Relationship, end_Of_Service_Nomination, end_Of_Service_Mobile_Number, religion,
				education1, education2, education3, eduDuration1, eduDuration2, eduDuration3);

		if (empMoreExisitingDetails == null) {
			int insertSuccesVal = hrDashbaordDbUtil.createNewEmployeeMoreDetails(empCode);
			if (insertSuccesVal == 1) {
				successVal = hrDashbaordDbUtil.updateEmployeeMoreDetails(empMoreNewDetails);

			} else {
				successVal = -2;
			}
		} else {
			successVal = hrDashbaordDbUtil.updateEmployeeMoreDetails(empMoreNewDetails);

		}

		response.setContentType("application/json");
		new Gson().toJson(successVal, response.getWriter());
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
}
