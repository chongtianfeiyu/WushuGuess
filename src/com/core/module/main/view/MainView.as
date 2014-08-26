package com.core.module.main.view
{
	import com.core.BaseViewMediator;
	import com.core.MainApplaction;
	import com.core.ModuleGlobals;
	import com.core.globals.Globals;
	import com.core.module.main.MainGlobals;
	import com.core.module.main.controller.MainCmd;
	import com.core.module.main.model.MainData;
	import com.core.module.stage.GameStageGlobals;
	import com.core.template.KeyWordTemplate;
	import com.core.vo.SchoolVO;
	import com.core.vo.SkillVO;
	import com.greensock.TweenLite;

	import org.puremvc.as3.interfaces.INotification;

	public class MainView extends BaseViewMediator
	{

		private var _skillVO:SkillVO;
		private var _guessInputList:GuessInputList;
		private var _guessTarget:GuessTargetView;
		private var _selectList:GuessSelectList;

		public function MainView()
		{
			super(ModuleGlobals.MAIN_MEDIATOR, this);

			_guessInputList=new GuessInputList();
			this.addChild(_guessInputList);

			_guessTarget=new GuessTargetView();
			this.addChild(_guessTarget);

			_selectList=new GuessSelectList();
			this.addChild(_selectList);
		}

		override public function listNotificationInterests():Array
		{
			return [
				GameStageGlobals.GAME_STAGE_SCHOOL_SCHOOL_SELECTED,
				MainGlobals.GUESS_CORRECT,
				MainGlobals.GUESS_WORD_SELECTED,
				MainGlobals.GUESS_WORD_DESELETED,
				MainGlobals.CONTINUE_GUESS];
		}

		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case GameStageGlobals.GAME_STAGE_SCHOOL_SCHOOL_SELECTED:
					var schoolVO:SchoolVO=note.getBody() as SchoolVO;
					if (mainData.userVO.guessingList.length == 0)
					{
						mainData.userVO.guessingList=KeyWordTemplate.getRandomList(Globals.GUESS_COUNT_PER_STAGE, schoolVO);
					}
					mainData.currentSchoolVO=schoolVO;
					_skillVO=mainData.userVO.guessingList[0];

					showMainGuessUI();
					break;
				case MainGlobals.GUESS_WORD_SELECTED:
					var selectCell:SelectCell=SelectCell(note.getBody());
					if (!_guessInputList.hasAllInput())
					{
						TweenLite.to(selectCell, .3, {alpha: 0});
						selectCell.touchable=false;
					}
					_guessInputList.setGuessWord(selectCell.getValue());
					if (_guessInputList.hasAllInput())
					{
						checkIsCorrect();
					}
					break;
				case MainGlobals.GUESS_WORD_DESELETED:
					_selectList.recoverCell(String(note.getBody()));
					break;
				case MainGlobals.GUESS_CORRECT:
					var vo:SkillVO=note.getBody() as SkillVO;
					for (var i:int=0; i < mainData.userVO.guessingList.length; i++)
					{
						var tempVO:SkillVO=mainData.userVO.guessingList[i];
						if (tempVO.id == vo.id)
							mainData.userVO.guessingList.splice(i, 1);
					}
					mainData.userVO.writeToSql();
					if (mainData.userVO.guessingList.length > 0)
					{
						GuessCorrectView.show(GuessCorrectView.TYPE_CONTINUE_GUESS);
					}
					else
					{
						MainCmd.instance.completeGuess(mainData.currentSchoolVO);
						GuessCorrectView.show(GuessCorrectView.TYPE_COMPELTE_STAGE);
					}
					break;
				case MainGlobals.CONTINUE_GUESS:
					_skillVO=mainData.userVO.guessingList[0];
					showMainGuessUI();
					break;
				case MainGlobals.CHALLENGE_NEXT_STAGE:
					hideMainGuessUI();
					break;
			}
		}

		private function hideMainGuessUI():void
		{
			if (this.parent)
				this.parent.removeChild(this);
		}

		private function showMainGuessUI():void
		{
			if (this.parent == null)
				MainApplaction.getInstance()._mainLayer.addChild(this);
			_guessInputList.updateList(_skillVO.name.length);
			_guessTarget.setSkillId(_skillVO.id);
			_selectList.setKeyWords(_skillVO.words);
			relayout();
		}

		private function checkIsCorrect():void
		{
			var guessValue:String=_guessInputList.getGuessValue();
			if (guessValue == _skillVO.name)
			{
				facade.sendNotification(MainGlobals.GUESS_CORRECT, _skillVO);
				_skillVO=null;
			}
		}

		private function relayout():void
		{

			_guessTarget.x=(Globals.stage.stageWidth - _guessTarget.width) / 2;
			_guessTarget.y=(Globals.stage.stageHeight - _guessTarget.height) / 3;

			_guessInputList.x=(Globals.stage.stageWidth - _guessInputList.width) / 2;
			_guessInputList.y=_guessTarget.y + _guessTarget.height + 10;

			_selectList.x=(Globals.stage.stageWidth - _selectList.width) / 2;
			_selectList.y=Globals.stage.stageHeight - _selectList.height - 50;
		}

		private var _mainData:MainData;

		public function get mainData():MainData
		{
			_mainData=facade.retrieveProxy(ModuleGlobals.MAIN_PROXY).getData() as MainData;
			return _mainData;
		}



	}
}


