package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
 
import beans.ConsultantLeads;
import beans.MarketingLeads;
import beans.fjtcouser;
import utils.MarketingLeadsDbUtil;

/**
 * @author nufail.a Servlet implementation class MarketingLeadsController
 *         Renamed to "Projects Stages 0 & 1"
 */
@WebServlet("/ProjectLeads")
public class MktProjectUnderDesign extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MarketingLeadsDbUtil marketingLeadsDbUtil;

	public MktProjectUnderDesign() throws ServletException {
		super.init();
		marketingLeadsDbUtil = new MarketingLeadsDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");
		} else {
			String emp_code = fjtuser.getEmp_code();
			String theDataFromHr = request.getParameter("octjf");
			String userRole = fjtuser.getRole();
			if (theDataFromHr == null) {
				theDataFromHr = "list";
			}
			switch (theDataFromHr) {
			case "list":
				try {
					goToMarketingLeads(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "dlmav":
				try {
					viewAllMarketingLeadsDetail(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "dlnwdtlcftc":// change tab from consultant leads to download
				try {
					goToMarketingDownloads(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "delete":
				try {
					deleteMarketingLeads(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "UPDATE":
				try {
					updateMarketingLeads(request, response, emp_code, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "etadputkm":// update marketing
				try {
					createMarketingLeads(request, response, emp_code, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "lctlmftc": // change tab from marketing leads to consultant leads
				try {
					// System.out.println("consultant entered");
					goToConsultantLeads(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "sbcnfpdw": // search by consultant name for product division wise
				try {
					serachProductforConsultant(request, response, emp_code);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToMarketingLeads(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void viewAllMarketingLeadsDetail(HttpServletRequest request, HttpServletResponse response, String userRole)
			throws SQLException, ServletException, IOException {
		String currYear = Calendar.getInstance().get(Calendar.YEAR) + "";

		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		request.setAttribute("DLFCL", divisonList);

		if (userRole.equals("mkt") || userRole.equals("mg")) {
			List<MarketingLeads> mktAll_Details = marketingLeadsDbUtil.getMarketingLeadsDetails(currYear);
			request.setAttribute("MLAD", mktAll_Details);
			request.setAttribute("MLWD", mktAll_Details);
		} else {
			fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			String companyCode = fjtuser.getEmp_com_code();
			String divnCode = fjtuser.getEmp_divn_code();
			List<MarketingLeads> mktWeek_Details = marketingLeadsDbUtil.getAllMarketingLeadsDetailsforSalesEng(currYear,
					companyCode, divnCode);
			request.setAttribute("MLWD", mktWeek_Details);
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ProjectUD.jsp");
		dispatcher.forward(request, response);
	}

	private void goToMarketingDownloads(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		String currYear = Calendar.getInstance().get(Calendar.YEAR) + "";
		List<MarketingLeads> mktAll_Details = marketingLeadsDbUtil.getMarketingLeadsDetails(currYear);
		List<MarketingLeads> mktWeek_Details = marketingLeadsDbUtil.getMarketingLeadsforLast2Week(currYear);
		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		request.setAttribute("DLFCL", divisonList);
		request.setAttribute("MLAD", mktAll_Details);
		request.setAttribute("MLWD", mktWeek_Details);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/mktdownload.jsp");
		dispatcher.forward(request, response);

	}

	private void goToConsultantLeads(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		request.setAttribute("DLFCL", divisonList);
		request.setAttribute("TABACTIVE", "YES");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ConsultantLeads.jsp");
		dispatcher.forward(request, response);

	}

	private void serachProductforConsultant(HttpServletRequest request, HttpServletResponse response, String emp_code)
			throws SQLException, ServletException, IOException {
		String search_word = request.getParameter("srch-term");
		String year = Calendar.getInstance().get(Calendar.YEAR) + "";
		List<ConsultantLeads> searchDtls = marketingLeadsDbUtil.getSerachResultConsultantleads(search_word, year);
		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		String message = "";

		if (searchDtls == null || searchDtls.isEmpty()) {
			message = "Search results for '<b><i>" + search_word + "</i></b>' not found.";

		}

		request.setAttribute("SWORD", message);
		request.setAttribute("DLFCL", divisonList);
		request.setAttribute("VACLD", searchDtls);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ConsultantLeads.jsp");
		dispatcher.forward(request, response);
	}

	private void deleteMarketingLeads(HttpServletRequest request, HttpServletResponse response, String userRole)
			throws SQLException, ServletException, IOException {
		String mlId = request.getParameter("mktli");
		marketingLeadsDbUtil.deleteUpdateMarketingLeads(mlId);
		goToMarketingLeads(request, response, userRole);
	}

	private void updateMarketingLeads(HttpServletRequest request, HttpServletResponse response, String emp_code,
			String userRole) throws SQLException, ServletException, IOException {
		String mlId = request.getParameter("mktli");
		String oportunity = request.getParameter("mktOpportunity");
		String status = request.getParameter("mkstatus");
		String location = request.getParameter("mktLocation");
		String leads = request.getParameter("mkLeads");
		String contact = request.getParameter("mktContact");
		String division = request.getParameter("mkDivn");
		String product = request.getParameter("prodct");
		String mainCont = request.getParameter("mktMainCont");
		String mepCont = request.getParameter("mktMepCont");
		String week = request.getParameter("mktWeek");
		String emp_ID = emp_code;
		String currYear = Calendar.getInstance().get(Calendar.YEAR) + "";
		MarketingLeads mkt_Details = new MarketingLeads(mlId, oportunity, status, location, leads, contact, division,
				product, mainCont, mepCont, currYear, emp_ID, week, 0);
		marketingLeadsDbUtil.editUpdateMarketingLeads(mkt_Details);
		goToMarketingLeads(request, response, userRole);

	}

	private void createMarketingLeads(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		String products = "";
		String oportunity = request.getParameter("mktOpportunity");
		String status = request.getParameter("mkstatus");
		String location = request.getParameter("mktLocation");
		String leads = request.getParameter("mkLeads");
		String contact = request.getParameter("mktContact");
		String division = request.getParameter("mkDivn");// division from front end
		// String remark=request.getParameter("mktRmrk");
		String[] product_lists = request.getParameterValues("prodct");
		if (product_lists.length > 0) {
			products = String.join(", ", product_lists);
		}
		String mainCont = request.getParameter("mktMainCont");
		String mepCont = request.getParameter("mktMepCont");
		String week = request.getParameter("mktWeek");
		String emp_ID = empployee_Code;
		String currYear = Calendar.getInstance().get(Calendar.YEAR) + "";
		MarketingLeads mkt_Details = new MarketingLeads(oportunity, status, location, leads, contact, division,
				products, mainCont, mepCont, currYear, emp_ID, week, 0);
		marketingLeadsDbUtil.insertNewMarketingLeads(mkt_Details);

		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		request.setAttribute("DLFCL", divisonList);

		goToMarketingLeads(request, response, userRole);

	}

	private void goToMarketingLeads(HttpServletRequest request, HttpServletResponse response, String userRole)
			throws ServletException, IOException, SQLException {
		String currYear = Calendar.getInstance().get(Calendar.YEAR) + "";
		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		request.setAttribute("DLFCL", divisonList);
		if (userRole.equals("mkt") || userRole.equals("mg")) {
			List<MarketingLeads> mktWeek_Details = marketingLeadsDbUtil.getMarketingLeadsforLast2Week(currYear);
			request.setAttribute("MLWD", mktWeek_Details);
		} else {
			fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			String companyCode = fjtuser.getEmp_com_code();
			String divnCode = fjtuser.getEmp_divn_code();
			List<MarketingLeads> mktWeek_Details = marketingLeadsDbUtil
					.getMarketingLeadsforLast2Week_Sales_Eng(currYear, companyCode, divnCode);
			request.setAttribute("MLWD", mktWeek_Details);
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ProjectUD.jsp");
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
