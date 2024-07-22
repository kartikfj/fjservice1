package beans;

public class ServiceRequest {
	
	private String id = null;
	private String fldVstId = null;
	private String employee_id = null;
	private String empName = null;
	private String user_type = null;
	private String divnCode = null;
	
	
	private String soCodeNo = null;
	private String projectName = null;
	private String customer = null;
	private String consultant = null;
	private String location = null;
	private String visitType = null;
	
	private double materialCost = 0;
	private double laborCost = 0;
	private double otherCost = 0;
	
	private double actMaterialCost = 0;
	private double actLaborCost = 0;
	private double actOtherCost = 0;
	
	
	private String ofcInitialRemarks = null;
	private String ofcFinalRemarks = null;
	 
	private String officeUserId = null;
	private String officeUserName = null;
	private String fieldUserId = null;
	private String fieldUserName = null;
	
	private String createdDate = null;
	
	
	private String checkin = null;
	private String checkout = null;
	private String fieldRemark = null;
	private int noOfAssistants = 0;
	private String visitDate = null;
	private int fldVisitStatus = 0;
	
	private int initStatus = 0;
	private int fldStatus = 0;
	private int finalStatus = 0;
	private int noOfVisits = 0;
	private double totalEstCost = 0;
	private double totalActCost = 0;
	
	private String startDate = null;
	private String toDate = null;
	private int status = 0;
	
	
	private int fieldEngRate = 0;
	private int fieldAsstRate = 0;
	
	private String region  = null; 
	
	private int totMinutes = 0;
	
	private int fldEngnrHrlyRate = 0;
	
	
	private long totalServiceMinutes = 0;
	private long totalServiceLaborExpense = 0;
	
	///////////
	
	
	public String getEmployee_id() {
		return employee_id;
	}
	public long getTotalServiceMinutes() {
		return totalServiceMinutes;
	}
	public void setTotalServiceMinutes(long totalServiceMinutes) {
		this.totalServiceMinutes = totalServiceMinutes;
	}
	public long getTotalServiceLaborExpense() {
		return totalServiceLaborExpense;
	}
	public void setTotalServiceLaborExpense(long totalServiceLaborExpense) {
		this.totalServiceLaborExpense = totalServiceLaborExpense;
	}
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	

	public int getFldEngnrHrlyRate() {
		return fldEngnrHrlyRate;
	}
	public void setFldEngnrHrlyRate(int fldEngnrHrlyRate) {
		this.fldEngnrHrlyRate = fldEngnrHrlyRate;
	}
	public String getSoCodeNo() {
		return soCodeNo;
	}
	public void setSoCodeNo(String soCodeNo) {
		this.soCodeNo = soCodeNo;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	public String getConsultant() {
		return consultant;
	}
	public void setConsultant(String consultant) {
		this.consultant = consultant;
	}
	
	public String getDivnCode() {
		return divnCode;
	}
	public void setDivnCode(String divnCode) {
		this.divnCode = divnCode;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getVisitType() {
		return visitType;
	}
	public void setVisitType(String visitType) {
		this.visitType = visitType;
	}
	
	
	
	public double getMaterialCost() {
		return materialCost;
	}
	public void setMaterialCost(double materialCost) {
		this.materialCost = materialCost;
	}
	public double getLaborCost() {
		return laborCost;
	}
	public void setLaborCost(double laborCost) {
		this.laborCost = laborCost;
	}
	
	
	
	public String getOfcInitialRemarks() {
		return ofcInitialRemarks;
	}
	public void setOfcInitialRemarks(String ofcInitialRemarks) {
		this.ofcInitialRemarks = ofcInitialRemarks;
	}
	public String getOfcFinalRemarks() {
		return ofcFinalRemarks;
	}
	public void setOfcFinalRemarks(String ofcFinalRemarks) {
		this.ofcFinalRemarks = ofcFinalRemarks;
	}
	
	
	

	
	public String getOfficeUserId() {
		return officeUserId;
	}
	public void setOfficeUserId(String officeUserId) {
		this.officeUserId = officeUserId;
	}
	public String getOfficeUserName() {
		return officeUserName;
	}
	public void setOfficeUserName(String officeUserName) {
		this.officeUserName = officeUserName;
	}
	public String getFieldUserId() {
		return fieldUserId;
	}
	public void setFieldUserId(String fieldUserId) {
		this.fieldUserId = fieldUserId;
	}
	public String getFieldUserName() {
		return fieldUserName;
	}
	public void setFieldUserName(String fieldUserName) {
		this.fieldUserName = fieldUserName;
	}
	
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	
	public double getOtherCost() {
		return otherCost;
	}
	public void setOtherCost(double otherCost) {
		this.otherCost = otherCost;
	}
	
	
	public int getInitStatus() {
		return initStatus;
	}
	public void setInitStatus(int initStatus) {
		this.initStatus = initStatus;
	}
	public int getFldStatus() {
		return fldStatus;
	}
	public void setFldStatus(int fldStatus) {
		this.fldStatus = fldStatus;
	}
	public int getFinalStatus() {
		return finalStatus;
	}
	public void setFinalStatus(int finalStatus) {
		this.finalStatus = finalStatus;
	}
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	public double getActMaterialCost() {
		return actMaterialCost;
	}
	public void setActMaterialCost(double actMaterialCost) {
		this.actMaterialCost = actMaterialCost;
	}
	public double getActLaborCost() {
		return actLaborCost;
	}
	public void setActLaborCost(double actLaborCost) {
		this.actLaborCost = actLaborCost;
	}
	public double getActOtherCost() {
		return actOtherCost;
	}
	public void setActOtherCost(double actOtherCost) {
		this.actOtherCost = actOtherCost;
	}
	
	
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	
	
	
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public String getFieldRemark() {
		return fieldRemark;
	}
	public void setFieldRemark(String fieldRemark) {
		this.fieldRemark = fieldRemark;
	}
	public String getVisitDate() {
		return visitDate;
	}
	public void setVisitDate(String visitDate) {
		this.visitDate = visitDate;
	}
	public int getFldVisitStatus() {
		return fldVisitStatus;
	}
	public void setFldVisitStatus(int fldVisitStatus) {
		this.fldVisitStatus = fldVisitStatus;
	}
	
	
	public int getNoOfAssistants() {
		return noOfAssistants;
	}
	public void setNoOfAssistants(int noOfAssistants) {
		this.noOfAssistants = noOfAssistants;
	}
	
	
	public String getFldVstId() {
		return fldVstId;
	}
	public void setFldVstId(String fldVstId) {
		this.fldVstId = fldVstId;
	}
	
	
	public int getNoOfVisits() {
		return noOfVisits;
	}
	public void setNoOfVisits(int noOfVisits) {
		this.noOfVisits = noOfVisits;
	}
	
	public double getTotalEstCost() {
		return totalEstCost;
	}
	public void setTotalEstCost(double totalEstCost) {
		this.totalEstCost = totalEstCost;
	}
	public double getTotalActCost() {
		return totalActCost;
	}
	public void setTotalActCost(double totalActCost) {
		this.totalActCost = totalActCost;
	}
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	

	public int getFieldEngRate() {
		return fieldEngRate;
	}
	public void setFieldEngRate(int fieldEngRate) {
		this.fieldEngRate = fieldEngRate;
	}
	public int getFieldAsstRate() {
		return fieldAsstRate;
	}
	public void setFieldAsstRate(int fieldAsstRate) {
		this.fieldAsstRate = fieldAsstRate;
	}
	
	
 
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	
	public int getTotMinutes() {
		return totMinutes;
	}
	public void setTotMinutes(int totMinutes) {
		this.totMinutes = totMinutes;
	}
	/////////////////////////////////////////////////////////////
	public ServiceRequest( String user_type, String divnCode) {
		super();		
		this.user_type = user_type;
		this.divnCode = divnCode;
	}
	
	
	public ServiceRequest(String soCodeNo, String projectName, String customer, String consultant) {
		super();
		this.soCodeNo = soCodeNo;
		this.projectName = projectName;
		this.customer = customer;
		this.consultant = consultant;
	}
	public ServiceRequest(String employee_id, String empName, String user_type) {
		super();
		this.employee_id = employee_id;
		this.empName = empName;
		this.user_type = user_type;
	}
	public ServiceRequest(String visitType) {
		super();
		this.visitType = visitType;
	}
	public ServiceRequest(String soCodeNo, String projectName, String customer, String consultant, String location, String visitType,
			double materialCost, double laborCost, double otherCost, String ofcInitialRemarks,
			String officeUserId, String officeUserName, String fieldUserId, String fieldUserName, String region) {
		super();
		// insert new service request
		this.soCodeNo = soCodeNo;
		this.projectName = projectName;
		this.customer = customer;
		this.consultant = consultant;
		this.location =  location;
		this.visitType = visitType;
		this.materialCost = materialCost;
		this.laborCost = laborCost;
		this.otherCost = otherCost;
		this.ofcInitialRemarks = ofcInitialRemarks; 
		this.officeUserId = officeUserId;
		this.officeUserName = officeUserName;
		this.fieldUserId = fieldUserId;
		this.fieldUserName = fieldUserName;
		this.region = region;
	}
	
	
	public ServiceRequest(String id, String soCodeNo, String projectName, String customer, String consultant,
			String location, String visitType, double materialCost, double laborCost, double otherCost,
			String ofcInitialRemarks, String officeUserId, String officeUserName, String fieldUserId,
			String fieldUserName,  int initStatus, int fldStatus, int finalStatus) {
		super();
		// project code details
		this.id = id;
		this.soCodeNo = soCodeNo;
		this.projectName = projectName;
		this.customer = customer;
		this.consultant = consultant;
		this.location = location;
		this.visitType = visitType;
		this.materialCost = materialCost;
		this.laborCost = laborCost;
		this.otherCost = otherCost;
		this.ofcInitialRemarks = ofcInitialRemarks;
		this.officeUserId = officeUserId;
		this.officeUserName = officeUserName;
		this.fieldUserId = fieldUserId;
		this.fieldUserName = fieldUserName; 
		this.initStatus = initStatus;
		this.fldStatus = fldStatus;
		this.finalStatus = finalStatus;
	}
	public ServiceRequest(String id, String soCodeNo, String projectName, String customer, String consultant,
			String location, String visitType,String ofcInitialRemarks,
			String ofcFinalRemarks,  double materialCost, double laborCost, double otherCost,
			double actMaterialCost, double actLaborCost, double actOtherCost, String fieldUserId,
			String fieldUserName, String officeUserId, String officeUserName, String createdDate, int initStatus, int fldStatus, int finalStatus, 
			int noOfVisits, double totalEstCost, double totalActCost, String region, long totalServiceMinutes, long totalServiceLaborExpense) {
		super();
		// service request complete details
		this.id = id;
		this.soCodeNo = soCodeNo;
		this.projectName = projectName;
		this.customer = customer;
		this.consultant = consultant;
		this.location = location;
		this.visitType = visitType;
		this.ofcInitialRemarks = ofcInitialRemarks;
		this.ofcFinalRemarks = ofcFinalRemarks;
		this.materialCost = materialCost;
		this.laborCost = laborCost;
		this.otherCost = otherCost;
		this.actMaterialCost = actMaterialCost;
		this.actLaborCost = actLaborCost;
		this.actOtherCost = actOtherCost;
		this.fieldUserId = fieldUserId;
		this.fieldUserName = fieldUserName;
		this.officeUserId = officeUserId;
		this.officeUserName = officeUserName;
		this.createdDate = createdDate;
		this.initStatus = initStatus;
		this.fldStatus = fldStatus;
		this.finalStatus = finalStatus;
		this.noOfVisits =  noOfVisits;
		this.totalEstCost = totalEstCost;
		this.totalActCost = totalActCost;
		this.region = region;
		this.totalServiceMinutes =totalServiceMinutes;
		this.totalServiceLaborExpense = totalServiceLaborExpense;
	}
	public ServiceRequest(String id, String checkin, String checkout, String fieldRemark, int noOfAssistants, String visitDate,
			int fldVisitStatus, String fieldUserId, int totMinutes, int fldEngnrHrlyRate) {
		super();
		//insert a fld visit
		this.id = id;
		this.checkout = checkout;
		this.checkin = checkin;
		this.fieldRemark = fieldRemark;
		this.visitDate = visitDate;
		this.fldVisitStatus = fldVisitStatus;
		this.fieldUserId = fieldUserId;
		this.noOfAssistants = noOfAssistants;
		this.totMinutes = totMinutes;
		this.fldEngnrHrlyRate = fldEngnrHrlyRate;
	}
	public ServiceRequest(String id, String fldVstId, String fieldUserId, String visitDate, String checkin, String checkout,
			String fieldRemark, int noOfAssistants,  int fldVisitStatus, String createdDate, int totMinutes) {
		super();
		// details of fld visit list for a single service request
		this.id = id;
		this.fldVstId = fldVstId;
		this.fieldUserId = fieldUserId;
		this.checkin = checkin;
		this.checkout = checkout;
		this.fieldRemark = fieldRemark;
		this.noOfAssistants = noOfAssistants;
		this.visitDate = visitDate;
		this.fldVisitStatus = fldVisitStatus;
		this.createdDate = createdDate;
		this.totMinutes =  totMinutes;
		
	}
	public ServiceRequest(String id, double actMaterialCost, double actLaborCost, double actOtherCost,
			String ofcFinalRemarks, int finalStatus, String officeUserId) {
		super();
		//update final confirmation
		this.id = id;
		this.actMaterialCost = actMaterialCost;
		this.actLaborCost = actLaborCost;
		this.actOtherCost = actOtherCost;
		this.ofcFinalRemarks = ofcFinalRemarks;
		this.finalStatus = finalStatus;
		this.officeUserId = officeUserId;
	}
	public ServiceRequest(String startDate, String toDate, int status, String divnCode) {
		super();
		// cust date filter condtion
		this.startDate = startDate;
		this.toDate = toDate;
		this.status = status;
		this.divnCode = divnCode;
	}

	public ServiceRequest(int fieldEngRate, int fieldAsstRate) {
		super();
		this.fieldEngRate = fieldEngRate;
		this.fieldAsstRate = fieldAsstRate;
	}
	
	public ServiceRequest(int status,String region) {
		super();
		this.region = region;
	}
	public ServiceRequest( int active, String employee_id, String empName) {
		super();
		this.employee_id = employee_id;
		this.empName = empName;
	}
	
	
}
