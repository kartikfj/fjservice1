package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipBooking;
import beans.SipDmListForManagementDashboard;

public class ConsolidatedReportDbUtil {

	public List<SipBooking> workingCapitalSummary(int iYear, String selCat) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		SipBooking tempTotalWorkingCap = null;
		float inv[] = new float[15];
		float pay[] = new float[15];
		float tot[] = new float[15];
		float rec[] = new float[15];
		int i = 1, j = 0;

		List<SipBooking> totalWorkingCap = new ArrayList<>();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM WC_POS_FJ WHERE WC_YEAR = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, iYear);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				i = 3;
				if (selCat.equals("Rec")) {
					String divsion = myRes.getString(2);
					String jan_tmp = myRes.getString(3);
					String feb_tmp = myRes.getString(4);
					String mar_tmp = myRes.getString(5);
					String apr_tmp = myRes.getString(6);
					String may_tmp = myRes.getString(7);
					String jun_tmp = myRes.getString(8);
					String jul_tmp = myRes.getString(9);
					String aug_tmp = myRes.getString(10);
					String sep_tmp = myRes.getString(11);
					String oct_tmp = myRes.getString(12);
					String nov_tmp = myRes.getString(13);
					String dec_tmp = myRes.getString(14);
					String tar_tmp = myRes.getString(15);
					SipBooking tempSummary = new SipBooking(divsion, "", "", "", jan_tmp, feb_tmp, mar_tmp, apr_tmp,
							may_tmp, jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp);
					totalWorkingCap.add(tempSummary);
				}
				/*
				 * if (selCat.equals("Inv")) { for (i = 16, j = 0; i <= 28; i++, j++) { inv[j] =
				 * myRes.getFloat(i); } tempTotalWorkingCap = new SipBooking(inv); } if
				 * (selCat.equals("Pay")) { for (i = 29, j = 0; i <= 41; i++, j++) { pay[j] =
				 * myRes.getFloat(i); } tempTotalWorkingCap = new SipBooking(pay); }
				 * 
				 * if (selCat.equals("Pay")) { for (j = 0; j <= 13; j++) { pay[j] = rec[j] +
				 * inv[j] - pay[j]; } tempTotalWorkingCap = new SipBooking(pay); }
				 */

			}
			return totalWorkingCap;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	private void close(Statement myStmt, ResultSet myRes) {
		try {
			if (myRes != null) {
				myRes.close();
			}
			if (myStmt != null) {
				myStmt.close();
			}
		} catch (Exception exc) {
			exc.printStackTrace();
		}
	}

	public List<SipBooking> workingCapitalSummary(String theDmCode, int iYear, String dvCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		double inv[] = new double[15];
		double pay[] = new double[15];
		double tot[] = new double[15];
		double rec[] = new double[15];
		double temprec = 0, tempinv = 0, temppay = 0, tempavgtot = 0, wctartot = 0;

		int i = 1, j = 0;
		double reccount = 0, invcount = 0, paycount = 0, avgtotcount = 0;
		List<SipBooking> totalWorkingCap = new ArrayList<>();

		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dvCode != null && dvCode.equals("")) {
				sql = "SELECT * FROM WC_POS_FJ WHERE WC_CAT = (SELECT DISTINCT CATG	 FROM DISC_DIVN_CAT WHERE DMEMPCODE = ? ) AND WC_YEAR = ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDmCode);
				myStmt.setInt(2, iYear);
				myRes = myStmt.executeQuery();

			} else {
				sql = "SELECT * FROM WC_POS_FJ WHERE WC_CAT = ? AND WC_YEAR = ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dvCode);
				myStmt.setInt(2, iYear);
				myRes = myStmt.executeQuery();

			}
			while (myRes.next()) {
				// sett = (i / 13) + 1;
				i = 3;

				for (i = 3, j = 0; i <= 15; i++, j++) {
					rec[j] = myRes.getDouble(i);
					if (j < 12) {
						temprec = temprec + rec[j];
						if (rec[j] > 0) {
							reccount = reccount + 1;
						}
						System.out.printf("rec == : %.2f ", rec[j]);
					}
					if (j == 12) {
						wctartot = wctartot + rec[j];
					}
				}

				for (i = 16, j = 0; i <= 28; i++, j++) {
					inv[j] = myRes.getDouble(i);
					if (j < 12) {
						tempinv = tempinv + inv[j];
						if (inv[j] > 0) {
							invcount = invcount + 1;
						}
					}
					if (j == 12) {
						wctartot = wctartot + inv[j];
					}
					System.out.printf("inv== : %.2f ", inv[j]);
				}

				for (i = 29, j = 0; i <= 41; i++, j++) {
					pay[j] = myRes.getDouble(i);
					if (j < 12) {
						temppay = temppay + pay[j];
						if (pay[j] > 0) {
							paycount = paycount + 1;
						}
					}
					if (j == 12) {
						wctartot = wctartot - pay[j];
					}
					System.out.printf("wctartot ", wctartot);
				}

				for (j = 0; j <= 13; j++) {
					tot[j] = rec[j] + inv[j] - pay[j];
					// System.out.println("rec=== " + rec[j] + " inv == " + inv[j] + " pay== " +
					// pay[j]);
					// double ff = rec[j] + inv[j] - pay[j];
					System.out.println("total " + tot[j]);

				}
				for (j = 0; j < 12; j++) {
					System.out.println(tot[j]);
					tempavgtot = tempavgtot + tot[j];
					if (tot[j] > 0) {
						avgtotcount = avgtotcount + 1;
					}
				}

				if (temprec > 0)
					temprec = temprec / reccount;
				if (tempinv > 0)
					tempinv = tempinv / invcount;
				if (temppay > 0)
					temppay = temppay / paycount;
				if (tempavgtot > 0)
					tempavgtot = tempavgtot / avgtotcount;

				System.out.println(
						"rec==" + temprec + "inv==" + tempinv + "pay==" + temppay + "tempavgtot==" + tempavgtot);

				SipBooking tempTotalWorkingCap = new SipBooking(rec, inv, pay, tot, temprec, tempinv, temppay,
						tempavgtot, wctartot);
				totalWorkingCap.add(tempTotalWorkingCap);
			}

		} catch (Exception e) {
			System.out.println("Exception in workingCapitalSummary" + e);
		}

		finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return totalWorkingCap;
	}

	public List<SipBooking> fundsBlockedSummary(String theDmCode, int iYear, String dvCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		List<SipBooking> totalFundsBlocked = new ArrayList<>();
		double inv120180[] = new double[15];
		double inv180365[] = new double[15];
		double inv366[] = new double[15];

		double rec120180[] = new double[15];
		double rec180365[] = new double[15];
		double rec366[] = new double[15];

		double totrec[] = new double[15];
		double totinv[] = new double[15];
		double totblockedfunds[] = new double[15];

		double tempavgrec1 = 0, tempavgrec2 = 0, tempavgrec3 = 0;
		double tempavginv1 = 0, tempavginv2 = 0, tempavginv3 = 0;
		double tempavgfbtot = 0, avgtotrec = 0, avgtotinv = 0;
		double reccount1 = 0, reccount2 = 0, reccount3 = 0, invcount1 = 0, invcount2 = 0, invcount3 = 0,
				tempavgfbcount = 0, avgreccount = 0, avginvcount = 0;

		double fbrectartot = 0, fbinvtartot = 0, tottar = 0;

		int i = 1, j = 0;

		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			// String sql = " SELECT * FROM FUND_BLOC_FJ WHERE FB_CAT = (SELECT DISTINCT
			// CATG FROM DISC_DIVN_CAT WHERE DMEMPCODE = ? ) AND FB_YEAR = ?";
			if (dvCode != null && dvCode.equals("")) {
				sql = "SELECT * FROM FUND_BLOC_FJ WHERE FB_CAT = (SELECT DISTINCT CATG FROM DISC_DIVN_CAT WHERE DMEMPCODE = ? ) AND FB_YEAR = ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDmCode);
				myStmt.setInt(2, iYear);
				myRes = myStmt.executeQuery();

			} else {
				sql = "SELECT * FROM FUND_BLOC_FJ WHERE FB_CAT = ? AND FB_YEAR = ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dvCode);
				myStmt.setInt(2, iYear);
				myRes = myStmt.executeQuery();

			}

			// myStmt = myCon.prepareStatement(sql);
			// myStmt.setString(1, theDmCode);
			// myStmt.setInt(2, iYear);
			// myRes = myStmt.executeQuery();
			while (myRes.next()) {
				i = 3;

				for (i = 3, j = 0; i <= 15; i++, j++) {
					rec120180[j] = myRes.getDouble(i);
					if (j < 12) {
						tempavgrec1 = tempavgrec1 + rec120180[j];
						if (rec120180[j] > 0) {
							reccount1 = reccount1 + 1;
						}

					}
					if (j == 12) {
						fbrectartot = fbrectartot + rec120180[j];
					}
				}
				for (i = 16, j = 0; i <= 28; i++, j++) {
					rec180365[j] = myRes.getFloat(i);
					if (j < 12) {
						tempavgrec2 = tempavgrec2 + rec180365[j];
						if (rec180365[j] > 0) {
							reccount2 = reccount2 + 1;
						}
					}
					if (j == 12) {
						fbrectartot = fbrectartot + rec180365[j];
					}
				}
				for (i = 29, j = 0; i <= 41; i++, j++) {
					rec366[j] = myRes.getDouble(i);
					if (j < 12) {
						tempavgrec3 = tempavgrec3 + rec366[j];
						if (rec366[j] > 0) {
							reccount3 = reccount3 + 1;
						}
					}
					if (j == 12) {
						fbrectartot = fbrectartot + rec366[j];
					}
				}

				for (i = 42, j = 0; i <= 54; i++, j++) {
					inv120180[j] = myRes.getDouble(i);
					if (j < 12) {
						tempavginv1 = tempavginv1 + inv120180[j];
						if (inv120180[j] > 0) {
							invcount1 = invcount1 + 1;
						}
					}
					if (j == 12) {
						fbinvtartot = fbinvtartot + inv120180[j];
					}
				}
				for (i = 55, j = 0; i <= 67; i++, j++) {
					inv180365[j] = myRes.getDouble(i);
					if (j < 12) {
						tempavginv2 = tempavginv2 + inv180365[j];
						if (inv180365[j] > 0) {
							invcount2 = invcount2 + 1;
						}
					}
					if (j == 12) {
						fbinvtartot = fbinvtartot + inv180365[j];
					}
				}
				for (i = 68, j = 0; i <= 80; i++, j++) {
					inv366[j] = myRes.getDouble(i);
					if (j < 12) {
						tempavginv3 = tempavginv3 + inv366[j];
						if (inv366[j] > 0) {
							invcount3 = invcount3 + 1;
						}
					}
					if (j == 12) {
						fbinvtartot = fbinvtartot + inv366[j];
					}
				}

				for (j = 0; j <= 13; j++) {
					totrec[j] = rec120180[j] + rec180365[j] + rec366[j];
				}
				for (j = 0; j < 12; j++) {
					avgtotrec = totrec[j] + avgtotrec;
					if (totrec[j] > 0) {
						avgreccount = avgreccount + 1;
					}
				}

				for (j = 0; j <= 13; j++) {
					totinv[j] = inv120180[j] + inv180365[j] + inv366[j];
				}
				for (j = 0; j < 12; j++) {
					avgtotinv = totinv[j] + avgtotinv;
					if (totinv[j] > 0) {
						avginvcount = avginvcount + 1;
					}
				}

				for (j = 0; j <= 13; j++) {
					totblockedfunds[j] = totrec[j] + totinv[j];
				}
				for (j = 0; j < 12; j++) {
					tempavgfbtot = tempavgfbtot + totblockedfunds[j];
					if (totblockedfunds[j] > 0) {
						tempavgfbcount = tempavgfbcount + 1;
					}
				}
				if (tempavgrec1 > 0)
					tempavgrec1 = tempavgrec1 / reccount1;
				if (tempavgrec2 > 0)
					tempavgrec2 = tempavgrec2 / reccount2;
				if (tempavgrec3 > 0)
					tempavgrec3 = tempavgrec3 / reccount3;
				if (tempavginv1 > 0)
					tempavginv1 = tempavginv1 / invcount1;
				if (tempavginv2 > 0)
					tempavginv2 = tempavginv2 / invcount2;
				if (tempavginv3 > 0)
					tempavginv3 = tempavginv3 / invcount3;
				if (avgtotrec > 0)
					avgtotrec = avgtotrec / avgreccount;

				if (avgtotinv > 0)
					avgtotinv = avgtotinv / avginvcount;

				if (tempavgfbtot > 0)
					tempavgfbtot = tempavgfbtot / tempavgfbcount;

				tottar = fbinvtartot + fbrectartot;
				System.out.println("tempavgfbtot" + tempavgfbtot);

				// String dmcode = myRes.getString(1);
				// String wc_at = myRes.getString(2);

				SipBooking tempTotalFundsBlocked = new SipBooking(rec120180, rec180365, rec366, inv120180, inv180365,
						inv366, totrec, totinv, totblockedfunds, tempavgrec1, tempavgrec2, tempavgrec3, tempavginv1,
						tempavginv2, tempavginv3, tempavgfbtot, avgtotrec, avgtotinv, fbrectartot, fbinvtartot, tottar);

				totalFundsBlocked.add(tempTotalFundsBlocked);
			}

		} catch (Exception e) {
			System.out.println("Exception in fundsBlockedSummary" + e);
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return totalFundsBlocked;
	}

	public List<SipBooking> financialPositionSummary(String theDmCode, int iYear, String dvCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		List<SipBooking> totalFinancialPosition = new ArrayList<>();
		double fp_wc[] = new double[15];
		double fp_ec[] = new double[15];
		double fp_adv[] = new double[15];

		double totfp[] = new double[15];
		int i = 1, j = 0;
		double tempfpwc = 0, tempfpec = 0, tempfpadv = 0, tempavgfptot = 0;
		double reccount = 0, invcount = 0, paycount = 0, tempavgfpcount = 0, fptartot = 0;

		try {
			myCon = orcl.getOrclConn();
			// String sql = " SELECT * FROM FIN_POS_FJ WHERE FP_CAT = (SELECT DISTINCT CATG
			// FROM DISC_DIVN_CAT WHERE DMEMPCODE = ?) AND FP_YEAR = ?";
			String sql = "";
			if (dvCode != null && dvCode.equals("")) {
				sql = " SELECT WC_YEAR,WC_CAT,WC_TOTJAN,WC_TOTFEB,WC_TOTMAR,WC_TOTAPR,WC_TOTMAY,WC_TOTJUN,WC_TOTJUL,WC_TOTAUG,WC_TOTSEP,WC_TOTOCT,WC_TOTNOV,WC_TOTDEC,WC_TOTTGT, "
						+ " FP_ECJAN,FP_ECFEB,FP_ECMAR,FP_ECAPR,FP_ECMAY,FP_ECJUN,FP_ECJUL,FP_ECAUG,FP_ECSEP,FP_ECOCT,FP_ECNOV,FP_ECDEC,FP_ECTGT,FP_ADVJAN,FP_ADVFEB,"
						+ " FP_ADVMAR,FP_ADVAPR,FP_ADVMAY,FP_ADVJUN,FP_ADVJUL,FP_ADVAUG,FP_ADVSEP,FP_ADVOCT,FP_ADVNOV,FP_ADVDEC,FP_ADVTGT"
						+ " from "
						+ " (select WC_YEAR,WC_CAT,(NVL(WC_RECJAN,0)+NVL(WC_INVJAN,0)-NVL(WC_PAYJAN,0)) AS WC_TOTJAN,(NVL(WC_RECFEB,0)+NVL(WC_INVFEB,0)-NVL(WC_PAYFEB,0)) AS WC_TOTFEB,(NVL(WC_RECMAR,0)+NVL(WC_INVMAR,0)-NVL(WC_PAYMAR,0)) AS WC_TOTMAR,"
						+ " (NVL(WC_RECAPR,0)+NVL(WC_INVAPR,0)-NVL(WC_PAYAPR,0)) AS WC_TOTAPR,(NVL(WC_RECMAY,0)+NVL(WC_INVMAY,0)-NVL(WC_PAYMAY,0)) AS WC_TOTMAY,(NVL(WC_RECJUN,0)+NVL(WC_INVJUN,0)-NVL(WC_PAYJUN,0)) AS WC_TOTJUN,(NVL(WC_RECJUL,0)+NVL(WC_INVJUL,0)-NVL(WC_PAYJUL,0)) AS WC_TOTJUL,"
						+ " (NVL(WC_RECAUG,0)+NVL(WC_INVAUG,0)-NVL(WC_PAYAUG,0)) AS WC_TOTAUG,(NVL(WC_RECSEP,0)+NVL(WC_INVSEP,0)-NVL(WC_PAYSEP,0)) AS WC_TOTSEP,(NVL(WC_RECOCT,0)+NVL(WC_INVOCT,0)-NVL(WC_PAYOCT,0)) AS WC_TOTOCT,(NVL(WC_RECNOV,0)+NVL(WC_INVNOV,0)-NVL(WC_PAYNOV,0)) AS WC_TOTNOV,"
						+ " (NVL(WC_RECDEC,0)+NVL(WC_INVDEC,0)-NVL(WC_PAYDEC,0)) AS WC_TOTDEC,(NVL(WC_RECTGT,0)+NVL(WC_INVTGT,0)-NVL(WC_PAYTGT,0)) AS WC_TOTTGT from WC_POS_FJ"
						+ " WHERE WC_CAT = (SELECT DISTINCT CATG FROM DISC_DIVN_CAT WHERE DMEMPCODE = ? ) AND WC_YEAR=?) wc,"
						+ " (select FP_YEAR,FP_CAT,FP_ECJAN,FP_ECFEB,FP_ECMAR,FP_ECAPR,FP_ECMAY,FP_ECJUN,FP_ECJUL,FP_ECAUG,FP_ECSEP,FP_ECOCT,FP_ECNOV,FP_ECDEC,FP_ECTGT,"
						+ " FP_ADVJAN,FP_ADVFEB,"
						+ " FP_ADVMAR,FP_ADVAPR,FP_ADVMAY,FP_ADVJUN,FP_ADVJUL,FP_ADVAUG,FP_ADVSEP,FP_ADVOCT,FP_ADVNOV,FP_ADVDEC,FP_ADVTGT from FIN_POS_FJ"
						+ " WHERE   FP_CAT = (SELECT DISTINCT CATG FROM DISC_DIVN_CAT WHERE DMEMPCODE =? ) AND FP_YEAR = ?) fp";

				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDmCode);
				myStmt.setInt(2, iYear);
				myStmt.setString(3, theDmCode);
				myStmt.setInt(4, iYear);
				myRes = myStmt.executeQuery();
			} else {
				sql = " SELECT WC_YEAR,WC_CAT,WC_TOTJAN,WC_TOTFEB,WC_TOTMAR,WC_TOTAPR,WC_TOTMAY,WC_TOTJUN,WC_TOTJUL,WC_TOTAUG,WC_TOTSEP,WC_TOTOCT,WC_TOTNOV,WC_TOTDEC,WC_TOTTGT, "
						+ " FP_ECJAN,FP_ECFEB,FP_ECMAR,FP_ECAPR,FP_ECMAY,FP_ECJUN,FP_ECJUL,FP_ECAUG,FP_ECSEP,FP_ECOCT,FP_ECNOV,FP_ECDEC,FP_ECTGT,FP_ADVJAN,FP_ADVFEB,"
						+ " FP_ADVMAR,FP_ADVAPR,FP_ADVMAY,FP_ADVJUN,FP_ADVJUL,FP_ADVAUG,FP_ADVSEP,FP_ADVOCT,FP_ADVNOV,FP_ADVDEC,FP_ADVTGT"
						+ " from "
						+ " (select WC_YEAR,WC_CAT,(NVL(WC_RECJAN,0)+NVL(WC_INVJAN,0)-NVL(WC_PAYJAN,0)) AS WC_TOTJAN,(NVL(WC_RECFEB,0)+NVL(WC_INVFEB,0)-NVL(WC_PAYFEB,0)) AS WC_TOTFEB,(NVL(WC_RECMAR,0)+NVL(WC_INVMAR,0)-NVL(WC_PAYMAR,0)) AS WC_TOTMAR,"
						+ " (NVL(WC_RECAPR,0)+NVL(WC_INVAPR,0)-NVL(WC_PAYAPR,0)) AS WC_TOTAPR,(NVL(WC_RECMAY,0)+NVL(WC_INVMAY,0)-NVL(WC_PAYMAY,0)) AS WC_TOTMAY,(NVL(WC_RECJUN,0)+NVL(WC_INVJUN,0)-NVL(WC_PAYJUN,0)) AS WC_TOTJUN,(NVL(WC_RECJUL,0)+NVL(WC_INVJUL,0)-NVL(WC_PAYJUL,0)) AS WC_TOTJUL,"
						+ " (NVL(WC_RECAUG,0)+NVL(WC_INVAUG,0)-NVL(WC_PAYAUG,0)) AS WC_TOTAUG,(NVL(WC_RECSEP,0)+NVL(WC_INVSEP,0)-NVL(WC_PAYSEP,0)) AS WC_TOTSEP,(NVL(WC_RECOCT,0)+NVL(WC_INVOCT,0)-NVL(WC_PAYOCT,0)) AS WC_TOTOCT,(NVL(WC_RECNOV,0)+NVL(WC_INVNOV,0)-NVL(WC_PAYNOV,0)) AS WC_TOTNOV,"
						+ " (NVL(WC_RECDEC,0)+NVL(WC_INVDEC,0)-NVL(WC_PAYDEC,0)) AS WC_TOTDEC,(NVL(WC_RECTGT,0)+NVL(WC_INVTGT,0)-NVL(WC_PAYTGT,0)) AS WC_TOTTGT from WC_POS_FJ"
						+ " WHERE WC_CAT = ? AND WC_YEAR=?) wc,"
						+ " (select FP_YEAR,FP_CAT,FP_ECJAN,FP_ECFEB,FP_ECMAR,FP_ECAPR,FP_ECMAY,FP_ECJUN,FP_ECJUL,FP_ECAUG,FP_ECSEP,FP_ECOCT,FP_ECNOV,FP_ECDEC,FP_ECTGT,"
						+ " FP_ADVJAN,FP_ADVFEB,"
						+ " FP_ADVMAR,FP_ADVAPR,FP_ADVMAY,FP_ADVJUN,FP_ADVJUL,FP_ADVAUG,FP_ADVSEP,FP_ADVOCT,FP_ADVNOV,FP_ADVDEC,FP_ADVTGT from FIN_POS_FJ"
						+ " WHERE   FP_CAT = ? AND FP_YEAR = ?) fp";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dvCode);
				myStmt.setInt(2, iYear);
				myStmt.setString(3, dvCode);
				myStmt.setInt(4, iYear);
				myRes = myStmt.executeQuery();
			}
			while (myRes.next()) {
				i = 3;

				for (i = 3, j = 0; i <= 15; i++, j++) {
					fp_wc[j] = myRes.getDouble(i);
					if (j < 12) {
						tempfpwc = tempfpwc + fp_wc[j];
						if (fp_wc[j] > 0) {
							reccount = reccount + 1;
						}
					}
					if (j == 12) {
						fptartot = fptartot + fp_wc[j];
					}
				}
				for (i = 16, j = 0; i <= 28; i++, j++) {
					fp_ec[j] = myRes.getDouble(i);
					if (j < 12) {
						tempfpec = tempfpec + fp_ec[j];
						if (fp_ec[j] > 0) {
							invcount = invcount + 1;
						}
					}
					if (j == 12) {
						fptartot = fptartot - fp_ec[j];
					}
				}
				for (i = 29, j = 0; i <= 41; i++, j++) {
					fp_adv[j] = myRes.getDouble(i);
					if (j < 12) {
						tempfpadv = tempfpadv + fp_adv[j];
						if (fp_adv[j] > 0) {
							paycount = paycount + 1;
						}
					}
					if (j == 12) {
						fptartot = fptartot - fp_adv[j];
					}
				}

				for (j = 0; j <= 13; j++) {
					totfp[j] = fp_wc[j] - fp_ec[j] - fp_adv[j];
				}
				for (j = 0; j < 12; j++) {
					tempavgfptot = tempavgfptot + totfp[j];
					if (totfp[j] != 0) {
						tempavgfpcount = tempavgfpcount + 1;
					}
				}
				System.out.println("tempavgfptot===" + tempavgfptot);
				if (tempfpwc > 0)
					tempfpwc = tempfpwc / reccount;
				if (tempfpec > 0)
					tempfpec = tempfpec / invcount;
				if (tempfpadv > 0)
					tempfpadv = tempfpadv / paycount;
				if (tempavgfptot != 0)
					tempavgfptot = tempavgfptot / tempavgfpcount;

				/*
				 * if (curYear == iYear) { tempfpwc = tempfpwc / month; tempfpec = tempfpec /
				 * month; tempfpadv = tempfpadv / month;
				 * 
				 * } else { tempfpwc = tempfpwc / 12; tempfpec = tempfpec / 12; tempfpadv =
				 * tempfpadv / 12; }
				 */

				// String dmcode = myRes.getString(1);
				// String wc_at = myRes.getString(2);

				SipBooking tempTotalFundsBlocked = new SipBooking(fp_wc, fp_ec, fp_adv, totfp, theDmCode, tempfpwc,
						tempfpec, tempfpadv, tempavgfptot, fptartot);

				totalFinancialPosition.add(tempTotalFundsBlocked);
			}

		} catch (Exception e) {
			System.out.println("Exception in financialPositionSummary" + e);
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return totalFinancialPosition;
	}

	public List<SipBooking> getRequestedDetailsSummary(int iYear, String selCat) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		List<SipBooking> totalWorkingCap = new ArrayList<>();
		try {
			if (selCat.equals("Rec") || selCat.equals("Inv") || selCat.equals("Pay")) {
				myCon = orcl.getOrclConn();
				String sql = "SELECT * FROM WC_POS_FJ WHERE WC_YEAR = ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setInt(1, iYear);
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					if (selCat.equals("Rec")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(3);
						String feb_tmp = myRes.getString(4);
						String mar_tmp = myRes.getString(5);
						String apr_tmp = myRes.getString(6);
						String may_tmp = myRes.getString(7);
						String jun_tmp = myRes.getString(8);
						String jul_tmp = myRes.getString(9);
						String aug_tmp = myRes.getString(10);
						String sep_tmp = myRes.getString(11);
						String oct_tmp = myRes.getString(12);
						String nov_tmp = myRes.getString(13);
						String dec_tmp = myRes.getString(14);
						String tar_tmp = myRes.getString(15);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp, "Receivables");
						totalWorkingCap.add(tempSummary);
					}
					if (selCat.equals("Inv")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(16);
						String feb_tmp = myRes.getString(17);
						String mar_tmp = myRes.getString(18);
						String apr_tmp = myRes.getString(19);
						String may_tmp = myRes.getString(20);
						String jun_tmp = myRes.getString(21);
						String jul_tmp = myRes.getString(22);
						String aug_tmp = myRes.getString(23);
						String sep_tmp = myRes.getString(24);
						String oct_tmp = myRes.getString(25);
						String nov_tmp = myRes.getString(26);
						String dec_tmp = myRes.getString(27);
						String tar_tmp = myRes.getString(28);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp, "Inventory");
						totalWorkingCap.add(tempSummary);
					}
					if (selCat.equals("Pay")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(29);
						String feb_tmp = myRes.getString(30);
						String mar_tmp = myRes.getString(31);
						String apr_tmp = myRes.getString(32);
						String may_tmp = myRes.getString(33);
						String jun_tmp = myRes.getString(34);
						String jul_tmp = myRes.getString(35);
						String aug_tmp = myRes.getString(36);
						String sep_tmp = myRes.getString(37);
						String oct_tmp = myRes.getString(38);
						String nov_tmp = myRes.getString(39);
						String dec_tmp = myRes.getString(40);
						String tar_tmp = myRes.getString(41);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp, "Payables");
						totalWorkingCap.add(tempSummary);
					}

				}
			} else if (selCat.equals("Rec1") || selCat.equals("Rec2") || selCat.equals("Rec3") || selCat.equals("Inv1")
					|| selCat.equals("Inv2") || selCat.equals("Inv3")) {

				myCon = orcl.getOrclConn();
				String sql = "SELECT * FROM FUND_BLOC_FJ where FB_YEAR = ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setInt(1, iYear);
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					if (selCat.equals("Rec1")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(3);
						String feb_tmp = myRes.getString(4);
						String mar_tmp = myRes.getString(5);
						String apr_tmp = myRes.getString(6);
						String may_tmp = myRes.getString(7);
						String jun_tmp = myRes.getString(8);
						String jul_tmp = myRes.getString(9);
						String aug_tmp = myRes.getString(10);
						String sep_tmp = myRes.getString(11);
						String oct_tmp = myRes.getString(12);
						String nov_tmp = myRes.getString(13);
						String dec_tmp = myRes.getString(14);
						String tar_tmp = myRes.getString(15);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
								"Receivables 120-180 days");
						totalWorkingCap.add(tempSummary);
					}
					if (selCat.equals("Rec2")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(16);
						String feb_tmp = myRes.getString(17);
						String mar_tmp = myRes.getString(18);
						String apr_tmp = myRes.getString(19);
						String may_tmp = myRes.getString(20);
						String jun_tmp = myRes.getString(21);
						String jul_tmp = myRes.getString(22);
						String aug_tmp = myRes.getString(23);
						String sep_tmp = myRes.getString(24);
						String oct_tmp = myRes.getString(25);
						String nov_tmp = myRes.getString(26);
						String dec_tmp = myRes.getString(27);
						String tar_tmp = myRes.getString(28);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
								"Receivables 180-365 days");
						totalWorkingCap.add(tempSummary);
					}
					if (selCat.equals("Rec3")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(29);
						String feb_tmp = myRes.getString(30);
						String mar_tmp = myRes.getString(31);
						String apr_tmp = myRes.getString(32);
						String may_tmp = myRes.getString(33);
						String jun_tmp = myRes.getString(34);
						String jul_tmp = myRes.getString(35);
						String aug_tmp = myRes.getString(36);
						String sep_tmp = myRes.getString(37);
						String oct_tmp = myRes.getString(38);
						String nov_tmp = myRes.getString(39);
						String dec_tmp = myRes.getString(40);
						String tar_tmp = myRes.getString(41);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
								"Receivables > 365 days");
						totalWorkingCap.add(tempSummary);
					}
					if (selCat.equals("Inv1")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(42);
						String feb_tmp = myRes.getString(43);
						String mar_tmp = myRes.getString(44);
						String apr_tmp = myRes.getString(45);
						String may_tmp = myRes.getString(46);
						String jun_tmp = myRes.getString(47);
						String jul_tmp = myRes.getString(48);
						String aug_tmp = myRes.getString(49);
						String sep_tmp = myRes.getString(50);
						String oct_tmp = myRes.getString(51);
						String nov_tmp = myRes.getString(52);
						String dec_tmp = myRes.getString(53);
						String tar_tmp = myRes.getString(54);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
								"Inventory 120-180 days");
						totalWorkingCap.add(tempSummary);
					}
					if (selCat.equals("Inv2")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(55);
						String feb_tmp = myRes.getString(56);
						String mar_tmp = myRes.getString(57);
						String apr_tmp = myRes.getString(58);
						String may_tmp = myRes.getString(59);
						String jun_tmp = myRes.getString(60);
						String jul_tmp = myRes.getString(61);
						String aug_tmp = myRes.getString(62);
						String sep_tmp = myRes.getString(63);
						String oct_tmp = myRes.getString(64);
						String nov_tmp = myRes.getString(65);
						String dec_tmp = myRes.getString(66);
						String tar_tmp = myRes.getString(67);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
								"Inventory 180-365 days");
						totalWorkingCap.add(tempSummary);
					}
					if (selCat.equals("Inv3")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(68);
						String feb_tmp = myRes.getString(69);
						String mar_tmp = myRes.getString(70);
						String apr_tmp = myRes.getString(71);
						String may_tmp = myRes.getString(72);
						String jun_tmp = myRes.getString(73);
						String jul_tmp = myRes.getString(74);
						String aug_tmp = myRes.getString(75);
						String sep_tmp = myRes.getString(76);
						String oct_tmp = myRes.getString(77);
						String nov_tmp = myRes.getString(78);
						String dec_tmp = myRes.getString(79);
						String tar_tmp = myRes.getString(80);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
								"Inventory > 365 days");
						totalWorkingCap.add(tempSummary);
					}
				}

			} else if (selCat.equals("EC") || selCat.equals("ADVFC")) {
				myCon = orcl.getOrclConn();
				String sql = "SELECT * FROM FIN_POS_FJ WHERE FP_YEAR = ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setInt(1, iYear);
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					if (selCat.equals("EC")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(16);
						String feb_tmp = myRes.getString(17);
						String mar_tmp = myRes.getString(18);
						String apr_tmp = myRes.getString(19);
						String may_tmp = myRes.getString(20);
						String jun_tmp = myRes.getString(21);
						String jul_tmp = myRes.getString(22);
						String aug_tmp = myRes.getString(23);
						String sep_tmp = myRes.getString(24);
						String oct_tmp = myRes.getString(25);
						String nov_tmp = myRes.getString(26);
						String dec_tmp = myRes.getString(27);
						String tar_tmp = myRes.getString(28);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
								"Equity Capital");
						totalWorkingCap.add(tempSummary);
					}
					if (selCat.equals("ADVFC")) {
						String divsion = myRes.getString(2);
						String jan_tmp = myRes.getString(29);
						String feb_tmp = myRes.getString(30);
						String mar_tmp = myRes.getString(31);
						String apr_tmp = myRes.getString(32);
						String may_tmp = myRes.getString(33);
						String jun_tmp = myRes.getString(34);
						String jul_tmp = myRes.getString(35);
						String aug_tmp = myRes.getString(36);
						String sep_tmp = myRes.getString(37);
						String oct_tmp = myRes.getString(38);
						String nov_tmp = myRes.getString(39);
						String dec_tmp = myRes.getString(40);
						String tar_tmp = myRes.getString(41);
						SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
								jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
								"Adv.from Customers");
						totalWorkingCap.add(tempSummary);
					}

				}
			} else if (selCat.equals("FB")) {
				myCon = orcl.getOrclConn();
				String sql = " SELECT FB_YEAR,FB_CAT,(NVL(FB_REC120180JAN,0)+NVL(FB_REC180365JAN,0)+NVL(FB_REC366JAN,0)+NVL(FB_INV120180JAN,0)+NVL(FB_INV180365JAN,0)+NVL(FB_INV366JAN,0)) AS WC_TOTJAN,\r\n"
						+ "   (NVL(FB_REC120180FEB,0)+NVL(FB_REC180365FEB,0)+NVL(FB_REC366FEB,0)+NVL(FB_INV120180FEB,0)+NVL(FB_INV180365FEB,0)+NVL(FB_INV366FEB,0)) AS WC_TOTFEB,\r\n"
						+ "   (NVL(FB_REC120180MAR,0)+NVL(FB_REC180365MAR,0)+NVL(FB_REC366MAR,0)+NVL(FB_INV120180MAR,0)+NVL(FB_INV180365MAR,0)+NVL(FB_INV366MAR,0)) AS WC_TOTMAR,\r\n"
						+ "   (NVL(FB_REC120180APR,0)+NVL(FB_REC180365APR,0)+NVL(FB_REC366APR,0)+NVL(FB_INV120180APR,0)+NVL(FB_INV180365APR,0)+NVL(FB_INV366APR,0)) AS WC_TOTAPR,\r\n"
						+ "   (NVL(FB_REC120180MAY,0)+NVL(FB_REC180365MAY,0)+NVL(FB_REC366MAY,0)+NVL(FB_INV120180MAY,0)+NVL(FB_INV180365MAY,0)+NVL(FB_INV366MAY,0)) AS WC_TOTMAY,\r\n"
						+ "   (NVL(FB_REC120180JUN,0)+NVL(FB_REC180365JUN,0)+NVL(FB_REC366JUN,0)+NVL(FB_INV120180JUN,0)+NVL(FB_INV180365JUN,0)+NVL(FB_INV366JUN,0)) AS WC_TOTJUN,\r\n"
						+ "   (NVL(FB_REC120180JUL,0)+NVL(FB_REC180365JUL,0)+NVL(FB_REC366JUL,0)+NVL(FB_INV120180JUL,0)+NVL(FB_INV180365JUL,0)+NVL(FB_INV366JUL,0)) AS WC_TOTJUL,\r\n"
						+ "   (NVL(FB_REC120180AUG,0)+NVL(FB_REC180365AUG,0)+NVL(FB_REC366AUG,0)+NVL(FB_INV120180AUG,0)+NVL(FB_INV180365AUG,0)+NVL(FB_INV366AUG,0)) AS WC_TOTAUG,\r\n"
						+ "   (NVL(FB_REC120180SEP,0)+NVL(FB_REC180365SEP,0)+NVL(FB_REC366SEP,0)+NVL(FB_INV120180SEP,0)+NVL(FB_INV180365SEP,0)+NVL(FB_INV366SEP,0)) AS WC_TOTSEP,\r\n"
						+ "   (NVL(FB_REC120180OCT,0)+NVL(FB_REC180365OCT,0)+NVL(FB_REC366OCT,0)+NVL(FB_INV120180OCT,0)+NVL(FB_INV180365OCT,0)+NVL(FB_INV366OCT,0)) AS WC_TOTOCT,\r\n"
						+ "   (NVL(FB_REC120180NOV,0)+NVL(FB_REC180365NOV,0)+NVL(FB_REC366NOV,0)+NVL(FB_INV120180NOV,0)+NVL(FB_INV180365NOV,0)+NVL(FB_INV366NOV,0)) AS WC_TOTNOV,\r\n"
						+ "   (NVL(FB_REC120180DEC,0)+NVL(FB_REC180365DEC,0)+NVL(FB_REC366DEC,0)+NVL(FB_INV120180DEC,0)+NVL(FB_INV180365DEC,0)+NVL(FB_INV366DEC,0)) AS WC_TOTDEC,\r\n"
						+ "   (NVL(FB_REC120180TGT,0)+NVL(FB_REC180365TGT,0)+NVL(FB_REC366TGT,0)+NVL(FB_INV120180TGT,0)+NVL(FB_INV180365TGT,0)+NVL(FB_INV366TGT,0)) AS WC_TOTTGT\r\n"
						+ "     FROM FUND_BLOC_FJ WHERE FB_YEAR = ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setInt(1, iYear);
				myRes = myStmt.executeQuery();
				while (myRes.next()) {

					String divsion = myRes.getString(2);
					String jan_tmp = myRes.getString(3);
					String feb_tmp = myRes.getString(4);
					String mar_tmp = myRes.getString(5);
					String apr_tmp = myRes.getString(6);
					String may_tmp = myRes.getString(7);
					String jun_tmp = myRes.getString(8);
					String jul_tmp = myRes.getString(9);
					String aug_tmp = myRes.getString(10);
					String sep_tmp = myRes.getString(11);
					String oct_tmp = myRes.getString(12);
					String nov_tmp = myRes.getString(13);
					String dec_tmp = myRes.getString(14);
					String tar_tmp = myRes.getString(15);
					SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
							jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp, "Funds Blocked");
					totalWorkingCap.add(tempSummary);
				}
			} else if (selCat.equals("NetWC")) {
				myCon = orcl.getOrclConn();
				String sql = " select WC_YEAR,WC_CAT,(NVL(WC_RECJAN,0)+NVL(WC_INVJAN,0)-NVL(WC_PAYJAN,0)) AS WC_TOTJAN,(NVL(WC_RECFEB,0)+NVL(WC_INVFEB,0)-NVL(WC_PAYFEB,0)) AS WC_TOTFEB,(NVL(WC_RECMAR,0)+NVL(WC_INVMAR,0)-NVL(WC_PAYMAR,0)) AS WC_TOTMAR,\r\n"
						+ " (NVL(WC_RECAPR,0)+NVL(WC_INVAPR,0)-NVL(WC_PAYAPR,0)) AS WC_TOTAPR,(NVL(WC_RECMAY,0)+NVL(WC_INVMAY,0)-NVL(WC_PAYMAY,0)) AS WC_TOTMAY,(NVL(WC_RECJUN,0)+NVL(WC_INVJUN,0)-NVL(WC_PAYJUN,0)) AS WC_TOTJUN,\r\n"
						+ " (NVL(WC_RECJUL,0)+NVL(WC_INVJUL,0)-NVL(WC_PAYJUL,0)) AS WC_TOTJUL,(NVL(WC_RECAUG,0)+NVL(WC_INVAUG,0)-NVL(WC_PAYAUG,0)) AS WC_TOTAUG,(NVL(WC_RECSEP,0)+NVL(WC_INVSEP,0)-NVL(WC_PAYSEP,0)) AS WC_TOTSEP,\r\n"
						+ " (NVL(WC_RECOCT,0)+NVL(WC_INVOCT,0)-NVL(WC_PAYOCT,0)) AS WC_TOTOCT,(NVL(WC_RECNOV,0)+NVL(WC_INVNOV,0)-NVL(WC_PAYNOV,0)) AS WC_TOTNOV,(NVL(WC_RECDEC,0)+NVL(WC_INVDEC,0)-NVL(WC_PAYDEC,0)) AS WC_TOTDEC,\r\n"
						+ " (NVL(WC_RECTGT,0)+NVL(WC_INVTGT,0)-NVL(WC_PAYTGT,0)) AS WC_TOTTGT from WC_POS_FJ WHERE WC_YEAR=?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setInt(1, iYear);
				myRes = myStmt.executeQuery();
				while (myRes.next()) {

					String divsion = myRes.getString(2);
					String jan_tmp = myRes.getString(3);
					String feb_tmp = myRes.getString(4);
					String mar_tmp = myRes.getString(5);
					String apr_tmp = myRes.getString(6);
					String may_tmp = myRes.getString(7);
					String jun_tmp = myRes.getString(8);
					String jul_tmp = myRes.getString(9);
					String aug_tmp = myRes.getString(10);
					String sep_tmp = myRes.getString(11);
					String oct_tmp = myRes.getString(12);
					String nov_tmp = myRes.getString(13);
					String dec_tmp = myRes.getString(14);
					String tar_tmp = myRes.getString(15);
					SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
							jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp,
							"Net. Working Capital");
					totalWorkingCap.add(tempSummary);
				}
			} else if (selCat.equals("BNKL")) {
				myCon = orcl.getOrclConn();
				String sql = "SELECT WC_YEAR,WC_CAT,(NVL(WC_TOTJAN,0)-NVL(FP_ECJAN,0)-NVL(FP_ADVJAN,0))as JAN,(NVL(WC_TOTFEB,0)-NVL(FP_ECFEB,0)-NVL(FP_ADVFEB,0)) as FEB,(NVL(WC_TOTMAR,0)-NVL(FP_ECMAR,0)-NVL(FP_ADVMAR,0)) as MAR,"
						+ " (NVL(WC_TOTAPR,0)-NVL(FP_ECAPR,0)-NVL(FP_ADVAPR,0)) as APR,(NVL(WC_TOTMAY,0)-NVL(FP_ECMAY,0)-NVL(FP_ADVMAY,0)) as MAY,(NVL(WC_TOTJUN,0)-NVL(FP_ECJUN,0)-NVL(FP_ADVJUN,0)) as JUN,"
						+ " (NVL(WC_TOTJUL,0)-NVL(FP_ECJUL,0)-NVL(FP_ADVJUL,0)) as JUL,(NVL(WC_TOTAUG,0)-NVL(FP_ECAUG,0)-NVL(FP_ADVAUG,0)) as AUG,(NVL(WC_TOTSEP,0)-NVL(FP_ECSEP,0)-NVL(FP_ADVSEP,0)) as SEP,"
						+ " (NVL(WC_TOTOCT,0)-NVL(FP_ECOCT,0)-NVL(FP_ADVOCT,0)) as OCT,(NVL(WC_TOTNOV,0)-NVL(FP_ECNOV,0)-NVL(FP_ADVNOV,0)) as NOV,(NVL(WC_TOTDEC,0)-NVL(FP_ECDEC,0)-NVL(FP_ADVDEC,0)) as DEC,"
						+ " (NVL(WC_TOTTGT,0)-NVL(FP_ECTGT,0)-NVL(FP_ADVTGT,0)) as TGT "
						// + "
						// FP_ECJAN,FP_ECFEB,FP_ECMAR,FP_ECAPR,FP_ECMAY,FP_ECJUN,FP_ECJUL,FP_ECAUG,FP_ECSEP,FP_ECOCT,FP_ECNOV,FP_ECDEC,FP_ECTGT,FP_ADVJAN,FP_ADVFEB,"
						// + "
						// FP_ADVMAR,FP_ADVAPR,FP_ADVMAY,FP_ADVJUN,FP_ADVJUL,FP_ADVAUG,FP_ADVSEP,FP_ADVOCT,FP_ADVNOV,FP_ADVDEC,FP_ADVTGT
						// "
						+ " from "
						+ " (select WC_YEAR,WC_CAT,(NVL(WC_RECJAN,0)+NVL(WC_INVJAN,0)-NVL(WC_PAYJAN,0)) AS WC_TOTJAN,(NVL(WC_RECFEB,0)+NVL(WC_INVFEB,0)-NVL(WC_PAYFEB,0)) AS WC_TOTFEB,(NVL(WC_RECMAR,0)+NVL(WC_INVMAR,0)-NVL(WC_PAYMAR,0)) AS WC_TOTMAR,\r\n"
						+ " (NVL(WC_RECAPR,0)+NVL(WC_INVAPR,0)-NVL(WC_PAYAPR,0)) AS WC_TOTAPR,(NVL(WC_RECMAY,0)+NVL(WC_INVMAY,0)-NVL(WC_PAYMAY,0)) AS WC_TOTMAY,(NVL(WC_RECJUN,0)+NVL(WC_INVJUN,0)-NVL(WC_PAYJUN,0)) AS WC_TOTJUN,(NVL(WC_RECJUL,0)+NVL(WC_INVJUL,0)-NVL(WC_PAYJUL,0)) AS WC_TOTJUL,\r\n"
						+ " (NVL(WC_RECAUG,0)+NVL(WC_INVAUG,0)-NVL(WC_PAYAUG,0)) AS WC_TOTAUG,(NVL(WC_RECSEP,0)+NVL(WC_INVSEP,0)-NVL(WC_PAYSEP,0)) AS WC_TOTSEP,(NVL(WC_RECOCT,0)+NVL(WC_INVOCT,0)-NVL(WC_PAYOCT,0)) AS WC_TOTOCT,(NVL(WC_RECNOV,0)+NVL(WC_INVNOV,0)-NVL(WC_PAYNOV,0)) AS WC_TOTNOV,\r\n"
						+ " (NVL(WC_RECDEC,0)+NVL(WC_INVDEC,0)-NVL(WC_PAYDEC,0)) AS WC_TOTDEC,(NVL(WC_RECTGT,0)+NVL(WC_INVTGT,0)-NVL(WC_PAYTGT,0)) AS WC_TOTTGT from WC_POS_FJ "
						+ " WHERE  WC_YEAR= ?) wc,"
						+ " (select FP_YEAR,FP_CAT,FP_ECJAN,FP_ECFEB,FP_ECMAR,FP_ECAPR,FP_ECMAY,FP_ECJUN,FP_ECJUL,FP_ECAUG,FP_ECSEP,FP_ECOCT,FP_ECNOV,FP_ECDEC,FP_ECTGT,"
						+ " FP_ADVJAN,FP_ADVFEB,"
						+ " FP_ADVMAR,FP_ADVAPR,FP_ADVMAY,FP_ADVJUN,FP_ADVJUL,FP_ADVAUG,FP_ADVSEP,FP_ADVOCT,FP_ADVNOV,FP_ADVDEC,FP_ADVTGT from FIN_POS_FJ "
						+ " WHERE  FP_YEAR = ?) fp " + " where wc.wc_cat = fp.fp_cat";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setInt(1, iYear);
				myStmt.setInt(2, iYear);
				myRes = myStmt.executeQuery();
				while (myRes.next()) {

					String divsion = myRes.getString(2);
					String jan_tmp = myRes.getString(3);
					String feb_tmp = myRes.getString(4);
					String mar_tmp = myRes.getString(5);
					String apr_tmp = myRes.getString(6);
					String may_tmp = myRes.getString(7);
					String jun_tmp = myRes.getString(8);
					String jul_tmp = myRes.getString(9);
					String aug_tmp = myRes.getString(10);
					String sep_tmp = myRes.getString(11);
					String oct_tmp = myRes.getString(12);
					String nov_tmp = myRes.getString(13);
					String dec_tmp = myRes.getString(14);
					String tar_tmp = myRes.getString(15);
					SipBooking tempSummary = new SipBooking(divsion, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp,
							jun_tmp, jul_tmp, aug_tmp, sep_tmp, oct_tmp, nov_tmp, dec_tmp, tar_tmp, "Bank Loan");
					totalWorkingCap.add(tempSummary);
				}
			}
			return totalWorkingCap;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBooking> getAllDivisionsForUser(String dm_Emp_Code) throws SQLException {
		// System.out.println("DM EMP CODE db: "+dm_Emp_Code);
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		List<SipBooking> divisionList = new ArrayList<>();
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT DISTINCT CATG FROM DISC_DIVN_CAT WHERE DMEMPCODE = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_Emp_Code);
			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				String division = myRes.getString(1);
				// String dm_name_tmp = myRes.getString(2);
				SipBooking tempdmList = new SipBooking(division, division);
				divisionList.add(tempdmList);
			}
			return divisionList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipDmListForManagementDashboard> getDMListfor_Mg() throws SQLException {
		List<SipDmListForManagementDashboard> dmList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " select DISTINCT DMEMPCODE, DMNAME FROM DISC_DIVN_CAT WHERE DMNAME IS NOT NULL AND DMEMPCODE IS NOT NULL";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String dm_code_tmp = myRes.getString(1);
				String dm_name_tmp = myRes.getString(2);
				SipDmListForManagementDashboard tempdmList = new SipDmListForManagementDashboard(dm_code_tmp,
						dm_name_tmp);
				dmList.add(tempdmList);
			}
			return dmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
}
