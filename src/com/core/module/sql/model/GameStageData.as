package com.core.module.sql.model
{
	import com.core.vo.StageSqlVO;

	public class GameStageData
	{
		private var _stageSqlVO:StageSqlVO;

		public function GameStageData()
		{
		}

		public function get stageSqlVO():StageSqlVO
		{
			return _stageSqlVO;
		}

		public function set stageSqlVO(value:StageSqlVO):void
		{
			_stageSqlVO=value;
		}

	}
}
