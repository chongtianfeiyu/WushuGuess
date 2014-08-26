package com.core.template
{
	import com.core.vo.SchoolVO;

	public class SchoolTemplate
	{
		public static var schoolData:Vector.<SchoolVO>;

		public static function init():void
		{

			var xml:XML=XML(new ResourceModule.schoolsData());
			var xmlList:XMLList=xml.school;
			var l:uint=xmlList.length();
			schoolData=new Vector.<SchoolVO>(l, true);
			for (var i:int=0; i < l; i++)
			{
				schoolData[i]=new SchoolVO(xmlList[i]);
			}
			schoolData.sort(sortByIdFunction);
		}

		private static function sortByIdFunction(a:*, b:*):int
		{
			if (a.id < b.id)
			{
				return -1;
			}
			else if (a.id == b.id)
			{
				return 0;
			}
			else
			{
				return -1;
			}

		}

		public static function getSchoolVO(id:int):SchoolVO
		{
			for each (var vo:SchoolVO in schoolData)
			{
				if (vo.id == id)
					return vo;
			}
			return null;

		}
	}
}

