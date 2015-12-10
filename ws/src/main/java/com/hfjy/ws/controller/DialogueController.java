package com.hfjy.ws.controller;

import java.io.IOException;
import java.util.List;

import com.google.gson.JsonObject;
import com.hfjy.framework.beans.Bean;
import com.hfjy.framework.common.entity.AccessResult;
import com.hfjy.framework.common.util.StringUtils;
import com.hfjy.framework.net.socket.DataMessage;
import com.hfjy.framework.net.socket.SocketSession;
import com.hfjy.framework.net.socket.annotation.Code;
import com.hfjy.framework.net.socket.annotation.Type;
import com.hfjy.ws.base.CommonController;
import com.hfjy.ws.service.DialogueService;
import com.hfjy.ws.service.RoomService;
import com.hfjy.ws.service.SystemService;
import com.hfjy.ws.service.VerifyService;
import com.hfjy.ws.service.impl.DialogueServiceImpl;
import com.hfjy.ws.service.impl.RoomServiceImpl;
import com.hfjy.ws.service.impl.SystemServiceImpl;
import com.hfjy.ws.service.impl.VerifyServiceImpl;

@Type("d")
public class DialogueController extends CommonController {

	@Bean(thisClass = DialogueServiceImpl.class)
	private DialogueService dialogueService;

	@Bean(thisClass = VerifyServiceImpl.class)
	private VerifyService verifyService;

	@Bean(thisClass = RoomServiceImpl.class)
	private RoomService roomService;

	
	
	@Bean(thisClass = SystemServiceImpl.class)
	private SystemService systemService;

	@Code("g")
	public void getMyHistoricalRecords(SocketSession session) throws IOException {
		String sessionId = session.getRemoteUser();
		if (verifyService.isLogin(sessionId)) {
			AccessResult<String> result = verifyService.getUserId(sessionId);
			if (result.isSuccess()) {
				AccessResult<List<String>> tmpResult = dialogueService.getUserHistoricalRecords(result.getResult());
				if (tmpResult.isSuccess()) {
					for (int i = 0; i < tmpResult.getResult().size(); i++) {
						session.sendMessage(tmpResult.getResult().get(i));
					}
				}
			}
		}
	}

	@Code("d")
	public void dialogue(SocketSession session, JsonObject jo) throws Exception {
		String sessionId = session.getRemoteUser();
		if (verifyService.isLogin(sessionId)) {
			if (roomService.isInRoom(sessionId)) {
				String fromUserId = verifyService.getUserId(sessionId).getResult();
				String toUserId = jo.get("t").getAsString();
				if (roomService.isSameRoomFromUserId(fromUserId, toUserId)) {
					String toSessionId = verifyService.getSessionId(toUserId).getResult();
					String text = jo.get("d").getAsString();
					text = StringUtils.unite(fromUserId, "对你说：", text);
					dialogueService.recordDialogue(fromUserId, toUserId, text);
					if (getWebSocketSession(toSessionId) != null) {
						sendMessageRemote(toSessionId, text);
					} else {
						AccessResult<String> uriResult = systemService.getServerUrl(toSessionId);
						if (uriResult.isSuccess()) {
							DataMessage data = new DataMessage();
							data.setType("d");
							data.setCode("s");
							JsonObject message = new JsonObject();
							message.addProperty("m", sessionId);
							message.addProperty("t", toSessionId);
							message.addProperty("d", text);
							data.setData(message);
							sendMessageServer(session, uriResult.getResult(), data);
						}
					}
				}
			}
		}
	}

	@Code("s")
	public void dialogueFromServer(JsonObject jo) throws IOException {
		String sessionId = jo.get("m").getAsString();
		String toSessionId = jo.get("t").getAsString();
		if (roomService.isSameRoomFromSessionId(sessionId, toSessionId)) {
			sendMessageRemote(toSessionId, jo.get("d").getAsString());
		}
	}
}
