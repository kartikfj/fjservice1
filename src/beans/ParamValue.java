/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author  
 */
public class ParamValue {
	private Date from;
	private Date to;
	private Time value;
	private String name;

	public boolean getCheckInRange(Date dt) {
		if (dt.getTime() >= getFrom().getTime() && dt.getTime() <= getTo().getTime()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * @return the from
	 */
	public Date getFrom() {
		return from;
	}

	/**
	 * @param from
	 *            the from to set
	 */
	public void setFrom(Date from) {
		this.from = from;
	}

	/**
	 * @return the to
	 */
	public Date getTo() {
		return to;
	}

	/**
	 * @param to
	 *            the to to set
	 */
	public void setTo(Date to) {
		this.to = to;
	}

	/**
	 * @return the value
	 */
	public Time getValue() {
		return value;
	}

	/**
	 * @param value
	 *            the value to set
	 */
	public void setValue(Time value) {
		this.value = value;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

}
