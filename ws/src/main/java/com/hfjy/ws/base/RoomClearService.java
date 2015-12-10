package com.hfjy.ws.base;

import com.hfjy.framework.beans.BeanManager;
import com.hfjy.framework.common.entity.AccessResult;
import com.hfjy.framework.net.socket.DestructionFilter;
import com.hfjy.ws.service.RoomService;
import com.hfjy.ws.service.VerifyService;
import com.hfjy.ws.service.impl.RoomServiceImpl;
import com.hfjy.ws.service.impl.VerifyServiceImpl;

public class RoomClearService implements DestructionFilter {

	private RoomService roomService = BeanManager.registrationClass(RoomServiceImpl.class);

	private VerifyService verifyService = BeanManager.registrationClass(VerifyServiceImpl.class);;

	@Override
	public void onClose(String remote) {
		AccessResult<String> result = verifyService.getUserId(remote);
		if (result.isSuccess()) {
			verifyService.exit(remote);
			roomService.outRoom(result.getResult());
		}
	}
}
