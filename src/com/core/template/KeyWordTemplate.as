package com.core.template
{
	import com.core.vo.SchoolVO;
	import com.core.vo.SkillVO;

	public class KeyWordTemplate
	{
		public static var keyWordsData:Vector.<SkillVO>;

		public static function init():void
		{

			var xml:XML=XML(new ResourceModule.keywordsData());
			var xmlList:XMLList=xml.skill;
			var l:uint=xmlList.length();
			keyWordsData=new Vector.<SkillVO>(l, true);
			for (var i:int=0; i < l; i++)
			{
				keyWordsData[i]=new SkillVO(xmlList[i]);
			}
		}

		public static function getSkillVO(id:int):SkillVO
		{
			for each (var vo:SkillVO in keyWordsData)
			{
				if (vo.id == id)
					return vo;
			}
			return null;

		}

		public static function getRandomList(count:int, schoolVO:SchoolVO):Array
		{
			var srcArray:Array=getSkillVOListByShcoolVO(schoolVO);
			srcArray.sort(randomSort);
			var ret:Array=[];
			for (var i:int=0; i < count; i++)
			{
				ret.push(srcArray[i]);
			}
			return ret;
		}

		private static function randomSort(a:*, b:*):int
		{
			return int(Math.random() * 3) - 1;
		}

		public static function getSkillVOListByShcoolVO(schoolVO:SchoolVO):Array
		{
			var ret:Array=[];
			var giftList:Array=schoolVO.getGifts();
			for each (var vo:SkillVO in keyWordsData)
			{
				if (giftList.indexOf(vo.gift) != -1)
					ret.push(vo);
			}
			return ret;
		}
	}
}

