package com.core.module.main.controller
{
	import com.core.ModuleGlobals;
	import com.core.module.sql.controller.SqlCmd;
	import com.core.module.sql.model.GameStageData;
	import com.core.module.stage.GameStageGlobals;
	import com.core.vo.SchoolVO;
	import com.core.vo.SkillVO;
	import com.core.vo.StageDataVO;

	import org.puremvc.as3.extend.StrongTypeCommand;

	public class MainCommand extends StrongTypeCommand
	{
		public function MainCommand()
		{
		}

		public function completeGuess(schoolVO:SchoolVO):void
		{
			var sql:String="UPDATE stage SET status='" + GameStageGlobals.STAGE_STATUS_FINISHED + "'WHERE id='" + schoolVO.id + "';";
			SqlCmd.instance.executeSQL(sql);
			for each (var stageVO:StageDataVO in stageData.stageSqlVO.stageDataList)
			{
				if (stageVO.schoolVO.id == schoolVO.id)
				{
					stageVO.schoolStatus=GameStageGlobals.STAGE_STATUS_FINISHED;
					break;
				}
			}
		}

		public function get stageData():GameStageData
		{
			return facade.retrieveProxy(ModuleGlobals.GAME_STAGE_PROXY).getData() as GameStageData;
		}

	}
}
