package com.core.module.main.view
{
	import com.core.ModuleGlobals;
	import com.core.module.main.MainGlobals;
	import com.core.module.main.model.MainData;
	import com.core.module.main.model.MainProxy;

	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.TiledRowsLayout;

	import org.puremvc.as3.patterns.facade.Facade;

	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class GuessInputList extends ScrollContainer
	{
		private var cellList:Vector.<GuessInputCell>;
		private var hLayout:HorizontalLayout;

		public function GuessInputList()
		{
			super();

			hLayout=new HorizontalLayout();
			hLayout.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			hLayout.gap=5;
			this.layout=hLayout;

			cellList=new Vector.<GuessInputCell>();

//			for (var i:int=0; i < ln; i++)
//			{
//				var cell:GuessInputCell=new GuessInputCell();
//				cell.addEventListener(TouchEvent.TOUCH, onDeselectedHandler);
//				cell.index=i;
//				this.addChild(cell)
//				cellList.push(cell);
//				this.width+=cell.width + 5;
//				this.height=cell.height;
//			}
		}

		public function updateList(ln:uint=3):void
		{
			var cell:GuessInputCell;
			while (cellList.length > 0)
			{
				cell=cellList.shift();
				cell.removeEventListener(TouchEvent.TOUCH, onDeselectedHandler);
				this.removeChild(cell);
				cell.dispose();
			}
			this.width=0;
			for (var i:int=0; i < ln; i++)
			{
				cell=new GuessInputCell();
				cell.addEventListener(TouchEvent.TOUCH, onDeselectedHandler);
				cell.index=i;
				this.addChild(cell)
				cellList.push(cell);
				this.width+=cell.width + 5;
				this.height=cell.height;
			}
		}

		private function onDeselectedHandler(e:TouchEvent):void
		{
			var cell:GuessInputCell=e.currentTarget as GuessInputCell;
			if (e.getTouch(cell, TouchPhase.ENDED))
			{
				Facade.getInstance().sendNotification(MainGlobals.GUESS_WORD_DESELETED, cell.getValue());
				cell.setValue("");
			}
		}

		public function getGuessValue():String
		{
			var ret:String="";
			for each (var cell:GuessInputCell in cellList)
			{
				ret+=cell.getValue();
			}
			return ret;
		}

		public function hasAllInput():Boolean
		{
			var ret:Boolean=true;
			for each (var cell:GuessInputCell in cellList)
			{
				ret&&=(cell.getValue() != "");
			}
			return ret;
		}

		public function setGuessWord(char:String, index:int=-1):void
		{
			if (index != -1)
			{
				cellList[index].setValue(char);
			}
			else
			{
				for (var i:int=0; i < cellList.length; i++)
				{
					if (cellList[i].getValue() == "")
					{
						cellList[i].setValue(char);
						return;
					}
				}
			}
			mainData.inputWords=getGuessValue();

		}
		private var _mainData:MainData;

		public function get mainData():MainData
		{
			_mainData=Facade.getInstance().retrieveProxy(ModuleGlobals.MAIN_PROXY).getData() as MainData;
			return _mainData;
		}
	}
}

