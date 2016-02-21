package model 
{
	/**
	 * Данные игровой фишки
	 * @author ProBigi
	 */
	public class TileModel 
	{
		/** Размер фишки */
		public static const TILE_SIZE:int = 100;
		
		/** Скорость фишки */
		public static const BASE_SPEED:int = 20;
		
		/** Смещение между фишками по X */
		public static const X_OFFSET:int = 20;
		
		/** Смещение между фишками по Y */
		public static const Y_OFFSET:int = 20;
		
		/** Интервал остановки каждого столбца барабана в фишках */
		public static const TILE_STOP_OFFSET:int = 2;
		
		/** Максимальная позиция, при которой фишка убирается и переносится наверх */
		public static var MAX_POS:int;
		
		/** Визуальные типы фишек */
		public static const COLORS:Vector.<uint> = Vector.<uint>([
				0x008000,
				0xFF8040,
				0x0000FF,
				0x804000,
				0xFF0000
				]);
		
		
		/** Количество колонок фишек */
		public static const TILE_COLS:int = 5;
		
		/** Количество фишек в колонке */
		public static const TILES_IN_COL:int = 10;
		
		/**
		 * Визуальный ориентир остановки фишки
		 * К примеру, из TILES_IN_COL фишек в колонке на фишке с указанным индексом будет ориент остановки барабана
		 */
		public static const ID_TO_STOP:int = 6;
		
		/**
		 * Расстояие для твина фишки перед финальной остановкой
		 */
		public static const ANIM_OFFSET:int = TILE_SIZE*2;
		
		public function TileModel() 
		{
			
		}
		
	}

}