package com.core.vo
{

	public class StageSqlVO
	{
		public var stageDataList:Vector.<StageDataVO>

		public function StageSqlVO(arr:Array)
		{
			stageDataList=new Vector.<StageDataVO>();
			for each (var temp:Object in arr)
			{
				stageDataList.push(new StageDataVO(temp.id, temp.status));
			}
		}
	}
}
