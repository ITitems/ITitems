<%--
  Class Name : SecSelect.jsp
  Description : 자산상세조회(관리자)
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
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
<link rel="stylesheet" href="<c:url value='/'/>css/pty_m.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/pty.css">
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
<title>ITitems</title>
<script type="text/javascript">
function AssetUpdt() {
	document.frm.action = "<c:url value='/sec/asm/SecAssetUpdt.do'/>";
    document.frm.submit();
}
function fnListPage(){
    history.back();
}
</script>
</head>

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
										<li><a href="">자산관리</a></li>
										<li>자산정보</li>
									</ul>
								</div>
								<!--// Location -->


								<form id="frm" name="frm">
									<input name="assetId" type="hidden" value="${resultVO.assetId}">
									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">자산정보</h2>

									<br>
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
													<!-- 대분류 --> <label for="">대분류</label>
												</td>
												<td>${resultVO.largeCategory}</td>
												<td class="lb">
													<!-- 중분류 --> <label for="">중분류</label>
												</td>
												<td>${resultVO.middleCategory}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수량 --> <label for="">수량</label>
												</td>
												<td> <fmt:formatNumber value="${resultVO.assetQty}" pattern="#,###"/></td>
												<td class="lb"><label for="egovComFileUploader">제품사진</label>
												</td>
												<td>
													<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				                                        <c:param name="param_atchFileId" value="${resultVO.photoId}" />
				                                    </c:import>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 품명 --> <label for="">제품명</label>
												</td>
												<td>${resultVO.assetName}</td>
												<td class="lb">
													<!-- 시리얼넘버 --> 
													<label for="">시리얼넘버</label>
												</td>
												<td>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득일자 --> <label for="">취득일자</label>
												</td>
												<td>${resultVO.acquiredDate}</td>
												<td class="lb">
													<!-- 취득가액 --> <label for="">취득가액</label>
												</td>
												<td>
													<c:if test="${resultVO .acquiredPrice != 0 and resultVO.acquiredPrice != null}">
														<fmt:formatNumber value="${resultVO.acquiredPrice}" pattern="#,###"/>원
													</c:if>
												</td>											
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> <label for="">제조사</label>
												</td>
												<td>${resultVO.maker}</td>
												<td class="lb">
													<label for="egovComFileUploader">지급확인서</label>
												</td>
												<td>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 비고 --> <label for="note">비고</label>
												</td>
												<td colspan="4">${resultVO.note}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 부서 --> 
													<label for="orgnztId">부서</label>
												</td>
												<td>
												</td>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령자 --> 
													<label for="">수령자</label> 
												</td>
												<td>
												</td>
												<td class="lb">
													<!-- 실사용자 --> 
													<label for="">실사용자</label> 
												</td>
												<td>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령일자 --> 
													<label for="">수령일자</label> 
												</td>
												<td colspan="4">
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 반출사유 --> 
													<label for="carryReason">반출사유</label>
												</td>
												<td colspan="4">
												</td>
											</tr>
										</table>
									</div>
									<!-- 버튼  -->
									<div class="board_view_bot">
										<div class="right_col btn1">
											<!-- 수정 -->
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="AssetUpdt();return false;"> <spring:message
													code="button.update" />
											</a>

										</div>
										<a href="<c:url value='/sec/asm/SecAssetManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;">이전</a><!-- 목록 -->
									</div>
									<!-- // 버튼 끝  -->
								</form>
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