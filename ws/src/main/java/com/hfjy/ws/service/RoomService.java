package com.hfjy.ws.service;

import java.util.List;

import com.hfjy.framework.common.entity.AccessResult;

public interface RoomService {

	boolean isInRoom(String sessionId);

	boolean isSameRoomFromUserId(String userIdOne, String userIdTwo);

	boolean isSameRoomFromSessionId(String sessionIdIdOne, String sessionIdTwo);

	AccessResult<List<String>> getRooms();

	AccessResult<List<String>> getRoomUsers(String roomId);

	AccessResult<String> getUserRoomId(String userId);

	AccessResult<String> inRoom(String userId);

	AccessResult<String> inRoom(String userId, String roomId);

	AccessResult<String> outRoom(String userId);
}
