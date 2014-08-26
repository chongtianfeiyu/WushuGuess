package com.core.layout
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class HBox extends Sprite
	{
		private var _space:Number=0;
		private var _paddingLeft:Number=0;

		public function HBox(space:Number=0, paddingLeft:Number=0)
		{
			super();
			_space=space;
			_paddingLeft=paddingLeft;
		}

		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			relayout();
			return child;
		}

		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			super.addChildAt(child, index);
			relayout();
			return child;
		}

		override public function removeChild(child:DisplayObject, dispose:Boolean=false):DisplayObject
		{
			super.removeChild(child, dispose);
			relayout();
			return child;
		}

		override public function removeChildAt(index:int, dispose:Boolean=false):DisplayObject
		{
			var child:DisplayObject=super.removeChildAt(index, dispose);
			relayout();
			return child;
		}

		override public function removeChildren(beginIndex:int=0, endIndex:int=-1, dispose:Boolean=false):void
		{
			super.removeChildren(beginIndex, endIndex, dispose);
			relayout();
		}

		private function relayout():void
		{
			for (var i:int=0; i < this.numChildren; i++)
			{
				var child:DisplayObject=this.getChildAt(i);
				child.x=(_space + child.width) * i + _paddingLeft - _space;
				child.y=0;
			}
		}
	}
}
