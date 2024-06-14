package beans;

import java.util.Map;

public class SalesmanPerformance {
	private String smCode = null;
	private String srNo = null;
	private String perf_ttl = null;
	private String yrTot = null;
	private String salesCode = null;
	private String salesName = null;

	private Map<String, String> salesEnglist = null;

	private String aging_1 = null;// <30
	private String aging_2 = null;// 30-60
	private String aging_3 = null;// 60-90
	private String aging_4 = null;// 90-120
	private String aging_5 = null;// 120-180
	private String aging_6 = null;// >180

	public String getSmCode() {
		return smCode;
	}

	public void setSmCode(String smCode) {
		this.smCode = smCode;
	}

	public String getSrNo() {
		return srNo;
	}

	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}

	public String getPerf_ttl() {
		return perf_ttl;
	}

	public void setPerf_ttl(String perf_ttl) {
		this.perf_ttl = perf_ttl;
	}

	public String getYrTot() {
		return yrTot;
	}

	public void setYrTot(String yrTot) {
		this.yrTot = yrTot;
	}

	public String getSalesCode() {
		return salesCode;
	}

	public void setSalesCode(String salesCode) {
		this.salesCode = salesCode;
	}

	public String getSalesName() {
		return salesName;
	}

	public void setSalesName(String salesName) {
		this.salesName = salesName;
	}

	public Map<String, String> getSalesEnglist() {
		return salesEnglist;
	}

	public void setSalesEnglist(Map<String, String> salesEnglist) {
		this.salesEnglist = salesEnglist;
	}

	public String getAging_1() {
		return aging_1;
	}

	public void setAging_1(String aging_1) {
		this.aging_1 = aging_1;
	}

	public String getAging_2() {
		return aging_2;
	}

	public void setAging_2(String aging_2) {
		this.aging_2 = aging_2;
	}

	public String getAging_3() {
		return aging_3;
	}

	public void setAging_3(String aging_3) {
		this.aging_3 = aging_3;
	}

	public String getAging_4() {
		return aging_4;
	}

	public void setAging_4(String aging_4) {
		this.aging_4 = aging_4;
	}

	public String getAging_5() {
		return aging_5;
	}

	public void setAging_5(String aging_5) {
		this.aging_5 = aging_5;
	}

	public String getAging_6() {
		return aging_6;
	}

	public void setAging_6(String aging_6) {
		this.aging_6 = aging_6;
	}

	public SalesmanPerformance(String smCode, String srNo, String perf_ttl, String yrTot) {
		super();
		this.smCode = smCode;
		this.srNo = srNo;
		this.perf_ttl = perf_ttl;
		this.yrTot = yrTot;
	}

	public SalesmanPerformance(String smCode, String srNo, String perf_ttl, String yrTot,
			Map<String, String> salesEngList) {
		super();
		this.smCode = smCode;
		this.srNo = srNo;
		this.perf_ttl = perf_ttl;
		this.yrTot = yrTot;
		this.salesEnglist = salesEngList;
	}

	public SalesmanPerformance(String smCode, String srNo, String perf_ttl, String yrTot, String aging_1,
			String aging_2, String aging_3, String aging_4, String aging_5, String aging_6) {
		super();
		this.smCode = smCode;
		this.srNo = srNo;
		this.perf_ttl = perf_ttl;
		this.yrTot = yrTot;
		this.aging_1 = aging_1;
		this.aging_2 = aging_2;
		this.aging_3 = aging_3;
		this.aging_4 = aging_4;
		this.aging_5 = aging_5;
		this.aging_6 = aging_6;

	}

}
