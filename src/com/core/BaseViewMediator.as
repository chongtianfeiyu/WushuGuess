package com.core
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.facade.Facade;

	import starling.display.Sprite;

	public class BaseViewMediator extends Sprite implements IMediator
	{
		protected var viewComponent:Object;
		protected var mediatorName:String;

		public function BaseViewMediator(mediatorName:String, viewComponent:Object=null)
		{
			super();
			this.mediatorName=mediatorName;
			this.viewComponent=viewComponent;
		}

		public function getMediatorName():String
		{
			return mediatorName;
		}

		public function getViewComponent():Object
		{
			return viewComponent;
		}

		public function setViewComponent(viewComponent:Object):void
		{
			this.viewComponent=viewComponent;
		}

		public function listNotificationInterests():Array
		{
			return [];
		}

		public function handleNotification(notification:INotification):void
		{
		}

		public function onRegister():void
		{
		}

		public function onRemove():void
		{
		}

		public static function get facade():IFacade
		{
			return Facade.getInstance();
		}
	}
}
