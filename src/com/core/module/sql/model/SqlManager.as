package com.core.module.sql.model
{
	import com.core.module.sql.SqlGlobals;
	import com.core.module.sql.controller.SqlCmd;
	import com.core.module.stage.GameStageGlobals;
	import com.core.template.SchoolTemplate;
	import com.core.vo.SchoolVO;

	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.net.Responder;

	public class SqlManager
	{
		private static var _sql:SQLConnection;
		private static var _sqlFile:File;
		private static const path:String=File.applicationStorageDirectory.nativePath + "/guess.sql";
		private static var _firstRun:Boolean;

		public function SqlManager()
		{
		}

		public static function get sql():SQLConnection
		{
			return _sql;
		}

		public static function init():void
		{
			_sqlFile=new File(path);
			_firstRun=!_sqlFile.exists;
			_sql=new SQLConnection();
			_sql.open(_sqlFile);
			trace("打开数据库文件：" + _sqlFile.nativePath);
			if (_firstRun)
			{
				runCreateTabelST();
			}
		}

		private static function runCreateTabelST():void
		{
//			var sql:String="CREATE TABLE stage(id int,status varchar(255));" +
//				"INSERT INTO stage VALUES('1','challenge');"
//				+ "CREATE TABLE user(rp int,guessing varchar(255));" +
//				"INSERT INTO user VALUES('0','');";
			SqlCmd.instance.executeSQL("CREATE TABLE stage(id int,status varchar(255));");
			for (var i:int=0; i < SchoolTemplate.schoolData.length; i++)
			{
				var vo:SchoolVO=SchoolTemplate.schoolData[i];
				var status:String;
				if (i == 0)
					status=GameStageGlobals.STAGE_STATUS_UNLOCKED;
				else
					status=GameStageGlobals.STAGE_STATUS_LOCKED;
				SqlCmd.instance.executeSQL("INSERT INTO stage VALUES('" + vo.id + "','" + status + "');");
			}
			SqlCmd.instance.executeSQL("CREATE TABLE user(rp int,guessing varchar(255));");
			SqlCmd.instance.executeSQL("INSERT INTO user VALUES('0','');");
		}
	}
}
