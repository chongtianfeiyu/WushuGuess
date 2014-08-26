package com.core.module.stage.model
{
	import com.core.ModuleGlobals;
	import com.core.module.sql.model.GameStageData;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class GameStageProxy extends Proxy implements IProxy
	{
		public function GameStageProxy()
		{
			super(ModuleGlobals.GAME_STAGE_PROXY, new GameStageData());
		}

	}
}
