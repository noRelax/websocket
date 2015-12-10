package com.hfjy.ws.controller;

import java.util.List;

import com.google.gson.JsonObject;
import com.hfjy.framework.beans.Bean;
import com.hfjy.framework.common.entity.AccessResult;
import com.hfjy.framework.common.util.StringUtils;
import com.hfjy.framework.net.socket.SocketSession;
import com.hfjy.framework.net.socket.annotation.Code;
import com.hfjy.framework.net.socket.annotation.Type;
import com.hfjy.ws.base.CommonController;
import com.hfjy.ws.service.RoomService;
import com.hfjy.ws.service.VerifyService;
import com.hfjy.ws.service.impl.RoomServiceImpl;
import com.hfjy.ws.service.impl.VerifyServiceImpl;

@Type("r")
public class RoomController extends CommonController {

	@Bean(thisClass = RoomServiceImpl.class)
	private RoomService roomService;

	@Bean(thisClass = VerifyServiceImpl.class)
	private VerifyService verifyService;

	@Code("g")
	public AccessResult<List<String>> getAllRoom() {
		return roomService.getRooms();
	}

	@Code("u")
	public AccessResult<List<String>> getRoomAllUser(JsonObject jo) {
		AccessResult<List<String>> result = roomService.getRoomUsers(jo.get("r").getAsString());
		if (result.isFailure()) {
			return AccessResult.initFailure("房间ID无效");
		}
		if (result.getResult() == null || result.getResult().size() < 1) {
			return AccessResult.initFailure("房间ID无效");
		}
		return AccessResult.initSuccess(result.getResult());
	}

	@Code("i")
	public AccessResult<String> inRoom(SocketSession session, JsonObject jo) {
		AccessResult<String> result = verifyService.getUserId(session.getRemoteUser());
		if (result.isFailure()) {
			return AccessResult.initFailure("你还没有登录");
		}
		AccessResult<String> tmpResult = roomService.getUserRoomId(result.getResult());
		if (tmpResult.isSuccess()) {
			return AccessResult.initFailure(StringUtils.unite("你已经在", tmpResult.getResult(), "房间里了"));
		}
		if (jo == null) {
			return roomService.inRoom(result.getResult());
		} else {
			return roomService.inRoom(result.getResult(), jo.get("r").getAsString());
		}
	}

	@Code("e")
	public AccessResult<String> exitRoom(SocketSession session) {
		AccessResult<String> result = verifyService.getUserId(session.getRemoteUser());
		if (result.isFailure()) {
			return AccessResult.initFailure("你还没有登录");
		}
		return roomService.outRoom(result.getResult());
	}
}