package com.hfjy.ws.service;

import com.hfjy.framework.common.entity.AccessResult;

public interface SystemService {

	void saveSessionId(String sessionId, String serverId);

	void removeSessionId(String sessionId);

	AccessResult<String> getServerUrl(String sessionId);
}
