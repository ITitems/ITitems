<%--
  Class Name : SecAssetUpdt.jsp
  Description : 자산수정 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.10   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.05.10
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
<link rel="stylesheet" href="<c:url value='/'/>css/jsh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>
<script src="<c:url value='/'/>js/jquery.js"></script>
<script src="<c:url value='/'/>js/jqueryui.js"></script>
<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="assetUpdt" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* ********************************************************
 * 자산 수정 처리
 ******************************************************** */
function UpdateAsset(){
	if(confirm("수정하시겠습니까?")){
		if(validateAssetUpdt(document.AssetUpdt)){
		    document.AssetUpdt.action = "<c:url value='/sec/asm/SecAssetUpdate.do'/>";
		    document.AssetUpdt.submit(); 
	    }
	}
}

/* ********************************************************
 * 중분류 조회
 ******************************************************** */
function getMCatList(Mval) {
	let val = document.getElementById('largeCategory').value;
	if(val == ""){
		document.getElementById('middleCategory').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '선택하세요';
		op.value = "";
		document.getElementById('middleCategory').appendChild(op);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/cat/GetMCategoryList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpper' : val},
			success: function (result) {
				document.getElementById('middleCategory').replaceChildren();
				let op = document.createElement('option');
				op.textContent = '선택하세요';
				document.getElementById('middleCategory').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.catId);
					op.textContent = res.catName;
					if(Mval == res.catName){
						op.setAttribute('selected', 'selected');
					}
					document.getElementById('middleCategory').appendChild(op);
				}
			},
			error: function (error) {
				console.log(error);
			}
		})
	}
}
/* ********************************************************
 * 프로젝트 검색
 ******************************************************** */
function ProjectSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/prj/ProjectSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 자산 검색
 ******************************************************** */
function AssetSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/ass/AssetSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 회원 검색
 ******************************************************** */
function UserSearch(ch){
	userCheck = ch;
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/uss/umt/user/SearchUserList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 검색 프로젝트 입력
 ******************************************************** */
function returnProject(val){
	
	if (val) {
		document.getElementById("prjId").value  = val.prjId;
		document.getElementById("prjNm").value  = val.prjNm;
		$("#prjId").closest("td").append(resetBtn.on("click",resetPrj));
	}
	
	fn_egov_modal_remove();
}

/* ********************************************************
 * 프로젝트 입력 리셋
 ******************************************************** */
 function resetPrj(e){
	document.getElementById("prjId").value  = "";
	document.getElementById("prjNm").value  = "";
	console.log(e)
}
 
/* ********************************************************
 * 검색 자산 입력
 ******************************************************** */
function returnAsset(val){
	
	if (val) {
		document.getElementById("useId").value  = val.userId;
		document.getElementById("useNm").value  = val.userNm;
	}
	
	fn_egov_modal_remove();
}

/* ********************************************************
 * 검색 회원 입력
 ******************************************************** */
function returnUser(val){

if (val) {
	if(userCheck == 0){
		document.getElementById("rcptId").value  = val.userId;
		document.getElementById("rcptNm").value  = val.userNm;
	}else if(userCheck == 1){
		document.getElementById("useId").value  = val.userId;
		document.getElementById("useNm").value  = val.userNm;
	}
	
}

/* ********************************************************
 * 수령자 입력 리셋
 ******************************************************** */
 function resetRcpt(){
	document.getElementById("rcptId").value  = "";
	document.getElementById("rcptNm").value  = "";
}

/* ********************************************************
 * 실사용자 입력 리셋
 ******************************************************** */
  function resetUse(){
 	document.getElementById("useId").value  = "";
 	document.getElementById("useNm").value  = "";
 }

/* ********************************************************
 * 숫자 콤마 입력
 ******************************************************** */
  function getNumber(obj){
	     var num01;
	     var num02;
	     num01 = obj.value;
	     num02 = num01.replace(/\D/g,""); 
	     num01 = setComma(num02);
	     obj.value =  num01;

	     $('#test').text(num01);
	  }

	  function setComma(n) {
	     var reg = /(^[+-]?\d+)(\d{3})/;
	     n += '';         
	     while (reg.test(n)) {
	        n = n.replace(reg, '$1' + ',' + '$2');
	     }         
	     return n;
	  }


/* ********************************************************
 * date input 생성
 ******************************************************** */
function make_date(){
	
	$("#acquiredDate").datepicker(
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
	
	$("#rcptDate").datepicker(
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
	
}

window.onload = function(){
	getMCatList('${resultVO.middleCategory}');
	getNumber(document.AssetUpdt.acquiredPrice);
	make_date();
	  }
//-->
</script>

<title>ITitems</title>

</head>

<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
}

.board_view_bot {
	overflow: hidden;
}

.right_btn {
	float: right;
}
</style>

<body>
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

	<!-- Skip navigation -->
	<a href="#contents" class="skip_navi">본문 바로가기</a>

	<div class="wrap">
		<!-- Header -->
		<c:import url="/sym/mms/EgovHeader.do" />
		<!--// Header -->

		<div class="container">
			<div class="sub_layout">
				<div class="sub_in">
					<div class="layout">

						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="">Home</a></li>
										<li><a href="">사이트관리</a></li>
										<li>자산수정</li>
									</ul>
								</div>
								<!--// Location -->


								<form:form modelAttribute="AssetInfoVO" id="AssetUpdt" name="AssetUpdt" method="post" enctype="multipart/form-data" >
									<input type="hidden" id="assetId" name="assetId" value="${resultVO.assetId}">
									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">자산수정</h2>

									<br>
									<!-- 추가/초기화 버튼  -->
									<!-- <div class="board_view_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_130"
												onclick="AssetSearch(); return fasle;">기존 자산 등록</a>
											기존 자산 추가
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="frm_reset(); return fasle;">초기화</a>
											초기화
										</div>
									</div> -->
									<!-- // 추가/초기화 버튼 끝  -->
									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 20%;">
												<col style="width: 30%;">
												<col style="width: 20%;">
												<col style="width: 30%;">
											</colgroup>
											<tr>
												<td class="lb">
													<!-- 대분류 --> 
													<label for="">대분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select" for="largeCategory">
															<select id="largeCategory" name="largeCategory"
																title="대분류" onchange="getMCatList();">
																<option value="" label="선택하세요" />
																<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
																	<option value="${LCat.catId}" <c:if test="${LCat.catName == resultVO.largeCategory}">selected="selected"</c:if>>
																		<c:out value="${LCat.catName}" />
																	</option>
																</c:forEach>
															</select>
															<form:errors path="largeCategory" />
													</label> 
													<br />
												</td>
												<td class="lb">
													<!-- 중분류 --> 
													<label for="">중분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select" for="middleCategory">
														<select id="middleCategory" name="middleCategory">
														</select>
													</label> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수량 -->
													<label for="">수량</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="assetQty" class="f_txt w_full" name="assetQty" type="text" value="${resultVO.assetQty}"  maxlength="20"
														onchange="getNumber(this);" onkeyup="getNumber(this);">
												</td>
												<td class="lb">
													<label for="egovComFileUploader">제품사진</label> <img src="<c:url value='/'/>images/ico_question.png">
												<td>
													<div class="board_attach2" id="file_upload_posbl">
														<input name="photo" id="photo" type="file" />
														<div id="egovComFileList"></div>
													</div>
													<div class="board_attach2" id="file_upload_imposbl">
													</div> 
													<c:if test="${empty result.atchFileId}">
														<input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
													</c:if>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 품명 --> 
													<label for="">제품명</label>
												</td>
												<td>
													<input id="assetName" class="f_txt w_full" name="assetName" type="text" value="${resultVO.assetName}"  maxlength="60">
													<br />
												</td>
												<td class="lb">
													<!-- 시리얼넘버 --> 
													<label for="">시리얼넘버</label> <img src="<c:url value='/'/>images/ico_question.png">
												</td>
												<td>
													<input id="assetSN" class="f_txt w_full" name="assetSN" type="text" value="" maxlength="60"> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> 
													<label for="">제조사</label>
												</td>
												<td>
													<input id="maker" class="f_txt w_full" name="maker" type="text" value="${resultVO.maker}" maxlength="60"> 
													<br />
												</td>
												<td class="lb">
													<label for="egovComFileUploader">지급확인서</label>
													<span class="req">필수</span> <img src="<c:url value='/'/>images/ico_question.png">
												</td>
												<td>
													<div class="board_attach2" id="file_upload_posbl">
														<input name="file" id="egovComFileUploader" type="file" />
														<div id="egovComFileList"></div>
													</div>
													<div class="board_attach2" id="file_upload_imposbl"></div>
													<c:if test="${empty result.atchFileId}">
														<input type="hidden" id="fileListCnt" name="fileListCnt"
															value="0" />
													</c:if>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득일자 --> 
													<label for="">취득일자</label>
												</td>
												<td>
													<span class="search_date">
														<input id="acquiredDate" class="f_txt w_full" name="acquiredDate" type="text" value="${resultVO.acquiredDate}">
													</span>
												</td>
												<td class="lb">
													<!-- 취득가액 --> 
													<label for="">취득가액</label>
												</td>
												<td>
													<input id="acquiredPrice" class="f_txt w_full"
													name="acquiredPrice" type="text" value="${resultVO.acquiredPrice}"  maxlength="60" onchange="getNumber(this);" onkeyup="getNumber(this);">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 비고 --> 
													<label for="note">비고</label>
												</td>
												<td colspan="4">
													<textarea id="note" name="note" class="f_txtar w_full h_200" cols="30" rows="10" >${resultVO.note}</textarea>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 부서 --> 
													<label for="orgnztId">부서</label>
												</td>
												<td>
													<label class="f_select w_30%" for="orgnztId">
														<select id="orgnztId" name="orgnztId" title="부서">
															<option value="" label="선택하세요" />
															<c:forEach var="orgnztId" items="${orgnztId_result}"
																varStatus="status">
																<option value="${orgnztId.code}">
																	<c:out value="${orgnztId.codeNm}" />
																</option>
															</c:forEach>
													</select>
													</label>
												</td>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td>
													<span class="f_search2 w_30%"> 
													<input id="prjNm" type="text" title="프로젝트" maxlength="100"
														readonly="false" />
													<button type="button" class="btn"
														onclick="ProjectSearch();">조회</button>
													</span> 
													<form:errors path="prjId" /> 
													<input name="prjId" id="prjId" type="hidden" title="프로젝트" value="" maxlength="8"
														readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령자 --> 
													<label for="">수령자</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_30%"> 
													<input id="rcptNm" type="text" title="회원" maxlength="100"
														readonly="false" value=""/>
													<button type="button" class="btn" onclick="UserSearch(0);">조회</button>
													</span> 
													<input name="rcptId" id="rcptId" type="hidden" title="프로젝트"
														value="" maxlength="8" readonly="readonly" />
												</td>
												<td class="lb">
													<!-- 실사용자 --> 
													<label for="">실사용자</label> 
												</td>
												<td>
													<span class="f_search2 w_30%"> 
														<input id="useNm" type="text" title="회원" maxlength="100"
															readonly="false" value=""/>
														<button type="button" class="btn" onclick="UserSearch(1);">조회</button>
													</span> 
													<input name="useId" id="useId" type="hidden" title="프로젝트" value=""
														maxlength="8" readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령일자 --> 
													<label for="">수령일자</label> 
												</td>
												<td colspan="4">
													<span class="search_date">
														<input id="rcptDate" class="f_txt w_full" name="rcptDate" type="text"  maxlength="60">
													</span>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 반출사유 --> 
													<label for="carryReason">반출사유</label>
												</td>
												<td colspan="4">
													<textarea id="carryReason" name="carryReason"
														class="f_txtar w_full h_200" cols="30" rows="10">
													</textarea>
												</td>
											</tr>
										</table>

										<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
											<script type="text/javascript">
												var maxFileNum = document.board.posblAtchFileNumber.value;
												if (maxFileNum == null
														|| maxFileNum == "") {
													maxFileNum = 3;
												}
												var multi_selector = new MultiSelector(
														document
																.getElementById('egovComFileList'),
														maxFileNum);
												multi_selector
														.addElement(document
																.getElementById('egovComFileUploader'));
											</script>
										</c:if>
									</div>
									
									<br>
									
									<!-- 등록버튼  -->
									<div class="board_view_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="UpdateAsset(); return false;"><spring:message
													code="button.update" /></a>
											<!-- 등록 -->
										</div>
									</div>
									<!-- // 등록버튼 끝  -->
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Footer -->
		<c:import url="/sym/mms/EgovFooter.do" />
		<!--// Footer -->
	</div>

</body>
</html>