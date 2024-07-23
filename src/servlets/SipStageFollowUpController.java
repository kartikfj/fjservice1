package servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import beans.CustomerVisit;
import beans.SipJihDues;
import beans.SipJihvSummary;
import beans.SipStageFollowUp;
import beans.fjtcouser;
import utils.SipChartDbUtil;
import utils.SipJihDuesDbUtil;
import utils.SipStageFollowpDbUtil;

/**
 * Servlet implementation class SipStageFollowUpController
 */
@WebServlet("/SipStageFollowUpController")
public class SipStageFollowUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SipStageFollowpDbUtil sipStageFollowpDbUtil;
	private SipChartDbUtil sipChartDbUtil;
	private SipJihDuesDbUtil sipJihDuesDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SipStageFollowUpController() {
		super();
		// TODO Auto-generated constructor stub
		sipChartDbUtil = new SipChartDbUtil();
		sipStageFollowpDbUtil = new SipStageFollowpDbUtil();
		sipJihDuesDbUtil = new SipJihDuesDbUtil();

	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			// only access for users who have sales code
			response.sendRedirect("logout.jsp");
		} else {
			String sales_eng_Emp_code = fjtuser.getEmp_code();
			if (fjtuser.getRole().equalsIgnoreCase("mg")) {
				// managment
				List<SipJihvSummary> theSalesEngList = sipChartDbUtil.getSalesEngListfor_Mg(sales_eng_Emp_code);
				request.setAttribute("SEngLst", theSalesEngList);
			} else {

				if (fjtuser.getSalesDMYn() >= 1) { // SALES Division Manager OR NOT
					// DM USER + SALES CODE
					List<SipJihvSummary> theSalesEngList = sipChartDbUtil.getSalesEngListfor_Dm(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				} else {
					// NORMAL SALES ENGINEER
					List<SipJihvSummary> theSalesEngList = sipChartDbUtil
							.getSalesEngListfor_NormalSalesEgr(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				}

			}

			String theDataFromHr = request.getParameter("action");
			if (theDataFromHr == null) {
				theDataFromHr = "list";
			}
			switch (theDataFromHr) {

			case "list":
				try {
					goToView(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "stageData":
				try {
					getStageData(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateStage":
				try {
					updateStage(request, response, sales_eng_Emp_code);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updateStageRemarks":
				updateStageRemarks(request, response, sales_eng_Emp_code);
				break;
			case "lost":
				updateQtnToLost(request, response, sales_eng_Emp_code, fjtuser);
				break;
			case "updateStg3":
				movetoStage3(request, response, sales_eng_Emp_code);
				break;
			case "loilost":
				updateLOIQtnToLost(request, response, sales_eng_Emp_code, fjtuser);
				break;
			case "updatePODate":
				updatePODate(request, response, sales_eng_Emp_code);
				break;
			case "updateINVDate":
				updateINVDate(request, response, sales_eng_Emp_code);
				break;
			case "updateReminder":
				updateReminder(request, response, sales_eng_Emp_code);
				break;
			case "remindersfortheqtn":
				remindersfortheqtn(request, response, sales_eng_Emp_code);
				break;
			case "updateExpLOIDate":
				updateExpLOIDate(request, response, sales_eng_Emp_code);
				break;
			case "updateSEWIN":
				updateSEWINPercentage(request, response, sales_eng_Emp_code);
				break;
			case "updateExpOrderDate":
				updateExpOrderDate(request, response, sales_eng_Emp_code);
				break;
			case "updateExpBillingDate":
				updateExpBillingDate(request, response, sales_eng_Emp_code);
				break;
			case "updateSubmittalStatus":
				updateSubmittalStatus(request, response, sales_eng_Emp_code);
				break;
			case "updateShortClose":
				updateShortClose(request, response, sales_eng_Emp_code);
				break;
			case "movetoStage1":
				moveToStage1(request, response, sales_eng_Emp_code);
				break;
			case "movetoStage2":
				moveToStage2(request, response, sales_eng_Emp_code);
				break;
			case "submittalstatusfortheqtn":
				submittalstatusfortheqtn(request, response, sales_eng_Emp_code);
				break;
			case "isapprovedyn":
				updateApprovalStatus(request, response, sales_eng_Emp_code, fjtuser);
				break;
			case "isinfocuslist":
				updateFocusListStatus(request, response, sales_eng_Emp_code, fjtuser);
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

	private void updateStage(HttpServletRequest request, HttpServletResponse response, String sales_eng_Emp_code)
			throws JsonIOException, IOException {
		int stage = 0;
		// System.out.println("Stage "+request.getParameter("stage"));
		if (!request.getParameter("stage").isEmpty() && request.getParameter("stage") != null) {
			stage = Integer.parseInt(request.getParameter("stage"));
		}

		String seCode = request.getParameter("seCode");
		String status = request.getParameter("status");

		int updateStatus = 0;

		switch (stage) {
		case 1:
			try {
				String priority = request.getParameter("priority");
				String remarks = request.getParameter("remarks");
				String id = request.getParameter("id");
				updateStatus = sipStageFollowpDbUtil.updateStage1Status(seCode, status, priority, remarks, id,
						sales_eng_Emp_code);
				// System.out.println("seCode "+seCode+" status "+status+" priority "+priority+"
				// remarks "+remarks+" id "+id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case 2:
			try {
				String priority = request.getParameter("priority");
				String remarks = request.getParameter("remarks");
				String id = request.getParameter("id");
				updateStatus = sipStageFollowpDbUtil.updateStage2Status(seCode, status, priority, remarks, id,
						sales_eng_Emp_code);
				// System.out.println("seCode "+seCode+" status "+status+" priority "+priority+"
				// remarks "+remarks+" id "+id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case 3:
			try {
				String priority = request.getParameter("priority");
				String remarks = request.getParameter("remarks");
				String id = request.getParameter("id");
				updateStatus = sipStageFollowpDbUtil.updateStage3Status(seCode, status, priority, remarks, id,
						sales_eng_Emp_code);
				// System.out.println("seCode "+seCode+" status "+status+" priority "+priority+"
				// remarks "+remarks+" id "+id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case 4:
			try {
				String soId = request.getParameter("soId");
				String filterJsonData = request.getParameter("filterData");
				JSONObject filters = new JSONObject(filterJsonData);
				JSONArray filters_json_array = filters.getJSONArray("data");
				int size = filters_json_array.length();
				ArrayList<SipStageFollowUp> itemDetails = new ArrayList<>();
				for (int i = 0; i < size; i++) {
					JSONObject obj = filters_json_array.getJSONObject(i);
					SipStageFollowUp item = new SipStageFollowUp(obj.getString("itemId"), obj.getString("material"),
							obj.getString("payment"), obj.getString("readyness"), obj.getString("deliveryDate"));
					itemDetails.add(item);
				}
				if (itemDetails != null) {
					updateStatus = sipStageFollowpDbUtil.updateStage4ItemsDetails(seCode, soId, sales_eng_Emp_code,
							itemDetails);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:
			try {
				updateStatus = 0;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		response.setContentType("application/json");
		new Gson().toJson(updateStatus, response.getWriter());
	}

	private void updateStageRemarks(HttpServletRequest request, HttpServletResponse response, String sales_eng_Emp_code)
			throws JsonIOException, IOException {
		String seCode = request.getParameter("seCode");
		String remarks = request.getParameter("remarks");
		String id = request.getParameter("id");
		String stage = request.getParameter("stage");

		System.out.print("hi this is data" + remarks + "this is my" + stage);
		int updateStatus = 0;

		try {
			updateStatus = sipStageFollowpDbUtil.updateStageRemarks(seCode, remarks, id, sales_eng_Emp_code, stage);
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.setContentType("application/json");
		new Gson().toJson(updateStatus, response.getWriter());
	}

	private void getStageData(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException {
		int stage = 0;
		if (!request.getParameter("stage").isEmpty() && request.getParameter("stage") != null) {
			stage = Integer.parseInt(request.getParameter("stage"));
		}
		String seCode = request.getParameter("seCode");
		List<SipStageFollowUp> details = null;
		switch (stage) {
		case 1:
			try {

				String status = request.getParameter("Follow-up Status");
				String priority = request.getParameter("Focus List");
				String consultantwinning = request.getParameter("Cons Win %");
				String contractorwinning = request.getParameter("Cont Win %");
				String totalwinning = request.getParameter("Tot Win %");
				String remarks = request.getParameter("searchremarks");
				String amountgreaterthan = request.getParameter("amountgreaterthan");
				System.out.println("seCode " + seCode + " status " + status + " priority " + priority + " stage "
						+ stage + "consultantwinning== " + consultantwinning + "contractorwinning== "
						+ contractorwinning + "remarks== " + remarks + "totalwinning== " + totalwinning);
				details = sipStageFollowpDbUtil.getStage1Details(seCode, status, priority, consultantwinning,
						contractorwinning, remarks, totalwinning, amountgreaterthan);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case 2:
			try {

				String status = request.getParameter("Follow-up Status");
				String priority = request.getParameter("Focus List");
				String consultantwinning = request.getParameter("Cons Win %");
				String contractorwinning = request.getParameter("Cont Win %");
				String totalwinning = request.getParameter("Tot Win %");
				String remarks = request.getParameter("searchremarks");
				String amountgreaterthan = request.getParameter("amountgreaterthan");
				System.out.println("seCode " + seCode + " status " + status + " priority " + priority + " stage "
						+ stage + "consultantwinning== " + consultantwinning + "contractorwinning== "
						+ contractorwinning + "remarks== " + remarks + "totalwinning== " + totalwinning);
				details = sipStageFollowpDbUtil.getStage2Details(seCode, status, priority, consultantwinning,
						contractorwinning, remarks, totalwinning, amountgreaterthan);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case 3:
			try {
				String status = request.getParameter("Follow-up Status");
				String priority = request.getParameter("Focus List");
				String consultantwinning = request.getParameter("Cons Win %");
				String contractorwinning = request.getParameter("Cont Win %");
				String totalwinning = request.getParameter("Tot Win %");
				String amountgreaterthan = request.getParameter("amountgreaterthan");
				// System.out.println("seCode "+seCode+" status "+status+" priority "+priority+"
				// stage "+stage);
				details = sipStageFollowpDbUtil.getStage3Details(seCode, status, priority, consultantwinning,
						contractorwinning, totalwinning, amountgreaterthan);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case 4:
			try {
				// String billing = request.getParameter("Billing");
				String material = request.getParameter("Material");
				String payment = request.getParameter("Payment");
				String readiness = request.getParameter("Readiness");
				String year = request.getParameter("year");
				String month = request.getParameter("month");
				String amountgreaterthan = request.getParameter("amountgreaterthan");
				// System.out.println("seCode "+seCode+" material "+material+" payment
				// "+payment+" readiness "+readiness);
				// System.out.println("year "+year+" month "+month);
				String etaMonth = "";
				if (year != null && month != null && !year.isEmpty() && !month.isEmpty()) {
					etaMonth = month + "/" + year;
				}
				// System.out.println("etaMonth "+etaMonth);
				details = sipStageFollowpDbUtil.getStage4Details(seCode, etaMonth, material, payment, readiness,
						amountgreaterthan);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:
			try {
				details = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());

	}

	private void updateQtnToLost(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code,
			fjtcouser fjtuser) throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String reason = request.getParameter("rsn");
		String remarkType = request.getParameter("rtyp");
		String statuschange = request.getParameter("tstuas");
		String segSalesCode = request.getParameter("segsalescode");
		int status = sipStageFollowpDbUtil.updateJIHDeQtnStatus(sysId, reason, sales_Egr_Code, remarkType, statuschange,
				fjtuser, segSalesCode);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateLOIQtnToLost(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code,
			fjtcouser fjtuser) throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String reason = request.getParameter("rsn");
		String remarkType = request.getParameter("rtyp");
		String statuschange = request.getParameter("tstuas");
		String segSalesCode = request.getParameter("segsalescode");
		System.out.println("kartik" + sysId);
		int status = sipStageFollowpDbUtil.updateLOIQtnToLost(sysId, reason, sales_Egr_Code, remarkType, statuschange,
				fjtuser, segSalesCode);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void movetoStage3(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String loiDateStr = request.getParameter("loidate");
		String loiAmount = request.getParameter("loiamt");
		String segSalesCode = request.getParameter("segsalescode");
		int loiamount = 0;
		if (loiAmount != null) {
			loiamount = Integer.parseInt(loiAmount);
		}
		// String remarkType = request.getParameter("rtyp");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(loiDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("movetoStage3" + ex);
		}

		int status = sipStageFollowpDbUtil.updateJIHDeQtnStatusToHold(sysId, sqlDate, sales_Egr_Code, segSalesCode,
				loiamount);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void goToView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		List<SipStageFollowUp> filtersList = sipStageFollowpDbUtil.getFilterList();
		// List<SipStageFollowUp> statusList = sipStageFollowpDbUtil.getStatusList();
		// List<SipStageFollowUp> priorityList =
		// sipStageFollowpDbUtil.getPriorityList();
		request.setAttribute("FILTERLST", filtersList);
		// request.setAttribute("STATUSLST", statusList);
		// request.setAttribute("PRIORITYLST", priorityList);
		List<SipJihDues> remarkType = sipJihDuesDbUtil.getRemarksTypes();
		List<SipJihDues> holdRemarkType = sipJihDuesDbUtil.getHoldRemarksTypes();
		List<SipJihDues> submittalstatus = sipStageFollowpDbUtil.getSubmitalStausOptions();
		request.setAttribute("RTYP", remarkType);
		request.setAttribute("HRTYP", holdRemarkType);
		request.setAttribute("SUBSTS", submittalstatus);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/SipStageFollowUp.jsp");
		dispatcher.forward(request, response);

	}

	private void updatePODate(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String loiDateStr = request.getParameter("podate");
		String segSalesCode = request.getParameter("segsalescode");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(loiDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("updateQtnToHold" + ex);
		}

		int status = sipStageFollowpDbUtil.updatePODate(sysId, sqlDate, segSalesCode);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateExpLOIDate(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String loiDateStr = request.getParameter("exploidate");
		String segSalesCode = request.getParameter("segsalescode");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(loiDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("updateExpLOIDate" + ex);
		}

		int status = sipStageFollowpDbUtil.updateExpLOIDate(sysId, sqlDate, segSalesCode);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateExpOrderDate(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String loiDateStr = request.getParameter("exporderdate");
		String segSalesCode = request.getParameter("segsalescode");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(loiDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("updateExpOrderDate" + ex);
		}

		int status = sipStageFollowpDbUtil.updateExpOrderDate(sysId, sqlDate, segSalesCode);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateExpBillingDate(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String billingDateStr = request.getParameter("expbillingdate");
		String segSalesCode = request.getParameter("segsalescode");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(billingDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("expbillingdate" + ex);
		}

		int status = sipStageFollowpDbUtil.updateExpBillingDate(sysId, sqlDate, segSalesCode);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateSubmittalStatus(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String reasonDesc = request.getParameter("reasonDesc");
		String substatusType = request.getParameter("substatusType");
		String segsalescode = request.getParameter("segsalescode");
		int status = sipStageFollowpDbUtil.updateSubmittalStatus(sysId, reasonDesc, substatusType, segsalescode);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateShortClose(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("id");
		int status = sipStageFollowpDbUtil.updateShortClose(sysId, sales_Egr_Code);
		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void moveToStage1(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("id");
		int status = sipStageFollowpDbUtil.moveToStage1(sysId, sales_Egr_Code);
		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void moveToStage2(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("id");
		int status = sipStageFollowpDbUtil.moveToStage2(sysId, sales_Egr_Code);
		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateSEWINPercentage(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String seWinper = request.getParameter("sewin");
		String segSalesCode = request.getParameter("segsalescode");
		int stage = 0;
		if (!request.getParameter("stage").isEmpty() && request.getParameter("stage") != null) {
			stage = Integer.parseInt(request.getParameter("stage"));
		}
		int seWinPercen = 0, status = 0;
		if (seWinper != null) {
			seWinPercen = Integer.parseInt(seWinper);
		}
		switch (stage) {
		case 2:
			try {
				status = sipStageFollowpDbUtil.updateSEWINPercentage(sysId, seWinPercen, segSalesCode);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case 3:
			try {
				status = sipStageFollowpDbUtil.updateSEWINPercentageforstage3(sysId, seWinPercen, segSalesCode);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		}

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateINVDate(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String invDateStr = request.getParameter("invdate");
		String segSalesCode = request.getParameter("segsalescode");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(invDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("updateQtnToHold" + ex);
		}

		int status = sipStageFollowpDbUtil.updateINVDate(sysId, sqlDate, segSalesCode);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateReminder(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String remDateStr = request.getParameter("reminderdate");
		String remDesc = request.getParameter("remDesc");
		String segSalesCode = request.getParameter("segsalescode");
		String projectName = request.getParameter("projectName");
		String qtnCodeNo = request.getParameter("qtnCodeNo");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date reminderDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		String empcode = sipStageFollowpDbUtil.getEmployeeCode(segSalesCode);
		try {
			dt = formatter.parse(remDateStr);
			reminderDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(reminderDate.getTime());
		} catch (ParseException ex) {
			System.out.println("movetoStage3" + ex);
		}

		int status = sipStageFollowpDbUtil.updateReminderDetails(sysId, sqlDate, empcode, segSalesCode, remDesc,
				projectName, qtnCodeNo);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void remindersfortheqtn(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws JsonIOException, IOException, SQLException, ServletException {
		String qtnCodeNo = request.getParameter("theQtnCodeNo");
		List<CustomerVisit> details = sipStageFollowpDbUtil.getRemindersFortheQtn(empCode, qtnCodeNo);
		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());
	}

	private void submittalstatusfortheqtn(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws JsonIOException, IOException, SQLException, ServletException {
		String qtnCodeNo = request.getParameter("theQtnCodeNo");
		List<CustomerVisit> details = sipStageFollowpDbUtil.getSubmittalStatusfortheqtnFortheQtn(qtnCodeNo);
		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());
	}

	private void updateApprovalStatus(HttpServletRequest request, HttpServletResponse response, String empCode,
			fjtcouser fjtuser) throws JsonIOException, IOException, SQLException, ServletException {
		String sysId = request.getParameter("id");
		String sesalescode = request.getParameter("sesaledcode");
		String approvalStatus = request.getParameter("approvalStatus");
		int status = sipStageFollowpDbUtil.updateApprovalStatusForConslt(sysId, sesalescode, approvalStatus, fjtuser);
		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());
	}

	private void updateFocusListStatus(HttpServletRequest request, HttpServletResponse response, String empCode,
			fjtcouser fjtuser) throws JsonIOException, IOException, SQLException, ServletException {
		String sysId = request.getParameter("id");
		String sesalescode = request.getParameter("sesaledcode");
		String approvalStatus = request.getParameter("approvalStatus");
//		int stage = 0;
//		if (!request.getParameter("stage").isEmpty() && request.getParameter("stage") != null) {
		String stage = request.getParameter("stage");
//		}
		System.out.println("new stage" + stage);
		int status = sipStageFollowpDbUtil.updateFocusListStatus(sysId, sesalescode, approvalStatus, fjtuser, stage);
		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
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
