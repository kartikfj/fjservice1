package beans;

import java.util.Map;

public class HrEvaluationReport {
	private String subordinateCode = null;
	private String subordinateName = null;
	private int adap = 0;
	private int csrv = 0;
	private int dlry = 0;
	private int ipsk = 0;
	private int ldrp = 0;
	private int qlty = 0;
	private int fjgcc = 0;
	private int cr = 0;
	private int sldrp = 0;

	private int total = 0;

	private Map<String, Integer> categoryMapping = null;

	private String company = null;
	private String division = null;
	private String employeeCode = null;
	private String employeeName = null;
	private String evaluatorCode = null;
	private String evaluatorName = null;
	private String managerCode = null;
	private String managerName = null;
	private String status = null;

	public String getSubordinateCode() {
		return subordinateCode;
	}

	public void setSubordinateCode(String subordinateCode) {
		this.subordinateCode = subordinateCode;
	}

	public String getSubordinateName() {
		return subordinateName;
	}

	public void setSubordinateName(String subordinateName) {
		this.subordinateName = subordinateName;
	}

	public int getAdap() {
		return adap;
	}

	public void setAdap(int adap) {
		this.adap = adap;
	}

	public int getCsrv() {
		return csrv;
	}

	public void setCsrv(int csrv) {
		this.csrv = csrv;
	}

	public int getDlry() {
		return dlry;
	}

	public void setDlry(int dlry) {
		this.dlry = dlry;
	}

	public int getIpsk() {
		return ipsk;
	}

	public void setIpsk(int ipsk) {
		this.ipsk = ipsk;
	}

	public int getLdrp() {
		return ldrp;
	}

	public void setLdrp(int ldrp) {
		this.ldrp = ldrp;
	}

	public int getQlty() {
		return qlty;
	}

	public void setQlty(int qlty) {
		this.qlty = qlty;
	}

	public int getFjgcc() {
		return fjgcc;
	}

	public void setFjgcc(int fjgcc) {
		this.fjgcc = fjgcc;
	}

	public int getCr() {
		return cr;
	}

	public void setCr(int cr) {
		this.cr = cr;
	}

	public int getSldrp() {
		return sldrp;
	}

	public void setSldrp(int sldrp) {
		this.sldrp = sldrp;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getEmployeeCode() {
		return employeeCode;
	}

	public void setEmployeeCode(String employeeCode) {
		this.employeeCode = employeeCode;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getEvaluatorCode() {
		return evaluatorCode;
	}

	public void setEvaluatorCode(String evaluatorCode) {
		this.evaluatorCode = evaluatorCode;
	}

	public String getEvaluatorName() {
		return evaluatorName;
	}

	public void setEvaluatorName(String evaluatorName) {
		this.evaluatorName = evaluatorName;
	}

	public String getManagerCode() {
		return managerCode;
	}

	public void setManagerCode(String managerCode) {
		this.managerCode = managerCode;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Map<String, Integer> getCategoryMapping() {
		return categoryMapping;
	}

	public void setCategoryMapping(Map<String, Integer> categoryMapping) {
		this.categoryMapping = categoryMapping;
	}

	public HrEvaluationReport(String subordinateCode, String subordinateName, int total,
			Map<String, Integer> catMapObj) {
		super();
		this.subordinateCode = subordinateCode;
		this.subordinateName = subordinateName;
		this.total = total;
		this.categoryMapping = catMapObj;
	}

	public HrEvaluationReport(String company, String division, String employeeCode, String employeeName,
			String evaluatorCode, String evaluatorName, String managerCode, String managerName, String status,
			int total) {
		super();
		this.company = company;
		this.division = division;
		this.employeeCode = employeeCode;
		this.employeeName = employeeName;
		this.evaluatorCode = evaluatorCode;
		this.evaluatorName = evaluatorName;
		this.managerCode = managerCode;
		this.managerName = managerName;
		this.status = status;
		this.total = total;
	}

	public HrEvaluationReport(String employeeCode, String employeeName, int total) {
		super();
		this.employeeCode = employeeCode;
		this.employeeName = employeeName;
		this.total = total;
	}

	public HrEvaluationReport(String employeeCode, String employeeName, String company, String division) {
		super();
		this.employeeCode = employeeCode;
		this.employeeName = employeeName;
		this.company = company;
		this.division = division;
	}

}
