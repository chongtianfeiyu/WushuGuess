package com.core.module.hud.controller
{
	import com.core.ModuleGlobals;

	import org.puremvc.as3.extend.CommandDTO;
	import org.puremvc.as3.patterns.facade.Facade;

	public class HudCmd extends CommandDTO
	{
		public function HudCmd()
		{
			super();
		}
		private static var _instance:HudCmd;

		public static function get instance():HudCmd
		{
			if (_instance == null)
				_instance=new HudCmd();
			return _instance;
		}

		private function send():void
		{
			Facade.getInstance().sendNotification(ModuleGlobals.HUD_CMD, this);
		}
	}
}
