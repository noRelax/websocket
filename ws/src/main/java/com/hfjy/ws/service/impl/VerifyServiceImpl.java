package com.hfjy.ws.service.impl;

import java.util.Iterator;
import java.util.Map;

import com.hfjy.framework.cache.collection.CacheMap;
import com.hfjy.framework.common.entity.AccessResult;
import com.hfjy.framework3rd.cache.RedisAccess;
import com.hfjy.ws.service.VerifyService;

public class VerifyServiceImpl implements VerifyService {
	Map<String, String> userSessionMap = new CacheMap<String, String>(RedisAccess.class, "user_session_map");

	@Override
	public boolean isLogin(String sessionId) {
		return userSessionMap.containsKey(sessionId);
	}

	@Override
	public AccessResult<String> login(String sessionId, String userid) {
		if (userSessionMap.containsValue(userid)) {
			return AccessResult.initFailure("用户ID已经存在");
		}
		if (!isLogin(sessionId)) {
			userSessionMap.put(sessionId, userid);
			return AccessResult.initSuccess("登录成功");
		}
		return AccessResult.initFailure("你已经登录");
	}

	@Override
	public AccessResult<String> exit(String sessionId) {
		if (isLogin(sessionId)) {
			userSessionMap.remove(sessionId);
			return AccessResult.initSuccess("退出成功");
		}
		return AccessResult.initFailure("该用户没有登录");
	}

	@Override
	public AccessResult<String> getUserId(String sessionId) {
		String userId = userSessionMap.get(sessionId);
		if (userId == null) {
			return AccessResult.initFailure("该用户没有登录");
		} else {
			return AccessResult.initSuccess(userId);
		}
	}

	@Override
	public AccessResult<String> getSessionId(String userId) {
		Iterator<String> iterator = userSessionMap.keySet().iterator();
		while (iterator.hasNext()) {
			String sessionId = iterator.next();
			String tmpUserId = userSessionMap.get(sessionId);
			if (tmpUserId.equals(userId)) {
				return AccessResult.initSuccess(sessionId);
			}
		}
		return AccessResult.initFailure("没有找到你的登录信息");
	}
}
