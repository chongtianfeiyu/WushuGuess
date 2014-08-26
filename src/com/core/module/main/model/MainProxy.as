package com.core.module.main.model
{
	import com.core.ModuleGlobals;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class MainProxy extends Proxy implements IProxy
	{
		public function MainProxy()
		{
			super(ModuleGlobals.MAIN_PROXY, new MainData());
		}

		public function mainData():MainData
		{
			return this.getData() as MainData;
		}
	}
}
