package com.core.module.stage.view
{
	import com.core.MainApplaction;
	import com.core.globals.Globals;
	import com.core.module.stage.GameStageGlobals;
	import com.core.vo.SchoolVO;
	import com.core.vo.StageDataVO;

	import flash.display.BitmapData;
	import flash.display.Shape;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class SchoolSelectView extends Sprite
	{
		public var schoolVO:SchoolVO;
		public var status:String;
		private var _bg:Image;
		private var _mark:Image;
		private var _mask:Image;

		public function SchoolSelectView(stageDataVO:StageDataVO)
		{
			super();
			this.schoolVO=stageDataVO.schoolVO;
			_bg=new Image(MainApplaction.sAssets.getTextureAtlas("skill").getTexture(this.schoolVO.texture));
			this.width=_bg.width;
			this.height=_bg.height;
			this.addChild(_bg);
			var sp:Shape=new Shape();
			sp.graphics.beginFill(0xadadad, .5);
			sp.graphics.drawRect(0, 0, this.width, this.height);
			sp.graphics.endFill();
			var bp:BitmapData=new BitmapData(this.width, this.height, true, 0x0);
			bp.draw(sp);
			var maskTexture:Texture=Texture.fromBitmapData(bp);
			_mask=new Image(maskTexture);

			setStatus(stageDataVO.schoolStatus);

			this.scaleX=this.scaleY=.8;

		}

		override public function dispose():void
		{
			super.dispose();
			this.removeEventListeners(TouchEvent.TOUCH);
		}


		public function setStatus(st:String):void
		{
			this.status=st;
			if (_mark && _mark.parent)
				_mark.parent.removeChild(_mark);
			if (_mask && _mask.parent)
				_mask.parent.removeChild(_mask);

			if (st == GameStageGlobals.STAGE_STATUS_UNLOCKED)
			{
				_mark=new Image(MainApplaction.sAssets.getTextureAtlas("skill").getTexture(status));
				_mark.touchable=false;
				_mark.width=125;
				_mark.height=160;
				this.addChild(_mark);
				this.addEventListener(TouchEvent.TOUCH, onTouchHandler);
			}
			else if (st == GameStageGlobals.STAGE_STATUS_FINISHED)
			{
				_mark=new Image(MainApplaction.sAssets.getTextureAtlas("skill").getTexture(status));
				_mark.touchable=false;
				_mark.width=90;
				_mark.height=155;
				this.addChild(_mark);

			}
			else if (st == GameStageGlobals.STAGE_STATUS_LOCKED)
			{
//				this.filter=FilterManager.grayFilter;
				this.alpha=.8;
				this.addChild(_mask);
			}
			if (_mark)
			{
				_mark.x=this.width - _mark.width;
				_mark.y=this.height - _mark.height;
			}
		}

		private function onTouchHandler(e:TouchEvent):void
		{
			if (e.getTouch(this, TouchPhase.ENDED))
			{
				Facade.getInstance().sendNotification(GameStageGlobals.SCHOOL_VIEW_TOUCHED, this.schoolVO);
			}
		}
	}
}


