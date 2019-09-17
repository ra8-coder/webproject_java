	Calendar cal = Calendar.getInstance();
	

	//오늘날짜
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH) + 1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);

	//클라이언트에서 넘어온 데이터

	String strYear = request.getParameter("year"); //사용자에게 년,월 값을 받아옴
	String strMonth = request.getParameter("month");
	String strDay = request.getParameter("day");

	//표시할 달력의 년,월
	int year = nowYear; //오늘날짜로 초기화
	int month = nowMonth;
	int day = nowDay;

	if (strYear != null) { //사용자가 입력한 값이 null이 아니면
		year = Integer.parseInt(strYear); //사용자가 선택한 년도	
	}
	if (strMonth != null) {
		month = Integer.parseInt(strMonth); //사용자가 선택한 월
	}
	if(strDay !=null){
		day = Integer.parseInt(strDay);
	}

	int preYear = year;
	int preMonth = month;
	int preDay = day-1;
	
	if(preDay <1){
		preYear = year;
		preMonth = month-1;
		cal.set(preYear, preMonth, 1);
		preDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	if (preMonth < 1) { //월이 0보다 작으면
		preYear = year - 1; //-1년 
		preMonth = 12; // 월 = 12
	}

	int nextYear = year;
	int nextMonth = month;
	int nextDay = day+1;
	

	if(nextDay > cal.getActualMaximum(Calendar.DAY_OF_MONTH)){
		nextDay =1;
		nextMonth = month+1;
		nextYear = year;
	}
	
	
	if (nextMonth > 12) { //월이 12보다 크면
		nextYear = year + 1; //+1년
		nextMonth = 1; //월 = 1
	}

	//표시할 달력 셋팅
	cal.set(year, month - 1, day); //년 월 일
	int startDay = 1; //월의 첫날은 1
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);//월의 마지막날

	int week = cal.get(Calendar.DAY_OF_WEEK);
	