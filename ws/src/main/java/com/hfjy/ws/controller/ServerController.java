package com.hfjy.ws.controller;

import com.hfjy.framework.net.socket.SocketSession;
import com.hfjy.framework.net.socket.annotation.Code;
import com.hfjy.framework.net.socket.annotation.Type;
import com.hfjy.ws.base.CommonController;

@Type("s")
public class ServerController extends CommonController {

	@Code("g")
	public String getServerHost(SocketSession session) {
		return session.getLocalServerUrl();
	}
}
