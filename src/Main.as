package
{
	import control.AppControl;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * Прототип барабана слот-машины
	 * @author ProBigi
	 */
	[SWF(frameRate="30", width="760",height="640", backgroundColor="0xFFF2D7")]
	public class Main extends Sprite 
	{
		public static var WIDTH:int = 760;
		public static var HEIGHT:int = 640;
		
		private var _appControl:AppControl;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			super.stage.align = StageAlign.TOP_LEFT;
			super.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_appControl = new AppControl(this);
		}
		
	}
	
}