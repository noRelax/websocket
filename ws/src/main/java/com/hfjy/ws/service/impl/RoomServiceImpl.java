package com.hfjy.ws.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.hfjy.framework.beans.Bean;
import com.hfjy.framework.cache.collection.CacheMap;
import com.hfjy.framework.common.entity.AccessResult;
import com.hfjy.framework.common.util.StringUtils;
import com.hfjy.framework3rd.cache.RedisAccess;
import com.hfjy.ws.service.RoomService;
import com.hfjy.ws.service.VerifyService;

public class RoomServiceImpl implements RoomService {
	Map<String, List<String>> roomUserMap = new CacheMap<>(RedisAccess.class, "room_user_map");

	@Bean(thisClass = VerifyServiceImpl.class)
	private VerifyService verifyService;

	@Override
	public boolean isInRoom(String sessionId) {
		if (verifyService.isLogin(sessionId)) {
			AccessResult<String> result = verifyService.getUserId(sessionId);
			if (result.isSuccess()) {
				if (getUserRoomId(result.getResult()).isSuccess()) {
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public boolean isSameRoomFromUserId(String userIdOne, String userIdTwo) {
		AccessResult<String> from = getUserRoomId(userIdOne);
		AccessResult<String> to = getUserRoomId(userIdTwo);
		if (from.isSuccess() && to.isSuccess() && from.getResult().equals(to.getResult())) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean isSameRoomFromSessionId(String sessionIdOne, String sessionIdTwo) {
		AccessResult<String> from = verifyService.getUserId(sessionIdOne);
		AccessResult<String> to = verifyService.getUserId(sessionIdTwo);
		if (from.isSuccess() && to.isSuccess()) {
			return isSameRoomFromUserId(from.getResult(), to.getResult());
		} else {
			return false;
		}
	}

	@Override
	public AccessResult<List<String>> getRooms() {
		List<String> list = new ArrayList<>();
		list.addAll(roomUserMap.keySet());
		return AccessResult.initSuccess(list);
	}

	@Override
	public AccessResult<List<String>> getRoomUsers(String roomId) {
		return AccessResult.initSuccess(roomUserMap.get(roomId));
	}

	@Override
	public AccessResult<String> getUserRoomId(String userId) {
		AccessResult<List<String>> roomResult = getRooms();
		if (roomResult.isSuccess()) {
			for (int i = 0; i < roomResult.getResult().size(); i++) {
				String roomId = roomResult.getResult().get(i);
				List<String> users = roomUserMap.get(roomId);
				if (users.contains(userId)) {
					return AccessResult.initSuccess(roomId);
				}
			}
		}
		return AccessResult.initFailure("你没有进入任何房间");
	}

	@Override
	public AccessResult<String> inRoom(String userId) {
		String newRoomId = (roomUserMap.keySet().size() + 1) + "";
		List<String> users = new ArrayList<>();
		users.add(userId);
		roomUserMap.put(newRoomId, users);
		return AccessResult.initSuccess("为你新开了一间房间,ID为" + newRoomId);
	}

	@Override
	public AccessResult<String> inRoom(String userId, String roomId) {
		if (roomUserMap.containsKey(roomId)) {
			List<String> users = roomUserMap.get(roomId);
			users.add(userId);
			roomUserMap.put(roomId, users);
			return AccessResult.initSuccess(StringUtils.unite("成功进入房间", roomId));
		}
		return AccessResult.initFailure("房间ID无效");
	}

	@Override
	public AccessResult<String> outRoom(String userId) {
		AccessResult<String> result = getUserRoomId(userId);
		if (result.isFailure()) {
			return result;
		}
		List<String> users = roomUserMap.get(result.getResult());
		users.remove(userId);
		if (users.size() > 0) {
			roomUserMap.put(result.getResult(), users);
		} else {
			roomUserMap.remove(result.getResult());
		}
		return AccessResult.initSuccess(StringUtils.unite("成功退出房间", result.getResult()));
	}
}