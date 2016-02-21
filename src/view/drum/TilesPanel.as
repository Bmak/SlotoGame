package view.drum 
{
	import aze.motion.easing.Back;
	import aze.motion.eaze;
	import event.GameEvent;
	import event.TileEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import model.AppModel;
	import model.TileModel;
	import view.Tile.Tile;
	/**
	 * Панель с фишками
	 * @author ProBigi
	 */
	public class TilesPanel extends Sprite
	{
		private var _model:AppModel;
		
		private var _allTiles:Vector.<Vector.<Tile>>;
		private var _tileContainers:Vector.<Sprite>;
		
		//Переменные для хранения повторяющихся элементов
		private var _tempTiles:Vector.<Tile> = null;
		private var _tempTile:Tile = null;
		
		private var _colIterator:int;
		private var _tileOffset:int;
		private var _currentTileOffset:int;
		private var _checkStopRoll:int;
		
		
		public function TilesPanel(model:AppModel) 
		{
			_model = model;
			
			initTiles();
		}
		
		//Инициализация матрицы игровых фишек
		private function initTiles():void
		{
			_allTiles = new Vector.<Vector.<Tile>>(TileModel.TILE_COLS, true);
			var tile:Tile = null;
			_tileContainers = new Vector.<Sprite>(TileModel.TILE_COLS, true);
			var cont:Sprite = null;
			for (var i:int = 0; i < TileModel.TILE_COLS; ++i)
			{
				_tempTiles = new Vector.<Tile>();
				cont = new Sprite;
				for (var j:int = 0; j < TileModel.TILES_IN_COL; ++j)
				{
					_tempTile = new Tile(_model.tileIDs[i][j]-1);
					_tempTile.y = (TileModel.TILE_SIZE + TileModel.Y_OFFSET) * j;
					cont.addChild(_tempTile);
					_tempTiles[j] = _tempTile;
				}
				_allTiles[i] = _tempTiles;
				_tileContainers[i] = cont;
				cont.x = (TileModel.TILE_SIZE + TileModel.X_OFFSET) * i;
				this.addChild(cont);
			}
			
			TileModel.MAX_POS = cont.height;
			
			_model.drumState = AppModel.DRUM_SLEEP;
		}
		
		//Запускаем вращение барабана
		public function startRoll():void
		{
			clearRound();
			
			this.addEventListener(Event.ENTER_FRAME, updateMoveTiles);
			
			for each (_tempTiles in _allTiles) {
				for each (_tempTile in _tempTiles) {
					_tempTile.speed = TileModel.BASE_SPEED;
					_tempTile.setTween = false;
					_tempTile.offSetY = 0;
					_tempTile.speedStopper = false;
				}
			}
		}
		
		//Сброс параметров перед вращение барабана
		private function clearRound():void
		{
			_colIterator = 0;
			_tileOffset = 0;
			_currentTileOffset = 0;
			_checkStopRoll = TileModel.TILES_IN_COL * TileModel.TILE_COLS;
		}
		
		//Крутим фишки бесконечно
		private function updateMoveTiles(e:Event):void 
		{
			if (_model.drumState != AppModel.DRUM_SLEEP)
			{
				for each (_tempTiles in _allTiles) {
					for each (_tempTile in _tempTiles) {
						if (!_tempTile.setTween)
						{
							_tempTile.move();
							if (_tempTile.y >= TileModel.MAX_POS) {
								repositionTile(_tempTile, _tempTiles);
							}
						}
					}
				}
			}
		}
		
		/**
		 * Перестановка фишек после того, как они пересекли черту минимальной позиции
		 * @param	tile	фишка, которую необходимо перенести
		 * @param	tiles	массив, в котором фишка содержится
		 */
		private function repositionTile(tile:Tile, tiles:Vector.<Tile>):void 
		{
			tile.y = tiles[0].y - (TileModel.TILE_SIZE + TileModel.Y_OFFSET);
			tiles.splice(0, 0, tiles.pop());
			
			if (_model.drumState == AppModel.DRUM_PREPARE_TO_STOP)
			{
				calculateTileStopOffset(tile);
			} else {
				//Ставим рандомный тип фишки
				tile.setTileType();
			}
			
		}
		
		/**
		 * Вычисляем в какой момент остановить столбец с фишками
		 * @param	tile
		 */
		private function calculateTileStopOffset(tile:Tile):void
		{
			if (_colIterator >= 5) { return; }
			
			_tempTiles = _allTiles[_colIterator];
			var index:int = _tempTiles.indexOf(tile);
			if (index != -1)
			{
				if (_currentTileOffset == _tileOffset)
				{
					_tempTile.addEventListener(TileEvent.STOP_TILES, onStopTilesColumn);
					_tempTile.speedStopper = true;
					_tempTile.offSetY = (TileModel.TILE_SIZE + TileModel.Y_OFFSET) * TileModel.ID_TO_STOP - TileModel.ANIM_OFFSET;
					_colIterator++;
					_tileOffset += TileModel.TILE_STOP_OFFSET;
				} else {
					_currentTileOffset++;
				}
			}
		}
		
		//Останавливаем с визуальным эффектом поочередно каждый столбец фишек
		private function onStopTilesColumn(e:TileEvent):void {
			var i:int = 0;
			var j:int;
			_tempTile = e.target as Tile;
			
			var index:int;
			for each (_tempTiles in _allTiles)
			{
				index = _tempTiles.indexOf(_tempTile);
				if (index != -1)
				{
					j = 0;
					for each (_tempTile in _tempTiles)
					{
						if (_tempTile.hasEventListener(TileEvent.STOP_TILES))
						{ 
							_tempTile.removeEventListener(TileEvent.STOP_TILES, onStopTilesColumn);
						}
						if (j > index) { _tempTile.move(); }
						_tempTile.setTween = true;
						_tempTile.speed = 0;
						j++;
					}
					setTileTween(i);
					return;
				}
				i++;
			}
		}
		
		private function setTileTween(index:int):void 
		{
			for each (_tempTile in _allTiles[index])
			{
				var dy:int = _tempTile.y + TileModel.ANIM_OFFSET;
				eaze(_tempTile).to(1.2, { y: dy } ).easing(Back.easeOut).onComplete(onCheckEndRoll, _tempTile);
			}
		}
		
		//Проверка полного завершения вращения барабана
		private function onCheckEndRoll(tile:Tile):void 
		{
			tile.offSetY += TileModel.ANIM_OFFSET;
			eaze(tile).killTweens();
			
			_checkStopRoll--;
			if (_checkStopRoll == 0)
			{
				onFinalRepos();
				
				this.removeEventListener(Event.ENTER_FRAME, updateMoveTiles);
				
				super.dispatchEvent(new GameEvent(GameEvent.DRUM_IS_STOPPED));
			}
		}
		
		//Возвращаем таблицу фишек в исходное состояние для следующего вращения
		private function onFinalRepos():void 
		{
			var len:int = 0;
			for each (_tempTiles in _allTiles) {
				len = _tempTiles.length;
				for (var i:int = 0; i < len; i++)
				{
					_tempTile = _tempTiles[i];
					if (_tempTile.y >= TileModel.MAX_POS) {
						_tempTile.y = _tempTiles[0].y - (TileModel.TILE_SIZE + TileModel.Y_OFFSET);
						_tempTiles.splice(0,0, _tempTiles.splice(i, 1)[0]);
					}
					
				}
			}
		}
		
		public function destroy():void
		{
			_model = null;
			
			for each(_tempTiles in _allTiles)
			{
				for each(_tempTile in _tempTiles)
				{
					if (_tempTile.hasEventListener(TileEvent.STOP_TILES))
					{ 
						_tempTile.removeEventListener(TileEvent.STOP_TILES, onStopTilesColumn);
					}
					eaze(_tempTile).killTweens();
					_tempTile.destroy();
					if (_tempTile.parent) { _tempTile.parent.removeChild(_tempTile); }
				}
				_tempTiles.length = 0;
			}
			_allTiles.length = 0;
			_allTiles = null;
			_tempTiles = null;
			_tempTile = null;
			
			var len:int = this.numChildren;
			while (len--)
			{
				this.removeChildAt(0);
			}
			_tileContainers.length = 0;
			_tileContainers = null;
		}
	}

}