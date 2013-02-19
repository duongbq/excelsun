package com.oxylusflash.videoplayer01
{
	//{region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import com.oxylusflash.videoplayer01.VideoPlayer;
	
	import caurina.transitions.Tweener;
	//}endregion
	
	public class EmbeddedText extends MovieClip
	{	
		//{region PUBLIC FIELDS
		public var Bg : MovieClip;
		public var mcCopyStatus : MovieClip;
		public var mcToggleEmbeddedCopyBtn : MovieClip;
		public var mcEmbeddedTitle : MovieClip;
		public var mcToggleEmbeddedClose : MovieClip;
		public var mcEmbeddedInputTxt : MovieClip;
		public var mcEmbeddedInputTxtMask : MovieClip;
		//}endregion
			
		//{region CONSTRUCTOR
		public function EmbeddedText()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		//}endregion
		
		//{region INIT
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			mcToggleEmbeddedClose.mcEmbeddedCloseNormal.addEventListener(MouseEvent.ROLL_OVER, mcEmbeddedCloseNormal_RollOverHandler, false, 0, true);
			mcToggleEmbeddedClose.mcEmbeddedCloseOver.addEventListener(MouseEvent.CLICK, mcEmbeddedCloseOver_ClickHandler, false, 0, true);
			mcToggleEmbeddedClose.mcEmbeddedCloseOver.addEventListener(MouseEvent.ROLL_OUT, mcEmbeddedCloseOver_RollOutHandler, false, 0, true);
			
			mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnNormal.addEventListener(MouseEvent.ROLL_OVER, mcEmbeddedCopyBtnNormal_RollOverHandler, false, 0, true);
			mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.addEventListener(MouseEvent.CLICK, mcEmbeddedCopyBtnOver_ClickHandler, false, 0, true);
			mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.addEventListener(MouseEvent.ROLL_OUT, mcEmbeddedCopyBtnOver_RollOutHandler, false, 0, true);
		}
		//}endregion
		
		//{region EVENT HAMDLLERS
		private function mcEmbeddedCloseNormal_RollOverHandler(e:Event):void 
		{
			mcToggleEmbeddedClose.mcEmbeddedCloseOver.visible = true;
			Tweener.addTween(mcToggleEmbeddedClose.mcEmbeddedCloseOver, {alpha:1, time:.3, transition:"easeOutCubic"});
		}
		
		private function mcEmbeddedCloseOver_ClickHandler(e:Event):void 
		{
			close();
		}
		
		private function mcEmbeddedCloseOver_RollOutHandler(e:Event):void 
		{
			Tweener.addTween(mcToggleEmbeddedClose.mcEmbeddedCloseOver, {alpha:0, time:.3, transition:"easeInCubic", onComplete: function ():void 
			{
			mcToggleEmbeddedClose.mcEmbeddedCloseOver.visible = false;
			}});
		}
		
		private function mcEmbeddedCopyBtnNormal_RollOverHandler(e:Event):void 
		{
			mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.visible = true;
			Tweener.addTween(mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver, {alpha:1, time:.3, transition:"easeOutCubic"});
		}
		
		private function mcEmbeddedCopyBtnOver_ClickHandler(e:Event):void 
		{
			mcEmbeddedInputTxt.txt.setSelection(0, mcEmbeddedInputTxt.txt.text.length);
			System.setClipboard(mcEmbeddedInputTxt.txt.text);
			
			mcCopyStatus.visible = true;
			Tweener.addTween(mcCopyStatus, { alpha:1 , time: .3, transition:"easeOutBack", onComplete: function ():void 
			{
				Tweener.addTween(mcCopyStatus, { alpha: 0, delay:2, time:.3, transition:"easeInBack" } );
			} } );
		}
		
		private function mcEmbeddedCopyBtnOver_RollOutHandler(e:Event):void 
		{
			Tweener.addTween(mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver, {alpha:0, time:.3, transition:"easeInCubic", onComplete:function ():void 
			{
				mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.visible = false;
			}});
		}
		//}endregion
		
		//{region METHODS
		internal function close():void 
		{
			if (!this.visible) 
			{
				this.visible = true;
				Tweener.addTween(this, {alpha: 1, time:.5, transition:"easeOutCirc"});
			}else 
			{
				Tweener.addTween(this, {alpha: 0, time:.5, transition:"easeInCirc", onComplete: function ():void 
				{
					this.visible = false;
					mcCopyStatus.visible = false;
					mcCopyStatus.alpha = 0;
				}});
			}
		}
		//}endregion
	}
}