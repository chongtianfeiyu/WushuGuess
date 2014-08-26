package com.core
{
	import com.core.module.hud.controller.HudCommand;
	import com.core.module.hud.model.HudProxy;
	import com.core.module.hud.view.HudView;
	import com.core.module.main.controller.MainCommand;
	import com.core.module.main.model.MainProxy;
	import com.core.module.main.view.MainView;
	import com.core.module.sql.controller.SqlCommand;
	import com.core.module.sql.model.SqlManager;
	import com.core.module.sql.model.SqlProxy;
	import com.core.module.sql.view.SqlMediator;
	import com.core.module.stage.model.GameStageProxy;
	import com.core.module.stage.view.GameStageView;
	import com.core.template.KeyWordTemplate;
	import com.core.template.SchoolTemplate;

	import flash.desktop.NativeApplication;
	import flash.ui.Keyboard;

	import feathers.themes.MinimalMobileTheme;

	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.utils.AssetManager;


	public class MainApplaction extends starling.display.Sprite
	{
		public static var sAssets:AssetManager;
		public static var mStarling:Starling;

		public var _bgLayer:Sprite;
		public var _uiLayer:Sprite;
		public var _effectLayer:Sprite;
		public var _mainLayer:Sprite;
		public var _popupLayer:Sprite;
		private var _loading:LoadingCanvas;

		public function MainApplaction()
		{
			super();
		}

		public function start(starling:Starling, assets:AssetManager):void
		{
			mStarling=starling;
			sAssets=assets;
			new MinimalMobileTheme();

			_bgLayer=new Sprite();
			_bgLayer.touchable=false;
			this.addChild(_bgLayer);

			_mainLayer=new Sprite();
			this.addChild(_mainLayer);

			_uiLayer=new Sprite();
			this.addChild(_uiLayer);

			_effectLayer=new Sprite();
			_effectLayer.touchable=false;
			this.addChild(_effectLayer);

			_popupLayer=new Sprite();
			this.addChild(_popupLayer);

			_loading=new LoadingCanvas();
			_loading.touchable=false;
			this.addChild(_loading);

			sAssets.loadQueue(function(ratio:Number):void
			{
				_loading.update(ratio);
			});

			initPureMVC();
			initTemplates();
			SqlManager.init();
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}


		private function onKeyDown(e:KeyboardEvent):void
		{
			this.stage.removeEventListeners(KeyboardEvent.KEY_DOWN);
			if (e.keyCode == Keyboard.BACK)
			{
				e.stopPropagation();
				NativeApplication.nativeApplication.exit();
			}
		}

		private function initPureMVC():void
		{
			facade.registerCommand(ModuleGlobals.MAIN_CMD, MainCommand);
			facade.registerMediator(new MainView());
			facade.registerProxy(new MainProxy());

			facade.registerCommand(ModuleGlobals.HUD_CMD, HudCommand);
			facade.registerMediator(new HudView());
			facade.registerProxy(new HudProxy());

			facade.registerCommand(ModuleGlobals.GAME_STAGE_CMD, HudCommand);
			facade.registerMediator(new GameStageView());
			facade.registerProxy(new GameStageProxy());

			facade.registerCommand(ModuleGlobals.SQL_CMD, SqlCommand);
			facade.registerMediator(new SqlMediator());
			facade.registerProxy(new SqlProxy());
		}

		private function initTemplates():void
		{
			KeyWordTemplate.init();
			SchoolTemplate.init();

		}

		/**
		 *只允许starling创建实例
		 * @return
		 *
		 */
		public static function getInstance():MainApplaction
		{
			return mStarling.root as MainApplaction;
		}

		public static function get facade():IFacade
		{
			return Facade.getInstance();
		}
	}
}


