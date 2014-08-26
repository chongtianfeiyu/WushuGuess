package com.core.module.stage.controller
{
	import com.core.ModuleGlobals;

	import org.puremvc.as3.extend.CommandDTO;
	import org.puremvc.as3.patterns.facade.Facade;

	public class GameStageCmd extends CommandDTO
	{
		public function GameStageCmd()
		{
			super();
		}
		private static var _instance:GameStageCmd;

		public static function get instance():GameStageCmd
		{
			if (_instance == null)
				_instance=new GameStageCmd();
			return _instance;
		}

		private function send():void
		{
			Facade.getInstance().sendNotification(ModuleGlobals.GAME_STAGE_CMD, this);
		}
	}
}
