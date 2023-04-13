package egovframework.let.ass.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.ass.service.AssetInfo;
import egovframework.let.ass.service.AssetInfoVO;
import egovframework.let.ass.service.AssetService;

/**
 * 자산관리를 위한 서비스 구현 클래스
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

@Service("AssetService")
public class AssetServiceImpl extends EgovAbstractServiceImpl implements AssetService {

	@Override
	public List<AssetInfoVO> SelectAssetInfoVOList(AssetInfoVO assetInfoVO) throws Exception {
		
		return null;
	}

	@Override
	public AssetInfoVO SelectAssetInfoVO(AssetInfoVO assetInfoVO) throws Exception {
		
		return null;
	}

	@Override
	public int InsertAssetInfo(AssetInfo assetInfo) throws Exception {
		
		return 0;
	}

	@Override
	public int UpdateAssetInfo(AssetInfo assetInfo) throws Exception {
		
		return 0;
	}

}
