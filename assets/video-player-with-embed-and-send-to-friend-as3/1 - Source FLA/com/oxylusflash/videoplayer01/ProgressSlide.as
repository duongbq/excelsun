package com.oxylusflash.videoplayer01
{
	//{region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.oxylusflash.videoplayer01.VideoPlayer;
	import caurina.transitions.Tweener;
	//}endregion
	
	public class ProgressSlide extends MovieClip
	{
		//{region FIELDS
		public var mcProgressScrobber : MovieClip;
		public var mcProgressBuffer : MovieClip;
		public var mcTotalTime : MovieClip;
		public var mcCurrentTime : MovieClip;
		public var Bg : MovieClip;
		
		private var _perc : Number;
		internal var w : Number;
		internal var marginRight : Number;
		internal var marginLeft : Number;
		internal static var megaFlag : Boolean = true;
		private var perControll : Number;
		//}endregion
		
		//{region CONSTRUCTOR
		public function ProgressSlide() 
		{
			w = this.width;
			this.mouseChildren = false;
			this.buttonMode = true;
			this.hitArea = this.mcProgressBuffer;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0 , true);
		}
		//}endregion
		
		//{region METHODS AND EVENT HANDLERS
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			mcProgressScrobber.width = 0;
			mcProgressScrobber.x = 0;
			marginRight = mcTotalTime.Bg.width;// + Resize.btnPadding;
			marginLeft = mcCurrentTime.Bg.width;
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			if (VideoPlayer.getInstance().mcVideoHolderHit.alpha == 1) 
			{
				VideoPlayer.getInstance().mcVideoHolderHit.alpha = 0;
			}
			megaFlag = false;
			updatePercentage();
			VideoPlayer.getInstance().stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler, false, 0, true);
			VideoPlayer.getInstance().stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler, false, 0, true);
		}
		
		private function mouseClickHandler(e:MouseEvent):void 
		{
			updatePercentage();
			VideoPlayer.getInstance().app.seek(percentage, true);
		}
		
		private function stage_mouseUpHandler(e:MouseEvent):void 
		{
			megaFlag = true;
			updatePercentage();
			VideoPlayer.getInstance().app.play();
			
			VideoPlayer.getInstance().mcController.mcPlayPauseToggle.mcPlay.visible = false;
			VideoPlayer.getInstance().mcController.mcPlayPauseToggle.mcPause.visible = true;
			
			if (VideoPlayer.getInstance().mcVideo.alpha == 0) 
			{
				VideoPlayer.getInstance().mcVideo.alpha = 1;
			}
			VideoPlayer.getInstance().stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			VideoPlayer.getInstance().stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
		}
		
		private function stage_mouseMoveHandler(e:MouseEvent):void 
		{
			updatePercentage();
			VideoPlayer.getInstance().app.seek(percentage, true);
		}
		
		internal function updatePercentage():void 
		{
			this.hitArea = this.mcProgressBuffer;
			this.percentage = (this.mouseX - marginLeft) / (w - (marginLeft + marginRight));
		}
		
		public function get percentage():Number { return _perc; }
		
		public function set percentage(value:Number):void 
		{
			value = Math.max(0, Math.min(1, value));
			
			if (_perc != value)
			{
				perControll = VideoPlayer.getInstance().app.loadedBytes / VideoPlayer.getInstance().app.totalBytes;
				_perc = value;
				if (_perc > perControll) 
				{
					_perc = perControll;
				}
				mcProgressScrobber.width = Math.round((w - (marginLeft + marginRight)) * _perc);
				mcCurrentTime.x = mcProgressScrobber.width;
			}
		}
		//}endregion
	}
	
}