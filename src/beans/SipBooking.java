package beans;

public class SipBooking {

	double rec[] = new double[15];
	double inv[] = new double[15];
	double pay[] = new double[15];
	double wctotal[] = new double[15];

	double selCat[] = new double[15];

	double bfrec120180[] = new double[15];
	double bfrec180365[] = new double[15];
	double bfrec366[] = new double[15];
	double bfinv120180[] = new double[15];
	double bfinv180365[] = new double[15];
	double bfinv366[] = new double[15];
	double bftotrec[] = new double[15];
	double bftotinv[] = new double[15];
	double totalbcfunds[] = new double[15];

	double fp_wc[] = new double[15];
	double fp_ec[] = new double[15];
	double fp_adv[] = new double[15];
	double fp_total[] = new double[15];

	double averrec = 0.0;
	double aveinv = 0.0;
	double avepay = 0.0;

	double avgfpwc = 0.0;
	double avgfpec = 0.0;
	double avgfpadv = 0.0;

	double avgrec1 = 0.0;
	double avginv2 = 0.0;
	double avginv1 = 0.0;
	double avgrec2 = 0.0;
	double avginv3 = 0.0;
	double avgrec3 = 0.0;

	double wctartot = 0.0;

	double fbrectartot = 0.0;
	double fbinvtartot = 0.0;
	double fbtartot = 0.0;

	double fptartot = 0.0;

	private String dm_emp_code = null;
	private String company = null;
	private String year = null;
	private String monthly_target = null;
	private String yr_total_target = null;
	private String ytm_target = null;
	private String jan = null;
	private String feb = null;
	private String mar = null;
	private String apr = null;
	private String may = null;
	private String jun = null;
	private String jul = null;
	private String aug = null;
	private String sep = null;
	private String oct = null;
	private String nov = null;
	private String dec = null;
	private String ytm_actual = null;

	private String division = null;

	private String divisionName = null;

	private String category = null;

	private float total_jan;
	private float total_feb;
	private float total_mar;
	private float total_apr;
	private float total_may;
	private float total_jun;
	private float total_jul;
	private float total_aug;
	private float total_sep;
	private float total_oct;
	private float total_nov;
	private float total_dec;

	private double fbavgtot;
	private double fpavgtot;
	private double wcavgtot;

	private double avgtotrec;
	private double avgtotinv;

	public String getDivisionName() {
		return divisionName;
	}

	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}

	public String getCompany() {
		return company;
	}

	public double[] getRec() {
		return rec;
	}

	public void setRec(double[] rec) {
		this.rec = rec;
	}

	public double[] getInv() {
		return inv;
	}

	public void setInv(double[] inv) {
		this.inv = inv;
	}

	public double[] getPay() {
		return pay;
	}

	public void setPay(double[] pay) {
		this.pay = pay;
	}

	public double[] getWctotal() {
		return wctotal;
	}

	public void setWctotal(double[] wctotal) {
		this.wctotal = wctotal;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonthly_target() {
		return monthly_target;
	}

	public void setMonthly_target(String monthly_target) {
		this.monthly_target = monthly_target;
	}

	public String getYr_total_target() {
		return yr_total_target;
	}

	public void setYr_total_target(String yr_total_target) {
		this.yr_total_target = yr_total_target;
	}

	public String getYtm_target() {
		return ytm_target;
	}

	public void setYtm_target(String ytm_target) {
		this.ytm_target = ytm_target;
	}

	public String getJan() {
		return jan;
	}

	public void setJan(String jan) {
		this.jan = jan;
	}

	public String getFeb() {
		return feb;
	}

	public void setFeb(String feb) {
		this.feb = feb;
	}

	public String getMar() {
		return mar;
	}

	public void setMar(String mar) {
		this.mar = mar;
	}

	public String getApr() {
		return apr;
	}

	public void setApr(String apr) {
		this.apr = apr;
	}

	public String getMay() {
		return may;
	}

	public void setMay(String may) {
		this.may = may;
	}

	public String getJun() {
		return jun;
	}

	public void setJun(String jun) {
		this.jun = jun;
	}

	public String getJul() {
		return jul;
	}

	public void setJul(String jul) {
		this.jul = jul;
	}

	public String getAug() {
		return aug;
	}

	public void setAug(String aug) {
		this.aug = aug;
	}

	public String getSep() {
		return sep;
	}

	public void setSep(String sep) {
		this.sep = sep;
	}

	public String getOct() {
		return oct;
	}

	public void setOct(String oct) {
		this.oct = oct;
	}

	public String getNov() {
		return nov;
	}

	public void setNov(String nov) {
		this.nov = nov;
	}

	public String getDec() {
		return dec;
	}

	public void setDec(String dec) {
		this.dec = dec;
	}

	public String getYtm_actual() {
		return ytm_actual;
	}

	public void setYtm_actual(String ytm_actual) {
		this.ytm_actual = ytm_actual;
	}

	public String getDm_emp_code() {
		return dm_emp_code;
	}

	public void setDm_emp_code(String dm_emp_code) {
		this.dm_emp_code = dm_emp_code;
	}

	public Double getAverrec() {
		return averrec;
	}

	public void setAverrec(Double averrec) {
		this.averrec = averrec;
	}

	public Double getAveinv() {
		return aveinv;
	}

	public void setAveinv(Double aveinv) {
		this.aveinv = aveinv;
	}

	public Double getAvepay() {
		return avepay;
	}

	public void setAvepay(Double avepay) {
		this.avepay = avepay;
	}

	public double getAvgrec1() {
		return avgrec1;
	}

	public void setAvgrec1(double avgrec1) {
		this.avgrec1 = avgrec1;
	}

	public double getAvginv2() {
		return avginv2;
	}

	public void setAvginv2(double avginv2) {
		this.avginv2 = avginv2;
	}

	public double getAvginv1() {
		return avginv1;
	}

	public void setAvginv1(double avginv1) {
		this.avginv1 = avginv1;
	}

	public double getAvgrec2() {
		return avgrec2;
	}

	public void setAvgrec2(double avgrec2) {
		this.avgrec2 = avgrec2;
	}

	public double getAvginv3() {
		return avginv3;
	}

	public void setAvginv3(double avginv3) {
		this.avginv3 = avginv3;
	}

	public double getAvgrec3() {
		return avgrec3;
	}

	public void setAvgrec3(double avgrec3) {
		this.avgrec3 = avgrec3;
	}

	public double getAvgfpwc() {
		return avgfpwc;
	}

	public void setAvgfpwc(double avgfpwc) {
		this.avgfpwc = avgfpwc;
	}

	public double getAvgfpec() {
		return avgfpec;
	}

	public void setAvgfpec(double avgfpec) {
		this.avgfpec = avgfpec;
	}

	public double getAvgfpadv() {
		return avgfpadv;
	}

	public void setAvgfpadv(double avgfpadv) {
		this.avgfpadv = avgfpadv;
	}

	public float getTotal_jan() {
		return total_jan;
	}

	public void setTotal_jan(float total_jan) {
		this.total_jan = total_jan;
	}

	public float getTotal_feb() {
		return total_feb;
	}

	public void setTotal_feb(float total_feb) {
		this.total_feb = total_feb;
	}

	public float getTotal_mar() {
		return total_mar;
	}

	public void setTotal_mar(float total_mar) {
		this.total_mar = total_mar;
	}

	public float getTotal_apr() {
		return total_apr;
	}

	public void setTotal_apr(float total_apr) {
		this.total_apr = total_apr;
	}

	public float getTotal_may() {
		return total_may;
	}

	public void setTotal_may(float total_may) {
		this.total_may = total_may;
	}

	public float getTotal_jun() {
		return total_jun;
	}

	public void setTotal_jun(float total_jun) {
		this.total_jun = total_jun;
	}

	public float getTotal_jul() {
		return total_jul;
	}

	public void setTotal_jul(float total_jul) {
		this.total_jul = total_jul;
	}

	public float getTotal_aug() {
		return total_aug;
	}

	public void setTotal_aug(float total_aug) {
		this.total_aug = total_aug;
	}

	public float getTotal_sep() {
		return total_sep;
	}

	public void setTotal_sep(float total_sep) {
		this.total_sep = total_sep;
	}

	public float getTotal_oct() {
		return total_oct;
	}

	public void setTotal_oct(float total_oct) {
		this.total_oct = total_oct;
	}

	public float getTotal_nov() {
		return total_nov;
	}

	public void setTotal_nov(float total_nov) {
		this.total_nov = total_nov;
	}

	public float getTotal_dec() {
		return total_dec;
	}

	public void setTotal_dec(float total_dec) {
		this.total_dec = total_dec;
	}

	public SipBooking(String company, String year, String monthly_target, String yr_total_target, String ytm_target,
			String jan, String feb, String mar, String apr, String may, String jun, String jul, String aug, String sep,
			String oct, String nov, String dec, String ytm_actual) {
		super();
		this.company = company;
		this.year = year;
		this.monthly_target = monthly_target;
		this.yr_total_target = yr_total_target;
		this.ytm_target = ytm_target;
		this.jan = jan;
		this.feb = feb;
		this.mar = mar;
		this.apr = apr;
		this.may = may;
		this.jun = jun;
		this.jul = jul;
		this.aug = aug;
		this.sep = sep;
		this.oct = oct;
		this.nov = nov;
		this.dec = dec;
		this.ytm_actual = ytm_actual;
	}

	public double getFbavgtot() {
		return fbavgtot;
	}

	public void setFbavgtot(float fbavgtot) {
		this.fbavgtot = fbavgtot;
	}

	public double getFpavgtot() {
		return fpavgtot;
	}

	public void setFpavgtot(float fpavgtot) {
		this.fpavgtot = fpavgtot;
	}

	public Double getWcavgtot() {
		return wcavgtot;
	}

	public void setWcavgtot(Double wcavgtot) {
		this.wcavgtot = wcavgtot;
	}

	public double[] getBfrec120180() {
		return bfrec120180;
	}

	public void setBfrec120180(double[] bfrec120180) {
		this.bfrec120180 = bfrec120180;
	}

	public double[] getBfrec180365() {
		return bfrec180365;
	}

	public void setBfrec180365(double[] bfrec180365) {
		this.bfrec180365 = bfrec180365;
	}

	public double[] getBfrec366() {
		return bfrec366;
	}

	public void setBfrec366(double[] bfrec366) {
		this.bfrec366 = bfrec366;
	}

	public double[] getBfinv120180() {
		return bfinv120180;
	}

	public void setBfinv120180(double[] bfinv120180) {
		this.bfinv120180 = bfinv120180;
	}

	public double[] getBfinv180365() {
		return bfinv180365;
	}

	public void setBfinv180365(double[] bfinv180365) {
		this.bfinv180365 = bfinv180365;
	}

	public double[] getBfinv366() {
		return bfinv366;
	}

	public void setBfinv366(double[] bfinv366) {
		this.bfinv366 = bfinv366;
	}

	public double[] getBftotrec() {
		return bftotrec;
	}

	public void setBftotrec(double[] bftotrec) {
		this.bftotrec = bftotrec;
	}

	public double[] getBftotinv() {
		return bftotinv;
	}

	public void setBftotinv(double[] bftotinv) {
		this.bftotinv = bftotinv;
	}

	public double[] getTotalbcfunds() {
		return totalbcfunds;
	}

	public void setTotalbcfunds(double[] totalbcfunds) {
		this.totalbcfunds = totalbcfunds;
	}

	public double[] getFp_wc() {
		return fp_wc;
	}

	public void setFp_wc(double[] fp_wc) {
		this.fp_wc = fp_wc;
	}

	public double[] getFp_ec() {
		return fp_ec;
	}

	public void setFp_ec(double[] fp_ec) {
		this.fp_ec = fp_ec;
	}

	public double[] getFp_adv() {
		return fp_adv;
	}

	public void setFp_adv(double[] fp_adv) {
		this.fp_adv = fp_adv;
	}

	public double[] getFp_total() {
		return fp_total;
	}

	public void setFp_total(double[] fp_total) {
		this.fp_total = fp_total;
	}

	public double[] getSelCat() {
		return selCat;
	}

	public void setSelCat(double[] selCat) {
		this.selCat = selCat;
	}

	public double getAvgtotrec() {
		return avgtotrec;
	}

	public void setAvgtotrec(float avgtotrec) {
		this.avgtotrec = avgtotrec;
	}

	public double getAvgtotinv() {
		return avgtotinv;
	}

	public void setAvgtotinv(float avgtotinv) {
		this.avgtotinv = avgtotinv;
	}

	public Double getWctartot() {
		return wctartot;
	}

	public void setWctartot(Double wctartot) {
		this.wctartot = wctartot;
	}

	public double getFbrectartot() {
		return fbrectartot;
	}

	public void setFbrectartot(double fbrectartot) {
		this.fbrectartot = fbrectartot;
	}

	public double getFbinvtartot() {
		return fbinvtartot;
	}

	public void setFbinvtartot(double fbinvtartot) {
		this.fbinvtartot = fbinvtartot;
	}

	public double getFbtartot() {
		return fbtartot;
	}

	public void setFbtartot(float fbtartot) {
		this.fbtartot = fbtartot;
	}

	public double getFptartot() {
		return fptartot;
	}

	public void setFptartot(float fptartot) {
		this.fptartot = fptartot;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public SipBooking(String division, String jan, String feb, String mar, String apr, String may, String jun,
			String jul, String aug, String sep, String oct, String nov, String dec, String target, String category) {
		super();
		this.division = division;
		this.ytm_target = target;
		this.jan = jan;
		this.feb = feb;
		this.mar = mar;
		this.apr = apr;
		this.may = may;
		this.jun = jun;
		this.jul = jul;
		this.aug = aug;
		this.sep = sep;
		this.oct = oct;
		this.nov = nov;
		this.dec = dec;
		this.category = category;
	}

	public SipBooking(String dm_emp_code, String monthly_target, String yr_total_target, String ytm_target, String jan,
			String feb, String mar, String apr, String may, String jun, String jul, String aug, String sep, String oct,
			String nov, String dec, String ytm_actual) {
		super();
		this.dm_emp_code = dm_emp_code;
		this.monthly_target = monthly_target;
		this.yr_total_target = yr_total_target;
		this.ytm_target = ytm_target;
		this.jan = jan;
		this.feb = feb;
		this.mar = mar;
		this.apr = apr;
		this.may = may;
		this.jun = jun;
		this.jul = jul;
		this.aug = aug;
		this.sep = sep;
		this.oct = oct;
		this.nov = nov;
		this.dec = dec;
		this.ytm_actual = ytm_actual;
	}

	public SipBooking() {

	}

	public SipBooking(String division, String divisonName) {
		this.division = division;
		this.divisionName = divisonName;
	}

	public SipBooking(double wcrec[], double wcinv[], double wcpay[], double wctotal[], double avgrec, double avginv,
			double avgpay, double avgtot, double wctartot) {

		this.rec = wcrec;
		this.inv = wcinv;
		this.pay = wcpay;
		this.wctotal = wctotal;
		this.averrec = avgrec;
		this.aveinv = avginv;
		this.avepay = avgpay;
		this.wcavgtot = avgtot;
		this.wctartot = wctartot;
	}

	public SipBooking(double wcrec[], double wcinv[], double wcpay[], double wctotal[]) {

		this.rec = wcrec;
		this.inv = wcinv;
		this.pay = wcpay;
		this.wctotal = wctotal;
	}

	public SipBooking(double bfrec120180[], double bfrec180365[], double bfrec366[], double bfinv120180[],
			double bfinv180365[], double bfinv366[], double bftotrec[], double bftotinv[], double totalbcfunds[],
			double avgrec1, double avgrec2, double avgrec3, double avginv1, double avginv2, double avginv3,
			double tempavgfbtot, double avgtotrec, double avgtotinv, double fbrectartot, double fbinvtartot,
			double fbtartot) {

		this.bfrec120180 = bfrec120180;
		this.bfrec180365 = bfrec180365;
		this.bfrec366 = bfrec366;
		this.bfinv120180 = bfinv120180;
		this.bfinv180365 = bfinv180365;
		this.bfinv366 = bfinv366;
		this.bftotrec = bftotrec;
		this.bftotinv = bftotinv;
		this.totalbcfunds = totalbcfunds;
		this.avgrec1 = avgrec1;
		this.avgrec2 = avgrec2;
		this.avgrec3 = avgrec3;
		this.avginv1 = avginv1;
		this.avginv2 = avginv2;
		this.avginv3 = avginv3;
		this.fbavgtot = tempavgfbtot;
		this.avgtotrec = avgtotrec;
		this.avgtotinv = avgtotinv;
		this.fbrectartot = fbrectartot;
		this.fbinvtartot = fbinvtartot;
		this.fbtartot = fbtartot;

	}

	public SipBooking(double fp_wc[], double fp_ec[], double fp_adv[], double fp_total[], String theDmCode,
			double avgfpwc, double avgfpec, double avgfpadv, double tempavgfptot, double fptartot) {

		this.fp_wc = fp_wc;
		this.fp_ec = fp_ec;
		this.fp_adv = fp_adv;
		this.fp_total = fp_total;
		this.dm_emp_code = theDmCode;
		this.avgfpwc = avgfpwc;
		this.avgfpec = avgfpec;
		this.avgfpadv = avgfpadv;
		this.fpavgtot = tempavgfptot;
		this.fptartot = fptartot;
	}

	public SipBooking(double fp_wc[], double fp_ec[], double fp_adv[], double fp_total[], String theDmCode) {

		this.fp_wc = fp_wc;
		this.fp_ec = fp_ec;
		this.fp_adv = fp_adv;
		this.fp_total = fp_total;
		this.dm_emp_code = theDmCode;

	}

	public SipBooking(double selCat[]) {
		this.selCat = selCat;
	}

	public SipBooking(double rec[], String division) {
		this.rec = rec;
		this.division = division;
	}
}
