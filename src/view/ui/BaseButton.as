package view.ui
{
	import event.GameEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * Компонент простейшей кнопки
	 * @author ProBigi
	 */
	public class BaseButton extends Sprite
	{
		public static const STATE_UNLOCK:int = 0;
		public static const STATE_LOCK:int = 1;
		
		protected const BTN_WIDTH:int = 150;
		protected const BTN_HEIGHT:int = 50;
		protected const VIEW_OUT:int = 0;
		protected const VIEW_OVER:int = 1;
		
		protected var _cont:Sprite;
		protected var _bkgOut:Sprite;
		protected var _bkgOver:Sprite;
		
		protected var _tfTitle:TextField;
		
		public function BaseButton(title:String)
		{
			_bkgOut = getBkgWithColor(0xFFFFFF);
			_bkgOver = getBkgWithColor(0xC0C0C0);
			
			_tfTitle = new TextField();
			
			var tFormat:TextFormat = _tfTitle.defaultTextFormat;
			tFormat.size = 30;
			tFormat.align = TextFormatAlign.CENTER;
			_tfTitle.antiAliasType = AntiAliasType.ADVANCED;
			_tfTitle.autoSize = TextFieldAutoSize.CENTER;
			_tfTitle.selectable = false;
			_tfTitle.defaultTextFormat = tFormat;
			_tfTitle.text = title;
			_tfTitle.x = (_bkgOut.width - _tfTitle.textWidth) / 2;
			_tfTitle.y = (_bkgOut.height - _tfTitle.textHeight) / 2 - 5;
			
			_cont = new Sprite;
			_cont.addChild(_bkgOver);
			_cont.addChild(_bkgOut);
			_cont.addChild(_tfTitle);
			this.addChild(_cont);
			this.buttonMode = true;
			this.mouseChildren = false;
			
			this.addEventListener(MouseEvent.MOUSE_OUT, onBtnOut);
			this.addEventListener(MouseEvent.MOUSE_OVER, onBtnOver);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onBtnDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onBtnUp);
		}
		
		public function set title(str:String):void
		{
			_tfTitle.text = str;
		}
		
		public function setBtnState(state:int):void
		{
			switch (state)
			{
			case STATE_UNLOCK: 
				this.mouseEnabled = true;
				this.alpha = 1;
				break;
			case STATE_LOCK: 
				this.mouseEnabled = false;
				this.alpha = 0.5;
				break;
			}
		}
		
		private function onBtnDown(e:MouseEvent):void
		{
			_cont.y = 1;
		}
		
		private function onBtnUp(e:MouseEvent):void
		{
			_cont.y = 0;
		}
		
		private function onBtnOut(e:MouseEvent):void
		{
			setBtnView(VIEW_OUT);
			_cont.y = 0;
		}
		
		private function onBtnOver(e:MouseEvent):void
		{
			setBtnView(VIEW_OVER);
		}
		
		private function getBkgWithColor(color:uint):Sprite
		{
			var result:Sprite = new Sprite();
			result.graphics.lineStyle(3);
			result.graphics.beginFill(color);
			result.graphics.drawRoundRect(0, 0, BTN_WIDTH, BTN_HEIGHT, 10, 10);
			result.graphics.endFill();
			return result;
		}
		
		private function setBtnView(view:int):void
		{
			switch (view)
			{
			case VIEW_OUT: 
				_cont.swapChildren(_bkgOver, _bkgOut);
				break;
			case VIEW_OVER: 
				_cont.swapChildren(_bkgOut, _bkgOver);
				break;
			}
		}
		
		public function destroy():void
		{	
			this.removeEventListener(MouseEvent.MOUSE_OUT, onBtnOut);
			this.removeEventListener(MouseEvent.MOUSE_OVER, onBtnOver);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onBtnDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onBtnUp);
			
			var len:int = this.numChildren;
			while (len--) {
				this.removeChildAt(0);
			}
			_cont = null;
			_bkgOut = null;
			_bkgOver = null;
			_tfTitle = null;
		}
	}

}