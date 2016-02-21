package event 
{
	import flash.events.Event;
	
	/**
	 * Игровые события
	 * @author ProBigi
	 */
	public class GameEvent extends Event 
	{
		/**
		 * Запускаем вращение барабана
		 */
		public static const ROLL_DRUM:String = "roll_drum";
		
		/**
		 * Останавливаем вращение барабана
		 */
		public static const STOP_DRUM:String = "stop_drum";
		
		/**
		 * Барабан остановлен
		 */
		public static const DRUM_IS_STOPPED:String = "drum_is_stopped";
		
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new GameEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}