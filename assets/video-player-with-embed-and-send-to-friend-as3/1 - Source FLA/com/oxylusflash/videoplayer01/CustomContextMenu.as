package com.oxylusflash.videoplayer01
{
	//{region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.net.navigateToURL;
	//}endregion
	
	public class CustomContextMenu extends MovieClip
	{
		//{region FIELDS
		private var myMenu : ContextMenu = new ContextMenu();
		internal var fullscreen : ContextMenuItem = new ContextMenuItem("Fullscreen");
		private var resizeToFit : ContextMenuItem = new ContextMenuItem("Resize to fit");
		private var resizeToFill : ContextMenuItem = new ContextMenuItem("Resize to fill");
		private var stretch : ContextMenuItem = new ContextMenuItem("Stretch");
		private var originalSize : ContextMenuItem = new ContextMenuItem("Original Size");
		private var copyRight : ContextMenuItem = new ContextMenuItem(VideoPlayer.getInstance().copyRight);
		//}endregion
		
		//{region CONSTRUCTOR
		public function CustomContextMenu()
		{
			resizeToFit.separatorBefore = true;
			copyRight.separatorBefore = true;
			myMenu.hideBuiltInItems();
			myMenu.customItems.push(fullscreen, resizeToFit, resizeToFill, stretch, originalSize, copyRight);
			VideoPlayer.getInstance().contextMenu = myMenu;
			fullscreen.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, fullscreenHandler);
			resizeToFit.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, resizeToFitHandler);
			resizeToFill.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, resizeToFillHandler);
			stretch.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, stretchHandler);
			originalSize.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, originalSizeHandler);
			copyRight.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, openLink);
			check(VideoPlayer.getInstance().videoMode);

		}
		//}endregion
		
		//{region EVENT HANDLERS
		private function openLink(e:ContextMenuEvent):void 
		{
			check("openlink");
			navigateToURL(new URLRequest(VideoPlayer.getInstance().link), VideoPlayer.getInstance().target);
		}
		
		function fullscreenHandler(e:ContextMenuEvent):void 
		{
			VideoPlayer.getInstance().toggleFullscreen();
		}
		
		private function resizeToFitHandler(e:ContextMenuEvent):void 
		{
			check("fittosize");
			VideoPlayer.getInstance().videoMode = "fittosize";
			VideoPlayer.getInstance().videoModeFun();		
		}
		
		private function resizeToFillHandler(e:ContextMenuEvent):void 
		{
			check("fittofill");
			VideoPlayer.getInstance().videoMode = "fittofill";
			VideoPlayer.getInstance().videoModeFun();
		}
		
		private function stretchHandler(e:ContextMenuEvent):void 
		{
			check("stretch");
			VideoPlayer.getInstance().videoMode = "stretch";
			VideoPlayer.getInstance().videoModeFun();
		}
		
		private function originalSizeHandler(e:ContextMenuEvent):void 
		{
			check("original");
			VideoPlayer.getInstance().videoMode = "original";
			VideoPlayer.getInstance().videoModeFun();
		}
		//}endregion
			
		//{region METHODS
		private function check(checked : String):void 
		{
			switch (checked) 
			{
				case "fittosize":
				resizeToFit.enabled = false;
				resizeToFill.enabled = true;
				stretch.enabled = true;
				originalSize.enabled = true;
				copyRight.enabled = true;
				break;
				
				case "fittofill":
				resizeToFit.enabled = true;
				resizeToFill.enabled = false;
				stretch.enabled = true;
				originalSize.enabled = true;
				copyRight.enabled = true;
				break;
				
				case "stretch":
				resizeToFit.enabled = true;
				resizeToFill.enabled = true;
				stretch.enabled = false;
				originalSize.enabled = true;
				copyRight.enabled = true;
				break;
				
				case "original":
				resizeToFit.enabled = true;
				resizeToFill.enabled = true;
				stretch.enabled = true;
				originalSize.enabled = false;
				copyRight.enabled = true;
				break;
				
				case "openlink":
				resizeToFit.enabled = true;
				resizeToFill.enabled = true;
				stretch.enabled = true;
				originalSize.enabled = true;
				copyRight.enabled = false;
				break;
			}
		}
		//}endregion
	}
}