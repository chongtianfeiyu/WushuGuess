package com.core.utils
{
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;

	public class FilterManager
	{
		public function FilterManager()
		{
		}

		public static function get greenGlowFilter():BlurFilter
		{
			return BlurFilter.createGlow(0x00ff00, 1, 5);
		}

		public static function get grayFilter():ColorMatrixFilter
		{
			var filter:ColorMatrixFilter=new ColorMatrixFilter();
			filter.adjustSaturation(-1);
			return filter;
		}
	}
}
