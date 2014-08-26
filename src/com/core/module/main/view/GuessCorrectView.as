package com.core.module.main.view
{
	import com.core.MainApplaction;
	import com.core.globals.Globals;
	import com.core.module.main.MainGlobals;
	import com.core.module.main.model.MainProxy;
//	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.text.TextFormat;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class GuessCorrectView extends Sprite
	{
		public static const TYPE_COMPELTE_STAGE:String="TYPE_COMPELTE_STAGE";
		public static const TYPE_CONTINUE_GUESS:String="TYPE_CONTINUE_GUESS";
		private static var _instance:GuessCorrectView;
		private var _textField:TextField;
		private var _tips:TextField
		private var _bg:Image;

		public function GuessCorrectView()
		{
			super();
			this.width=480;
			this.height=800;
			var sp:Shape=new Shape();
			sp.graphics.beginFill(0x0);
			sp.graphics.drawRect(0, 0, 480, 800);
			sp.graphics.endFill();
			var bp:BitmapData=new BitmapData(480, 800, true, 0x0);
			bp.draw(sp);
			_bg=Image.fromBitmap(new Bitmap(bp));
			this.addChild(_bg);
			_textField=new TextField(480, 80, "恭喜,猜对啦!RP+1", "simsun", 56, 0xff0000);
			_textField.hAlign="center";
			_textField.touchable=false;
			_textField.x=(width - _textField.width) / 2;
			_textField.y=(height - _textField.height) / 2;
			this.addChild(_textField);

			_tips=new TextField(480, 50, "<点击继续>", "simsun", 32, 0xff0000);
			_tips.hAlign="center";
			_tips.touchable=false;
			_tips.x=(width - _textField.width) / 2;
			_tips.y=(height - _textField.height) / 2 + 80;
			this.addChild(_tips);


		}

		private function onTouchContinue(e:TouchEvent):void
		{
			if (e.getTouch(this, TouchPhase.ENDED))
			{
				Facade.getInstance().sendNotification(MainGlobals.CONTINUE_GUESS);
				this.close();
			}
		}

		private function onTouchComplete(e:TouchEvent):void
		{
			if (e.getTouch(this, TouchPhase.ENDED))
			{
				Facade.getInstance().sendNotification(MainGlobals.CHALLENGE_NEXT_STAGE);
				this.close();
			}
		}

		private function close():void
		{
			if (this.parent)
				this.parent.removeChild(this);
//			TweenLite.to(_instance, .5, {alpha: 0, onComplete: function():void {
//				if (this.parent)
//					this.parent.removeChild(this);
//			}});
		}

		override public function dispose():void
		{
			super.dispose();
			this.removeEventListeners(TouchEvent.TOUCH);
			_instance=null;
		}


		public static function show(type:String):void
		{
			if (_instance == null)
			{
				_instance=new GuessCorrectView();
				MainApplaction.getInstance()._popupLayer.addChild(_instance);
			}
			_instance.x=(Globals.stage.stageWidth - _instance.width) / 2;
			_instance.y=(Globals.stage.stageHeight - _instance.height) / 2;
//			_instance.alpha=0;
//			TweenLite.to(_instance, .5, {alpha: 1});
			_instance.removeEventListeners(TouchEvent.TOUCH);
			if (type == TYPE_COMPELTE_STAGE)
			{
				_instance._tips.text="<点击挑战下一个门派>";
				_instance.addEventListener(TouchEvent.TOUCH, _instance.onTouchComplete);
			}
			else
			{
				_instance._tips.text="<点击继续>";
				_instance.addEventListener(TouchEvent.TOUCH, _instance.onTouchContinue);
			}
		}

		public static function close():void
		{
			if (_instance && _instance.parent)
				_instance.parent.removeChild(_instance);
		}

	}
}
