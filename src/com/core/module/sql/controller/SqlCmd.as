package com.core.module.sql.controller
{
	import com.core.ModuleGlobals;

	import flash.net.Responder;

	import org.puremvc.as3.extend.CommandDTO;
	import org.puremvc.as3.patterns.facade.Facade;

	public class SqlCmd extends CommandDTO
	{
		public function SqlCmd()
		{
			super();
		}

		public static function get instance():SqlCmd
		{
			return new SqlCmd();
		}

		public function executeSQL(sql:String, sqlFlag:String=null, rp:Responder=null):void
		{
			AddFunction("executeSQL", [sql, sqlFlag, rp]);
			send();
		}

		private function send():void
		{
			Facade.getInstance().sendNotification(ModuleGlobals.SQL_CMD, this);
		}
	}
}
