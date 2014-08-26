package com.core.vo
{
	public class SkillVO
	{
		public var id:int;
		public var name:String;
		public var gift:String;
		public var icon:String;
		public var words:String;
		public function SkillVO(xmlData:XML)
		{
			this.id = xmlData.@id;
			this.name = xmlData.@name;
			this.gift = xmlData.@gift;
			this.icon = xmlData.@icon;
			this.words = xmlData.@words;
		}
	}
}

