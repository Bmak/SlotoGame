package control 
{
	import flash.display.Sprite;
	import model.AppModel;
	import view.AppView;
	/**
	 * Основной контроллер приложения
	 * На начальном этапе в нем может происходить загрузка и инициализация всех основных элементов
	 * @author ProBigi
	 */
	public class AppControl 
	{
		
		private var _mainCont:Sprite;
		
		private var _view:AppView;
		private var _model:AppModel;
		
		public function AppControl(cont:Sprite) 
		{
			_mainCont = cont;
			
			_model = new AppModel();
			_view = new AppView(_model);
			
			_mainCont.addChild(_view);
		}
		
	}

}