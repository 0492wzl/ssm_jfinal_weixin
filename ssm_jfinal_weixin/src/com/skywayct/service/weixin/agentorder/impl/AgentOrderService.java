package com.skywayct.service.weixin.agentorder.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.skywayct.dao.DaoSupport;
import com.skywayct.entity.Page;
import com.skywayct.service.weixin.agentorder.AgentOrderManager;
import com.skywayct.util.PageData;

@Service("agentorderService")
public class AgentOrderService implements AgentOrderManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 代理会员查看下级订单列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList(
				"AgentOrderMapper.datalistPage", page);
	}

	/**
	 * 统计
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> countOrder(Page page) throws Exception {
		return (List<PageData>) dao.findForList("AgentOrderMapper.countOrder",
				page);
	}

}
