<%--
  Class Name : AssetInsert.jsp
  Description : 자산등록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.13   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.04.13
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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
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
<validator:javascript formName="board" staticJavascript="false"
	xhtml="true" cdata="false" />
<c:if test="${anonymous == 'true'}">
	<c:set var="prefix" value="/anonymous" />
</c:if>
<script type="text/javascript">
	let tdClone;
	
	function insertCarryDetail(reqId) {
		let dataList;
		let trList = document.querySelector('.assetlist tbody').querySelectorAll("tr")
		trList.forEach(function(items,index) {
			let formdata = new FormData();
			formdata.append('reqId', reqId);
			formdata.append('largeCategory', items.querySelector('#middleCategory').value);
			formdata.append('middleCategory', items.querySelector('#middleCategory').value);
			formdata.append('reqQty', items.querySelector('#reqQty').value);
			formdata.append('maker', items.querySelector('#maker').value);
			formdata.append('user', trList.length - items.querySelector('#user').value);
			formdata.append('reqOrder', index);
			$.ajax({
				url: '${pageContext.request.contextPath}/req/insertRequestDetail.do',
				method: 'POST',
				enctype: "multipart/form-data",
				processData: false,
				contentType: false,
				data: formdata,
				success: function (result) {
					console.log("성공")
				},
				error: function (error) {
					console.log(error);
				}
			}) 
		});
	}

	function insertCarry() {
		event.preventDefault();
		
		let formData = new FormData(document.getElementById('frm'));
		
	 	$.ajax({
			url: '${pageContext.request.contextPath}/req/insertRequest.do',
			method: 'POST',
			enctype: "multipart/form-data",
			processData: false,
			contentType: false,
			data: formData,
			success: function (result) {
				insertCarryDetail(result);
			},
			error: function (error) {
				console.log(error);
			}
		}) 
	}
	
	function addTd() {
		 let td = tdClone.cloneNode(true);
		 document.querySelector('.assetlist tbody').appendChild(td); 
	}
	
	window.onload = function(){
		tdClone = document.querySelector('.assetlist tbody tr').cloneNode(true);
		  }
	
	function getMCatList(Lcat) {
		
		let val = Lcat.value;
		let mCat = Lcat.closest("td").querySelector("div");
		if (val == "ETC"){
			mCat.replaceChildren();
			let input = document.createElement('input');
			input.setAttribute('id', 'middleCategory');
			input.setAttribute('name', 'middleCategory');
			input.setAttribute('type', 'text');
			input.setAttribute('class', 'f_txt w_full');
			mCat.appendChild(input);
		}else if (val == ""){
			mCat.replaceChildren();
			let label = document.createElement('label');
			label.setAttribute('class', 'f_select');
			let select = document.createElement('select');
			select.setAttribute('id', 'middleCategory');
			select.setAttribute('name', 'middleCategory');
			let op = document.createElement('option');
			op.textContent = '선택하세요';
			select.appendChild(op);
			label.appendChild(select);
			mCat.appendChild(label);
		}else{
			$.ajax({
				url: '${pageContext.request.contextPath}/cat/GetMCategoryList.do',
				method: 'POST',
				contentType: 'application/x-www-form-urlencoded',
				data: {'searchUpper' : val},
				success: function (result) {
					mCat.replaceChildren();
					let label = document.createElement('label');
					label.setAttribute('class', 'f_select');
					let select = document.createElement('select');
					select.setAttribute('id', 'middleCategory');
					select.setAttribute('name', 'middleCategory');
					let op = document.createElement('option');
					op.textContent = '선택하세요';
					select.appendChild(op);
					for(res of result){
						op = document.createElement('option');
						op.setAttribute('value', res.catId);
						op.textContent = res.catName;
						select.appendChild(op);
					}
					label.appendChild(select);
					mCat.appendChild(label);
				},
				error: function (error) {
					console.log(error);
				}
			})	
		} 
		
	}

	function fn_egov_validateForm(obj) {
		return true;
	}

	function fn_egov_regist_notice() {
		//document.board.onsubmit();

		if (!validateBoard(document.board)) {
			return;
		}
		<c:if test="${bdMstr.bbsAttrbCode == 'BBSA02'}">
		if (document.getElementById("egovComFileUploader").value == "") {
			alert("갤러리 게시판의 경우 이미지 파일 첨부가 필수사항입니다.");
			return false;
		}
		</c:if>
		if (confirm('<spring:message code="common.regist.msg" />')) {
			//document.board.onsubmit();
			document.board.action = "<c:url value='/cop/bbs${prefix}/insertBoardArticle.do'/>";
			document.board.submit();
		}
	}

	function fn_egov_select_noticeList() {
		document.board.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.board.submit();
	}

	/* ********************************************************
	 * 달력
	 ******************************************************** */
	function fn_egov_init_date() {

		$("#searchBgnDe").datepicker(
				{
					dateFormat : 'yy-mm-dd',
					showOn : 'button',
					buttonImage : '<c:url value='/images/ico_calendar.png'/>',
					buttonImageOnly : true

					,
					showMonthAfterYear : true,
					showOtherMonths : true,
					selectOtherMonths : true,
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]

					,
					changeMonth : true // 월선택 select box 표시 (기본은 false)
					,
					changeYear : true // 년선택 selectbox 표시 (기본은 false)
					,
					showButtonPanel : true
				// 하단 today, done  버튼기능 추가 표시 (기본은 false)
				});

		$("#searchEndDe").datepicker(
				{
					dateFormat : 'yy-mm-dd',
					showOn : 'button',
					buttonImage : '<c:url value='/images/ico_calendar.png'/>',
					buttonImageOnly : true

					,
					showMonthAfterYear : true,
					showOtherMonths : true,
					selectOtherMonths : true,
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]

					,
					changeMonth : true // 월선택 select box 표시 (기본은 false)
					,
					changeYear : true // 년선택 selectbox 표시 (기본은 false)
					,
					showButtonPanel : true
				// 하단 today, done  버튼기능 추가 표시 (기본은 false)
				});
	}
	
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
	
	function returnProject(val){
		
		if (val) {
			document.getElementById("prjId").value  = val.prjId;
			document.getElementById("prjNm").value  = val.prjNm;
		}
		
		fn_egov_modal_remove();
	}
	
function returnUser(val){
	
	document.getElementById("pm").value  = val.userId;
	document.getElementById("pmNm").value  = val.userNm;
	
	fn_egov_modal_remove();
}


</script>

<title>자산관리 > 자산등록</title>

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

.board_view2 thead .lb {
	text-align: center;
}
</style>

<body >
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
						<!-- Left menu -->
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->

						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="">Home</a></li>
										<li><a href="">자산관리</a></li>
										<li>반출 신청</li>
									</ul>
								</div>
								<!--// Location -->


								<form id="frm" name="frm">
									
									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">반출 신청</h2>
									<input name="reqGroup" value="H2" type="hidden">
									<input name="reqStatus" value="R0" type="hidden">
									<br>
									
									<div class="board_view2">
									
										<table>
											<colgroup>
												<col style="width: 16%;">
												<col style="width: 34%;">
												<col style="width: 16%;">
												<col style="width: 34%;">
											</colgroup>
											<tr>
												<td class="lb">
													<!-- 성명 --> 
													<label for="">성명</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_full">
														<input value="${userManageVO.emplyrNm}" type="text"
															readonly="readonly">
													</span>
													<input value="${userManageVO.uniqId}" name="id" type="hidden"
														readonly="readonly">
												</td>
												<td class="lb">
													<!-- 직위 --> 
													<label for="">직위</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_full">
														<input type="text" readonly="readonly" 
															value="${userManageVO.grade}">
														
													</span>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td colspan="3">
													<span class="f_search2 w_60%"> 
														<input id="prjNm" type="text" title="프로젝트" maxlength="100"
															readonly="false" />
														<button type="button" class="btn"
															onclick="ProjectSearch();">조회</button>
													</span> 
													<span class="f_txt_inner ml15">(프로젝트 검색)</span> 
													<form:errors path="prjId" /> 
													<input name="prjId" id="prjId" type="hidden" title="프로젝트" value="" maxlength="8"
														readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용장소 --> 
													<label for="">사용장소</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input type="text" class="f_txt w_full" id="place" name="place">
												</td>
												<td class="lb">
													<!-- PM(관리자) --> 
													<label for="">PM(관리자)</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_30%"> 
														<input id="pmNm" type="text" title="회원" maxlength="100"
															readonly="false" />
														<button type="button" class="btn" onclick="UserSearch(1);">조회</button>
													</span> 
													<input name="pm" id="pm" type="hidden" title="프로젝트" value=""
														maxlength="8" readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용기간 --> 
													<label for="">사용기간</label> 
													<span class="req">필수</span>
												</td>
												<td colspan="3">
													<input id="startDate" class="f_txt w_40%" name="startDate" type="date"
														 maxlength="60">
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input id="endDate" class="f_txt w_40%"
														name="endDate" type="date" maxlength="60">
													<br />
												</td>
											</tr>
										</table>
									</form>
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
								
								<div class="board_view2 assetlist">
									<table>
										<colgroup>
											<col style="width: 22%;">
											<col style="width: 15%;">
											<col style="width: 29%;">
											<col style="width: 34%;">
										</colgroup>
										<thead>
											<tr>
												<td class="lb"><label for="">구분</label><span class="req">필수</span></td>
												<td class="lb"><label for="">수량</label><span class="req">필수</span></td>
												<td class="lb"><label for="">S/N(노트북)/제조사</label></td>
												<td class="lb"><label for="">사용자</label></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													<label class="f_select" for="largeCategory">
														<select id="largeCategory" name="largeCategory"
															title="대분류" onchange="getMCatList(this);">
															<option value="" label="선택하세요" />
															<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
																<option value="${LCat.catId}">
																	<c:out value="${LCat.catName}" />
																</option>
															</c:forEach>
															<option value="ETC" label="직접입력" />
														</select>
													</label> 
												<br><br>
													<div id="mCat">
														<label class="f_select" for="middleCategory"> 
															<select id="middleCategory" name="middleCategory" title="중분류">
																<option value='' label="선택하세요" selected="selected" />
															</select>
														</label>
													</div>
												</td>
												<td><input id="reqQty" name="reqQty" type="number" value="0" class="f_txt w_full"></td>
												<td><input id="maker" name="maker" type="text" class="f_txt w_full"></td>
												<td><input id="user" name="user" type="text" class="f_txt w_full"></td>
											</tr>
										</tbody>
										<tr>
											<td colspan="4">
												<div class="right_btn btn1">
													<!-- 입력칸 추가 -->
													<a href="#LINK" class="btn btn_blue_46 w_100"
														onclick="addTd();">+</a>
												</div>
											</td>
										</tr>
									</table>
								</div>
								<br>
								<div>
									<input type="checkbox"> 상기와 같이 장비 반입/반출을 신청합니다.
								</div>
								<br>
								<!-- 등록버튼  -->
								<div class="board_view_bot">
									<div class="right_btn btn1">
										<a href="#LINK" class="btn btn_blue_46 w_100"
											onclick="insertCarry();return false;">신청 <spring:message
												code="button.create" /></a>
										<!-- 등록 -->
									</div>
								</div>
								<!-- // 등록버튼 끝  -->
								
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