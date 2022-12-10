package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.AttachImageVO;
import org.zerock.mapper.AttachMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AttachServiceImpl implements AttachService{
	
	@Autowired
	private AttachMapper attachMapper;

	@Override
	public List<AttachImageVO> getAttachList(int goodsCode) {
		// TODO Auto-generated method stub
		log.info("getAttachList............");
		
		return attachMapper.getAttachList(goodsCode);
	}

}
