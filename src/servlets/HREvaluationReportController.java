package servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.json.JSONException;
//import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import beans.HrEvaluationCategory;
import beans.HrEvaluationDetails;
//import beans.HrEvaluationDetails;
import beans.HrEvaluationRating;
import beans.HrEvaluationReport;
import beans.HrEvaluationSettings;
import beans.HrEvaluationUserProfile;
import beans.fjtcouser;
import utils.HrEvaluationDbUtil;

/**
 * Servlet implementation class HREvaluationReportController
 */
@WebServlet(name = "EvaluationReport", urlPatterns = { "/EvaluationReport" })
public class HREvaluationReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HrEvaluationDbUtil hrEvaluationDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HREvaluationReportController() {
		super();
		// TODO Auto-generated constructor stub
		hrEvaluationDbUtil = new HrEvaluationDbUtil();
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
			String dmCode = fjtuser.getEmp_code();
			String dmName = fjtuser.getUname();
			String employeeCode = "";
			String requestType = request.getParameter("action");

			if (requestType == null) {
				requestType = "def";
			}
			switch (requestType) {
			case "def":
				try {
					goToView(request, response, dmCode, dmCode, dmName);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "viewUsrEvlDtls":
				try {// in the employee report,details,click xlsx report.
					getEmployeeEvaluationProfile(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "viewMangmentGeneralReport":
				try {// if hr login, she can view final report of all employees
					getEmployeeEvaluationGeneralReport(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "newEvlYrDtls":// when selects a perticular year and click on view
				goToCustView(request, response, dmCode, dmCode, dmName);
				break;
			default:
				try {
					goToView(request, response, dmCode, employeeCode, dmName);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void getEmployeeEvaluationGeneralReport(HttpServletRequest request, HttpServletResponse response,
			String dmCode) throws ServletException, IOException, SQLException {
		// String employeeCode = request.getParameter("hr0");
		int evaluationYear = Integer.parseInt(request.getParameter("hr1"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr2"));
		List<HrEvaluationReport> reportList = hrEvaluationDbUtil.getEvaluationReportForManagment(evaluationYear,
				evaluationTerm);

		response.setContentType("application/json");
		new Gson().toJson(reportList, response.getWriter());

	}

	private void getEmployeeEvaluationProfile(HttpServletRequest request, HttpServletResponse response, String dmCode)
			throws ServletException, IOException, SQLException {
		String employeeCode = request.getParameter("hr0");
		int evaluationYear = Integer.parseInt(request.getParameter("hr1"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr2"));
		// System.out.println(employeeCode+" "+dmCode);
		HrEvaluationUserProfile userProfile = hrEvaluationDbUtil.employeeUserProfile(employeeCode);
		List<HrEvaluationCategory> allCategoryContents = hrEvaluationDbUtil
				.getCompleteCategoryContentForReport(employeeCode, evaluationYear, evaluationTerm);
		HrEvaluationDetails generalComments = hrEvaluationDbUtil.getGeneralCommentsForReports(employeeCode,
				evaluationYear, evaluationTerm);

		String json1 = new Gson().toJson(userProfile);
		String json2 = new Gson().toJson(allCategoryContents);
		String json3 = new Gson().toJson(generalComments);

		JsonObject jsonObj = new JsonObject();
		jsonObj.addProperty("Profile", json1);
		jsonObj.addProperty("Category", json2);
		jsonObj.addProperty("General", json3);

		response.setContentType("application/json");
		new Gson().toJson(jsonObj, response.getWriter());

	}

	private void goToCustView(HttpServletRequest request, HttpServletResponse response, String dmCode,
			String employeeCode, String employeeName) throws ServletException, IOException {
		int evaluationYear = Integer.parseInt(request.getParameter("evlYr"));
		int evaluationTerm = Integer.parseInt(request.getParameter("evlTerm"));
		Date currentDate = new Date(evaluationTerm);
		HrEvaluationSettings settings = new HrEvaluationSettings(evaluationYear, currentDate, currentDate,
				evaluationTerm, 0);
		try {

			// int totalScore = 0;
			List<HrEvaluationUserProfile> employeeLists = hrEvaluationDbUtil.employeeListForReport(dmCode);
			List<HrEvaluationSettings> evaluationYrLists = hrEvaluationDbUtil.getPreviuosEvaluationYears();
			int evalutionManagerOrNot = employeeLists.size();// if 1 evl manager permission, if 0 only self evaluation

			HrEvaluationUserProfile loggedEmployee = new HrEvaluationUserProfile(employeeCode, employeeName);
			employeeLists.add(loggedEmployee);

			HrEvaluationUserProfile userProfile = hrEvaluationDbUtil.employeeUserProfile(employeeCode);
			request.setAttribute("EMPLST", employeeLists);
			request.setAttribute("EVLMNGRORNOT", evalutionManagerOrNot);
			request.setAttribute("PROFILE", userProfile);
			request.setAttribute("selected_subordinate", employeeCode);
			if (settings != null) {
				List<HrEvaluationRating> ratings = hrEvaluationDbUtil.evaluationRatings();
				List<HrEvaluationCategory> categoryWiseSummary = hrEvaluationDbUtil.employeeEvaluationSummaryForManager(
						employeeCode, settings.getEvaluationYear(), settings.getEvaluationTerm());
				request.setAttribute("EVLRATINGS", ratings);
				request.setAttribute("EVLSETTINGS", settings);
				request.setAttribute("EVLCATSUMMRY", categoryWiseSummary);
			}
			request.setAttribute("selectedTerm", settings.getEvaluationTerm());
			request.setAttribute("selectedEvlYear", settings.getEvaluationYear());
			request.setAttribute("EVLYRS", evaluationYrLists);
			request.setAttribute("EMPSCATGRYSCORE", getEmployeesCategoryScore(employeeLists,
					settings.getEvaluationYear(), settings.getEvaluationTerm()));

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/hr/report.jsp");
		dispatcher.forward(request, response);

	}

	private void goToView(HttpServletRequest request, HttpServletResponse response, String dmCode, String employeeCode,
			String employeeName) throws ServletException, IOException {

		HrEvaluationSettings settings = null;
		try {
			settings = hrEvaluationDbUtil.hrEvaluationSettings();
			// int totalScore = 0;
			List<HrEvaluationUserProfile> employeeLists = hrEvaluationDbUtil.employeeListForReport(dmCode);
			List<HrEvaluationSettings> evaluationYrLists = hrEvaluationDbUtil.getPreviuosEvaluationYears();
			int evalutionManagerOrNot = employeeLists.size();// if 1 evl manager permission, if 0 only self evaluation

			HrEvaluationUserProfile loggedEmployee = new HrEvaluationUserProfile(employeeCode, employeeName);
			employeeLists.add(loggedEmployee);

			HrEvaluationUserProfile userProfile = hrEvaluationDbUtil.employeeUserProfile(employeeCode);
			request.setAttribute("EMPLST", employeeLists);
			request.setAttribute("EVLMNGRORNOT", evalutionManagerOrNot);
			request.setAttribute("PROFILE", userProfile);
			request.setAttribute("selected_subordinate", employeeCode);
			if (settings != null) {
				List<HrEvaluationRating> ratings = hrEvaluationDbUtil.evaluationRatings();
				List<HrEvaluationCategory> categoryWiseSummary = hrEvaluationDbUtil.employeeEvaluationSummaryForManager(
						employeeCode, settings.getEvaluationYear(), settings.getEvaluationTerm());
				request.setAttribute("EVLRATINGS", ratings);
				request.setAttribute("EVLSETTINGS", settings);
				request.setAttribute("EVLCATSUMMRY", categoryWiseSummary);
			}
			request.setAttribute("selectedTerm", settings.getEvaluationTerm());
			request.setAttribute("selectedEvlYear", settings.getEvaluationYear());
			request.setAttribute("EVLYRS", evaluationYrLists);
			request.setAttribute("EMPSCATGRYSCORE", getEmployeesCategoryScore(employeeLists,
					settings.getEvaluationYear(), settings.getEvaluationTerm()));

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/hr/report.jsp");
		dispatcher.forward(request, response);

	}

	private List<HrEvaluationReport> getEmployeesCategoryScore(List<HrEvaluationUserProfile> employeeLists,
			int evaluationYear, int evaluationTerm) throws SQLException {
		Iterator<HrEvaluationUserProfile> itr = employeeLists.iterator();

		List<HrEvaluationReport> categoryList = new ArrayList<>();
		while (itr.hasNext()) {
			HrEvaluationUserProfile sub = (HrEvaluationUserProfile) itr.next();
			HrEvaluationReport categoryContent = hrEvaluationDbUtil.getSingleEmployeeCategoryScore(sub.getEmpCode(),
					sub.getEmpName(), evaluationYear, evaluationTerm);
			categoryList.add(categoryContent);
		}
		return categoryList;
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
