package view.drum
{
	import event.GameEvent;
	import flash.display.Sprite;
	import model.AppModel;
	
	/**
	 * Панель барабана со всеми элементами
	 * @author ProBigi
	 */
	public class DrumPanel extends Sprite
	{
		public static const DRUM_WIDTH:int = 600;
		public static const DRUM_HEIGHT:int = 360;
		
		private var _model:AppModel;
		
		private var _box:Sprite;
		
		private var _mask:Sprite;
		
		private var _tilesPanel:TilesPanel;
		
		public function DrumPanel(model:AppModel)
		{
			_model = model;
			_box = getBox();
			_mask = getBox();
			
			_tilesPanel = new TilesPanel(_model);
			_tilesPanel.x = (_box.width - _tilesPanel.width) / 2;
			_tilesPanel.y = (_box.height - _tilesPanel.height) / 2 - 60;
			
			this.addChild(_box);
			this.addChild(_mask);
			this.addChild(_tilesPanel);
			_tilesPanel.mask = _mask;
			
			_tilesPanel.addEventListener(GameEvent.DRUM_IS_STOPPED, onDrumIsStopped);
		}
		
		private function onDrumIsStopped(e:GameEvent):void 
		{
			super.dispatchEvent(e);
		}
		
		public function startRoll():void
		{
			_tilesPanel.startRoll();
		}
		
		private function getBox():Sprite
		{
			var result:Sprite = new Sprite;
			result.graphics.lineStyle(5);
			result.graphics.beginFill(0xE5E5E5);
			result.graphics.drawRect(0, 0, DRUM_WIDTH, DRUM_HEIGHT);
			result.graphics.endFill();
			
			return result;
		}
		
		public function destroy():void
		{
			_tilesPanel.removeEventListener(GameEvent.DRUM_IS_STOPPED, onDrumIsStopped);
			_tilesPanel.destroy();
			
			var len:int = this.numChildren;
			while (len--) {
				this.removeChildAt(0);
			}
			
			_model = null;
			_box = null;
			_mask = null;
			_tilesPanel = null;
		}
	
	}

}