package event 
{
	import flash.events.Event;
	
	/**
	 * События игровой фишки
	 * @author ProBigi
	 */
	public class TileEvent extends Event 
	{
		
		/** Остановить фишку */
		public static const STOP_TILES:String = "stop_tiles";
		
		public function TileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new TileEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TileEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}