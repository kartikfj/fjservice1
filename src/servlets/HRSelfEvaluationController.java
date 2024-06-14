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

import beans.HrEvaluationCategory;
import beans.HrEvaluationDetails;
import beans.HrEvaluationOperations;
import beans.HrEvaluationRating;
import beans.HrEvaluationSettings;
import beans.HrEvaluationUserProfile;
import beans.fjtcouser;
import utils.HrEvaluationDbUtil;

/**
 * Servlet implementation class HRSelfEvaluationController
 */
@WebServlet("/SelfEvaluation")
public class HRSelfEvaluationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private HrEvaluationDbUtil hrEvaluationDbUtil;

	public HRSelfEvaluationController() throws ServletException {
		super.init();
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
			String employeeCode = fjtuser.getEmp_code();
			String requestType = request.getParameter("action");

			if (requestType == null) {
				requestType = "def";
			}
			switch (requestType) {
			case "def": // default view
				try {
					goToView(request, response, employeeCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "viewSCDtls": // when click on view to see the comments in each section
				try {
					getSingleCategoryContents(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateEvlSCtgry": // after entering the comments and click on save
				try {
					updateSingleCategoryContentByEmployee(request, response, employeeCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateGnrl": // when click on save in the final comments section
				try {
					updateEmployeeMasterGoalsAndComment(request, response, employeeCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "ntfyMngr": // when submitting the comments to the manager
				try {
					NotifyToManagerToUpdate(request, response, employeeCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "chkEmpCmntCount":
				try {
					checkEmployeeCommentCount(request, response, employeeCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToView(request, response, employeeCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void checkEmployeeCommentCount(HttpServletRequest request, HttpServletResponse response,
			String employeeCode) throws JsonIOException, IOException {
		int evaluationYear = Integer.parseInt(request.getParameter("hr1"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr2"));
		String evaluationId = request.getParameter("hr3");
		long id = Long.parseLong(evaluationId);
		int result = 0;
		result = hrEvaluationDbUtil.getEmployeeCommntsOrRespCount(evaluationYear, evaluationTerm, id, employeeCode);
		response.setContentType("application/json");
		new Gson().toJson(result, response.getWriter());

	}

	private void NotifyToManagerToUpdate(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws JsonIOException, IOException {
		int dbOptnStatus = 0;
		long id = 0;
		HrEvaluationOperations dbOperationStatus = null;
		String dmCode = request.getParameter("hr0"); // to address id, dmcode : cc address id
		int evaluationYear = Integer.parseInt(request.getParameter("hr1"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr2"));
		String empName = request.getParameter("hr3"); // to address name
		String managerName = request.getParameter("hr4"); // cc address name
		String evaluationId = request.getParameter("hr5");
		if (evaluationId == null || evaluationId.isEmpty() || empCode == null || empCode.isEmpty()
				|| empCode.length() > 7 || empCode.length() == 0) {
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
		} else {
			id = Long.parseLong(evaluationId);
			if (hrEvaluationDbUtil.updateEvaluationUserEntryStatus(id, empCode, evaluationYear, evaluationTerm, 1,
					"EVL_EMP_ENTRY_ACTV") == 1) {
				id = Long.parseLong(evaluationId);
				String mailSubject = "Employee Performance Evaluation Notification ";
				String mailContent = "Updated my comments   for " + evaluationYear + ", Term-" + evaluationTerm
						+ " against your rating. <br/>Please check in FJ-Portal";
				dbOptnStatus = hrEvaluationDbUtil.sendHREvaluationMailNotification(evaluationYear, evaluationTerm,
						dmCode, managerName, empCode, empName, mailSubject, mailContent);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			} else {
				dbOperationStatus = new HrEvaluationOperations(id, 0);// evl user entry update db optn failed
			}
		}
		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());

	}

	private void updateEmployeeMasterGoalsAndComment(HttpServletRequest request, HttpServletResponse response,
			String employeeCode) throws JsonIOException, IOException {
		long id = 0;
		int dbOptnStatus = 0;
		String evaluationId = request.getParameter("hr0");
		int operationStatus = Integer.parseInt(request.getParameter("hr4")); // 0: not a valid optn, 1: create new
																				// Master entry and update
																				// goals/employee comment then get id
																				// after db optn, 2: update
																				// goals/employee comment in existing
																				// master entry
		String comment = request.getParameter("hr1");
		String empCode = request.getParameter("hr2");

		int evaluationYear = Integer.parseInt(request.getParameter("hr3"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr6"));
		int fieldCode = Integer.parseInt(request.getParameter("hr5"));// 1: goals , 2: employee comment
		if (empCode == null || empCode.isEmpty() || empCode.length() > 7 || empCode.length() == 0) {
			empCode = employeeCode;
		}
		// System.out.println("General ID: "+evaluationId+" operationStatus:
		// "+operationStatus+" comment: "+comment+" empCode: "+empCode+" year:
		// "+evaluationYear+"");
		String evaluatorCode = hrEvaluationDbUtil.getEvaluatorCode(empCode);
		HrEvaluationOperations dbOperationStatus = null;
		switch (operationStatus) {
		case 0:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 1:
			HrEvaluationOperations masterEntryInsertStatus = hrEvaluationDbUtil
					.createNewEvalMasterEntryGeneralByEmployee(empCode, evaluationYear, comment, fieldCode,
							evaluationTerm, evaluatorCode);
			if (masterEntryInsertStatus.getId() > 0 && masterEntryInsertStatus.getActionStatus() > 0) {
				id = masterEntryInsertStatus.getId();
				dbOptnStatus = masterEntryInsertStatus.getActionStatus();
			}
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 2:
			try {
				id = Long.parseLong(evaluationId);
				dbOptnStatus = hrEvaluationDbUtil.updateEvaluationMasterEntryGeneral(id, empCode, evaluationYear,
						comment, fieldCode);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			} catch (Exception e) {
				System.out.println("Error while hr evlgeneral  operation 2");
				e.printStackTrace();
			}
			break;
		default:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);

		}
		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());

	}

	private void updateSingleCategoryContentByEmployee(HttpServletRequest request, HttpServletResponse response,
			String employeeCode) throws JsonIOException, IOException, SQLException {
		long id = 0;
		int dbOptnStatus = 0;
		String evaluationId = request.getParameter("hr0");
		String evaluationCode = request.getParameter("hr1");
		int contentNumber = Integer.parseInt(request.getParameter("hr2"));
		int operationStatus = Integer.parseInt(request.getParameter("hr3")); // 0: not a valid optn, 1: create Master
																				// entry get id after db optn then
																				// insert new txn, 2: insert txn
																				// directly with id, 3: update txn
																				// direcly
		String comment = request.getParameter("hr4");
		String empCode = request.getParameter("hr5");
		int evaluationYear = Integer.parseInt(request.getParameter("hr6"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr7"));
		if (empCode == null || empCode.isEmpty() || empCode.length() > 7 || empCode.length() == 0) {
			empCode = employeeCode;
		}
		// System.out.println("ID: "+evaluationId+" evl code: "+evaluationCode+" content
		// number: "+contentNumber+" operationStatus: "+operationStatus+" comment:
		// "+comment+" empCode: "+empCode+" year: "+evaluationYear+"");
		String evaluatorCode = hrEvaluationDbUtil.getEvaluatorCode(empCode);
		HrEvaluationOperations dbOperationStatus = null;
		switch (operationStatus) {
		case 0:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 1:
			HrEvaluationOperations masterEntryInsertStatus = hrEvaluationDbUtil.createNewEvaluationMasterEntry(empCode,
					evaluationYear, evaluationTerm, evaluatorCode);
			if (masterEntryInsertStatus.getId() > 0 && masterEntryInsertStatus.getActionStatus() > 0) {
				id = masterEntryInsertStatus.getId();
				dbOptnStatus = hrEvaluationDbUtil.createNewSingleCategoryEntry(id, evaluationCode, contentNumber,
						comment);
			}
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 2:
			try {
				id = Long.parseLong(evaluationId);
				dbOptnStatus = hrEvaluationDbUtil.createNewSingleCategoryEntry(id, evaluationCode, contentNumber,
						comment);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			} catch (Exception e) {
				System.out.println("Error while hr evl operation 2");
				e.printStackTrace();
			}
			break;
		case 3:
			try {
				id = Long.parseLong(evaluationId);
				dbOptnStatus = hrEvaluationDbUtil.updateSingleCategory(id, evaluationCode, contentNumber, comment);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			} catch (Exception e) {
				System.out.println("Error while hr evl operation 2");
				e.printStackTrace();
			}
			break;
		default:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);

		}
		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());

	}

	private void getSingleCategoryContents(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		String evaluationCode = request.getParameter("hr0");
		String empCode = request.getParameter("hr1");
		int evaluationYear = Integer.parseInt(request.getParameter("hr2"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr3"));
		List<HrEvaluationCategory> categorContentList = hrEvaluationDbUtil.empSingleCategoryEvaluation(empCode,
				evaluationYear, evaluationCode, evaluationTerm);
		response.setContentType("application/json");
		new Gson().toJson(categorContentList, response.getWriter());

	}

	private void goToView(HttpServletRequest request, HttpServletResponse response, String employeeCode)
			throws ServletException, IOException {

		HrEvaluationSettings settings = null;
		try {
			settings = hrEvaluationDbUtil.hrEvaluationSettings();

			HrEvaluationUserProfile userProfile = hrEvaluationDbUtil.employeeUserProfile(employeeCode);
			int evalutionManagerOrNot = hrEvaluationDbUtil.employeeList(employeeCode).size();// if 1 evl manager
																								// permission, if 0 only
																								// self evaluation
			request.setAttribute("EVLMNGRORNOT", evalutionManagerOrNot);
			request.setAttribute("PROFILE", userProfile);
			int totalScore = 0;
			int evlYrValidActiveOrNot = 0;

			if (settings != null) {
				evlYrValidActiveOrNot = hrEvaluationDbUtil.checkEvaluationYearDateActiveOrNot(settings);
				HrEvaluationDetails evalMasterDetails = hrEvaluationDbUtil.employeeEvaluationMasterEntryDetails(
						employeeCode, settings.getEvaluationYear(), settings.getEvaluationTerm());
				List<HrEvaluationCategory> categoryWiseSummary = hrEvaluationDbUtil.employeeEvaluationSummary(
						employeeCode, settings.getEvaluationYear(), settings.getEvaluationTerm());
				List<HrEvaluationRating> ratings = hrEvaluationDbUtil.evaluationRatings();

				totalScore = hrEvaluationDbUtil.getTotalActualScoreByMgr(employeeCode, settings.getEvaluationYear(),
						settings.getEvaluationTerm());

				request.setAttribute("EVLMASTER", evalMasterDetails);
				request.setAttribute("EVLCATSUMMRY", categoryWiseSummary);
				request.setAttribute("EVLRATINGS", ratings);
				request.setAttribute("EVLSETTINGS", settings);
			}
			request.setAttribute("EVLACTIVEORNOT", evlYrValidActiveOrNot);
			request.setAttribute("TOTACTUALSCORE", totalScore);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (employeeCode.equals("E000001")) {
			response.sendRedirect("EmployeeEvaluation");
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/hr/selfEvaluation.jsp");
			dispatcher.forward(request, response);
		}

	}

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
