package model 
{
	import flash.display.Stage;
	/**
	 * Модель игровых данных
	 * @author ProBigi
	 */
	public class AppModel 
	{
		/** Ширина барабана */
		public static const DRUM_WIDTH:int = 600;
		/** Высота барабана */
		public static const DRUM_HEIGHT:int = 360;
		
		
		/** Состояние - Барабан стоит в ожидании */
		public static const DRUM_SLEEP:int = 0;
		/** Состояние - Барабан вращается в данный момент */
		public static const DRUM_ROLLING:int = 1;
		/** Состояние - Запущен механим остановки барабана */
		public static const DRUM_PREPARE_TO_STOP:int = 2;
		
		/** Текущее состояние барабана */
		private var _drumState:int;
		
		/** Исходные ID фишек */
		private var _tileIDs:Vector.<Vector.<int>>;
		
		private var _drum1:Vector.<int> = Vector.<int>([1,2,4,3,2,1,5,2,1,4]);
		private var _drum2:Vector.<int> = Vector.<int>([3,5,2,1,4,2,1,4,2,1]);
		private var _drum3:Vector.<int> = Vector.<int>([5,1,2,3,2,4,4,2,1,2]);
		private var _drum4:Vector.<int> = Vector.<int>([2,1,3,3,4,1,2,3,1,5]);
		private var _drum5:Vector.<int> = Vector.<int>([3,5,4,2,1,3,4,2,1,3]);
		
		
		
		public function AppModel() 
		{
			_tileIDs = new Vector.<Vector.<int>>();
			_tileIDs.push(_drum1, _drum2, _drum3, _drum4, _drum5);
		}
		
		public function get tileIDs():Vector.<Vector.<int>> { return _tileIDs; }
		
		public function get drumState():int { return _drumState; }
		public function set drumState(state:int):void
		{
			_drumState = state;
		}
	}

}