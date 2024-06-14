package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ConsultantLeads;
import beans.MktSalesLeads;
import beans.fjtcouser;
import utils.MarketingLeadsDbUtil;

/**
 * Servlet implementation class ConsultantProductReportController
 */
@WebServlet(name = "ConsultantProductReport", urlPatterns = { "/ConsultantProductReport" })
public class ConsultantProductReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MarketingLeadsDbUtil marketingLeadsDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		marketingLeadsDbUtil = new MarketingLeadsDbUtil();
		try {
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");

		} else {

			List<MktSalesLeads> productList = marketingLeadsDbUtil.getProductList();
			List<ConsultantLeads> consultantList = marketingLeadsDbUtil.getAllConsultantList();
			request.setAttribute("PLFCL", productList);
			request.setAttribute("CLFCL", consultantList);

		}
		String theDataFromHr = request.getParameter("fjtco");

		if (theDataFromHr == null) {
			theDataFromHr = "list";

		}

		switch (theDataFromHr) {
		case "list":

			try {
				goToConsultantProductPage(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "rpeotrpad":

			try {
				goToConsultantProductReport(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:

			try {
				// goToRegularisePage(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private void goToConsultantProductPage(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/consultantProductReport.jsp");
		dispatcher.forward(request, response);

	}

	private void goToConsultantProductReport(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		final String[] consultantList = request.getParameterValues("consltList");
		String[] productList = request.getParameterValues("productList");
		List<String> selectedConsltCheckboxes = null;
		List<String> selectedProductCheckboxes = null;
		int totalSelectedConsulCnt = (consultantList.length) / 10;

		if (consultantList.length % 10 > 0)
			totalSelectedConsulCnt++;

		System.out.println("totalSelectedConsul" + totalSelectedConsulCnt);
		if (consultantList != null && consultantList.length > 0) {
			selectedConsltCheckboxes = Arrays.asList(consultantList);
		}
		if (productList != null && productList.length > 0) {
			selectedProductCheckboxes = Arrays.asList(productList);
		}
		request.setAttribute("selectedConsultCheckBoxes", selectedConsltCheckboxes);
		request.setAttribute("selectedProdcutCheckBoxes", selectedProductCheckboxes);
		int count = 1;

		String[] consultantArray = new String[totalSelectedConsulCnt];
		StringBuilder consultantListforQuery = new StringBuilder();
		int i = 0;
		StringBuilder probuilder = new StringBuilder();
		if (consultantList.length > 0) {
			String prodctList = String.join(",", productList);

			for (String prlist : productList) {
				probuilder.append("'" + prlist + "',");
			}
			String productListforQuery = probuilder.deleteCharAt(probuilder.length() - 1).toString();
			System.out.println("productListforQuery==" + productListforQuery);
			StringBuilder builder = new StringBuilder();
			for (String list : consultantList) {
				builder.append("'" + list + "',");
				System.out.println("builder== " + builder);
				count++;
				System.out.println("cout== " + count);
				if (count > 10) {
					consultantArray[i++] = builder.deleteCharAt(builder.length() - 1).toString();
					count = 1;
					builder = new StringBuilder();
					System.out.println("consultantArray[0]== " + consultantArray[i - 1]);
				}
			}

			if (count > 1)
				consultantArray[i++] = builder.deleteCharAt(builder.length() - 1).toString();

			for (int j = 0; j < consultantArray.length; j++) {
				if (j > 0)
					consultantListforQuery.append(" or ");
				consultantListforQuery.append(" consultant IN (");
				consultantListforQuery.append(consultantArray[j]);
				consultantListforQuery.append(" )");
			}

			// String consultantListforQuery = builder.deleteCharAt(builder.length() -
			// 1).toString();
			String[][] theConsltProductList = marketingLeadsDbUtil.getConsultantProductReport(
					consultantListforQuery.toString(), productListforQuery, consultantList, productList);
			request.setAttribute("CON_PRO_MATRIX_LIST", theConsltProductList);

		} else {
			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-info\">\r\n"
					+ "  <strong>Info!</strong> Please Complete Selection\r\n" + "</div> ");
		}

		// RequestDispatcher dispatcher =
		// request.getRequestDispatcher("/marketing/consultantProductReport.jsp");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/consultantProductReport.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ConsultantProductReportController() {
		super();
		// TODO Auto-generated constructor stub
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
