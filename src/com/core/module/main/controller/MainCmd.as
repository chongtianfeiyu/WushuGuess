package com.core.module.main.controller
{
	import com.core.ModuleGlobals;
	import com.core.vo.SchoolVO;
	import com.core.vo.SkillVO;

	import org.puremvc.as3.extend.CommandDTO;
	import org.puremvc.as3.patterns.facade.Facade;

	public class MainCmd extends CommandDTO
	{
		public function MainCmd()
		{
			super();
		}

		public function completeGuess(schoolVO:SchoolVO):void
		{
			AddFunction("completeGuess", [schoolVO]);
			send();
		}

		public static function get instance():MainCmd
		{
			return new MainCmd();
		}

		private function send():void
		{
			Facade.getInstance().sendNotification(ModuleGlobals.MAIN_CMD, this);
		}
	}
}
