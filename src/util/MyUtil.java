package util;

public class MyUtil {//페이징 처리


	//전체 페이지수
	public int getPageCount (int numPerPage,int dataCount){

		int pageCount = 0;
		pageCount = dataCount / numPerPage;

		if(dataCount % numPerPage !=0)
			pageCount++;

		return pageCount;

	}

	public String pageIndexList(int currentPage,int totalPage,
			String listUrl){ //페이지 목록

		int numPerBlock = 10; //표시할 페이지 숫자갯수

		int currentPageSetup; //표시할 첫 페이지-1

		int page;

		StringBuffer sb = new StringBuffer(); 

		if(currentPage==0||totalPage==0)
			return "";

		if(listUrl.indexOf("?")!=-1){
			listUrl = listUrl + "&";
		}else{
			listUrl = listUrl +"?";
		}

		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;

		if(currentPage % numPerBlock ==0)
			currentPageSetup = currentPageSetup-numPerBlock;


		//◀이전
		if(totalPage > numPerBlock && currentPageSetup>0){
			sb.append("<a href=\"" + listUrl + "pageNum=" +
					currentPageSetup + "\">◀이전</a>&nbsp;");
		}



		//바로가기 페이지
		page = currentPageSetup + 1;

		while(page<=totalPage && page <=(currentPageSetup + numPerBlock)){

			if(page==currentPage){
				sb.append("<font color=\"Fuchsia\">" + page + "</font>&nbsp;");

			}else{
				sb.append("<a href=\"" + listUrl + "pageNum=" + page + "\">" + page + "</a>&nbsp;");
			}

			page++;		

		}

		//다음▶
		if(totalPage-currentPageSetup > numPerBlock){

			sb.append("<a href=\"" + listUrl + "pageNum=" + page + "\">다음▶</a>&nbsp;");
		}

		return sb.toString();
	}








}
