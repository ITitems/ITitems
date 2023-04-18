package egovframework.let.ass.service;

import java.io.Serializable;
import java.util.Date;

/**
 * 자산정보 관리를 위한 VO 클래스
 * @author 영남사업부 주소현
 * @since 2023.04.13
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.13  주소현          최초 생성
 *  
 *  </pre>
 */

@SuppressWarnings("serial")
public class AssetInfoVO extends AssetInfo implements Serializable {
	
	/** 검색위치 */
    private String searchDept = "";
    
    /** 검색프로젝트 */
    private String searchPrj = "";
    
    /** 검색대분류 */
    private String searchLCat = "";
    
    /** 검색중분류 */
    private String searchdMCat = "";
    
    /** 검색상태 */
    private String searchStatus = "";
	
	/** 검색시작일 */
    private Date startDate;
    
    /** 검색종료일 */
    private Date endDate;
    
    /** 검색단어 */
    private String searchWord = "";
    
    /** 페이징 */
    
    /** 정렬순서(DESC,ASC) */
    private long sortOrdr = 0L;

    /** 현재페이지 */
    private int page = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 첫페이지 인덱스 */
    private int startPage = 1;

    /** 마지막페이지 인덱스 */
    private int lastPage = 1;

    /** 전체 레코드 개수 */
    private int totalRecord = 100;
    
    /** 시작 레코드 번호 */
    private int first;
    
    /** 마지막 레코드 번호 */
    private int last;
    
    /** 전체 마지막페이지 인덱스*/
    private int endPage;
    
    public int getFirst() {
		first = (getPage() - 1) * getPageUnit() + 1;
		return first;
	}
	public int getLast() {
		last = getPage() * getPageUnit();
		return last;
	}

	
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getLastPage() {
		lastPage = totalRecord / pageUnit + 
				   ( totalRecord % pageUnit>0 ? 1 : 0 );
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public int getStartPage() {
		startPage = (page-1)/pageSize * pageSize + 1;
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		endPage = (page-1)/pageSize  * pageSize  + pageSize ;
		if ( endPage > getLastPage() )
			endPage = getLastPage() ;
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public String getSearchDept() {
		return searchDept;
	}
	public void setSearchDept(String searchDept) {
		this.searchDept = searchDept;
	}
	public String getSearchPrj() {
		return searchPrj;
	}
	public void setSearchPrj(String searchPrj) {
		this.searchPrj = searchPrj;
	}
	public String getSearchLCat() {
		return searchLCat;
	}
	public void setSearchLCat(String searchLCat) {
		this.searchLCat = searchLCat;
	}
	public String getSearchdMCat() {
		return searchdMCat;
	}
	public void setSearchdMCat(String searchdMCat) {
		this.searchdMCat = searchdMCat;
	}
	public String getSearchStatus() {
		return searchStatus;
	}
	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public long getSortOrdr() {
		return sortOrdr;
	}
	public void setSortOrdr(long sortOrdr) {
		this.sortOrdr = sortOrdr;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public void setFirst(int first) {
		this.first = first;
	}
	public void setLast(int last) {
		this.last = last;
	}
	
	
}
