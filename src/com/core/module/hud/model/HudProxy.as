package com.core.module.hud.model
{
	import com.core.ModuleGlobals;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class HudProxy extends Proxy implements IProxy
	{
		public function HudProxy()
		{
			super(ModuleGlobals.HUD_PROXY, null);
		}
	}
}
