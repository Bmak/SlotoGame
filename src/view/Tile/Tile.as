package view.Tile
{
	import event.TileEvent;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import model.TileModel;
	
	/**
	 * Игровая фишка на барабане
	 * @author ProBigi
	 */
	public class Tile extends Sprite
	{
		private var _view:Sprite;
		private var _tfTitle:TextField;
		private var _tfFormat:TextFormat;
		
		private var _speed:int;
		
		/** Тип фишки */
		private var _type:int;
		
		/** Параметр выравнивания фишки */
		private var _offSetY:Number = NaN;
		
		/** Переключатель типа движения фишки Tween или EnterFrame */
		private var _setTween:Boolean = false;
		
		/** Переключатель остановки фишки */
		private var _speedStopper:Boolean = false;
		
		public function Tile(type:int)
		{
			_type = type;
			
			_view = new Sprite();
			
			_tfTitle = new TextField();
			_tfFormat = _tfTitle.defaultTextFormat;
			_tfFormat.size = 35;
			_tfFormat.align = TextFormatAlign.CENTER;
			_tfTitle.antiAliasType = AntiAliasType.ADVANCED;
			_tfTitle.autoSize = TextFieldAutoSize.CENTER;
			_tfTitle.selectable = false;
			
			setTileView(_type);
			
			this.addChild(_view);
			this.addChild(_tfTitle);
		}
		
		public function get speed():int { return _speed; }
		public function set speed(value:int):void { _speed = value; }
		
		public function get speedStopper():Boolean { return _speedStopper; }
		public function set speedStopper(value:Boolean):void { _speedStopper = value; }
		
		public function get offSetY():Number { return _offSetY; }
		public function set offSetY(value:Number):void { _offSetY = value; }
		
		public function get setTween():Boolean { return _setTween; }
		public function set setTween(value:Boolean):void { _setTween = value; }
		
		public function setTileType(type:int = -1):void
		{
			if (type == -1)
			{
				type = Math.random() * TileModel.COLORS.length;
			}
			setTileView(type);
			_type = type;
		}
		
		public function setTileView(type:int):void
		{
			var color:uint = TileModel.COLORS[type];
			
			_view.graphics.clear();
			_view.graphics.lineStyle(2, color);
			_view.graphics.beginFill(0xFFFFFF);
			_view.graphics.drawRoundRect(0, 0, TileModel.TILE_SIZE, TileModel.TILE_SIZE, 10, 10);
			_view.graphics.endFill();
			
			_tfFormat.color = color;
			_tfTitle.defaultTextFormat = _tfFormat;
			_tfTitle.text = String(type);
			_tfTitle.x = (_view.width - _tfTitle.textWidth) / 2;
			_tfTitle.y = (_view.height - _tfTitle.textHeight) / 2 - 7;
		}
		
		public function move():void {
			this.y += _speed;
			
			if (_speedStopper && this.y >= _offSetY) {
				this.y = _offSetY;
				_speed = 0;
				super.dispatchEvent(new TileEvent(TileEvent.STOP_TILES));
			}
		}
		
		public function destroy():void
		{
			var len:int = this.numChildren;
			while (len--) {
				this.removeChildAt(0);
			}
			_view = null;
			_tfTitle = null;
			_tfFormat = null;
		}
	}

}