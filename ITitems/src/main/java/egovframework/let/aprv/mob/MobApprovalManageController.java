package egovframework.let.aprv.mob;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.aprv.service.ApprovalDefaultVO;
import egovframework.let.aprv.service.ApprovalManageService;
import egovframework.let.aprv.service.ApprovalManageVO;
import egovframework.let.ass.service.AssetVO;
import egovframework.let.req.service.RequestManageVO;
import egovframework.let.req.service.RequestService;

/**
 * 사용자관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 영남사업부 천세훈
 * @since 2023.05.17
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.05.10  천세훈         최초 생성
 *
 * </pre> 
 */

@RestController
public class MobApprovalManageController {

	/** approvalManageService */
	@Resource(name = "approvalManageService")
	private ApprovalManageService approvalManageService;
	
	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "RequestService")
	private RequestService requestService;
	/**
	 * 전체조회
	 * @param approvalSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return aprv/approvalManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/aprv/MobApprovalManage.do")
	public Map<String, Object> selectApprovalList(@RequestBody ApprovalDefaultVO approvalSearchVO,
									 ModelMap model, HttpServletRequest request) throws Exception{
		Map<String, Object> appMap = new HashMap<String, Object>();
		System.out.println("결재 전제조회 ============================================");
		System.out.println(approvalSearchVO.getSearchKeyword());
		System.out.println(approvalSearchVO.getSearchGroup());
		System.out.println(approvalSearchVO.getSearchStatus());

		//메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "2000000");
		LoginVO loginId = (LoginVO)request.getSession().getAttribute("LoginVO");

		approvalSearchVO.setUniqId(loginId.getUniqId());

//		//미인증 사용자에 대한 보안처리
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
//		if(!isAuthenticated) {
//			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
//			return "uat/uia/EgovLoginUsr";
//		}

		/** EgovPropertyService*/
		approvalSearchVO.setPageSize(propertiesService.getInt("pageSize"));

		appMap.put("resultList", approvalManageService.mobSelectApprovalList(approvalSearchVO));
		int leftCnt = approvalManageService.selectApprovalListTotCntB(approvalSearchVO);
		appMap.put("leftCnt", leftCnt);

		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		//결재상태코드를 코드정보로부터 조회 - COM008
		vo.setCodeId("COM008");
		appMap.put("aprvStatus_result", cmmUseService.selectCmmCodeDetail(vo));

		//결재요청분류코드를 코드정보로부터 조회 - COM011
		vo.setCodeId("COM011");
		appMap.put("aprvGroup_result", cmmUseService.selectCmmCodeDetail(vo));

		return appMap;
	}
	
	/**
	 * 반출입신청 결재요청자 등록
	 */
	@RequestMapping(value = "/aprv/MobApprovalInsert.do")
	@ResponseBody
	public String ApprovalInsert(ApprovalManageVO approvalManageVO, HttpServletRequest request) {
		LoginVO loginId = (LoginVO)request.getSession().getAttribute("LoginVO");
		approvalManageVO.setId(loginId.getUniqId());
		approvalManageService.InsertApproval(approvalManageVO);
		return approvalManageVO.getReqId();
	}
	
	/**
	 * 반출입신청상세정보 페이지로 이동
	 */
	@RequestMapping(value = "/aprv/MobSelectApproval.do")
	public Map<String, Object> SelectApproval(@RequestBody ApprovalDefaultVO approvalSearchVO,
								RequestManageVO manageVO,
								HttpServletRequest request,
								ModelMap model) throws Exception {
		Map<String, Object> appMap = new HashMap<String, Object>();
		
		LoginVO loginId = (LoginVO)request.getSession().getAttribute("LoginVO");
		approvalSearchVO.setAuthorCode(loginId.getAuthorCode());
		approvalSearchVO.setUniqId(loginId.getUniqId());
		System.out.println("왔다==============================================");
		System.out.println(approvalSearchVO.getAuthorCode());
		System.out.println(approvalSearchVO.getUniqId());
		System.out.println("==============================================");
//		// 미인증 사용자에 대한 보안처리
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
//    	if(!isAuthenticated) {
//    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
//        	return "uat/uia/EgovLoginUsr";
//    	}
    	
		ApprovalManageVO approvalManageVO = new ApprovalManageVO();
		approvalManageVO = approvalManageService.SelectApproval(approvalSearchVO);
		appMap.put("approvalVO", approvalManageVO);
		appMap.put("AuthorCode", approvalSearchVO.getAuthorCode());
		appMap.put("loginId", approvalSearchVO.getUniqId());
		//============= 모바일 처리
//		manageVO.setAuthorCode(approvalSearchVO.getAuthorCode());
//		manageVO.setId(approvalSearchVO.getUniqId());
		manageVO.setReqId(approvalSearchVO.getReqId());
		
		//====================
		appMap.put("approvalDetailList", requestService.MobSelectRequestVOList(manageVO));
		appMap.put("aprvList_result",requestService.SelectAprvList(manageVO));
		System.out.println("==============================================");
		System.out.println(appMap);
		System.out.println("==============================================");
		return appMap;
	}
	
	/**
	 * 반출입신청 승인처리
	 */
	@RequestMapping(value = "/aprv/MobApprovalUpdate.do")
	@ResponseBody
	public int UpdateApproval(ApprovalManageVO approvalManageVO, HttpServletRequest request) {
		LoginVO loginVO = (LoginVO)request.getSession().getAttribute("LoginVO");
		String targetId = loginVO.getUniqId();
		approvalManageVO.setTargetId(targetId);
		System.out.println(approvalManageVO.getReqId());
		return approvalManageService.UpdateApproval(approvalManageVO);
	}
	/**
	 * 반출입신청 자산내역 등록
	 */
	@RequestMapping(value = "/aprv/MobApprovalInsertHist.do")
	@ResponseBody
	public int ApprovalInsertHist(AssetVO assetVO) {
		return approvalManageService.ApprovalInsertHist(assetVO);
	}
	/**
	 * 반출입신청 반려처리
	 */
	@RequestMapping(value = "/aprv/MobApprovalDisUpdate.do")
	@ResponseBody
	public int ApprovalDisUpdate(ApprovalManageVO approvalManageVO, HttpServletRequest request, @RequestParam String reqId ) {
		LoginVO loginVO = (LoginVO)request.getSession().getAttribute("LoginVO");
		String targetId = loginVO.getUniqId();
		approvalManageVO.setReqId(reqId);
		approvalManageVO.setTargetId(targetId);
		return approvalManageService.ApprovalDisUpdate(approvalManageVO);
	}
	
}