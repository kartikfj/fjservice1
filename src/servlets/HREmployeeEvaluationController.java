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
import beans.HrEvaluationReport;
import beans.HrEvaluationSettings;
import beans.HrEvaluationUserProfile;
import beans.fjtcouser;
import utils.HrEvaluationDbUtil;

/**
 * Servlet implementation class HREmployeeEvaluationController
 */
@WebServlet("/EmployeeEvaluation")
public class HREmployeeEvaluationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private HrEvaluationDbUtil hrEvaluationDbUtil;

	public HREmployeeEvaluationController() throws ServletException {
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
			String dmCode = fjtuser.getEmp_code();
			String employeeCode = "";
			String requestType = request.getParameter("action");

			if (requestType == null) {
				requestType = "def";
			}
			switch (requestType) {
			case "def":
				try {
					goToView(request, response, dmCode, employeeCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "viewSCDtls":// when click on view to see the comments in each section
				try {
					getSingleCategoryContents(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "newUserDtls": // when manager selects the employee and click on view
				try {
					getEmployeeEvaluationProfile(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateEvlRating": // after entering the comments and click on save
				try {
					updateSingleCategoryContentByManager(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateGnrl": // when click on save in the final comments section
				try {
					updateEmployeeManagerFinalComment(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "closeEvl": // closing the evaluation with mutual understanding
				try {
					closeEvaluationByManager(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "ntfyEmp": // when submitting the comments to the employee
				try {
					NotifyToEmployeeToUpdate(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "empPndLst":
				try {
					getEvaluationEmployeePendingList(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateHRGnrl": // when HR click on save in the final comments section
				try {
					updateHRFinalComment(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateAreastoImp": // when click on save in the final comments section
				try {
					updateManagerAreastoimprComment(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "trainingNeeded": // when click on save in the final comments section
				try {
					updateManagerTrainingNeededComment(request, response, dmCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToView(request, response, dmCode, employeeCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void getEvaluationEmployeePendingList(HttpServletRequest request, HttpServletResponse response,
			String dmCode) throws SQLException, JsonIOException, IOException {
		int evaluationYear = Integer.parseInt(request.getParameter("hr1"));
		List<HrEvaluationUserProfile> pendingList = hrEvaluationDbUtil.evaluationEmployeesPendingList(dmCode,
				evaluationYear);
		response.setContentType("application/json");
		new Gson().toJson(pendingList, response.getWriter());

	}

	private void NotifyToEmployeeToUpdate(HttpServletRequest request, HttpServletResponse response, String dmCode)
			throws JsonIOException, IOException {
		// System.out.println("Mail function called");
		int dbOptnStatus = 0;
		long id = 0;
		HrEvaluationOperations dbOperationStatus = null;
		String empCode = request.getParameter("hr0"); // to address id, dmcode : cc address id
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
			if (hrEvaluationDbUtil.getTotalActualScoreByMgr(empCode, evaluationYear, evaluationTerm) > 0) {
				if (hrEvaluationDbUtil.updateEvaluationUserEntryStatus(id, empCode, evaluationYear, evaluationTerm, 1,
						"EVL_MANAGER_ENTRY_ACTV") == 1) {

					String mailSubject = "Employee Performance Evaluation Notification ";
					String mailContent = "Your Employee Performance Evaluation ratings submitted   for "
							+ evaluationYear + ", Term-" + evaluationTerm
							+ ". <br/>Please update your comments, self goals and final comments  by login to FJ-Portal.  <br/> Please submit  to manager after completing your comments.";
					dbOptnStatus = hrEvaluationDbUtil.sendHREvaluationMailNotification(evaluationYear, evaluationTerm,
							empCode, empName, dmCode, managerName, mailSubject, mailContent);
					// System.out.println("Mail Status "+dbOptnStatus);
					dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);

				} else {
					dbOperationStatus = new HrEvaluationOperations(id, 0);// evl user entry update db optn failed
				}
			} else {
				dbOperationStatus = new HrEvaluationOperations(id, -5);// -5, no score entered
			}
		}
		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());
	}

	private void getEmployeeEvaluationProfile(HttpServletRequest request, HttpServletResponse response, String dmCode)
			throws ServletException, IOException {
		String employeeCode = request.getParameter("selectedUser");
		// System.out.println(employeeCode+" "+dmCode);
		goToView(request, response, dmCode, employeeCode);

	}

	private void closeEvaluationByManager(HttpServletRequest request, HttpServletResponse response, String dmCode)
			throws JsonIOException, IOException {
		long id = 0;
		int dbOptnStatus = 0;
		String evaluationId = request.getParameter("hr0");
		String empCode = request.getParameter("hr1");
		int evaluationYear = Integer.parseInt(request.getParameter("hr2"));
		int initialEvaluationStatus = Integer.parseInt(request.getParameter("hr3")); // 0: evaluation initial stage , ie
																						// updation only possible, if
																						// this greater than or less
																						// than zero not allow to
																						// updates
		int evaluationTerm = Integer.parseInt(request.getParameter("hr4"));
		String empName = request.getParameter("hr5");
		String managerName = request.getParameter("hr6");
		int newEvaluationStatus = Integer.parseInt(request.getParameter("hr7")); // 0: evaluation initial stage, not
																					// allow to update . if this greater
																					// than zero allow to close
																					// evaluation
		if (empCode == null || empCode.isEmpty() || empCode.length() > 7 || empCode.length() == 0) {
			initialEvaluationStatus = -1;
		}
		// System.out.println("Close evaluation"+evaluationId+" initialEvaluationStatus:
		// "+initialEvaluationStatus+" newEvaluationStatus: "+newEvaluationStatus+"
		// empCode: "+empCode+"");

		HrEvaluationOperations dbOperationStatus = null;

		if ((newEvaluationStatus == 1 || newEvaluationStatus == 2) && initialEvaluationStatus == 0) {
			id = Long.parseLong(evaluationId);
			dbOptnStatus = hrEvaluationDbUtil.closeEvaluation(id, empCode, evaluationYear, newEvaluationStatus,
					evaluationTerm, dmCode);
			if (id > 0 && dbOptnStatus > 0) {
				String mailSubject = "Employee Performance Evaluation Closed ";
				String mailContent = "Employee Performance Evaluation Closed for you. <br/>Evaluation Year : "
						+ evaluationYear + ", Term-" + evaluationTerm + ". <br/>";
				dbOptnStatus = hrEvaluationDbUtil.sendHREvaluationMailNotification(evaluationYear, evaluationTerm,
						empCode, empName, dmCode, managerName, mailSubject, mailContent);
			}
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
		} else {
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
		}

		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());

	}

	private void updateEmployeeManagerFinalComment(HttpServletRequest request, HttpServletResponse response,
			String dmCode) throws JsonIOException, IOException {
		long id = 0;
		int dbOptnStatus = 0;
		String evaluationId = request.getParameter("hr0");
		int operationStatus = Integer.parseInt(request.getParameter("hr4")); // 0: not a valid optn, 1: create new
																				// Master entry and update dm final
																				// comment then get id after db optn, 2:
																				// update dm final comment in existing
																				// master entry
		String comment = request.getParameter("hr1"); // dm final comment
		String empCode = request.getParameter("hr2");
		int evaluationYear = Integer.parseInt(request.getParameter("hr3"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr5"));
		if (empCode == null || empCode.isEmpty() || empCode.length() > 7 || empCode.length() < 7
				|| empCode.length() == 0) {
			operationStatus = 0;
		}
		// System.out.println("General ID: "+evaluationId+" operationStatus:
		// "+operationStatus+" comment: "+comment+" empCode: "+empCode+" DM CODE:
		// "+dmCode+" year: "+evaluationYear+" evl term: "+evaluationTerm);

		HrEvaluationOperations dbOperationStatus = null;
		switch (operationStatus) {
		case 0:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 1:
			HrEvaluationOperations masterEntryInsertStatus = hrEvaluationDbUtil
					.createNewEvaluationMasterEntryGeneralByManager(empCode, evaluationYear, comment, evaluationTerm,
							dmCode);
			if (masterEntryInsertStatus.getId() > 0 && masterEntryInsertStatus.getActionStatus() > 0) {
				id = masterEntryInsertStatus.getId();
				dbOptnStatus = masterEntryInsertStatus.getActionStatus();
			}
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 2:
			try {
				id = Long.parseLong(evaluationId);
				dbOptnStatus = hrEvaluationDbUtil.updateEvaluationMasterEntryGeneralByManager(id, empCode,
						evaluationYear, comment, evaluationTerm, dmCode);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			} catch (Exception e) {
				System.out.println("Error while hr evl general by manager operation 2");
				e.printStackTrace();
			}
			break;
		default:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);

		}
		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());

	}

	private void updateHRFinalComment(HttpServletRequest request, HttpServletResponse response, String dmCode)
			throws JsonIOException, IOException {
		long id = 0;
		int dbOptnStatus = 0;
		String evaluationId = request.getParameter("hr0");
		int operationStatus = Integer.parseInt(request.getParameter("hr4")); // 0: not a valid optn, 1: create new
																				// Master entry and update dm final
																				// comment then get id after db optn, 2:
																				// update dm final comment in existing
																				// master entry
		String comment = request.getParameter("hr1"); // dm final comment
		String empCode = request.getParameter("hr2");
		int evaluationYear = Integer.parseInt(request.getParameter("hr3"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr5"));
		if (empCode == null || empCode.isEmpty() || empCode.length() > 7 || empCode.length() < 7
				|| empCode.length() == 0) {
			operationStatus = 0;
		}
		HrEvaluationOperations dbOperationStatus = null;
		try {
			id = Long.parseLong(evaluationId);
			dbOptnStatus = hrEvaluationDbUtil.updateEvaluationMasterEntryGeneralByHR(id, empCode, evaluationYear,
					comment, evaluationTerm, dmCode);
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
		} catch (Exception e) {
			System.out.println("Error while hr evl general by manager operation 2");
			e.printStackTrace();
		}
		dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);

		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());

	}

	private void updateManagerAreastoimprComment(HttpServletRequest request, HttpServletResponse response,
			String dmCode) throws JsonIOException, IOException {
		long id = 0;
		int dbOptnStatus = 0;
		String evaluationId = request.getParameter("hr0");
		int operationStatus = Integer.parseInt(request.getParameter("hr4")); // 0: not a valid optn, 1: create new
																				// Master entry and update dm final
																				// comment then get id after db optn, 2:
																				// update dm final comment in existing
																				// master entry
		String comment = request.getParameter("hr1"); // dm final comment
		String empCode = request.getParameter("hr2");
		int evaluationYear = Integer.parseInt(request.getParameter("hr3"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr5"));
		if (empCode == null || empCode.isEmpty() || empCode.length() > 7 || empCode.length() < 7
				|| empCode.length() == 0) {
			operationStatus = 0;
		}
		HrEvaluationOperations dbOperationStatus = null;
		switch (operationStatus) {
		case 0:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 1:
			HrEvaluationOperations masterEntryInsertStatus = hrEvaluationDbUtil
					.createNewEvaluationMasterEntryImprareasByManager(empCode, evaluationYear, comment, evaluationTerm,
							dmCode);
			if (masterEntryInsertStatus.getId() > 0 && masterEntryInsertStatus.getActionStatus() > 0) {
				id = masterEntryInsertStatus.getId();
				dbOptnStatus = masterEntryInsertStatus.getActionStatus();
			}
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 2:
			try {
				id = Long.parseLong(evaluationId);
				dbOptnStatus = hrEvaluationDbUtil.updateEvaluationMasterEntryAreasImprByMgr(id, empCode, evaluationYear,
						comment, evaluationTerm, dmCode);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			} catch (Exception e) {
				System.out.println("Error while hr evl general by manager operation 2");
				e.printStackTrace();
			}
			break;
		default:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);

		}
		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());
	}

	private void updateManagerTrainingNeededComment(HttpServletRequest request, HttpServletResponse response,
			String dmCode) throws JsonIOException, IOException {
		long id = 0;
		int dbOptnStatus = 0;
		String evaluationId = request.getParameter("hr0");
		int operationStatus = Integer.parseInt(request.getParameter("hr4")); // 0: not a valid optn, 1: create new
																				// Master entry and update dm final
																				// comment then get id after db optn, 2:
																				// update dm final comment in existing
																				// master entry
		String comment = request.getParameter("hr1"); // dm final comment
		String empCode = request.getParameter("hr2");
		int evaluationYear = Integer.parseInt(request.getParameter("hr3"));
		int evaluationTerm = Integer.parseInt(request.getParameter("hr5"));
		if (empCode == null || empCode.isEmpty() || empCode.length() > 7 || empCode.length() < 7
				|| empCode.length() == 0) {
			operationStatus = 0;
		}
		HrEvaluationOperations dbOperationStatus = null;
		switch (operationStatus) {
		case 0:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 1:
			HrEvaluationOperations masterEntryInsertStatus = hrEvaluationDbUtil
					.createNewEvaluationMasterEntryTraingingneedsByManager(empCode, evaluationYear, comment,
							evaluationTerm, dmCode);
			if (masterEntryInsertStatus.getId() > 0 && masterEntryInsertStatus.getActionStatus() > 0) {
				id = masterEntryInsertStatus.getId();
				dbOptnStatus = masterEntryInsertStatus.getActionStatus();
			}
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			break;
		case 2:
			try {
				id = Long.parseLong(evaluationId);
				dbOptnStatus = hrEvaluationDbUtil.updateEvaluationMasterEntryTrainingNeedsByMgr(id, empCode,
						evaluationYear, comment, evaluationTerm, dmCode);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);
			} catch (Exception e) {
				System.out.println("Error while hr evl general by manager operation 2");
				e.printStackTrace();
			}
			break;
		default:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus);

		}

		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());

	}

	private void updateSingleCategoryContentByManager(HttpServletRequest request, HttpServletResponse response,
			String dmCode) throws JsonIOException, IOException, SQLException {
		long id = 0;
		int dbOptnStatus = 0;
		int totalScore = 0;
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
		int rating = Integer.parseInt(request.getParameter("hr8"));
		// int actualScore = Integer.parseInt(request.getParameter("hr9"));
		String ratingYN = request.getParameter("hr10");
		if (empCode == null || empCode.isEmpty() || empCode.length() > 7 || empCode.length() < 7
				|| empCode.length() == 0) {
			operationStatus = 0; // not a valid opn, subordinate employee code wrong
		}
		// System.out.println("ID: "+evaluationId+" evl code: "+evaluationCode+" content
		// number: "+contentNumber+" operationStatus: "+operationStatus+" comment:
		// "+comment+" dmCode: "+dmCode+" empCode: "+empCode+" year: "+evaluationYear+"
		// term: "+evaluationTerm+" rating: "+rating);

		HrEvaluationOperations dbOperationStatus = null;
		switch (operationStatus) {
		case 0:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus, totalScore);
			break;
		case 1:
			HrEvaluationOperations masterEntryInsertStatus = hrEvaluationDbUtil
					.createNewEvaluationMasterEntryByManager(empCode, evaluationYear, evaluationTerm, dmCode);
			if (masterEntryInsertStatus.getId() > 0 && masterEntryInsertStatus.getActionStatus() > 0) {
				id = masterEntryInsertStatus.getId();
				dbOptnStatus = hrEvaluationDbUtil.createNewSingleCategoryEntryByManager(id, evaluationCode,
						contentNumber, comment, rating, dmCode);
			}
			totalScore = getTotalScoreByManager(dbOptnStatus, empCode, evaluationYear, evaluationTerm, ratingYN);
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus, totalScore);
			break;
		case 2:
			try {
				id = Long.parseLong(evaluationId);
				dbOptnStatus = hrEvaluationDbUtil.createNewSingleCategoryEntryByManager(id, evaluationCode,
						contentNumber, comment, rating, dmCode);
				totalScore = getTotalScoreByManager(dbOptnStatus, empCode, evaluationYear, evaluationTerm, ratingYN);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus, totalScore);
			} catch (Exception e) {
				System.out.println("Error while hr evl by manager txn operation 2");
				e.printStackTrace();
			}
			break;
		case 3:
			try {
				id = Long.parseLong(evaluationId);
				dbOptnStatus = hrEvaluationDbUtil.updateSingleCategoryByManager(id, evaluationCode, contentNumber,
						comment, rating, dmCode);
				totalScore = getTotalScoreByManager(dbOptnStatus, empCode, evaluationYear, evaluationTerm, ratingYN);
				dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus, totalScore);
			} catch (Exception e) {
				System.out.println("Error while hr evl operation 2");
				e.printStackTrace();
			}
			break;
		default:
			dbOperationStatus = new HrEvaluationOperations(id, dbOptnStatus, totalScore);

		}

		response.setContentType("application/json");
		new Gson().toJson(dbOperationStatus, response.getWriter());

	}

	private int getTotalScoreByManager(int dbOptnStatus, String empCode, int evaluationYear, int evaluationTerm,
			String ratingYN) {

		return (dbOptnStatus == 1 && ratingYN.equalsIgnoreCase("Y"))
				? hrEvaluationDbUtil.getTotalActualScoreByMgr(empCode, evaluationYear, evaluationTerm)
				: 0;
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

	private void goToView(HttpServletRequest request, HttpServletResponse response, String dmCode, String employeeCode)
			throws ServletException, IOException {

		HrEvaluationSettings settings = null;
		List<HrEvaluationReport> allEmployeeLists = null;
		try {
			settings = hrEvaluationDbUtil.hrEvaluationSettings();
			int totalScore = 0;
			int evlYrValidActiveOrNot = 0;
			List<HrEvaluationUserProfile> employeeLists = hrEvaluationDbUtil.employeeList(dmCode);
			fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			if (fjtuser.getRole().equals("hrmgr")) {
				allEmployeeLists = hrEvaluationDbUtil.getAllEmployeesCommentsDoneByManager(dmCode,
						settings.getEvaluationYear(), settings.getEvaluationTerm());
			}

			int evalutionManagerOrNot = employeeLists.size();// if 1 evl manager permission, if 0 only self evaluation
			if (evalutionManagerOrNot >= 1) {

				HrEvaluationUserProfile userProfile = hrEvaluationDbUtil.employeeUserProfile(employeeCode);
				// HashMap empTrainingCodes = hrEvaluationDbUtil.employeeTrainingCodes();
				request.setAttribute("EMPLST", employeeLists);
				request.setAttribute("EVLMNGRORNOT", evalutionManagerOrNot);
				request.setAttribute("PROFILE", userProfile);
				request.setAttribute("EMPLISTFORHRCMNTS", allEmployeeLists);
				// request.setAttribute("EMPTRAININGCODES", empTrainingCodes);
				request.setAttribute("selected_subordinate", employeeCode);
				if (settings != null) {
					evlYrValidActiveOrNot = hrEvaluationDbUtil.checkEvaluationYearDateActiveOrNot(settings);
					HrEvaluationDetails evalMasterDetails = hrEvaluationDbUtil.employeeEvaluationMasterEntryDetails(
							employeeCode, settings.getEvaluationYear(), settings.getEvaluationTerm());
					List<HrEvaluationCategory> categoryWiseSummary = hrEvaluationDbUtil
							.employeeEvaluationSummaryForManager(employeeCode, settings.getEvaluationYear(),
									settings.getEvaluationTerm());
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
			} else {
				response.sendRedirect("logout.jsp");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/hr/managerEvaluation.jsp");
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
