package com.core.module.sql.controller
{
	import com.core.module.sql.SqlGlobals;
	import com.core.module.sql.model.SqlManager;

	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.net.Responder;

	import org.puremvc.as3.extend.StrongTypeCommand;

	public class SqlCommand extends StrongTypeCommand
	{
		private var _sqlList:Array;
		private var _sqlStatement:SQLStatement;

		public function SqlCommand()
		{
			super();
			_sqlList=new Array();
		}

		private function get sqlStatement():SQLStatement
		{
			if (_sqlStatement == null)
			{
				_sqlStatement=new SQLStatement();
				_sqlStatement.sqlConnection=SqlManager.sql;
			}
			return _sqlStatement;
		}

		public function executeSQL(sql:String, sqlFlag:String=null, rp:Responder=null):void
		{
			if (sqlStatement.executing)
			{
				_sqlList.push({sql: sql, sqlFlag: sqlFlag});
			}
			else
			{
				sqlStatement.text=sql;
				sqlStatement.addEventListener(SQLEvent.RESULT, function(e:SQLEvent):void
				{
					var ret:SQLResult=sqlStatement.getResult();
					sendNotification(SqlGlobals.SQL_EXCUTE_SUCCESSED, {result: ret, flag: sqlFlag});
					if (_sqlList.length > 0)
					{
						var tempData:Object=_sqlList.shift();
						executeSQL(tempData.sql, tempData.sqlFlag);
					}
				});
				sqlStatement.execute(-1, rp);
			}
		}
	}
}
