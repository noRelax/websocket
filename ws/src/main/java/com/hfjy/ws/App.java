package com.hfjy.ws;

import java.util.Iterator;
import java.util.Properties;

import org.slf4j.Logger;

import com.hfjy.framework.common.util.LocalResourcesUtil;
import com.hfjy.framework.common.util.StringUtils;
import com.hfjy.framework.logging.LoggerFactory;
import com.hfjy.framework.net.socket.SockeServer;
import com.hfjy.framework3rd.net.websocket.JettyWebSockeServer;
import com.hfjy.ws.base.RoomClearService;
//主分支提交代码
public class App {
	private final static Logger log = LoggerFactory.getLogger(App.class);
	

	public static void main(String[] args) throws Exception {
		Properties config = LocalResourcesUtil.getProperties("c:/user");
		final Iterator<Object> iterator = config.values().iterator();
		while (iterator.hasNext()) {
			final Integer port = Integer.parseInt(iterator.next().toString());
			new Thread() {
				public void run() {
					try {
						log.info(StringUtils.unite("server port is ", port));
						SockeServer webSockeServer = new JettyWebSockeServer(port);
						webSockeServer.initControllers(new String[] { "com.hfjy.ws.controller" });
						webSockeServer.addDestructionFilter(RoomClearService.class);
						log.info(StringUtils.unite(port, " port this server ok"));
						webSockeServer.start();
					} catch (Exception e) {
						log.error(e.getMessage(), e);
					}
				}
			}.start();
		}
	}
}
