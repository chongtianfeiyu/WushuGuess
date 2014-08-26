package com.core.globals
{
	import com.core.MainApplaction;

	import starling.display.Stage;


	public class Globals
	{

		public static const GUESS_COUNT_PER_STAGE:int=5;
		private static var _stage:Stage;

		/**
		 *资源初始化完毕
		 */
		public static var GAME_RESOURCE_LOADED:String="GAME_RESOURCE_LOADED";
		/**
		 *选择关卡
		 */
		public static var SELECT_GAME_STAGE:String="SELECT_GAME_STAGE";


		public static function get stage():Stage
		{
			if (_stage == null)
				_stage=MainApplaction.mStarling.stage;
			return _stage;
		}

		public static var stageDataInited:Boolean=false;
		public static var userDataInited:Boolean=false;

		public static function getGameDataInited():Boolean
		{
			return stageDataInited && userDataInited;
		}
	}
}
