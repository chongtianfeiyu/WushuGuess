package com.core.module.hud.view
{
	import com.core.BaseViewMediator;
	import com.core.MainApplaction;
	import com.core.ModuleGlobals;
	import com.core.globals.Globals;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;

	import starling.display.Image;
	import starling.textures.Texture;

	public class HudView extends BaseViewMediator implements IMediator
	{
		public function HudView()
		{
			super(ModuleGlobals.HUD_VIEW, this);
		}

		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case Globals.GAME_RESOURCE_LOADED:
					MainApplaction.getInstance()._uiLayer.addChild(this);

					var bgTexture:Texture=MainApplaction.sAssets.getTextureAtlas("skill").getTexture("stage_bg");
					MainApplaction.getInstance()._bgLayer.addChild(new Image(bgTexture));
					break;
			}
		}

		override public function listNotificationInterests():Array
		{
			return [Globals.GAME_RESOURCE_LOADED];
		}

	}
}


