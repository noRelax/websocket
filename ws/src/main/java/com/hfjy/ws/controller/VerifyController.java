package com.hfjy.ws.controller;

import com.google.gson.JsonObject;
import com.hfjy.framework.beans.Bean;
import com.hfjy.framework.common.entity.AccessResult;
import com.hfjy.framework.common.util.JsonUtil;
import com.hfjy.framework.net.socket.SocketSession;
import com.hfjy.framework.net.socket.annotation.Code;
import com.hfjy.framework.net.socket.annotation.Type;
import com.hfjy.ws.base.CommonController;
import com.hfjy.ws.service.SystemService;
import com.hfjy.ws.service.VerifyService;
import com.hfjy.ws.service.impl.SystemServiceImpl;
import com.hfjy.ws.service.impl.VerifyServiceImpl;

@Type("v")
public class VerifyController extends CommonController {

	@Bean(thisClass = VerifyServiceImpl.class)
	private VerifyService verifyService;

	@Bean(thisClass = SystemServiceImpl.class)
	private SystemService systemService;

	@Code("g")
	public AccessResult<String> getUserId(SocketSession session) {
		return verifyService.getUserId(session.getRemoteUser());
	}

	@Code("l")
	public AccessResult<String> login(SocketSession session, String date) {
		JsonObject jo = JsonUtil.toJsonObject(date);
		String user = jo.get("u").getAsString();
		systemService.saveSessionId(session.getRemoteUser(), session.getLocalServerUrl());
		return verifyService.login(session.getRemoteUser(), user);
	}

	@Code("e")
	public AccessResult<String> exit(SocketSession session) {
		systemService.removeSessionId(session.getRemoteUser());
		return verifyService.exit(session.getRemoteUser());
	}
}
