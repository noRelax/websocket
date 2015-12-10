package com.hfjy.ws.base;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class StartInit implements ServletContextListener{

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("系统初始化开始···");
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("系统销毁···");
	}
	

}
