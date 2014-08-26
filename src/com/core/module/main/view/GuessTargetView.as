package com.core.module.main.view
{
	import com.core.MainApplaction;
	import com.core.globals.Globals;
	import com.core.template.KeyWordTemplate;
	import com.core.vo.SkillVO;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class GuessTargetView extends Sprite
	{
		private var _icon:Image;
		private var _texture:Texture;
		private var _zoomIcon:Image;
		public var skillVO:SkillVO;

		public function GuessTargetView()
		{
			super();
			_icon=new Image(Texture.empty(100, 100));
			_icon.addEventListener(TouchEvent.TOUCH, onTouchEvent);
			this.addChild(_icon);

			_zoomIcon=new Image(Texture.empty(100, 100));
			_zoomIcon.width=480;
			_zoomIcon.height=480;
			_zoomIcon.addEventListener(TouchEvent.TOUCH, onZoomIconTouchEvent);
		}

		public function setSkillId(skillId:int):void
		{
			skillVO=KeyWordTemplate.getSkillVO(skillId);
			_texture=MainApplaction.sAssets.getTextureAtlas("skill").getTexture(skillVO.icon);

			_icon.texture=_texture;

			_zoomIcon.texture=_texture;

			relayout();
		}

		private function onZoomIconTouchEvent(e:TouchEvent):void
		{
			if (e.getTouch(_zoomIcon, TouchPhase.ENDED))
			{
				e.stopImmediatePropagation();
				hideZoomIcon();
			}
		}


		private function onTouchEvent(e:TouchEvent):void
		{
			if (e.getTouch(_icon, TouchPhase.ENDED))
			{
				e.stopImmediatePropagation();
				showZoomIcon();
			}
		}

		private function showZoomIcon():void
		{
			MainApplaction.getInstance()._popupLayer.addChild(_zoomIcon);
			_zoomIcon.x=0;
			_zoomIcon.y=(Globals.stage.stageHeight - _zoomIcon.height) / 2;
		}

		private function hideZoomIcon():void
		{
			if (_zoomIcon.parent)
			{
				_zoomIcon.parent.removeChild(_zoomIcon);
			}
		}

		public function relayout():void
		{

		}
	}
}

