package com.hfjy.ws.service.impl;

import java.util.List;
import java.util.Map;

import com.hfjy.framework.cache.collection.CacheList;
import com.hfjy.framework.cache.collection.CacheMap;
import com.hfjy.framework.common.entity.AccessResult;
import com.hfjy.framework.common.util.StringUtils;
import com.hfjy.framework3rd.cache.RedisAccess;
import com.hfjy.ws.service.DialogueService;

public class DialogueServiceImpl implements DialogueService {
	Map<String, List<String>> userDialogueMap = new CacheMap<>(RedisAccess.class, "user_dialogue_map");

	@Override
	public void recordDialogue(String fromUserId, String toUserId, String text) {
		AccessResult<List<String>> result = getUserHistoricalRecords(toUserId);
		if (result.isSuccess()) {
			result.getResult().add(text);
		}
	}

	@Override
	public AccessResult<List<String>> getUserHistoricalRecords(String userId) {
		List<String> userDialogueList = userDialogueMap.get(userId);
		if (userDialogueList == null) {
			userDialogueList = new CacheList<>(RedisAccess.class, StringUtils.unite(userId, "user_dialogue_list"));
		}
		return AccessResult.initSuccess(userDialogueList);
	}

}
