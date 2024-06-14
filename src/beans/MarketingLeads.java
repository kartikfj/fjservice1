package beans;

public class MarketingLeads {
	private String id = null;// opportunities
	private String opt = null;// opportunities
	private String status = null;
	private String location = null;
	private String leads = null;
	private String contactDtls = null;
	private String products = null;
	private String remarks = null;
	private String updatedYr = null;
	private String updatedBy = null;
	private String updatedDate = null;
	private String createddDate = null;
	private String updtdWeek = null;
	private String mainContractor = null;
	private String mepContractor = null;
	private String updateStatus = null;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOpt() {
		return opt;
	}

	public void setOpt(String opt) {
		this.opt = opt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getLeads() {
		return leads;
	}

	public void setLeads(String leads) {
		this.leads = leads;
	}

	public String getContactDtls() {
		return contactDtls;
	}

	public void setContactDtls(String contactDtls) {
		this.contactDtls = contactDtls;
	}

	public String getProducts() {
		return products;
	}

	public void setProducts(String products) {
		this.products = products;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getUpdatedYr() {
		return updatedYr;
	}

	public void setUpdatedYr(String updatedYr) {
		this.updatedYr = updatedYr;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public String getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getUpdtdWeek() {
		return updtdWeek;
	}

	public void setUpdtdWeek(String updtdWeek) {
		this.updtdWeek = updtdWeek;
	}

	public String getMainContractor() {
		return mainContractor;
	}

	public void setMainContractor(String mainContractor) {
		this.mainContractor = mainContractor;
	}

	public String getMepContractor() {
		return mepContractor;
	}

	public void setMepContractor(String mepContractor) {
		this.mepContractor = mepContractor;
	}

	public String getCreateddDate() {
		return createddDate;
	}

	public void setCreateddDate(String createddDate) {
		this.createddDate = createddDate;
	}

	public String getUpdateStatus() {
		return updateStatus;
	}

	public void setUpdateStatus(String updateStatus) {
		this.updateStatus = updateStatus;
	}

	public MarketingLeads(String id, String opt, String status, String location, String leads, String contactDtls,
			String products, String remarks, String mainContractor, String mepContractor, String updatedYr,
			String updatedBy, String updtdWeek, String createddDate, String updatedDate) {// display
		super();
		this.id = id;
		this.opt = opt;
		this.status = status;
		this.location = location;
		this.leads = leads;
		this.contactDtls = contactDtls;
		this.products = products;
		this.remarks = remarks;
		this.mainContractor = mainContractor;
		this.mepContractor = mepContractor;
		this.updatedYr = updatedYr;
		this.updatedBy = updatedBy;
		this.updtdWeek = updtdWeek;
		this.createddDate = createddDate;
		this.updatedDate = updatedDate;
	}

	public MarketingLeads(String opt, String status, String location, String leads, String contactDtls, String products,
			String remarks, String mainContractor, String mepContractor, String updatedYr, String updatedBy,
			String updtdWeek, int valid) {// insert
		super();
		this.opt = opt;
		this.status = status;
		this.location = location;
		this.leads = leads;
		this.contactDtls = contactDtls;
		this.products = products;
		this.remarks = remarks;
		this.mainContractor = mainContractor;
		this.mepContractor = mepContractor;
		this.updatedYr = updatedYr;
		this.updatedBy = updatedBy;
		this.updtdWeek = updtdWeek;
	}

	public MarketingLeads(String id, String opt, String status, String location, String leads, String contactDtls,
			String products, String remarks, String mainContractor, String mepContractor, String updatedYr,
			String updatedBy, String updtdWeek, int flag) {// update
		super();
		this.id = id;
		this.opt = opt;
		this.status = status;
		this.location = location;
		this.leads = leads;
		this.contactDtls = contactDtls;
		this.products = products;
		this.remarks = remarks;
		this.mainContractor = mainContractor;
		this.mepContractor = mepContractor;
		this.updatedYr = updatedYr;
		this.updatedBy = updatedBy;
		this.updtdWeek = updtdWeek;
	}

	public MarketingLeads(String id, String opt, String status, String location, String leads, String contactDtls,
			String products, String remarks, String mainContractor, String mepContractor, String updatedYr,
			String updatedBy, String updtdWeek, String createddDate, String updatedDate, String updateStatus) {// display
		super();
		this.id = id;
		this.opt = opt;
		this.status = status;
		this.location = location;
		this.leads = leads;
		this.contactDtls = contactDtls;
		this.products = products;
		this.remarks = remarks;
		this.mainContractor = mainContractor;
		this.mepContractor = mepContractor;
		this.updatedYr = updatedYr;
		this.updatedBy = updatedBy;
		this.updtdWeek = updtdWeek;
		this.createddDate = createddDate;
		this.updatedDate = updatedDate;
		this.updateStatus = updateStatus;
	}

}
