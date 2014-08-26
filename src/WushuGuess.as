package
{
	import com.core.MainApplaction;
	import com.core.template.KeyWordTemplate;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	public class WushuGuess extends Sprite
	{
		private var mStarling:Starling;

		public function WushuGuess()
		{
			super();
			this.stage.frameRate=30;
			Starling.multitouchEnabled=true; // useful on mobile devices
			var iOS:Boolean=Capabilities.manufacturer.indexOf("iOS") != -1;
			Starling.handleLostContext=!iOS; // not necessary on iOS. Saves a lot of memory!
			var w:Number=stage.fullScreenWidth < stage.fullScreenHeight ? stage.fullScreenWidth : stage.fullScreenHeight;
			var h:Number=stage.fullScreenWidth > stage.fullScreenHeight ? stage.fullScreenWidth : stage.fullScreenHeight;
			var stageHeight:int=800;
			var stageWidth:int=stageHeight / h * w;
			var viewPort:Rectangle=RectangleUtil.fit(new Rectangle(0, 0, stageWidth, stageHeight), new Rectangle(0, 0, w, h), ScaleMode.SHOW_ALL, iOS);
			var appDir:File=File.applicationDirectory;
			var assets:AssetManager=new AssetManager();
			assets.verbose=Capabilities.isDebugger;
			assets.enqueue(appDir.resolvePath("assets/icons"));

			// launch Starling

			mStarling=new Starling(MainApplaction, stage, viewPort);
			mStarling.stage.stageWidth=stageWidth; // <- same size on all devices!
			mStarling.stage.stageHeight=stageHeight; // <- same size on all devices!
			mStarling.simulateMultitouch=true;
			mStarling.enableErrorChecking=false;
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
			{
				mStarling.start();
				var game:MainApplaction=mStarling.root as MainApplaction;
				game.start(mStarling, assets);
			});


			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated. 

			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, function(e:*):void
			{
				mStarling.start();
			});

			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, function(e:*):void
			{
				mStarling.stop();
			});

			mStarling.showStats=true;

		}

		protected function onOrientationChanging(event:StageOrientationEvent):void
		{
			trace(stage.orientation);
		}
	}
}


