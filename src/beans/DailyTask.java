package beans;

public class DailyTask {
	private String tid01 = null;// task id
	private String tyr02 = null;// task year
	private String tuid03 = null;// task user id
	private String tsid04 = null;// task sales id
	private String twd05 = null;// task work
	private String tmth06 = null;// task month
	private String ttyp07 = null;// task type
	private String tdesc08 = null;// description
	private String tst09 = null;// task start time
	private String tet10 = null;// task end time
	private String tendb11 = null;// task entered emp name to save in db
	private String tecmp12 = null;// task entered emp company to save in db
	private String tedvn13 = null;// task entered emp division to save in db
	private int sysid = 0;
	private String cvdid = null;// customer visit document id
	private String cvpopn = null;// customer visit project or party name

	private String salesVisitStstus = "n";
	private String salesCode = null;

	private String emp_code = null;// employee code for select option
	private String emp_name = null;// employee name for select option

	private String partyName = null;// for customer visit details , party name
	private String cvDate = null;// custome visit date

	private String contactPerson = null;// for customer visit details , party name
	private String contactNumber = null;// custome visit date

	public String getTid01() {
		return tid01;
	}

	public void setTid01(String tid01) {
		this.tid01 = tid01;
	}

	public String getTyr02() {
		return tyr02;
	}

	public void setTyr02(String tyr02) {
		this.tyr02 = tyr02;
	}

	public String getTuid03() {
		return tuid03;
	}

	public void setTuid03(String tuid03) {
		this.tuid03 = tuid03;
	}

	public String getTsid04() {
		return tsid04;
	}

	public void setTsid04(String tsid04) {
		this.tsid04 = tsid04;
	}

	public String getTwd05() {
		return twd05;
	}

	public void setTwd05(String twd05) {
		this.twd05 = twd05;
	}

	public String getTmth06() {
		return tmth06;
	}

	public void setTmth06(String tmth06) {
		this.tmth06 = tmth06;
	}

	public String getTtyp07() {
		return ttyp07;
	}

	public void setTtyp07(String ttyp07) {
		this.ttyp07 = ttyp07;
	}

	public String getTdesc08() {
		return tdesc08;
	}

	public void setTdesc08(String tdesc08) {
		this.tdesc08 = tdesc08;
	}

	public String getTst09() {
		return tst09;
	}

	public void setTst09(String tst09) {
		this.tst09 = tst09;
	}

	public String getTet10() {
		return tet10;
	}

	public void setTet10(String tet10) {
		this.tet10 = tet10;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public int getSysid() {
		return sysid;
	}

	public void setSysid(int sysid) {
		this.sysid = sysid;
	}

	public DailyTask(String tid01, String tyr02, String tuid03, String tendb11, String tecmp12, String tedvn13,
			String tsid04, String twd05, String tmth06, String ttyp07, String tdesc08, String tst09, String tet10,
			String cvdid, String cvpopn, String partyName) {
		super();
		this.tid01 = tid01;
		this.tyr02 = tyr02;
		this.tuid03 = tuid03;
		this.tendb11 = tendb11;
		this.tecmp12 = tecmp12;
		this.tedvn13 = tedvn13;
		this.tsid04 = tsid04;
		this.twd05 = twd05;
		this.tmth06 = tmth06;
		this.ttyp07 = ttyp07;
		this.tdesc08 = tdesc08;
		this.tst09 = tst09;
		this.tet10 = tet10;
		this.cvdid = cvdid;
		this.cvpopn = cvpopn;
		this.partyName = partyName;
	}

	public DailyTask(String tid01, String tyr02, String tuid03, String tendb11, String tecmp12, String tedvn13,
			String tsid04, String twd05, String tmth06, String ttyp07, String tdesc08, String tst09, String tet10,
			String cvdid, String cvpopn, String partyName, String contactPerson, String contactNumber) {
		super();
		this.tid01 = tid01;
		this.tyr02 = tyr02;
		this.tuid03 = tuid03;
		this.tendb11 = tendb11;
		this.tecmp12 = tecmp12;
		this.tedvn13 = tedvn13;
		this.tsid04 = tsid04;
		this.twd05 = twd05;
		this.tmth06 = tmth06;
		this.ttyp07 = ttyp07;
		this.tdesc08 = tdesc08;
		this.tst09 = tst09;
		this.tet10 = tet10;
		this.cvdid = cvdid;
		this.cvpopn = cvpopn;
		this.partyName = partyName;
		this.contactPerson = contactPerson;
		this.contactNumber = contactNumber;
	}

	public DailyTask(String tid01, String tyr02, String tuid03, String tendb11, String tecmp12, String tedvn13,
			String tsid04, String twd05, String tmth06, String ttyp07, String tdesc08, String tst09, String tet10,
			String cvdid, String cvpopn, String partyName, String contactPerson, String contactNumber, int sysid) {
		super();
		this.tid01 = tid01;
		this.tyr02 = tyr02;
		this.tuid03 = tuid03;
		this.tendb11 = tendb11;
		this.tecmp12 = tecmp12;
		this.tedvn13 = tedvn13;
		this.tsid04 = tsid04;
		this.twd05 = twd05;
		this.tmth06 = tmth06;
		this.ttyp07 = ttyp07;
		this.tdesc08 = tdesc08;
		this.tst09 = tst09;
		this.tet10 = tet10;
		this.cvdid = cvdid;
		this.cvpopn = cvpopn;
		this.partyName = partyName;
		this.contactPerson = contactPerson;
		this.contactNumber = contactNumber;
		this.sysid = sysid;
	}

	public DailyTask(String tyr02, String tuid03, String tendb11, String tecmp12, String tedvn13, String tsid04,
			String twd05, String tmth06, String ttyp07, String tdesc08, String tst09, String tet10) {
		super();
		this.tyr02 = tyr02;
		this.tuid03 = tuid03;
		this.tendb11 = tendb11;
		this.tecmp12 = tecmp12;
		this.tedvn13 = tedvn13;
		this.tsid04 = tsid04;
		this.twd05 = twd05;
		this.tmth06 = tmth06;
		this.ttyp07 = ttyp07;
		this.tdesc08 = tdesc08;
		this.tst09 = tst09;
		this.tet10 = tet10;
	}

	public DailyTask(String ttyp07, String tdesc08, String tst09, String tet10, String tid01) {
		super();
		this.ttyp07 = ttyp07;
		this.tdesc08 = tdesc08;
		this.tst09 = tst09;
		this.tet10 = tet10;
		this.tid01 = tid01;
	}

	public DailyTask(String ttyp07, String tdesc08, String tst09, String tet10, int tid01) {
		super();
		this.ttyp07 = ttyp07;
		this.tdesc08 = tdesc08;
		this.tst09 = tst09;
		this.tet10 = tet10;
		this.sysid = tid01;
	}

	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public DailyTask(String emp_code, String emp_name) {
		super();
		this.emp_code = emp_code;
		this.emp_name = emp_name;
	}

	public String getTendb11() {
		return tendb11;
	}

	public void setTendb11(String tendb11) {
		this.tendb11 = tendb11;
	}

	public String getTecmp12() {
		return tecmp12;
	}

	public void setTecmp12(String tecmp12) {
		this.tecmp12 = tecmp12;
	}

	public String getTedvn13() {
		return tedvn13;
	}

	public void setTedvn13(String tedvn13) {
		this.tedvn13 = tedvn13;
	}

	// complete staff daily task report
	public DailyTask(String tecmp12, String tedvn13, String emp_code, String emp_name, String twd05, String ttyp07,
			String tst09, String tet10, String tdesc08) {
		super();
		this.tecmp12 = tecmp12;
		this.tedvn13 = tedvn13;
		this.emp_code = emp_code;
		this.emp_name = emp_name;
		this.twd05 = twd05;
		this.ttyp07 = ttyp07;
		this.tst09 = tst09;
		this.tet10 = tet10;
		this.tdesc08 = tdesc08;
	}

	public DailyTask(String tecmp12, String tedvn13, String emp_code, String emp_name) {
		super();
		this.tecmp12 = tecmp12;
		this.tedvn13 = tedvn13;
		this.emp_code = emp_code;
		this.emp_name = emp_name;
	}

	public String getCvdid() {
		return cvdid;
	}

	public void setCvdid(String cvdid) {
		this.cvdid = cvdid;
	}

	public String getCvpopn() {
		return cvpopn;
	}

	public void setCvpopn(String cvpopn) {
		this.cvpopn = cvpopn;
	}

	public String getSalesVisitStstus() {
		return salesVisitStstus;
	}

	public void setSalesVisitStstus(String salesVisitStstus) {
		this.salesVisitStstus = salesVisitStstus;
	}

	public String getSalesCode() {
		return salesCode;
	}

	public void setSalesCode(String salesCode) {
		this.salesCode = salesCode;
	}

	public DailyTask(String salesVisitStstus, String salesCode, String empCode) {
		super();
		this.salesVisitStstus = salesVisitStstus;
		this.salesCode = salesCode;
		this.emp_code = empCode;
	}

	public String getCvDate() {
		return cvDate;
	}

	public void setCvDate(String cvDate) {
		this.cvDate = cvDate;
	}

	public DailyTask(int flag, String cvdid, String salesCode, String cvDate, String tdesc08, String ttyp07,
			String tst09, String tet10, String cvpopn, String partyName) {
		// for single day regularisation cust visit reference

		super();
		this.cvdid = cvdid;
		this.salesCode = salesCode;
		this.cvDate = cvDate;
		this.tdesc08 = tdesc08;
		this.ttyp07 = ttyp07;
		this.tst09 = tst09;
		this.tet10 = tet10;
		this.cvpopn = cvpopn;
		this.partyName = partyName;
	}

}
