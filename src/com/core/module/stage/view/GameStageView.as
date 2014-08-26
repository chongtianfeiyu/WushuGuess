package com.core.module.stage.view
{
	import com.core.BaseViewMediator;
	import com.core.MainApplaction;
	import com.core.ModuleGlobals;
	import com.core.globals.Globals;
	import com.core.module.main.MainGlobals;
	import com.core.module.main.model.MainData;
	import com.core.module.sql.SqlGlobals;
	import com.core.module.sql.controller.SqlCmd;
	import com.core.module.sql.model.GameStageData;
	import com.core.module.stage.GameStageGlobals;
	import com.core.template.SchoolTemplate;
	import com.core.vo.SchoolVO;
	import com.core.vo.StageDataVO;
	import com.core.vo.StageSqlVO;
	import com.core.vo.UserVO;

	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;

	import flash.data.SQLResult;

	import org.puremvc.as3.interfaces.INotification;

	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class GameStageView extends BaseViewMediator
	{

		public var buttonList:ScrollContainer;
		private var _selectedSchoolVO:SchoolVO;
		private var _touchedSelecter:Boolean=false;
		private var _stageDataList:Vector.<StageDataVO>;

		public function GameStageView()
		{
			super(ModuleGlobals.GAME_STAGE_VIEW, this);
			_stageDataList=new Vector.<StageDataVO>();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(e:Event):void
		{

			var layout:VerticalLayout=new VerticalLayout();
			layout.horizontalAlign=VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			buttonList=new ScrollContainer();
			buttonList.layout=layout;
			buttonList.y=0;
			buttonList.width=480;
			buttonList.height=800;

			this.update();

		}

		private function onListTouched(e:TouchEvent):void
		{
			if (e.getTouch(this, TouchPhase.ENDED))
			{
				if (_selectedSchoolVO && !SchoolSelectConformView.isShow && _touchedSelecter)
				{
					SchoolSelectConformView.show(_selectedSchoolVO);
					_touchedSelecter=false;
				}
				else
					SchoolSelectConformView.hide();
			}
		}

		private function checkStatus(id:int):String
		{
			for each (var vo:StageDataVO in stageData.stageSqlVO.stageDataList)
			{
				if (vo.schoolVO.id == id)
				{
					return vo.schoolStatus;
				}
			}
			return GameStageGlobals.STAGE_STATUS_LOCKED;
		}

		public override function dispose():void
		{
			super.dispose();
			while (buttonList.numChildren > 0)
			{
				var dob:DisplayObject=buttonList.removeChildAt(0);
				dob.removeEventListeners(TouchEvent.TOUCH);
			}
			this.removeEventListeners(TouchEvent.TOUCH);
		}

		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case Globals.GAME_RESOURCE_LOADED:
					SqlCmd.instance.executeSQL("select * from stage", SqlGlobals.SQL_FLAG_GET_STAGE_INFO);
					SqlCmd.instance.executeSQL("select * from user", SqlGlobals.SQL_FLAG_GET_USER_INFO);
					break;
				case SqlGlobals.SQL_FLAG_GET_STAGE_INFO:
					var ret:SQLResult=notification.getBody() as SQLResult;
					if (ret && ret.data)
					{
						stageData.stageSqlVO=new StageSqlVO(ret.data);
						Globals.stageDataInited=true;
						trace("......stageDataInited");
					}
					if (Globals.getGameDataInited())
						MainApplaction.getInstance()._mainLayer.addChild(this);
					break;
				case SqlGlobals.SQL_FLAG_GET_USER_INFO:
					mainData.userVO=new UserVO((notification.getBody() as SQLResult).data[0]);
					Globals.userDataInited=true;
					trace("......userDataInited");
					if (Globals.getGameDataInited())
						MainApplaction.getInstance()._mainLayer.addChild(this);
					break;
				case GameStageGlobals.SCHOOL_VIEW_TOUCHED:
					_selectedSchoolVO=notification.getBody() as SchoolVO;
					_touchedSelecter=true;
//					SchoolSelectConformView.show();
					break;
				case GameStageGlobals.GAME_STAGE_SCHOOL_SCHOOL_SELECTED:
					this.close();
					SchoolSelectConformView.hide(SchoolSelectConformView.close);
					break;
				case MainGlobals.CHALLENGE_NEXT_STAGE:
					MainApplaction.getInstance()._mainLayer.addChild(this);
					this.update();
					break;
			}
		}

		private function update():void
		{
			var stageDataVO:StageDataVO;
			for each (var vo:SchoolVO in SchoolTemplate.schoolData)
			{
				var perStatus:String=stageDataVO ? stageDataVO.schoolStatus : null;
				stageDataVO=new StageDataVO(vo.id, checkStatus(vo.id));
				if (perStatus == GameStageGlobals.STAGE_STATUS_FINISHED
					&& stageDataVO.schoolStatus == GameStageGlobals.STAGE_STATUS_LOCKED)
				{
					stageDataVO.schoolStatus=GameStageGlobals.STAGE_STATUS_UNLOCKED;
				}
				_stageDataList.push(stageDataVO);
				var view:SchoolSelectView=new SchoolSelectView(stageDataVO);
				buttonList.addChild(view);
			}
			this.addChild(buttonList);
			this.addEventListener(TouchEvent.TOUCH, onListTouched);

		}

		private function close():void
		{
			if (this.parent)
				this.parent.removeChild(this);
		}

		override public function listNotificationInterests():Array
		{
			return [Globals.GAME_RESOURCE_LOADED,
				SqlGlobals.SQL_FLAG_GET_STAGE_INFO,
				GameStageGlobals.SCHOOL_VIEW_TOUCHED,
				GameStageGlobals.GAME_STAGE_SCHOOL_SCHOOL_SELECTED,
				SqlGlobals.SQL_FLAG_GET_USER_INFO,
				MainGlobals.CHALLENGE_NEXT_STAGE,];
		}

		public function get stageData():GameStageData
		{
			return facade.retrieveProxy(ModuleGlobals.GAME_STAGE_PROXY).getData() as GameStageData;
		}

		public function get mainData():MainData
		{
			return facade.retrieveProxy(ModuleGlobals.MAIN_PROXY).getData() as MainData;
		}
	}
}


