/****************************************************************
 * 
 * 파일명 : ProjectPopup.js
 * 설  명 : 프로젝트검색 팝업 JavaScript
 * 
 *    수정일      수정자     Version        Function 명
 * ------------    ---------   -------------  ----------------------------
 * 2023.04.18    주소현       1.0             최초생성
 * 
 * 
 */

	function projectSearch(prjNm) {
	var retVal;

	var url = frm.zip_url.value;
	//var url = "/ebt/sym/cmm/EgovCcmZipSearchPopup.do"; 
	var varParam = new Object();
	varParam.sZip = sZip.value;		

	// IE
	//var openParam = "dialogWidth:500px;dialogHeight:325px;scroll:no;status:no;center:yes;resizable:yes;";
	// FIREFOX
	var openParam = "dialogWidth:550px;dialogHeight:365px;scroll:no;status:no;center:yes;resizable:yes;";

	retVal = window.showModalDialog(url, varParam, openParam, "zipCallback");

	otherParameters[0] = sZip;
	otherParameters[1] = vZip;
	otherParameters[2] = sAddr;

	if(retVal) {
		sZip.value  = retVal.sZip;
		vZip.value  = retVal.vZip;
		sAddr.value = retVal.sAddr;
	}
}


function zipCallback(retVal) {
	if (retVal) {
		otherParameters[0].value  = retVal.sZip;
		otherParameters[1].value  = retVal.vZip;
		otherParameters[2].value = retVal.sAddr;
	}
}
