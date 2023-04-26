package egovframework.let.req.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.cat.service.CategoryManageVO;
import egovframework.let.cat.service.CategoryService;
import egovframework.let.req.service.RequestService;
import egovframework.let.uss.umt.service.EgovUserManageService;
import egovframework.let.uss.umt.service.UserManageVO;

/**
 * 신청관리를 위한 컨트롤러 클래스
 * 
 * @author 영남사업부 주소현
 * @since 2023.04.26
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.04.26  주소현          최초 생성
 *
 *      </pre>
 */

@Controller
public class RequestController {

	@Resource(name = "RequestService")
	private RequestService requestService;
	
	@Resource(name = "CategoryService")
	protected CategoryService categoryService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "userManageService")
	private EgovUserManageService userManageService;


	/**
	 * 반입/반출신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/req/CarryRequset.do")
	public String ReturnRequest(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		vo.setCodeId("COM008");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		return "/req/CarryRequset";
	}
	
	/**
	 * 반입/반출신청 등록 페이지로 이동
	 */
	@RequestMapping(value = "/req/CarryRegist.do")
	public String CarryRegist(HttpServletRequest request, ModelMap model, @ModelAttribute("AssetInfoVO") AssetInfoVO assetInfoVO) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		UserManageVO userManageVO = new UserManageVO();
		userManageVO = userManageService.selectUser(user.getUniqId());
		model.addAttribute("userManageVO", userManageVO);
	
		return "/req/CarryRegist";
	}

	/**
	 * 처분신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/req/DisposeRequest.do")
	public String DisposeRequest(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		vo.setCodeId("COM008");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		return "/req/DisposeRequest";
	}

	/**
	 * 수리신청조회 페이지로 이동
	 */
	@RequestMapping(value = "/req/RepairRequest.do")
	public String RepairRequest(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("baseMenuNo", "100");

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));
		
		vo.setCodeId("COM008");
		model.addAttribute("status_result", cmmUseService.selectCmmCodeDetail(vo));
		
		CategoryManageVO cvo = new CategoryManageVO();
		model.addAttribute("LCat_result", categoryService.SelectCategoryVOList(cvo));
		
		
		return "/req/RepairRequest";
	}

	
}
