package view
{
	import event.GameEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import model.AppModel;
	import view.drum.DrumPanel;
	import view.ui.BaseButton;
	
	/**
	 * Основное отображение игры
	 * @author ProBigi
	 */
	public class AppView extends Sprite
	{
		private var _model:AppModel;
		
		private var _startBtn:BaseButton;
		private var _stopBtn:BaseButton;
		
		private var _drumPanel:DrumPanel;
		
		public function AppView(model:AppModel)
		{
			_model = model;
			
			_startBtn = new BaseButton("PLAY");
			_startBtn.x = Main.WIDTH / 2 - _startBtn.width * 1.5;
			_startBtn.y = Main.HEIGHT - 100;
			this.addChild(_startBtn);
			
			_stopBtn = new BaseButton("STOP");
			_stopBtn.x = Main.WIDTH / 2 + _stopBtn.width / 2;
			_stopBtn.y = Main.HEIGHT - 100;
			this.addChild(_stopBtn);
			_stopBtn.setBtnState(BaseButton.STATE_LOCK);
			
			_drumPanel = new DrumPanel(_model);
			_drumPanel.x = (Main.WIDTH - DrumPanel.DRUM_WIDTH) / 2;
			_drumPanel.y = (Main.HEIGHT - DrumPanel.DRUM_HEIGHT) / 2;
			this.addChild(_drumPanel);
			
			_startBtn.addEventListener(MouseEvent.CLICK, onStartRollDrum);
			_stopBtn.addEventListener(MouseEvent.CLICK, onStopRollDrum);
			
			_drumPanel.addEventListener(GameEvent.DRUM_IS_STOPPED, onDrumIsStopped);
		}
		
		//Запускаем вращение барабана
		private function onStartRollDrum(e:MouseEvent):void
		{
			_startBtn.setBtnState(BaseButton.STATE_LOCK);
			_stopBtn.setBtnState(BaseButton.STATE_UNLOCK);
			
			_model.drumState = AppModel.DRUM_ROLLING;
			_drumPanel.startRoll();
		}
		
		//Запускаем остановку барабана
		private function onStopRollDrum(e:MouseEvent):void
		{
			_stopBtn.setBtnState(BaseButton.STATE_LOCK);
			_model.drumState = AppModel.DRUM_PREPARE_TO_STOP;
		}
		
		//Барабан остановился полностью
		private function onDrumIsStopped(e:GameEvent):void
		{
			_model.drumState == AppModel.DRUM_SLEEP;
			_startBtn.setBtnState(BaseButton.STATE_UNLOCK);
		}
		
		public function destroy():void
		{
			_model = null;
			
			var len:int = this.numChildren;
			while (len--)
			{
				this.removeChildAt(0);
			}
			
			_startBtn.removeEventListener(MouseEvent.CLICK, onStartRollDrum);
			_stopBtn.removeEventListener(MouseEvent.CLICK, onStopRollDrum);
			
			_drumPanel.removeEventListener(GameEvent.DRUM_IS_STOPPED, onDrumIsStopped);
			
			_startBtn.destroy();
			_stopBtn.destroy();
			_drumPanel.destroy();
			
			_startBtn = null;
			_stopBtn = null;
			_drumPanel = null;
		}
	
	}

}