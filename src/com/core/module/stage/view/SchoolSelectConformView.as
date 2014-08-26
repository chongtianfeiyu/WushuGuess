package com.core.module.stage.view
{
	import com.core.MainApplaction;
	import com.core.globals.Globals;
	import com.core.module.stage.GameStageGlobals;
	import com.core.vo.SchoolVO;
	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;

	import feathers.controls.Button;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class SchoolSelectConformView extends Sprite
	{
		private var _bg:Image;
		private var _conformBtn:Button;
		private var _schoolVO:SchoolVO;
		public static var isShow:Boolean=false;
		private static var _instance:SchoolSelectConformView;

		public function SchoolSelectConformView()
		{
			super();

			var sp:Shape=new Shape();
			sp.graphics.beginFill(0xADADAD, 1);
			sp.graphics.drawRoundRect(0, 0, 200, 50, 15, 15);
			sp.graphics.endFill();
			var bd:BitmapData=new BitmapData(200, 50, true, 0x0);
			bd.draw(sp);
			_bg=Image.fromBitmap(new Bitmap(bd));
			_bg.touchable=false;
			this.addChild(_bg);

			_conformBtn=new Button();
			_conformBtn.label="Conform";
			this.addChild(_conformBtn);
			this._conformBtn.addEventListener(TouchEvent.TOUCH, onTouchHandler);

		}


		public static function get instance():SchoolSelectConformView
		{
			return _instance;
		}

		public static function show(vo:SchoolVO):void
		{
			if (_instance == null)
			{
				_instance=new SchoolSelectConformView();
				_instance.x=Globals.stage.stageWidth;
				_instance.y=(Globals.stage.stageHeight - _instance.height) / 2;
				MainApplaction.getInstance()._popupLayer.addChild(_instance);
			}
			TweenLite.to(_instance, .3, {x: Globals.stage.stageWidth - _instance.width});
			_instance._schoolVO=vo;
			isShow=true;
		}

		public static function hide(callback:Function=null):void
		{
			if (_instance)
			{
				TweenLite.to(_instance, .3, {x: Globals.stage.stageWidth, onComplete: function():void
				{
					isShow=false;
					if (callback != null)
						callback();
				}});
			}
		}

		public static function close():void
		{
			if (_instance && _instance.parent)
			{
				_instance.parent.removeChild(_instance);
				_instance.dispose();
			}
		}

		private function onTouchHandler(e:TouchEvent):void
		{
			if (e.getTouch(_conformBtn, TouchPhase.ENDED))
			{
				Facade.getInstance().sendNotification(GameStageGlobals.GAME_STAGE_SCHOOL_SCHOOL_SELECTED, _schoolVO);
			}
		}

		override public function dispose():void
		{

			super.dispose();
			_instance=null;
		}


	}
}
