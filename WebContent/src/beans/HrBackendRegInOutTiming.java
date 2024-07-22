package beans;

import java.sql.Time;
 
public class HrBackendRegInOutTiming {
	private Time checkin;
	private Time checkout;
	private String status;

	public void setCheckin(Time s) {
		checkin = s;
	}

	public void setCheckout(Time s) {
		checkout = s;
	}

	public Time getCheckout() {
		return checkout;
	}

	public Time getCheckin() {
		return checkin;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	public HrBackendRegInOutTiming(Time checkin, Time checkout, String status) {
		super();
		this.checkin = checkin;
		this.checkout = checkout;
		this.status = status;
	}
 
}