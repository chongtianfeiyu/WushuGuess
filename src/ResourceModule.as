package
{
	import flash.display.Sprite;

	public class ResourceModule extends Sprite
	{
		[Embed(source="assets/data/keywords.xml",mimeType="application/octet-stream")]
		public static var keywordsData:Class;
		[Embed(source="assets/data/schools.xml",mimeType="application/octet-stream")]
		public static var schoolsData:Class;
		public function ResourceModule()
		{
			super();
		}
	}
}

