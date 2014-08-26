package com.core.module.main.view
{

	import com.core.ModuleGlobals;
	import com.core.module.main.MainGlobals;
	import com.core.module.main.model.MainData;
	import com.greensock.TweenLite;

	import feathers.controls.ScrollContainer;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.TiledRowsLayout;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class GuessSelectList extends ScrollContainer
	{
		private var cellList:Array;
		private var tileLayout:TiledColumnsLayout;

		public function GuessSelectList()
		{
			super();

			tileLayout=new TiledColumnsLayout();
			tileLayout.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			tileLayout.verticalAlign=TiledRowsLayout.VERTICAL_ALIGN_MIDDLE;
			tileLayout.typicalItemWidth=60;
			tileLayout.horizontalGap=5;
			tileLayout.verticalGap=5;
			this.layout=tileLayout;

			this.width=480;
			this.height=300;
			cellList=new Array();
		}

		public function setKeyWords(str:String):void
		{
			var cell:SelectCell;
			while (cellList.length > 0)
			{
				cell=cellList.shift();
				this.removeChild(cell);
				cell.removeEventListener(TouchEvent.TOUCH, onTouchHandler);
				cell.dispose();
			}
			for (var i:int=0; i < str.length; i++)
			{
				cell=new SelectCell(str.charAt(i));
				cell.addEventListener(TouchEvent.TOUCH, onTouchHandler);
				this.addChild(cell)
				cellList.push(cell);
			}
		}

		private function onTouchHandler(e:TouchEvent):void
		{
			var cell:SelectCell=e.currentTarget as SelectCell;
			if (cell && e.getTouch(cell, TouchPhase.ENDED))
			{
				Facade.getInstance().sendNotification(MainGlobals.GUESS_WORD_SELECTED, cell);
				e.stopImmediatePropagation();
			}
		}

		public override function dispose():void
		{
			super.dispose();
			while (cellList.length > 0)
			{
				this.removeChild(cellList.shift()).removeEventListeners(TouchEvent.TOUCH);
			}
		}
		private var _mainData:MainData;

		public function get mainData():MainData
		{
			_mainData=Facade.getInstance().retrieveProxy(ModuleGlobals.MAIN_PROXY).getData() as MainData;
			return _mainData;
		}


		public function recoverCell(str:String):void
		{
			for (var i:int=0; i < cellList.length; i++)
			{
				if (cellList[i].getValue() == str)
				{
					TweenLite.to(cellList[i], .3, {alpha: 1, onComplete: function():void
					{
						cellList[i].touchable=true;
					}});
					return;
				}
			}
		}
	}
}
