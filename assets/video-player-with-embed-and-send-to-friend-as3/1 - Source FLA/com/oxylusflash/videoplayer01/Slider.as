package com.oxylusflash.videoplayer01
{
	//{region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.oxylusflash.videoplayer01.VideoPlayer;
	
	import caurina.transitions.Tweener;
	//}endregion
	
	public class Slider extends MovieClip
	{
		//{region FIELDS
		public var Bg : MovieClip;
		public var mcVolumeScrobberSlide : MovieClip;
		
		private static const MARGIN_TOP:Number = 4;
		private static const MARGIN_BOTTOM:Number = 7;
		private var _perc:Number;
		private var h:Number;
		
		internal var drag : Boolean = true;
		internal var rollOut : Boolean = false;
		//}endregion
		
		//{region CONSTRUCTOR
		public function Slider()
		{
			h = this.Bg.height;
			this.mouseChildren = false;
			this.buttonMode = true;
			this.hitArea = this;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
		}
		//}endregion
		
		//{region METHODS AND EVENT HANDLERS
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			rollOut = false;
			toggleScrobber(true);
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			VideoPlayer.getInstance().stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler, false, 0, true);
			VideoPlayer.getInstance().stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler, false, 0, true);
			updatePercentage();
			VideoPlayer.getInstance().muteOver();
		}
		
		private function stage_mouseMoveHandler(e:MouseEvent):void 
		{
			drag = false;
			updatePercentage();
			VideoPlayer.getInstance().muteOver();
		}
		
		private function mouseWheelHandler(e:MouseEvent):void 
		{
			percentage += 0.05 * e.delta;
			VideoPlayer.getInstance().muteOver();
		}
		
		private function rollOutHandler(e:MouseEvent):void 
		{
			rollOut = true;
			if (drag) 
			{
				toggleScrobber(false);
			}
			VideoPlayer.getInstance().muteNormal();
		}
		
		private function stage_mouseUpHandler(e:MouseEvent):void 
		{
			VideoPlayer.getInstance().stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			VideoPlayer.getInstance().stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			drag = true;
		}
		
		private function updatePercentage():void 
		{

			this.percentage = ((VideoPlayer.getInstance().mcController.height - this.mouseY) - (MARGIN_BOTTOM  + VideoPlayer.getInstance().mcController.Bg.height)) / (h - (MARGIN_TOP + MARGIN_BOTTOM));
		}
		
		public function get percentage():Number { return _perc; }
		
		public function set percentage(value:Number):void 
		{
			value = Math.max(0, Math.min(1, value));
			if (_perc != value)
			{
				_perc = value;
				
				VideoPlayer.getInstance().app.volume = _perc;
				Tweener.addTween(this.mcVolumeScrobberSlide,{ height:Math.round((h - (MARGIN_TOP + MARGIN_BOTTOM)) * _perc), time: .3, transition:"easeOutQuint" });
			}
		}
		
		internal function toggleScrobber(flag:Boolean):void 
		{
			if (flag) 
			{
				this.visible = true;
				Tweener.addTween(this, { alpha:1, time:.3, transition:"easeOutquad" } );
			}else 
			{
				Tweener.addTween(this, {alpha:0, time:.5, transition:"easeInBack", onComplete: function ():void 
				{
					this.visible = false;
				}});
			}
		}
		//}endregion
	}
}