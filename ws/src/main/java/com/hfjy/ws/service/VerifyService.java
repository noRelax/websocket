package com.hfjy.ws.service;

import com.hfjy.framework.common.entity.AccessResult;

public interface VerifyService {

	boolean isLogin(String sessionId);

	AccessResult<String> getUserId(String sessionId);

	AccessResult<String> getSessionId(String userId);

	AccessResult<String> login(String sessionId, String userid);

	AccessResult<String> exit(String sessionId);
}
