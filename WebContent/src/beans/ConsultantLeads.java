package beans;

import java.util.ArrayList;
import java.util.HashMap;

public class ConsultantLeads {

	private String cnslt_id = null;
	private String conslt_name = null;// consultant_name
	private String product = null; // product
	private String status = null; // status
	private String division = null; // division
	private String remarks = null;// remarks
	private String cyr = null;// created year
	private String cby = null;// created by
	private String uyr = null;// updated year
	private String uby = null;// updatedBy
	private String created_date = null;
	private String updated_date = null;
	private String contactDetails = null;// consultant Details
	private String createdBy = null;
	private String divn_name = null;
	private String divn_code = null;

	private String updateStatus = null;
	private String isUpdateByBDM = null;
	private String consultantType = null;
	private String isUpdateByEVM = null;

	public String getIsUpdateByEVM() {
		return isUpdateByEVM;
	}

	public void setIsUpdateByEVM(String isUpdateByEVM) {
		this.isUpdateByEVM = isUpdateByEVM;
	}

	private HashMap<String, ArrayList<String>> divnProductList = null;

	public String getCreated_date() {
		return created_date;
	}

	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}

	public String getUpdated_date() {
		return updated_date;
	}

	public void setUpdated_date(String updated_date) {
		this.updated_date = updated_date;
	}

	public String getCnslt_id() {
		return cnslt_id;
	}

	public void setCnslt_id(String cnslt_id) {
		this.cnslt_id = cnslt_id;
	}

	public String getConslt_name() {
		return conslt_name;
	}

	public void setConslt_name(String conslt_name) {
		this.conslt_name = conslt_name;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getCyr() {
		return cyr;
	}

	public void setCyr(String cyr) {
		this.cyr = cyr;
	}

	public String getCby() {
		return cby;
	}

	public void setCby(String cby) {
		this.cby = cby;
	}

	public String getUyr() {
		return uyr;
	}

	public void setUyr(String uyr) {
		this.uyr = uyr;
	}

	public String getUby() {
		return uby;
	}

	public void setUby(String uby) {
		this.uby = uby;
	}

	public String getUpdateStatus() {
		return updateStatus;
	}

	public void setUpdateStatus(String updateStatus) {
		this.updateStatus = updateStatus;
	}

	public String getContactDetails() {
		return contactDetails;
	}

	public void setContactDetails(String consultantDetails) {
		this.contactDetails = consultantDetails;
	}

	public HashMap<String, ArrayList<String>> getDivnProductList() {
		return divnProductList;
	}

	public void setDivnProductList(HashMap<String, ArrayList<String>> divnProductList) {
		this.divnProductList = divnProductList;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getConsultantType() {
		return consultantType;
	}

	public void setConsultantType(String consultantType) {
		this.consultantType = consultantType;
	}

	public ConsultantLeads(String conslt_name, String product, String status, String division, String remarks,
			String cyr, String cby, String contactDetails, String isUpdateByBDM, String isUpdateByEVM,
			String consultantType) {
		// Constructor for creating new consultant leads
		super();
		this.conslt_name = conslt_name;
		this.product = product;
		this.status = status;
		this.division = division;
		this.remarks = remarks;
		this.cyr = cyr;
		this.cby = cby;
		this.contactDetails = contactDetails;
		this.isUpdateByBDM = isUpdateByBDM;
		this.isUpdateByEVM = isUpdateByEVM;
		this.consultantType = consultantType;
	}

	public ConsultantLeads(String cnslt_id, String conslt_name, String product, String status, String division,
			String remarks, String created_date, String updated_date, String updateStatus) {
		// View all consultant leads
		super();
		this.cnslt_id = cnslt_id;
		this.conslt_name = conslt_name;
		this.product = product;
		this.status = status;
		this.division = division;
		this.remarks = remarks;
		this.created_date = created_date;
		this.updated_date = updated_date;
		this.updateStatus = updateStatus;

	}

	public ConsultantLeads(String cnslt_id, String conslt_name, String product, String status, String division,
			String remarks, String created_date, String updated_date, String updateStatus,
			HashMap<String, ArrayList<String>> divnProductList, String contact_details, String byBDM, String byEVM,
			String createdBy, String consultantType) {
		// View all consultant leads
		super();
		this.cnslt_id = cnslt_id;
		this.conslt_name = conslt_name;
		this.product = product;
		this.status = status;
		this.division = division;
		this.remarks = remarks;
		this.created_date = created_date;
		this.updated_date = updated_date;
		this.updateStatus = updateStatus;
		this.divnProductList = divnProductList;
		this.contactDetails = contact_details;
		this.isUpdateByBDM = byBDM;
		this.isUpdateByEVM = byEVM;
		this.createdBy = createdBy;
		this.consultantType = consultantType;
	}

	public ConsultantLeads(String conslt_name, String product, String status, String division, String remarks) {
		// Constructor for creating new consultant leads
		super();
		this.conslt_name = conslt_name;
		this.product = product;
		this.status = status;
		this.division = division;
		this.remarks = remarks;
	}

	public String getDivn_name() {
		return divn_name;
	}

	public void setDivn_name(String divn_name) {
		this.divn_name = divn_name;
	}

	public String getDivn_code() {
		return divn_code;
	}

	public void setDivn_code(String divn_code) {
		this.divn_code = divn_code;
	}

	public String getIsUpdateByBDM() {
		return isUpdateByBDM;
	}

	public void setIsUpdateByBDM(String isUpdateByBDM) {
		this.isUpdateByBDM = isUpdateByBDM;
	}

	public ConsultantLeads(String divn_code, String divn_name) {
		super();
		// for complete divison details
		this.divn_code = divn_code;
		this.divn_name = divn_name;
	}

	public ConsultantLeads(String cnslt_id, String status, String remarks, String contactDetails, String product,
			String sdfsd, String isUpdateByEVM) {
		// update consultant leads
		super();
		this.cnslt_id = cnslt_id;
		this.status = status;
		this.remarks = remarks;
		this.contactDetails = contactDetails;
		this.product = product;
		this.isUpdateByEVM = isUpdateByEVM;
	}

	public ConsultantLeads(String conslt_code, String conslt_name, String test1) {
		super();
		this.cnslt_id = conslt_code;
		this.conslt_name = conslt_name;
	}

}
