package com.core
{
	import com.core.globals.Globals;

	import feathers.controls.ProgressBar;
	import feathers.core.PopUpManager;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class LoadingCanvas extends Sprite
	{
		private var mLoadingProgress:ProgressBar;
		private var _label:TextField;

		public function LoadingCanvas()
		{
			super();

			mLoadingProgress=new ProgressBar();
			mLoadingProgress.width=200;
			mLoadingProgress.height=25;
			mLoadingProgress.minimum=0;
			mLoadingProgress.maximum=1;
			mLoadingProgress.value=0;
			mLoadingProgress.y=30;
			this.addChild(mLoadingProgress);

			_label=new TextField(200, 30, "正在加载资源...", "simsun", 18);
			this.addChild(_label);

			PopUpManager.addPopUp(this);
		}

		public function update(ratio:Number):void
		{
			mLoadingProgress.value=ratio;
			if (ratio == 1)
			{
				Facade.getInstance().sendNotification(Globals.GAME_RESOURCE_LOADED);
				if (this.parent)
					this.parent.removeChild(this);
				this.dispose();

			}
		}
	}
}


