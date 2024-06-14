package beans;

import java.sql.Date;

public class SalesManForecast {
	private String s3Forecast = null;
	private String s4Forecast = null;
	private Date reqDate;
	private String s5Forecast = null;
	private String empcode = null;
	private String smCode = null;
	private String week = null;
	private String company = null;
	private String division = null;
	private String salesman_code = null;
	private String salesman_name = null;
	private String salesman_emp_code = null;

	public String getS3Forecast() {
		return s3Forecast;
	}

	public void setS3Forecast(String s3Forecast) {
		this.s3Forecast = s3Forecast;
	}

	public String getS4Forecast() {
		return s4Forecast;
	}

	public void setS4Forecast(String s4Forecast) {
		this.s4Forecast = s4Forecast;
	}

	public Date getReqDate() {
		return reqDate;
	}

	public void setReqDate(Date reqDate) {
		this.reqDate = reqDate;
	}

	public String getS5Forecast() {
		return s5Forecast;
	}

	public void setS5Forecast(String s5Forecast) {
		this.s5Forecast = s5Forecast;
	}

	public String getEmpcode() {
		return empcode;
	}

	public void setEmpcode(String empcode) {
		this.empcode = empcode;
	}

	public String getSmCode() {
		return smCode;
	}

	public void setSmCode(String smCode) {
		this.smCode = smCode;
	}

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
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

	public String getSalesman_code() {
		return salesman_code;
	}

	public void setSalesman_code(String salesman_code) {
		this.salesman_code = salesman_code;
	}

	public String getSalesman_name() {
		return salesman_name;
	}

	public void setSalesman_name(String salesman_name) {
		this.salesman_name = salesman_name;
	}

	public String getSalesman_emp_code() {
		return salesman_emp_code;
	}

	public void setSalesman_emp_code(String salesman_emp_code) {
		this.salesman_emp_code = salesman_emp_code;
	}

	public SalesManForecast(String salesman_code, String salesman_name, String salesman_emp_code, String s3Forecast,
			String s4Forecast, String s5Forecast) {
		this.salesman_code = salesman_code;
		this.salesman_name = salesman_name;
		this.salesman_emp_code = salesman_emp_code;
		this.s3Forecast = s3Forecast;
		this.s4Forecast = s4Forecast;
		this.s5Forecast = s5Forecast;
	}

}
