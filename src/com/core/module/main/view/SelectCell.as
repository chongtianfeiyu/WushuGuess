package com.core.module.main.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class SelectCell extends Sprite
	{
		private var _bg:Image;
		private var _tx:TextField;

		public function SelectCell(str:String)
		{
			super();

			var sp:Shape=new Shape();
			sp.graphics.beginFill(0x0, 1);
			sp.graphics.drawRoundRect(0, 0, 45, 45, 15, 15);
			sp.graphics.endFill();
			var bd:BitmapData=new BitmapData(45, 45, true, 0x0);
			bd.draw(sp);
			_bg=Image.fromBitmap(new Bitmap(bd));
			this.addChild(_bg);

			_tx=new TextField(45, 45, str, "simsun");
			_tx.touchable =false;
			_tx.color=0xffffff;
			_tx.fontSize=30;
			this.addChild(_tx);
		}

		public function getValue():String
		{
			return _tx.text;
		}
	}
}
