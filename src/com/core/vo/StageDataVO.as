package com.core.vo
{
	import com.core.module.sql.controller.SqlCmd;
	import com.core.template.SchoolTemplate;

	public class StageDataVO
	{
		public var schoolVO:SchoolVO;
		private var _schoolStatus:String;

		public function StageDataVO(schoolId:int, schoolStatus:String)
		{
			this.schoolVO=SchoolTemplate.getSchoolVO(schoolId);
			_schoolStatus=schoolStatus;
		}

		public function get schoolStatus():String
		{
			return _schoolStatus;
		}

		public function set schoolStatus(value:String):void
		{
			_schoolStatus=value;
			writeToSql();
		}

		private function writeToSql():void
		{
			var sql:String="UPDATE stage SET status = '" + _schoolStatus + "'WHERE id='" + schoolVO.id + "';";
			SqlCmd.instance.executeSQL(sql);
		}

	}
}
