package com.core.vo
{
	import com.core.globals.Globals;
	import com.core.module.sql.controller.SqlCmd;
	import com.core.template.KeyWordTemplate;

	public class UserVO
	{
		public var rp:int;
		private var _guessingList:Array;

		public function UserVO(data:*)
		{
			this.rp=data.rp;
			_guessingList=new Array();
			var idList:Array=String(data.guessing).length > 0 ? String(data.guessing).split(";") : [];
			if (idList.length != 0)
			{
				for each (var id:String in idList)
				{
					guessingList.push(KeyWordTemplate.getSkillVO(int(id)));
				}
			}
		}

		/**
		 *SkillVO
		 */
		public function get guessingList():Array
		{
			return _guessingList;
		}

		/**
		 * @private
		 */
		public function set guessingList(value:Array):void
		{
			_guessingList=value;
			writeToSql();
		}

		public function getSqlGuessList():String
		{
			var arr:Array=[];
			for each (var vo:SkillVO in guessingList)
			{
				arr.push(vo.id.toString());
			}
			return arr.join(";");
		}

		public function writeToSql():void
		{
			var sql:String="UPDATE user SET guessing = '" + getSqlGuessList() + "'";
			SqlCmd.instance.executeSQL(sql);
		}
	}
}
