package com.core.module.sql.view
{
	import com.core.ModuleGlobals;
	import com.core.module.sql.SqlGlobals;
	import com.core.module.sql.controller.SqlCmd;

	import flash.data.SQLResult;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class SqlMediator extends Mediator
	{
		public function SqlMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(ModuleGlobals.SQL_MEDIATOR, viewComponent);
		}

		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case SqlGlobals.SQL_EXCUTE_SUCCESSED:
					var result:SQLResult=notification.getBody().result;
					var flag:String=notification.getBody().flag;
					if (flag != null)
						handlerFlag(result, flag);
					break;
				case SqlGlobals.SQL_EXCUTE_FAILED:
					break;
				case SqlGlobals.SQL_DATA_INTED:
//					SqlCmd.instance.executeSQL("INSERT INTO stage VALUES('1','challenge');");
					break;

			}
		}

		private function handlerFlag(result:SQLResult, flag:String):void
		{
			sendNotification(flag, result);
		}

		override public function listNotificationInterests():Array
		{
			return [SqlGlobals.SQL_EXCUTE_SUCCESSED, SqlGlobals.SQL_EXCUTE_FAILED, SqlGlobals.SQL_DATA_INTED];
		}

	}
}
