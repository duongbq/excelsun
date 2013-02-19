package com.oxylusflash.videoplayer01
{
	//{region IMPORT CLASSES
	import com.oxylusflash.videoplayer01.VideoPlayer;
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.StageDisplayState;
	import flash.events.FullScreenEvent;
	
	import com.oxylusflash.videoplayer01.VideoPlayer;
	//}endregion
	
	public class Resize extends MovieClip
	{
		//{region STATIC FIELDS
		static internal var btnPadding : uint = 8;
		static internal var mcFullscreenTogglePadding : uint = 4;
		static internal var mcVolumeTogglePadding : uint = 4;
		static internal var mcTitleMaskPadding : uint = 4;//era 8
		static internal var mcPlayPauseTogglePadding : uint = 4;
		static internal var copyStatusPadding : uint = 8;
		static internal var invalidMailPaddingLeft : uint = 8;
		static internal var padding : uint = 6;
		static internal var miniMenuPadding : uint = 10;
		static internal var embeddedTopPadding : uint = 13;
		static internal var embeddedLateralPadding : uint = 13;
		static internal var closePadding : uint = 15;
		static internal var sendMailTitlePaddingLeft : uint = 15;
		static internal var sendMailTitlePaddingTop : uint = 15;
		static internal var sendMailBtn : uint = 15;
		static internal var sendMailInputPadding : uint = 15;
		static internal var prgLeftPadding : uint = 1;
		static internal var ctrlLeftPadding : uint = 1;
		static internal var prgTopPadding : uint = 1;
		static internal var ctrlTopPadding : uint = 1;
		static internal var paramPadding: uint = 6;
		static internal var invalidMailPadding : uint = 15;
		static internal var copyStatusTopLeftPadding: uint = 15;
		//}endregion
		
		//{region CONSTRUCTOR
		public function Resize() 
		{
			VideoPlayer.getInstance().stage.addEventListener(FullScreenEvent.FULL_SCREEN, resizeComponent, false, 0, true);
		}
		//}endregion
		
		//{region METHODS
		//{region CHECK SIZE
		internal function checkSize(flag : Boolean, full : Boolean = true):void
		{
			if (!flag) 
			{
				VideoPlayer.getInstance().mcVideoHolderHit.Bg.width = VideoPlayer.getInstance().Bg.width = VideoPlayer.getInstance().mcVideoMask.width = (VideoPlayer.getInstance().componentW == 0)? VideoPlayer.getInstance().stage.stageWidth : VideoPlayer.getInstance().componentW;
				VideoPlayer.getInstance().mcVideoHolderHit.Bg.height = VideoPlayer.getInstance().Bg.height = VideoPlayer.getInstance().mcVideoMask.height = (VideoPlayer.getInstance().componentH == 0)? VideoPlayer.getInstance().stage.stageHeight : VideoPlayer.getInstance().componentH;
			}else 
			{
			if (full && flag)
			{
				VideoPlayer.getInstance().mcVideoHolderHit.Bg.width = VideoPlayer.getInstance().Bg.width = VideoPlayer.getInstance().mcVideoMask.width = VideoPlayer.getInstance().stage.stageWidth;
				VideoPlayer.getInstance().mcVideoHolderHit.Bg.height = VideoPlayer.getInstance().Bg.height = VideoPlayer.getInstance().mcVideoMask.height = VideoPlayer.getInstance().stage.stageHeight;
			}else 
			{
				VideoPlayer.getInstance().mcVideoHolderHit.Bg.width = VideoPlayer.getInstance().Bg.width = VideoPlayer.getInstance().mcVideoMask.width = (VideoPlayer.getInstance().componentW == 0)? VideoPlayer.getInstance().stage.stageWidth : VideoPlayer.getInstance().componentW;
				VideoPlayer.getInstance().mcVideoHolderHit.Bg.height = VideoPlayer.getInstance().Bg.height = VideoPlayer.getInstance().mcVideoMask.height = (VideoPlayer.getInstance().componentH == 0)? VideoPlayer.getInstance().stage.stageHeight : VideoPlayer.getInstance().componentH;
			}
			}
		}
		//}endregion
		
		//{region RESIZE COMPONENT
		private function resizeComponent(e:FullScreenEvent):void 
		{
			if (e.fullScreen)
			{
				checkSize(true, true);
				resize();
			}else 
			{
				checkSize(true, false);
				resize();
			}
		}
		//}endregion
		
		//{region RESIZE
		internal function resize():void 
		{
			//<start> you should remove this if you combine this app with other apps/ or change the values
			VideoPlayer.getInstance().x = 0;
			VideoPlayer.getInstance().y = 0;
			//<end>
			
			VideoPlayer.getInstance().updateVideoMode(VideoPlayer.getInstance().Bg.width, VideoPlayer.getInstance().Bg.height);
			
			VideoPlayer.getInstance().mcVideoHolderHit.x = VideoPlayer.getInstance().mcVideoMask.x = VideoPlayer.getInstance().x;
			VideoPlayer.getInstance().mcVideoHolderHit.y = VideoPlayer.getInstance().mcVideoMask.y = VideoPlayer.getInstance().y;
			
			VideoPlayer.getInstance().mcSendMail.Bg.width = VideoPlayer.getInstance().sendMailWidth;
			VideoPlayer.getInstance().mcSendMail.Bg.height = VideoPlayer.getInstance().sendMailHeight;
			
			VideoPlayer.getInstance().mcSendMail.mcToggleMailSendBtn.x = VideoPlayer.getInstance().mcSendMail.Bg.width - (VideoPlayer.getInstance().mcSendMail.mcToggleMailSendBtn.width + sendMailBtn);
			VideoPlayer.getInstance().mcSendMail.mcToggleMailSendBtn.y = VideoPlayer.getInstance().mcSendMail.Bg.height - (VideoPlayer.getInstance().mcSendMail.mcToggleMailSendBtn.height + sendMailBtn);
			
			VideoPlayer.getInstance().mcSendMail.mcInvalidMail.x = invalidMailPadding;
			VideoPlayer.getInstance().mcSendMail.mcInvalidMail.y = VideoPlayer.getInstance().mcSendMail.Bg.height - (VideoPlayer.getInstance().mcSendMail.mcInvalidMail.Bg.height + invalidMailPadding);
			VideoPlayer.getInstance().mcSendMail.mcInvalidMail.Bg.width = VideoPlayer.getInstance().mcSendMail.mcToggleMailSendBtn.x - invalidMailPaddingLeft;
			
			VideoPlayer.getInstance().mcSendMail.mcToggleMailClose.x = VideoPlayer.getInstance().mcSendMail.Bg.width - (VideoPlayer.getInstance().mcSendMail.mcToggleMailClose.width + closePadding);
			VideoPlayer.getInstance().mcSendMail.mcToggleMailClose.y = closePadding;
			
			VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.x = sendMailTitlePaddingLeft;
			VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.txt.x = 0;
			VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.txt.y = 0;
			VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.Bg.width = VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.txt.textWidth;
			VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.Bg.height = VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.txt.textHeight;
			VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.y = sendMailTitlePaddingTop;
			
			VideoPlayer.getInstance().mcSendMail.mcMailInputTxt.x = sendMailInputPadding;
			VideoPlayer.getInstance().mcSendMail.mcMailInputTxt.y = VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.y + VideoPlayer.getInstance().mcSendMail.mcMailBoxTitle.Bg.height + sendMailInputPadding;
			VideoPlayer.getInstance().mcSendMail.mcMailInputTxt.Bg.width = VideoPlayer.getInstance().mcSendMail.Bg.width - (2 * sendMailInputPadding);
			VideoPlayer.getInstance().mcSendMail.mcMailInputTxt.txt.x = 2;
			VideoPlayer.getInstance().mcSendMail.mcMailInputTxt.txt.y = 8;
			
			VideoPlayer.getInstance().mcSendMail.mcMailInputTxt.txt.width = VideoPlayer.getInstance().mcSendMail.mcMailInputTxt.Bg.width - 4;

			VideoPlayer.getInstance().mcEmbedded.Bg.width = VideoPlayer.getInstance().embeddedTextWidth;
			VideoPlayer.getInstance().mcEmbedded.Bg.height = VideoPlayer.getInstance().embeddedTextHeight;
			
			VideoPlayer.getInstance().mcEmbedded.mcEmbeddedTitle.x = embeddedLateralPadding;
			VideoPlayer.getInstance().mcEmbedded.mcEmbeddedTitle.y = embeddedTopPadding;
			
			VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxtMask.x = VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.x = embeddedTopPadding;
			VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxtMask.width = VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.Bg.width = VideoPlayer.getInstance().mcEmbedded.Bg.width - 2 * embeddedTopPadding;
			VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxtMask.y = VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.y = VideoPlayer.getInstance().mcEmbedded.mcEmbeddedTitle.y + VideoPlayer.getInstance().mcEmbedded.mcEmbeddedTitle.Bg.height + embeddedTopPadding;
			VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxtMask.height = VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.Bg.height = VideoPlayer.getInstance().mcEmbedded.Bg.height - (VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.y + VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedCopyBtn.Bg.height + 2*miniMenuPadding);
			
			VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedCopyBtn.x = VideoPlayer.getInstance().mcEmbedded.Bg.width - (VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedCopyBtn.Bg.width + embeddedTopPadding);
			VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedCopyBtn.y = VideoPlayer.getInstance().mcEmbedded.Bg.height - (VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedCopyBtn.Bg.height + embeddedTopPadding);
			
			VideoPlayer.getInstance().mcEmbedded.mcCopyStatus.x = copyStatusTopLeftPadding;
			VideoPlayer.getInstance().mcEmbedded.mcCopyStatus.y = VideoPlayer.getInstance().mcEmbedded.Bg.height - (VideoPlayer.getInstance().mcEmbedded.mcCopyStatus.Bg.height + copyStatusTopLeftPadding);
			VideoPlayer.getInstance().mcEmbedded.mcCopyStatus.Bg.width = VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedCopyBtn.x - copyStatusPadding;

			VideoPlayer.getInstance().mcEmbedded.mcCopyStatus.txt.x = 0;
			VideoPlayer.getInstance().mcEmbedded.mcCopyStatus.txt.y = 0;
			VideoPlayer.getInstance().mcEmbedded.mcCopyStatus.txt.width = VideoPlayer.getInstance().mcEmbedded.mcCopyStatus.Bg.width;
			
			VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedClose.x = VideoPlayer.getInstance().mcEmbedded.Bg.width - (VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedClose.Bg.width + embeddedTopPadding);
			VideoPlayer.getInstance().mcEmbedded.mcToggleEmbeddedClose.y = embeddedTopPadding;
			
			VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.txt.width = VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.Bg.width;
			VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.txt.height = VideoPlayer.getInstance().mcEmbedded.mcEmbeddedInputTxt.Bg.height;

			position("left", VideoPlayer.getInstance().mcController, ctrlLeftPadding);
			
			position(VideoPlayer.getInstance().controllerPos, VideoPlayer.getInstance().mcController, ctrlTopPadding,"" ,VideoPlayer.getInstance().controllerPosOrder);
			
			VideoPlayer.getInstance().mcProgressBar.Bg.width = VideoPlayer.getInstance().mcController.Bg.width = VideoPlayer.getInstance().Bg.width - 2;

			VideoPlayer.getInstance().mcProgressBar.mcProgressBuffer.width = VideoPlayer.getInstance().loaderInfo.bytesLoaded / VideoPlayer.getInstance().loaderInfo.bytesTotal * (VideoPlayer.getInstance().mcProgressBar.Bg.width - (VideoPlayer.getInstance().mcProgressBar.mcTotalTime.Bg.width + VideoPlayer.getInstance().mcProgressBar.mcCurrentTime.Bg.width));
			
			VideoPlayer.getInstance().mcProgressBar.mcProgressScrobber.width = Math.round((VideoPlayer.getInstance().mcProgressBar.Bg.width - 
			(VideoPlayer.getInstance().mcProgressBar.marginLeft + VideoPlayer.getInstance().mcProgressBar.marginRight)) * VideoPlayer.getInstance().mcProgressBar.percentage);
			VideoPlayer.getInstance().mcProgressBar.mcCurrentTime.x = VideoPlayer.getInstance().mcProgressBar.mcProgressScrobber.width;
		
			VideoPlayer.getInstance().mcProgressBar.w = VideoPlayer.getInstance().mcProgressBar.Bg.width;

			VideoPlayer.getInstance().mcProgressBar.mcTotalTime.x = VideoPlayer.getInstance().mcProgressBar.Bg.width - VideoPlayer.getInstance().mcProgressBar.mcTotalTime.Bg.width;

			VideoPlayer.getInstance().mcController.mcVolumeToggle.x = VideoPlayer.getInstance().mcController.Bg.width - VideoPlayer.getInstance().mcController.mcVolumeToggle.width - VideoPlayer.getInstance().mcController.mcFullscreenToggle.width - 2 * mcVolumeTogglePadding;
			VideoPlayer.getInstance().mcController.mcFullscreenToggle.x = VideoPlayer.getInstance().mcController.mcVolumeToggle.x + VideoPlayer.getInstance().mcController.mcVolumeToggle.width + mcFullscreenTogglePadding;
			
			VideoPlayer.getInstance().mcController.mcTitleMask.width = VideoPlayer.getInstance().mcController.Bg.width - (VideoPlayer.getInstance().mcController.mcVolumeToggle.width +  
			VideoPlayer.getInstance().mcController.mcFullscreenToggle.width + 
			Math.floor(5 * ((VideoPlayer.getInstance().mcController.mcFullscreenToggle.x - VideoPlayer.getInstance().mcController.mcVolumeToggle.x) - VideoPlayer.getInstance().mcController.mcVolumeToggle.width)) + 
			VideoPlayer.getInstance().mcController.mcPlayPauseToggle.width);
		
			position("left", VideoPlayer.getInstance().mcProgressBar, prgLeftPadding);
	
			position(VideoPlayer.getInstance().progressBarPos, VideoPlayer.getInstance().mcProgressBar, prgTopPadding, VideoPlayer.getInstance().progressBarPosOrder);

			VideoPlayer.getInstance().mcVideoHolderHit.Bg.height = VideoPlayer.getInstance().Bg.height;

			position(VideoPlayer.getInstance().bufferPosX, VideoPlayer.getInstance().mcBufferToggle, paramPadding);
			position(VideoPlayer.getInstance().bufferPosY, VideoPlayer.getInstance().mcBufferToggle, paramPadding);
			
			position(VideoPlayer.getInstance().miniMenuPosX, VideoPlayer.getInstance().mcMiniMenu, paramPadding);
			position(VideoPlayer.getInstance().miniMenuPosY, VideoPlayer.getInstance().mcMiniMenu, paramPadding);
			
			position(VideoPlayer.getInstance().sendMailPosX, VideoPlayer.getInstance().mcSendMail, paramPadding);
			position(VideoPlayer.getInstance().sendMailPosY, VideoPlayer.getInstance().mcSendMail, paramPadding);
			
			position(VideoPlayer.getInstance().embeddedTextPosX, VideoPlayer.getInstance().mcEmbedded, paramPadding);
			position(VideoPlayer.getInstance().embeddedTextPosY, VideoPlayer.getInstance().mcEmbedded, paramPadding);
			
			VideoPlayer.getInstance().mcController.mcPlayPauseToggle.x = mcPlayPauseTogglePadding;
			VideoPlayer.getInstance().mcController.mcTitleMask.x = VideoPlayer.getInstance().mcController.mcPlayPauseToggle.x + VideoPlayer.getInstance().mcController.mcPlayPauseToggle.width + mcTitleMaskPadding;
			VideoPlayer.getInstance().mcController.mcTitle.x = VideoPlayer.getInstance().mcController.mcTitleMask.x;
			VideoPlayer.getInstance().mcController.mcVolumeToggle.x = VideoPlayer.getInstance().mcController.Bg.width - VideoPlayer.getInstance().mcController.mcVolumeToggle.width - VideoPlayer.getInstance().mcController.mcFullscreenToggle.width - 2 * mcVolumeTogglePadding;
			VideoPlayer.getInstance().mcController.mcFullscreenToggle.x = VideoPlayer.getInstance().mcController.mcVolumeToggle.x + VideoPlayer.getInstance().mcController.mcVolumeToggle.width + mcFullscreenTogglePadding;

			positionVolume();
			
			//SHOW APP
			Tweener.addTween(VideoPlayer.getInstance(), {alpha:1, time: 2, transition:"easeOutBack"});
		}
		//}endregion
	
		//{region POSITION VOLUME
		private function positionVolume():void 
		{
			if (VideoPlayer.getInstance().controllerPos == "bottom" || VideoPlayer.getInstance().controllerPos == "center") 
			{
				VideoPlayer.getInstance().mcVolumeScrobber.x = VideoPlayer.getInstance().mcController.mcVolumeToggle.x + ((VideoPlayer.getInstance().mcController.mcVolumeToggle.Bg.width - VideoPlayer.getInstance().mcVolumeScrobber.Bg.width)/2);
				VideoPlayer.getInstance().mcVolumeScrobber.y = -VideoPlayer.getInstance().mcVolumeScrobber.height;
			}else 
			{
				VideoPlayer.getInstance().mcVolumeScrobber.x = VideoPlayer.getInstance().mcController.mcVolumeToggle.x + ((VideoPlayer.getInstance().mcController.mcVolumeToggle.Bg.width + VideoPlayer.getInstance().mcVolumeScrobber.Bg.width)/2);
				VideoPlayer.getInstance().mcVolumeScrobber.y = VideoPlayer.getInstance().mcVolumeScrobber.height + VideoPlayer.getInstance().mcController.Bg.height;// VideoPlayer.getInstance().mcVolumeScrobber.height;
			}
		}
		//}endregion
		
		//{region POSITION COMPONENTS
		private function position(pos:String, mc:MovieClip, pPadding:uint = 0, pOrder:String = "", cOrder:String = ""):void
		{
			switch (pos) 
			{
				case "top":
				if (pOrder == "" && cOrder == "") 
				{
					mc.y = 0 + pPadding;
				}else 
				{
					if (pOrder == "first") 
					{
						mc.y = 0 + pPadding;;
					}
					if (pOrder == "second") 
					{
						mc.y = 0 + VideoPlayer.getInstance().mcController.Bg.height + 2*pPadding;
					}
					if (cOrder == "first") 
					{
						VideoPlayer.getInstance().mcVolumeScrobber.rotation = 180;
						mc.y = 0 + pPadding;
					}
					if (cOrder == "second") 
					{
						VideoPlayer.getInstance().mcVolumeScrobber.rotation = 180;
						mc.y = 0 + VideoPlayer.getInstance().mcProgressBar.Bg.height + 2*pPadding;
					}
				}
				break;
				
				case "center":
				if (pOrder == "" && cOrder == "") 
				{
					mc.y = VideoPlayer.getInstance().Bg.height / 2 - mc.Bg.height / 2;
				}else 
				{
					if (pOrder == "first") 
					{
						mc.y = VideoPlayer.getInstance().Bg.height / 2 - mc.Bg.height;
					}
					if (pOrder == "second") 
					{
						mc.y = (VideoPlayer.getInstance().Bg.height / 2 - (VideoPlayer.getInstance().mcController.Bg.height + VideoPlayer.getInstance().mcProgressBar.Bg.height + 2*pPadding));
					}
					if (cOrder == "first") 
					{
						mc.y = VideoPlayer.getInstance().Bg.height / 2 - mc.Bg.height;
					}
					if (cOrder == "second") 
					{
						mc.y = (VideoPlayer.getInstance().Bg.height / 2 - (VideoPlayer.getInstance().mcController.Bg.height + VideoPlayer.getInstance().mcProgressBar.Bg.height + 2*pPadding));
					}
				}
				break;
				
				case "bottom":
				if (pOrder == "" && cOrder == "") 
				{	
					mc.y = VideoPlayer.getInstance().Bg.height - (mc.Bg.height + pPadding);
				}else 
				{
					if (pOrder == "first") 
					{
						mc.y = VideoPlayer.getInstance().Bg.height - (mc.Bg.height + VideoPlayer.getInstance().mcController.Bg.height + 2*pPadding);
					}
					if (pOrder == "second") 
					{
						mc.y = VideoPlayer.getInstance().Bg.height - (VideoPlayer.getInstance().mcProgressBar.Bg.height + pPadding);
					}
					if (cOrder == "first") 
					{
						mc.y = VideoPlayer.getInstance().Bg.height - (mc.Bg.height + VideoPlayer.getInstance().mcProgressBar.Bg.height + 2*pPadding);
					}
					if (cOrder == "second") 
					{
						mc.y = VideoPlayer.getInstance().Bg.height - (mc.Bg.height + pPadding);
					}
				}
				break;
				
				case "left":
				mc.x = 0 + pPadding;
				break;
				
				case "middle":
				mc.x = VideoPlayer.getInstance().Bg.width / 2 - mc.Bg.width / 2;
				break;
				
				case "right":
				mc.x = VideoPlayer.getInstance().Bg.width - (mc.Bg.width + pPadding);
				break;
			}
		}
		//}endregion
		
		//}endregion
	}
}