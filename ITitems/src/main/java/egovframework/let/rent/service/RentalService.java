package egovframework.let.rent.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 자산 관리를 위한 서비스 인터페이스  클래스
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
public interface RentalService {
	
	public Map<String, Object> SelectRentalVOList(RentalManageVO rentalManageVO) throws Exception;
	
	public RentalVO SelectRentalVO(RentalManageVO rentalManageVO);
	
	public Map<String, Object> SelectMyRentalInfoList(RentalManageVO rentalManageVO);
	
	public int InsertRentalInfo(RentalVO RentalVO);
	
	public int UpdateRentalInfo(RentalVO RentalVO);
	
	public int deleteRentalInfo(RentalVO RentalVO);
	
	public int UpdateRentalDetail(RentalVO RentalVO);
	
	public int InsertRentalHist(RentalVO RentalVO);

	public void xlsxTrsfRentalList(RentalManageVO rentalManageVO, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public void xlsxTrsfMyRentalList(RentalManageVO rentalManageVO, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
