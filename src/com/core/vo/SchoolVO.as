package com.core.vo
{

	public class SchoolVO
	{
		public var id:int;
		public var name:String;
		public var gifts:String;
		public var texture:String;

		public function SchoolVO(xmlData:XML)
		{
			this.id=xmlData.@id;
			this.name=xmlData.@name;
			this.gifts=xmlData.@gifts;
			this.texture=xmlData.@texture;
		}

		public function getGifts():Array
		{
			return gifts.split(";");
		}
	}
}

