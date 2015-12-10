package com.hfjy.ws.service.impl;

import java.util.Map;

import com.hfjy.framework.cache.collection.CacheMap;
import com.hfjy.framework.common.entity.AccessResult;
import com.hfjy.framework3rd.cache.RedisAccess;
import com.hfjy.ws.service.SystemService;

public class SystemServiceImpl implements SystemService {
	Map<String, String> sessionServerMap = new CacheMap<>(RedisAccess.class, "session_server_Map");

	@Override
	public void saveSessionId(String sessionId, String serverId) {
		sessionServerMap.put(sessionId, serverId);
	}

	@Override
	public void removeSessionId(String sessionId) {
		sessionServerMap.remove(sessionId);
	}

	@Override
	public AccessResult<String> getServerUrl(String sessionId) {
		return AccessResult.initSuccess(sessionServerMap.get(sessionId));
	}
}
