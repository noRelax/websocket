package com.hfjy.ws.service;

import java.util.List;

import com.hfjy.framework.common.entity.AccessResult;

public interface DialogueService {

	void recordDialogue(String fromUserId, String toUserId, String text);

	AccessResult<List<String>> getUserHistoricalRecords(String userId);

}
