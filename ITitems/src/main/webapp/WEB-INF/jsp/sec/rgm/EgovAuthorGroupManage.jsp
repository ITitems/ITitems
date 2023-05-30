<%--
  Class Name : EgovAuthorGroupManage.jsp
  Description : EgovAuthorGroupManage List 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.17    천세훈		최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.04.17
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/csh.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<title>Iteyes 자산관리솔루션</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function fncManageChecked() {

    var resultCheck = false;

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var selectAuthor = document.listForm.authorManageCombo;
    /* var booleanRegYn = document.listForm.regYn; */
    /* var listMberTyCode = document.listForm.mberTyCode; */
        
    var returnId = "";
    var returnAuthor = "";
    /* var returnRegYn = ""; */
    /* var returnmberTyCode = ""; */

    var checkedCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnId == "") {
                        returnId = checkField[i].value;
                        returnAuthor = selectAuthor[i].value;
                        /* returnRegYn = booleanRegYn[i].value; */
                        /* returnmberTyCode = listMberTyCode[i].value; */
                    }
                    else {
                        returnId = returnId + ";" + checkField[i].value;
                        returnAuthor = returnAuthor + ";" + selectAuthor[i].value;
                        /* returnRegYn = returnRegYn + ";" + booleanRegYn[i].value; */
                        /* returnmberTyCode = returnmberTyCode + ";" + listMberTyCode[i].value; */
                        
                    }
                }
            }

            if(checkedCount > 0) 
                resultCheck = true;
            else {
                alert("선택된  항목이 없습니다.");
                resultCheck = false;
            }
            
        } else {
             if(document.listForm.delYn.checked == false) {
                alert("선택 항목이 없습니다.");
                resultCheck = false;
            }
            else {
                returnId = checkId.value;
                returnAuthor = selectAuthor.value;
               /*  returnRegYn = booleanRegYn.value; */

                resultCheck = true;
            }
        } 
    } else {
        alert("조회된 결과가 없습니다.");
    }
    
    document.listForm.userIds.value = returnId;
    document.listForm.authorCodes.value = returnAuthor;
    /* document.listForm.regYns.value = returnRegYn; */

    return resultCheck;
}

function fncSelectAuthorGroupList(pageNo){
    //document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit();
}
function setPageUnit(){
	document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit();
}
function fncAddAuthorGroupInsert() {
	
    if(!fncManageChecked()) return;
    
    if(confirm('<spring:message code="common.regist.msg" />')) {
        document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupInsert.do'/>";
        document.listForm.submit();
    }
}

function fncAuthorGroupDeleteList() {
 
    if(!fncManageChecked()) return;

    if(confirm('<spring:message code="common.delete.msg" />')) {
        document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupDelete.do'/>";
        document.listForm.submit(); 
    }
}

function linkPage(pageNo){
    //document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorGroupPop() {

    if(document.listForm.searchCondition.value == '3') {
        
        var $dialog = $('<div id="modalPan"></div>')
    	.html('<iframe style="border: 0px; " src="' + "<c:url value='/sec/gmt/EgovGroupSearchView.do'/>" + '" width="100%" height="100%"></iframe>')
    	.dialog({
        	autoOpen: false,
            modal: true,
            width: 1100,
            height: 600
    	});
        $(".ui-dialog-titlebar").hide();
    	$dialog.dialog('open');
    } else {
        alert("그룹을 선택하세요.");
        return;
    }
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}

function onSearchCondition() {
    document.listForm.searchKeyword.value = "";
    if(document.listForm.searchCondition.value == '3') {
        document.listForm.searchKeyword.readOnly = true;
    } else {
        document.listForm.searchKeyword.readOnly = false;
    }
}

function press() {

    if (event.keyCode==13) {
        fncSelectAuthorGroupList('1');
    }
}
//-->
</script>
<style>
	.btn_area{
	justify-content: flex-end !important;
	}
	
</style>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
                                        <li><a href="">사이트관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>사용자별권한관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form id="listForm" name="listForm" action="<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>" method="post">

                                <h2 class="tit_2">사용자별권한관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition pty_condition">
                                	<div style="display: flex; gap:8px;">
	                                    <label class="f_select item" for="searchCondition">
	                                        <select id="searchCondition" name="searchCondition" onchange="onSearchCondition()" title="조회조건">
	    					                    <option value="1" <c:if test="${userSearchVO.searchCondition == '1'}">selected="selected"</c:if> >사용자ID</option>
	                                            <option value="2" <c:if test="${userSearchVO.searchCondition == '2'}">selected="selected"</c:if> >사용자명</option>
	    					               
	    					                </select>
	                                    </label> 
									
										<span class="item f_search">
											<input class="f_input w_250 pty_f_input" type="text" name="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어" onkeypress="press();" value="<c:out value='${authorGroupVO.searchKeyword}'/>">
										</span>
										<button class="btn pty_btn" onclick="javascript:fncSelectAuthorGroupList('1'); return false;">검색</button>
									</div>
                                </div>
                                <!--// 검색조건 -->

                                <div class="board_list_top">
                                	<div class="left_col">
                                		<div class="list_count">
												<div style="display: flex; justify-content: space-between; align-items: center;" class="pty_margin-bottom_8">
													
													<div>
														<span style="margin:0;">Totall</span> 
														<strong><c:out value="${paginationInfo.totalRecordCount}" /></strong> 
																
													</div>
														
													<div style="display: flex; align-items: center;">
														<span style="margin-right: 16px;">페이지당 항목 수</span> 
														<label class="item f_select" for="pageUnit"> 
																
															<select name="pageUnit" id="pageUnit" title="페이지당 항목 수" onchange="setPageUnit(); return false;">										
																	<option value="10" <c:if test="${empty userSearchVO.pageUnit || userSearchVO.pageUnit == '10'}">selected="selected"</c:if>>10</option>
																	<option value="20" <c:if test="${userSearchVO.pageUnit == '20'}">selected="selected"</c:if>>20</option>
																	<option value="50" <c:if test="${userSearchVO.pageUnit == '50'}">selected="selected"</c:if>>50</option>
																	<option value="100" <c:if test="${userSearchVO.pageUnit == '100'}">selected="selected"</c:if>>100</option>
																	<option value="300" <c:if test="${userSearchVO.pageUnit == '300'}">selected="selected"</c:if>>300</option>
																	<option value="500" <c:if test="${userSearchVO.pageUnit == '500'}">selected="selected"</c:if>>500</option>
															</select>
														</label>
														
														
													</div>
													
												</div>
												
												
											</div>
                              			</div>
                                    
                                </div>

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="권한 그룹을 관리하는 테이블입니다.사용자 ID,사용자 명,사용자 유형,권한,등록 여부의 정보를 담고 있습니다.">
                                    	<caption>권한그룹관리</caption>
                                        <colgroup>
                                            <col style="width: 5%;">
                                            <col style="width: 5%;">
                                            <col style="width: 10%;">
                                            <col style="width: 15%;">
                                            <col style="width: 15%;">
                                            <col style="width: auto;">
                                            <col style="width: 20%;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <span class="f_chk_only chkAll">
                                                        <input type="checkbox" name="checkAll" title="선택여부" onclick="javascript:fncCheckAll()">
                                                    </span>
                                                </th>
                                                <th scope="col">번호</th>
                                                <th scope="col">사용자명</th>
                                                <th scope="col">직급</th>
                                                <th scope="col">부서</th>
                                                <th scope="col">사용자ID</th>
                                                <th scope="col">권한</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${empty authorGroupList}">
                                        		<tr>
                                        			<td colspan="7">검색결과가 없습니다.</td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="authorGroup" items="${authorGroupList}" varStatus="status">
                                            <tr>
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input type="checkbox" name="delYn" title="선택">
                                                        <input type="hidden" name="checkId" value="<c:out value="${authorGroup.uniqId}"/>"/>
                                                    </span>
                                                </td>
                                                <td><c:out value="${paginationInfo.totalRecordCount - ((authorGroupVO.pageIndex-1) * authorGroupVO.pageUnit) - status.index}"/></td>
                                                <td><c:out value="${authorGroup.userNm}"/></td>
                                                <td><c:out value="${authorGroup.grade}"/></td>
                                                <td><c:out value="${authorGroup.orgnztId}"/></td>
                                                <td><c:out value="${authorGroup.userId}"/></td>
                                                <td>
                                                    <label class="f_select" for="">
                                                        <select name="authorManageCombo" title="권한">
                                                        	<c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
                                                            	<option value="<c:out value="${authorManage.authorCode}"/>" <c:if test="${authorManage.authorCode == authorGroup.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/></option>
                                                            </c:forEach>
                                                    </select>
                                                    </label>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>
								
								<div class="right_col btn_area">                                                                        	
										<!-- <button class="btn pty_btn" onclick="javascript:fntrsfExcel(); return false;">Excel</button> -->
                               			<a href="#LINK" class="btn btn_blue_46" onclick="javascript:fncAddAuthorGroupInsert()">권한변경</a><!-- 권한등록 -->
                               			
                                </div>
								
								<!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty authorGroupVO.pageIndex }">
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                                <!-- //페이지 네비게이션 끝 -->
                                <!--// 게시판 -->
                                
                                <input type="hidden" name="userId"/>
								<input type="hidden" name="userIds"/>
								<input type="hidden" name="authorCodes"/>
								<input type="hidden" name="regYns"/>
								<!-- <input type="hidden" name="mberTyCodes"/> -->
								<input type="hidden" name="pageIndex" value="<c:out value='${authorGroupVO.pageIndex}'/>"/>
								
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