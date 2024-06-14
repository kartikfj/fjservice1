package beans;

public class SipDivForecast {

	private String divname = null;
	private String forecast = null;
	private String invoiced = null;
	private String revForecast = null;
	private String variance = null;
	private String targ_perc = null;
	private String procs_date = null;

	public String getDivname() {
		return divname;
	}

	public void setDivname(String divname) {
		this.divname = divname;
	}

	public String getForecast() {
		return forecast;
	}

	public void setForecast(String forecast) {
		this.forecast = forecast;
	}

	public String getInvoiced() {
		return invoiced;
	}

	public void setInvoiced(String invoiced) {
		this.invoiced = invoiced;
	}

	public String getRevForecast() {
		return revForecast;
	}

	public void setRevForecast(String revForecast) {
		this.revForecast = revForecast;
	}

	public String getVariance() {
		return variance;
	}

	public void setVariance(String variance) {
		this.variance = variance;
	}

	public String getTarg_perc() {
		return targ_perc;
	}

	public void setTarg_perc(String targ_perc) {
		this.targ_perc = targ_perc;
	}

	public String getProcs_date() {
		return procs_date;
	}

	public void setProcs_date(String procs_date) {
		this.procs_date = procs_date;
	}

	public SipDivForecast(String divname, String forecast, String invoiced, String revForecast, String variance,
			String targ_perc, String procs_date) {
		super();
		this.divname = divname;
		this.forecast = forecast;
		this.invoiced = invoiced;
		this.revForecast = revForecast;
		this.variance = variance;
		this.targ_perc = targ_perc;
		this.procs_date = procs_date;
	}

}
