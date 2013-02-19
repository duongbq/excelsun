package com.oxylusflash.videoplayer01
{
	//{region IMPORT CLASSES
	import flash.display.ActionScriptVersion;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.FullScreenEvent;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Video;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.text.TextFieldAutoSize;
	import flash.display.StageDisplayState;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.ui.Keyboard;
	
	import com.oxylusflash.videoplayer01.events.PlaybackEvent;
	import com.oxylusflash.videoplayer01.VideoPlaybackController;
	import com.oxylusflash.videoplayer01.Resize;
	import com.oxylusflash.videoplayer01.Slider;
	import com.oxylusflash.videoplayer01.ProgressSlide;
	import com.oxylusflash.videoplayer01.CustomContextMenu;
	import com.oxylusflash.videoplayer01.SendMail;
	import com.oxylusflash.videoplayer01.EmbeddedText;
	
	import utils.Utils;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	//}endregion
	
	public class VideoPlayer extends MovieClip
	{
		//{region PUBLIC FIELDS
		public var mcVideoMask : mcVideoPlayerMask;
		public var mcController : MovieClip;
		public var mcVideoHolderHit : MovieClip;
		public var mcBufferToggle : MovieClip;
		public var mcVideo : Video;
		public var mcMiniMenu : MovieClip;
		
		public var Bg : MovieClip;
		public var mcVolumeScrobber : Slider = new Slider();
		public var mcProgressBar : ProgressSlide = new ProgressSlide();
		public var mcSendMail : SendMail = new SendMail();
		public var mcEmbedded : EmbeddedText = new EmbeddedText();
		//}endregion
		
		//{region PRIVATE FIELDS
		//static properties
		private static var INSTANCE : VideoPlayer;
		private var t : Timer = new Timer(2000, 1);
		private var anim : Timer = new Timer(100, 1);
		
		private var url : URLRequest;
		private var xmlLoader : URLLoader;
		private var xml : XML;
		internal var app : VideoPlaybackController;
		private var customContextMenu : CustomContextMenu;

		private var mcTarget : MovieClip;
		private var autoFlag : Boolean = true;
		
		private var loader : Loader;
		private var _componentW : Number;
		private var _componentH : Number;
		private var _embeddedTextWidth : Number;
		private var _embeddedTextHeight : Number;
		private var _sendMailWidth : Number;
		private var _sendMailHeight : Number;
		private var _controllerPosOrder : String;
		private var _controllerPos : String;
		private var _progressBarPosOrder : String;
		private var _progressBarPos : String;
		private var _sendMailPosX : String;
		private var _sendMailPosY : String;
		private var _embeddedTextPosX : String;
		private var _embeddedTextPosY : String;
		private var _bufferPosX : String;
		private var _bufferPosY : String;
		private var _miniMenuPosX : String;
		private var _miniMenuPosY : String;
		private var _videoTitleAutoScroll : Boolean;
		private var _videoTitleScrollSpeed : Number;
		private var _embeddedCode : String;
		private var _mail : String;
		private var _autoPlay : Boolean;
		private var _autoLoad : Boolean;
		private var _repeat : Boolean;
		private var _initialVolume : Number;
		private var _bufferTime : Number;
		private var _videoMode : String;
		private var _videoURL : String;
		private var _videoPrev : String;
		private var _videoName : String;
		private var _link : String;
		private var _target : String;
		private var volPercentage : Number;
		private var check : Number;
		private var animFlag : Boolean = true;
		private var xCheck : Number;
		private var _miniMenuVisible : Boolean;
		private var _errorMessage : String;
		private var _mailMessage : String;
		private var _phpUrl : String;
		private var _emailSubject : String;
		private var _emailFooter : String;
		private var _nickName : String;
		private var _copyMessage : String;
		private var _oR : Number;
		private var _cR : Number;
		private var _oH : Number;
		private var _oW : Number;
		private var _cH : Number;
		private var _cW : Number;
		private var _videoColor : uint;
		private var _picMode : String;
		private var _autoHide : Boolean;
		private var _copyRight : String;
		private var doResize : Resize;
		private var _sendMailTitle : String;
		private var _embeddedCodeTitle : String;
		private var _holdWidth : Number;
		private var _holdHeight : Number;
		//}endregion
		
		//{region CONSTRUCTOR
		public function VideoPlayer() 
		{
			
			ColorShortcuts.init();
			//masking component
			mcVideoMask = new mcVideoPlayerMask();
			stage.addChild(mcVideoMask);
			
			if (INSTANCE) 
			{
				throw new Error("you've tried to make another instance of class VideoPlayer, \n but this class is singleton and singleton classes can't have more then one instance");
			}else 
			{
				INSTANCE = this;
				this.addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		//}endregion
		
		//{region GET INSTANCE
		public static function getInstance():VideoPlayer 
		{
			return INSTANCE;
		}
		//}endregion
		
		//{region INIT
		internal function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			doResize = new Resize();
			
			new Utils();
			
			this.mask = mcVideoMask;
			
			//hiding component
			this.alpha = 0;
			
			//try loading the XML
			loadXML();
		}
		//}endregion
		
		//{region RESET COMPONENT
		private function reset():void
		{
			Tweener.addTween(Bg, { _color: _videoColor, time:0.2, transition:"easeOutBack" } );
			Tweener.addTween(mcVideoHolderHit.Bg, { _color: _videoColor, time:0.2, transition:"easeOutBack" } );
			mcVideoHolderHit.buttonMode = true;
			mcVideoHolderHit.mouseChildren = false;
			mcVideoHolderHit.doubleClickEnabled = true;
			mcVideoHolderHit.alpha = 0;
			mcVideoHolderHit.mcVideoHolderPic.alpha = 0;
			mcVideoHolderHit.Bg.alpha = 0;
			mcVideoHolderHit.mcTxt.visible = false;
			mcVideoHolderHit.mcTxt.alpha = 0;
			mcVideoHolderHit.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcVideoHolderHit.mcTxt.txt.selectable = false;
			mcVideoHolderHit.mcTxt.txt.condenseWhite = true;
			mcVideoHolderHit.mcTxt.txt.textColor = 0xffffff;
			mcVideoHolderHit.mcTxt.txt.multiline = true;
			mcVideoHolderHit.mcTxt.x = mcVideoHolderHit.width / 2 - mcVideoHolderHit.mcTxt.width / 2;
			
			mcBufferToggle.visible = false;
			mcBufferToggle.alpha = 0;
			
			mcBufferToggle.mcBuffer.mcBufferTxt.visible = false;
			mcBufferToggle.mcBuffer.mcBufferTxt.alpha = 0;
			mcBufferToggle.mcBuffer.mcBufferTxt.txt.autoSize = TextFieldAutoSize.CENTER;
			mcBufferToggle.mcBuffer.mcBufferTxt.txt.selectable = false;
			mcBufferToggle.mcBuffer.mcBufferTxt.txt.condenseWhite = true;
			mcBufferToggle.mcBuffer.mcBufferTxt.txt.textColor = 0xffffff;
			
			mcBufferToggle.mcBufferLoader.mcBufferLoaderProgress.visible = false;
			mcBufferToggle.mcBufferLoader.mcBufferLoaderProgress.alpha = 0;
			mcBufferToggle.mcBufferLoader.mcBufferLoaderProgress.width = 0;
			
			mcController.mcPlayPauseToggle.mcPause.buttonMode = true;
			mcController.mcPlayPauseToggle.mcPlay.buttonMode = true;
			mcController.mcFullscreenToggle.mcFullscreenOn.buttonMode = true;
			mcController.mcFullscreenToggle.mcFullscreenOff.buttonMode = true;
			
			mcController.mcVolumeToggle.mcVolumeNormal.buttonMode = true;
			mcController.mcVolumeToggle.mcVolumeOver.buttonMode = true;
			mcController.mcVolumeToggle.mcVolumeMute.buttonMode = true;
			
			//reset component
			mcVideo.alpha = 0;
			
			//bufferProgress
			this.addChild(mcProgressBar);
			mcProgressBar.mcProgressBuffer.visible = false;
			mcProgressBar.mcProgressBuffer.width = 1;
			
			//textFields
			mcProgressBar.mcTotalTime.txt.autoSize = TextFieldAutoSize.CENTER;
			mcProgressBar.mcTotalTime.txt.selectable = false;
			mcProgressBar.mcTotalTime.txt.condenseWhite = true;
			mcProgressBar.mcTotalTime.txt.textColor = 0x505456;;
			mcProgressBar.mcTotalTime.txt.multiline = false;
			mcProgressBar.mcTotalTime.txt.text = "";
			
			
			mcProgressBar.mcCurrentTime.txt.autoSize = TextFieldAutoSize.RIGHT;
			mcProgressBar.mcCurrentTime.txt.selectable = false;
			mcProgressBar.mcCurrentTime.txt.condenseWhite = true;
			mcProgressBar.mcCurrentTime.txt.multiline = false;
			mcProgressBar.mcCurrentTime.txt.textColor = 0x505456;
			mcProgressBar.mcCurrentTime.txt.text = "";
			
			mcProgressBar.mcCurrentTime.buttonMode = true;
			mcProgressBar.mcCurrentTime.mouseChildren = false;
			
			//miniMenu settings
			mcMiniMenu.visible = miniMenuVisible;
			mcMiniMenu.mcMailToggle.mcMailOver.buttonMode = true;
			mcMiniMenu.mcMailToggle.mcMailOver.visible = false;
			mcMiniMenu.mcMailToggle.mcMailOver.alpha = 0;
			mcMiniMenu.mcMailToggle.mcMailNormal.buttonMode = true;
			
			mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver.buttonMode = true;
			mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver.visible = false;
			mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver.alpha = 0;
			mcMiniMenu.mcEmbeddedToggle.mcEmbeddedNormal.buttonMode = true;
			
			//embedded Caption
			this.addChild(mcEmbedded);
			mcEmbedded.visible = false;
			mcEmbedded.alpha = 0;
			
			mcEmbedded.mcCopyStatus.visible = false;
			mcEmbedded.mcCopyStatus.alpha = 0;
			mcEmbedded.mcCopyStatus.txt.autoSize = TextFieldAutoSize.LEFT;
			mcEmbedded.mcCopyStatus.txt.selectable = false;
			mcEmbedded.mcCopyStatus.txt.multiline = false;
			mcEmbedded.mcCopyStatus.txt.textColor = 0xffffff;
			mcEmbedded.mcCopyStatus.txt.text = copyMessage;
			
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.visible = false;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.alpha = 0;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.buttonMode = true;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.mouseChildren = false;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.txt.autoSize = TextFieldAutoSize.CENTER;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.txt.selectable = false;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.txt.multiline = false;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnOver.txt.textColor = 0xBFC4D4;
			
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnNormal.buttonMode = true;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnNormal.mouseChildren = false;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnNormal.txt.autoSize = TextFieldAutoSize.CENTER;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnNormal.txt.selectable = false;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnNormal.txt.multiline = false;
			mcEmbedded.mcToggleEmbeddedCopyBtn.mcEmbeddedCopyBtnNormal.txt.textColor = 0x7C7F81;
			
			mcEmbedded.mcEmbeddedTitle.txt.autoSize = TextFieldAutoSize.LEFT;
			mcEmbedded.mcEmbeddedTitle.txt.selectable = false;
			mcEmbedded.mcEmbeddedTitle.txt.condenseWhite = true;
			mcEmbedded.mcEmbeddedTitle.txt.multiline = false;
			mcEmbedded.mcEmbeddedTitle.txt.textColor = 0xCBCCDA;
			mcEmbedded.mcEmbeddedTitle.txt.text = embeddedCodeTitle;
			
			mcEmbedded.mcToggleEmbeddedClose.mcEmbeddedCloseOver.visible = false;
			mcEmbedded.mcToggleEmbeddedClose.mcEmbeddedCloseOver.alpha = 0;
			mcEmbedded.mcToggleEmbeddedClose.mcEmbeddedCloseOver.buttonMode = true;
			mcEmbedded.mcToggleEmbeddedClose.mcEmbeddedCloseOver.mouseChildren = false;
			
			mcEmbedded.mcToggleEmbeddedClose.mcEmbeddedCloseNormal.buttonMode = true;
			mcEmbedded.mcToggleEmbeddedClose.mcEmbeddedCloseNormal.mouseChildren = false;
			
			mcEmbedded.mcEmbeddedInputTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcEmbedded.mcEmbeddedInputTxt.txt.selectable = true;
			mcEmbedded.mcEmbeddedInputTxt.txt.alwaysShowSelection = true;
			mcEmbedded.mcEmbeddedInputTxt.txt.setSelection(0, mcEmbedded.mcEmbeddedInputTxt.txt.text.length);
			mcEmbedded.mcEmbeddedInputTxt.txt.multiline = true;
			mcEmbedded.mcEmbeddedInputTxt.txt.textColor = 0x030303;
			mcEmbedded.mcEmbeddedInputTxt.txt.text = embeddedCode;
			
			//sendMail Caption
			this.addChild(mcSendMail);
			mcSendMail.visible = false;
			mcSendMail.alpha = 0;

			mcSendMail.mcMailInputTxt.txt.selectable = true;
			mcSendMail.mcMailInputTxt.txt.multiline = false;
			mcSendMail.mcMailInputTxt.txt.textColor = 0x030303;
			mcSendMail.mcMailInputTxt.txt.condenseWhite = true;
			mcSendMail.mcMailInputTxt.txt.text = "";
			
			mcSendMail.mcInvalidMail.visible = false;
			mcSendMail.mcInvalidMail.alpha = 0;
			mcSendMail.mcInvalidMail.txt.autoSize = TextFieldAutoSize.LEFT;
			mcSendMail.mcInvalidMail.txt.selectable = false;
			mcSendMail.mcInvalidMail.txt.multiline = false;
			mcSendMail.mcInvalidMail.txt.textColor = 0xffffff;
			mcSendMail.mcInvalidMail.txt.text = errorMessage;
		
			mcSendMail.mcMailBoxTitle.txt.autoSize = TextFieldAutoSize.LEFT;
			mcSendMail.mcMailBoxTitle.txt.selectable = false;
			mcSendMail.mcMailBoxTitle.txt.condenseWhite = true;
			mcSendMail.mcMailBoxTitle.txt.multiline = false;
			mcSendMail.mcMailBoxTitle.txt.textColor = 0xCBCCDA;
			mcSendMail.mcMailBoxTitle.txt.text = sendMailTitle;
			
			mcSendMail.mcToggleMailClose.mcMailCloseOver.buttonMode = true;
			mcSendMail.mcToggleMailClose.mcMailCloseOver.mouseChildren = false;
			mcSendMail.mcToggleMailClose.mcMailCloseNormal.buttonMode = true;
			mcSendMail.mcToggleMailClose.mcMailCloseNormal.mouseChildren = false;
			
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.buttonMode = true;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.mouseChildren = false;
			
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnNormal.buttonMode = true;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnNormal.mouseChildren = false;
			
			mcSendMail.mcToggleMailClose.mcMailCloseOver.visible = false;
			mcSendMail.mcToggleMailClose.mcMailCloseOver.alpha = 0;
			
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.visible = false;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.alpha = 0;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.txt.autoSize = TextFieldAutoSize.CENTER;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.txt.selectable = false;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.txt.condenseWhite = true;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.txt.multiline = false;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnOver.txt.textColor = 0xBFC4D4;
			
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnNormal.txt.autoSize = TextFieldAutoSize.CENTER;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnNormal.txt.selectable = false;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnNormal.txt.condenseWhite = true;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnNormal.txt.multiline = false;
			mcSendMail.mcToggleMailSendBtn.mcMailSendBtnNormal.txt.textColor = 0x7C7F81;
			
			//controller
			mcController.mcTitle.txt.autoSize = TextFieldAutoSize.LEFT;
			mcController.mcTitle.txt.selectable = false;
			mcController.mcTitle.txt.condenseWhite = true;
			mcController.mcTitle.txt.multiline = false;
			mcController.mcTitle.Bg.alpha = 0;
			
			//controller's btns
			mcController.mcPlayPauseToggle.mcPause.visible = false;
			mcController.mcVolumeToggle.mcVolumeNormal.visible = false;
			mcController.mcVolumeToggle.mcVolumeNormal.alpha = 0;
			mcController.mcVolumeToggle.mcVolumeMute.visible = false;
			mcController.mcVolumeToggle.mcVolumeMute.alpha = 0;
			mcController.mcVolumeToggle.mcVolumeOver.visible = false;
			mcController.mcVolumeToggle.mcVolumeOver.alpha = 0;
			mcController.mcFullscreenToggle.mcFullscreenOff.visible = false;
			
			//volume
			mcVolumeScrobber.visible = false;
			mcVolumeScrobber.alpha = 0;
		}
		//}endregion
		
		//{region LOAD XML
		private function loadXML():void
		{
		
			url = new URLRequest("settings.xml");
			xmlLoader = new URLLoader();
			
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoader_CompleteHandler, false, 0, true);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlLoader_IoError, false, 0, true);
			xmlLoader.load(url);
		}
		//}endregion
		
		//{region PARSING THE XML
		private function xmlLoader_CompleteHandler(e:Event):void 
		{
			xmlLoader.removeEventListener(Event.COMPLETE, xmlLoader_CompleteHandler);
			xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, xmlLoader_IoError);
			
			xml = new XML(xmlLoader.data);
			
			_componentW = Number(xml.settings.width.text());
			_componentH = Number(xml.settings.height.text());
			
			_embeddedTextWidth = Number(xml.settings.embeddedTextWidth.text());
			_embeddedTextHeight = Number(xml.settings.embeddedTextHeight.text());
			
			_sendMailWidth = Number(xml.settings.sendMailWidth.text());
			_sendMailHeight = Number(xml.settings.sendMailHeight.text());
			
			_controllerPosOrder = xml.settings.controllerPosition.@order.toLowerCase();
			_controllerPos = xml.settings.controllerPosition.text().toLowerCase();
			
			_progressBarPosOrder = xml.settings.progressBarPosition.@order.toLowerCase();
			_progressBarPos = xml.settings.progressBarPosition.text().toLowerCase();
			
			_sendMailPosX = xml.settings.sendMailPositionX.text().toLowerCase();
			_sendMailPosY = xml.settings.sendMailPositionY.text().toLowerCase();
			
			_embeddedTextPosX = xml.settings.embeddedTextPositionX.text().toLowerCase();
			_embeddedTextPosY = xml.settings.embeddedTextPositionY.text().toLowerCase();
			
			_bufferPosX = xml.settings.bufferPositionX.text().toLowerCase();
			_bufferPosY = xml.settings.bufferPositionY.text().toLowerCase();
			
			_miniMenuPosX = xml.settings.miniMenuPositionX.text().toLowerCase();
			_miniMenuPosY = xml.settings.miniMenuPositionY.text().toLowerCase();
			
			_videoTitleAutoScroll = xml.settings.videoTitleAutoScroll.text().toLowerCase() == "true";
			_videoTitleScrollSpeed = Number(xml.settings.videoTitleScrollSpeed.text());
			
			_embeddedCode = xml.settings.embeddedCode.text();
			_nickName = xml.settings.nickName.text();
			_mailMessage = xml.settings.mailMessage.text();
			_errorMessage = xml.settings.errorMessage.text();
			_copyMessage = xml.settings.copyMessage.text();
			
			_mail = xml.settings.mail.text();
			_emailSubject = xml.settings.emailSubject.text();
			_emailFooter = xml.settings.emailFooter.text();
			_link = xml.settings.link.text();
			_copyRight = xml.settings.copyRight.text();
			_target = xml.settings.link.text();
			_sendMailTitle = xml.settings.sendMailTitle.text();
			_embeddedCodeTitle = xml.settings.embeddedCodeTitle.text();
			_phpUrl = xml.settings.phpUrl.text();
			
			//video settings
			_autoPlay = xml.settings.autoPlay.text().toLowerCase() == "true";
			_autoLoad = xml.settings.autoLoad.text().toLowerCase() == "true";
			_repeat = xml.settings.repeat.text().toLowerCase() == "true";
			_miniMenuVisible = xml.settings.miniMenuVisible.text().toLowerCase() == "true";
			_autoHide = xml.settings.autoHide.text().toLowerCase() == "true";
			_initialVolume = Number(xml.settings.initialVolume.text());
			_bufferTime = Number(xml.settings.bufferTime.text());
			_videoMode = xml.settings.videoMode.text().toLowerCase();
			_picMode = xml.settings.picMode.text().toLowerCase();
			_videoColor = uint(xml.settings.videoColor.text());
			
			//video SRC
			_videoURL = xml.video.videoURL.text();
			_videoPrev = xml.video.videoPrev.text();
			_videoName = xml.video.videoName.text();
			
			if (initialVolume == 0)
			{
				mcController.mcVolumeToggle.mcVolumeMute.visible = true;
				Tweener.addTween(mcController.mcVolumeToggle.mcVolumeMute, {alpha:1, time: .3, transition:"easeOutElastic"});
			}
			
			customContextMenu = new CustomContextMenu();
			
			populateTextFields();
			reset();
			startApp();
			
			mcController.addChild(mcVolumeScrobber);
			mcVolumeScrobber.percentage = initialVolume;
			muteNormal();
			
			doResize.checkSize(false);
			
			doResize.resize();
		}
		//}endregion
		
		//{region START APPLICATION
		private function startApp():void
		{
			//addEventListeners
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler, false, 0, true);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, fullscreenHandler, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mcVideoHolderHit_MouseMoveHandler, false, 0, true);
			if (_autoHide) 
			{
				stage.addEventListener(Event.MOUSE_LEAVE, rollOutHandler, false, 0, true);
				mcVideoMask.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
			}
			mcVideoHolderHit.addEventListener(MouseEvent.CLICK, playPause_ClickHandler, false, 0, true);
			mcVideoHolderHit.addEventListener(MouseEvent.DOUBLE_CLICK, toggleFullscreen_DoubleClickHandler, false, 0, true);
			mcVideoHolderHit.addEventListener(MouseEvent.MOUSE_UP, mcVidHolderHit_MouseUpHandler, false, 0, true);
			
			mcController.mcPlayPauseToggle.mcPause.addEventListener(MouseEvent.CLICK, playPause_ClickHandler, false, 0, true);
			mcController.mcPlayPauseToggle.mcPlay.addEventListener(MouseEvent.CLICK, playPause_ClickHandler, false, 0, true);
			
			mcController.mcVolumeToggle.mcVolumeNormal.addEventListener(MouseEvent.ROLL_OVER, volNormal_RollOverHandler, false, 0, true);
			
			mcController.mcVolumeToggle.mcVolumeOver.addEventListener(MouseEvent.ROLL_OVER, volOver_RollOverHandler, false, 0, true);
			mcController.mcVolumeToggle.mcVolumeOver.addEventListener(MouseEvent.MOUSE_WHEEL, vol_MouseWheelHandler, false, 0, true);
			mcController.mcVolumeToggle.mcVolumeOver.addEventListener(MouseEvent.CLICK, volOver_ClickHandler, false, 0, true);
			mcController.mcVolumeToggle.mcVolumeOver.addEventListener(MouseEvent.ROLL_OUT, volOver_RollOutHandler, false, 0, true);
			
			mcController.mcVolumeToggle.mcVolumeMute.addEventListener(MouseEvent.ROLL_OVER, volMute_RollOverHandler, false, 0, true);
			mcController.mcVolumeToggle.mcVolumeMute.addEventListener(MouseEvent.MOUSE_WHEEL, vol_MouseWheelHandler , false, 0, true);
			mcController.mcVolumeToggle.mcVolumeMute.addEventListener(MouseEvent.CLICK, volMute_ClickHandler, false, 0, true);
			mcController.mcVolumeToggle.mcVolumeMute.addEventListener(MouseEvent.ROLL_OUT, volMute_RollOutHandler, false, 0, true);
				
			mcController.mcFullscreenToggle.mcFullscreenOn.addEventListener(MouseEvent.ROLL_OVER, fullscreenOn_rollOverHandler, false, 0, true);
			mcController.mcFullscreenToggle.mcFullscreenOn.addEventListener(MouseEvent.CLICK, fullscreenOn_ClickHandler, false, 0, true);
			mcController.mcFullscreenToggle.mcFullscreenOn.addEventListener(MouseEvent.ROLL_OUT, fullscreenOn_rollOutHandler, false, 0, true);
			
			mcController.mcFullscreenToggle.mcFullscreenOff.addEventListener(MouseEvent.ROLL_OVER, fullscreenOff_rollOverHandler, false, 0, true);
			mcController.mcFullscreenToggle.mcFullscreenOff.addEventListener(MouseEvent.CLICK, fullscreenOff_ClickHandler, false, 0, true);
			mcController.mcFullscreenToggle.mcFullscreenOff.addEventListener(MouseEvent.ROLL_OUT, fullscreenOff_rollOutHandler, false, 0, true);
			//MINI MENU MAIL
			mcMiniMenu.mcMailToggle.mcMailNormal.addEventListener(MouseEvent.ROLL_OVER, mailNormal_RollOverHandler, false, 0, true);
			
			mcMiniMenu.mcMailToggle.mcMailOver.addEventListener(MouseEvent.CLICK, mailOver_ClickHandler, false, 0, true);
			mcMiniMenu.mcMailToggle.mcMailOver.addEventListener(MouseEvent.ROLL_OUT, mailOver_RollOutHandler, false, 0, true);
			
			//MINI MENU EMBEDDED
			mcMiniMenu.mcEmbeddedToggle.mcEmbeddedNormal.addEventListener(MouseEvent.ROLL_OVER, embeddedNormal_RollOverHandler, false, 0, true);
			
			mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver.addEventListener(MouseEvent.CLICK, embeddedOver_ClickHandler, false, 0, true);
			mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver.addEventListener(MouseEvent.ROLL_OUT, embeddedOver_RollOutHandler, false, 0, true);
			
			//Video
			app = new VideoPlaybackController(mcVideo);
			app.addEventListener(PlaybackEvent.BUFFERING, app_BufferingHandler, false, 0, true);
			app.addEventListener(PlaybackEvent.BUFFER_PROGRESS, app_BufferProgressHandler, false, 0, true);
			app.addEventListener(PlaybackEvent.BUFFER_FULL, app_BufferFullHandler, false, 0, true);
			app.addEventListener(PlaybackEvent.LOAD_PROGRESS, app_LoadProgress, false, 0, true);
			app.addEventListener(PlaybackEvent.PLAYBACK_READY, app_PlaybackReadyHandler, false, 0, true);
			app.addEventListener(PlaybackEvent.PLAYBACK_TIME_UPDATE, app_PlaybackTimeUpdateHandler, false, 0, true);
			app.addEventListener(PlaybackEvent.ERROR, app_ErrorHandler, false, 0, true);
			
			app.volume = initialVolume;
			app.autoPlay = autoPlay;
			app.repeat = repeat;
			
			if (!autoPlay && autoFlag) 
			{
				var url : URLRequest = new URLRequest(_videoPrev);
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_CompleteHandler, false, 0, true);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_IoError, false, 0, true);
				loader.load(url);
				autoLoad = true;
			}
			
			if (autoLoad || autoPlay) 
			{
				app.load(videoURL);
					
				if (autoPlay) 
				{
				togglePlayPause();
				}
			}
			animateTitle();
		}
		
		private function loader_CompleteHandler(e:Event):void 
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_CompleteHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_IoError);
			
			mcVideoHolderHit.mcVideoHolderPic.alpha = 1;
			
			mcVideoHolderHit.Bg.alpha = 1;
			
			mcVideoHolderHit.alpha = 1;
			
			var bd : BitmapData = new BitmapData(loader.content.width, loader.content.height, true, 0x000000);
			bd.draw(loader.content);
		
			var bmp : Bitmap = new Bitmap(bd);
			
			bmp.smoothing = true;
			
			bmp.x = 0;
			bmp.y = 0;
			
			holdWidth = bmp.width;
			holdHeight = bmp.height;
			
			mcVideoHolderHit.mcVideoHolderPic.addChild(bmp);
			
			picModeFun();
		}
		
		private function loader_IoError(e:IOErrorEvent):void 
		{
			trace("Loader error", e.toString());
		}
		//}endregion
		
		//{region POPULATE TEXTFIELDS
		private function populateTextFields():void
		{
			//movie title
			mcController.mcTitle.txt.text = videoName;
			mcController.mcTitle.Bg.width = mcController.mcTitle.txt.textWidth;
			mcController.mcTitle.Bg.height = mcController.mcTitle.txt.textHeight;
			mcController.mcTitleMask.height = mcController.mcTitle.Bg.height;
		}
		//}endregion
		
		//{region TOGGLEFULLSCREEN
		internal function toggleFullscreen():void 
		{
			if (stage.displayState == StageDisplayState.NORMAL) 
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
				if (mcSendMail.visible) 
				{
					mcSendMail.close();
				}
				if (mcEmbedded.visible) 
				{
					mcEmbedded.close();
				}
				t.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer, false, 0, true);
			}else 
			{
				stage.displayState = StageDisplayState.NORMAL;
				t.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			}
		}
		//}endregion
		
		//{region CHECKFULLSCREENBTN
		internal function checkFullscreenBtn():void
		{
			if (mcController.mcFullscreenToggle.mcFullscreenOn.visible)
			{
				mcController.mcFullscreenToggle.mcFullscreenOn.visible = false;
				mcController.mcFullscreenToggle.mcFullscreenOff.visible = true;
				customContextMenu.fullscreen.caption = "Exit Fullscreen";
			}else 
			{
				mcController.mcFullscreenToggle.mcFullscreenOn.visible = true;
				mcController.mcFullscreenToggle.mcFullscreenOff.visible = false;
				customContextMenu.fullscreen.caption = "Fullscreen";
				showController();
			}
		}
		//}endregion

		//{region ANIMATE TITLE & HIDE VOLUME WHEN RELEASE OUTSIDE
		private function animateTitle():void
		{
			anim.removeEventListener(TimerEvent.TIMER_COMPLETE, timerAnimate);
			anim.addEventListener(TimerEvent.TIMER_COMPLETE, timerAnimate, false, 0, true);
			
			if (mcVolumeScrobber.drag && mcVolumeScrobber.rollOut) 
			{
				mcVolumeScrobber.rollOut = false;
				mcVolumeScrobber.toggleScrobber(false);
			}
			
			if (mcController.mcTitleMask.width < mcController.mcTitle.Bg.width && videoTitleAutoScroll) 
			{				
				check = 2 * (Math.round(mcController.mcTitle.Bg.width - mcController.mcTitleMask.width));
				
				if (check >  Math.round(mcController.mcTitleMask.x - mcController.mcTitle.x) && animFlag)
				{
					mcController.mcTitle.x -= videoTitleScrollSpeed;
					
					xCheck = Math.round(mcController.mcTitleMask.x - mcController.mcTitle.x);
					
					if (check == xCheck) 
					{
						animFlag = false;
					}
				}else 
				{
					mcController.mcTitle.x = mcController.mcTitleMask.width;
					animFlag = true;
				}
			}else 
			{
				Tweener.addTween(mcController.mcTitle, { x:mcController.mcTitleMask.x, time:1, transition:"easeOutBack" } );
			}
			anim.reset();
			anim.start();
		}
		//}endregion
		
		//{region TOGGLEPLAYPAUSE
		internal function togglePlayPause():void 
		{
			if (mcController.mcPlayPauseToggle.mcPlay.visible) 
			{
				mcController.mcPlayPauseToggle.mcPlay.visible = false;
				mcController.mcPlayPauseToggle.mcPause.visible = true;
				if (autoLoad && !autoPlay && autoFlag) 
				{
					mcVideoHolderHit.alpha = 0;
					autoFlag = false;
				}
				if (mcVideo.alpha == 0) 
				{
					mcVideo.alpha = 1;
					//doResize.resize();
				}
				app.play();
			}else 
			{
				mcController.mcPlayPauseToggle.mcPlay.visible = true;
				mcController.mcPlayPauseToggle.mcPause.visible = false;
				app.pause();
			}
		}
		//}endregion
		
		//{region TOGGLEVOLUME
		internal function toggleVolume(state:String):void 
		{
			switch (state) 
			{
				case "MUTE":
				mcController.mcVolumeToggle.mcVolumeMute.visible = true; 
				mcController.mcVolumeToggle.mcVolumeMute.alpha = 1;
				mcController.mcVolumeToggle.mcVolumeNormal.visible = false;
				mcController.mcVolumeToggle.mcVolumeNormal.alpha = 0;
				mcController.mcVolumeToggle.mcVolumeOver.visible = false;
				mcController.mcVolumeToggle.mcVolumeOver.alpha = 0;
				
				break;
				case "NORMAL":
				mcController.mcVolumeToggle.mcVolumeNormal.visible = true;
				mcController.mcVolumeToggle.mcVolumeNormal.alpha = 1;
				mcController.mcVolumeToggle.mcVolumeOver.visible = false;
				mcController.mcVolumeToggle.mcVolumeOver.alpha = 0;
				mcController.mcVolumeToggle.mcVolumeMute.visible = false; 
				mcController.mcVolumeToggle.mcVolumeMute.alpha = 0;
				
				break;
				case "OVER":
				mcController.mcVolumeToggle.mcVolumeOver.visible = true;
				mcController.mcVolumeToggle.mcVolumeOver.alpha = 1;
				mcController.mcVolumeToggle.mcVolumeNormal.visible = false;
				mcController.mcVolumeToggle.mcVolumeNormal.alpha = 0;
				mcController.mcVolumeToggle.mcVolumeMute.visible = false; 
				mcController.mcVolumeToggle.mcVolumeMute.alpha = 0;
				break;
			}
		}
		//}endregion
		
		//{region MUTE/NORMAL/OVER
		internal function muteNormal():void 
		{
			if (mcVolumeScrobber.percentage == 0) 
			{
				toggleVolume("MUTE");
			}else 
			{
				toggleVolume("NORMAL");
			}
		}
		internal function muteOver():void 
		{
			if (mcVolumeScrobber.percentage == 0) 
			{
				toggleVolume("MUTE");
			}else 
			{
				toggleVolume("OVER");
			}
		}
		//}endregion
		
		//{region SHOWCONTROLLER
		private function showController():void 
		{
			mcMiniMenu.alpha = 1;
			mcController.alpha = 1;
			mcProgressBar.alpha = 1;
		}
		//}endregion
		
		//{region HIDECONTROLLER
		private function hideController():void 
		{
			mcMiniMenu.alpha = 0;
			mcController.alpha = 0;
			mcProgressBar.alpha = 0;
		}
		//}endregion
		
		//{region UPDATE VIDEO MODE
		internal function updateVideoMode(cW:Number, cH:Number):void 
		{
			this.cW =  cW;
			this.cH =  cH;

			oW = app.originalVideoWidth;
			oH = app.originalVideoHeight;
			cR = this.cW / this.cH;
			oR = oW / oH;
			
			videoModeFun();
			if (mcVideoHolderHit.alpha == 1) 
			{
				picModeFun();
			}
		}
		//}endregion
		
		//{region PICTURE MODE
		internal function picModeFun():void
		{		
			switch (picMode) 
			{
				case "original":
				mcVideoHolderHit.mcVideoHolderPic.x = 0;
				mcVideoHolderHit.mcVideoHolderPic.y = 0;
				
				mcVideoHolderHit.mcVideoHolderPic.width = holdWidth;
				mcVideoHolderHit.mcVideoHolderPic.height = holdHeight;
				
				if (mcVideoHolderHit.mcVideoHolderPic.width < cW) 
				{
					mcVideoHolderHit.mcVideoHolderPic.x = cW / 2 - mcVideoHolderHit.mcVideoHolderPic.width / 2;
				}
				if (mcVideoHolderHit.mcVideoHolderPic.height < cH)
				{
					mcVideoHolderHit.mcVideoHolderPic.y = cH / 2 - mcVideoHolderHit.mcVideoHolderPic.height / 2;
				}
				break;
				
				case "stretch":
				mcVideoHolderHit.mcVideoHolderPic.x = 0;
				mcVideoHolderHit.mcVideoHolderPic.y = 0;
				mcVideoHolderHit.mcVideoHolderPic.width = cW;
				mcVideoHolderHit.mcVideoHolderPic.height = cH;
				break;
				
				case "fittosize":			
				mcVideoHolderHit.mcVideoHolderPic.x = 0;
				mcVideoHolderHit.mcVideoHolderPic.y = 0;
				
				mcVideoHolderHit.mcVideoHolderPic.fitToSize(cW, cH, true);
				
				if (mcVideoHolderHit.mcVideoHolderPic.width < cW) 
				{
					mcVideoHolderHit.mcVideoHolderPic.x = cW / 2 - mcVideoHolderHit.mcVideoHolderPic.width / 2;
				}

				if (mcVideoHolderHit.mcVideoHolderPic.height < cH)
				{
					mcVideoHolderHit.mcVideoHolderPic.y = cH / 2 - mcVideoHolderHit.mcVideoHolderPic.height / 2;
				}
				break;
				
				case "fittofill":
				mcVideoHolderHit.mcVideoHolderPic.x = 0;
				mcVideoHolderHit.mcVideoHolderPic.y = 0;
				
				mcVideoHolderHit.mcVideoHolderPic.fitToSize(cW, cH, false);
				break;
			}
		}
		//}endregion
		
		//{region VIDEO MODE
		internal function videoModeFun():void 
		{
			switch (videoMode) 
			{ 
				case "original" :
				
				mcVideo.width = oW;
				mcVideo.height = oH;
				
				mcVideo.y = 0;
				mcVideo.x = 0;
				
				if (mcVideo.height < cH) 
				{
					mcVideo.y = cH / 2 - mcVideo.height / 2;
				}
				if (mcVideo.width < cW) 
				{
					mcVideo.x = cW / 2 - mcVideo.width / 2;
				}
				break;
				
				case "stretch" :
				
				mcVideo.y = 0;
				mcVideo.x = 0;
				
				mcVideo.width = cW;
				mcVideo.height = cH;
				break;
				
				case "fittosize" :
				
				mcVideo.y = 0;
				mcVideo.x = 0;
				
				if (oR > cR) 
				{
					mcVideo.width = cW;
					mcVideo.height = mcVideo.width / oR;
				}else 
				{
					mcVideo.height = cH;
					mcVideo.width = mcVideo.height * oR;
				}
				if (mcVideo.height < cH) 
				{
					mcVideo.y = cH / 2 - mcVideo.height / 2;
				}
				if (mcVideo.width < cW) 
				{
					mcVideo.x = cW / 2 - mcVideo.width / 2;
				}
				break;
				
				case "fittofill" :
				
				mcVideo.y = 0;
				mcVideo.x = 0;
				
				if (oR < cR) 
				{
					mcVideo.width = cW;
					mcVideo.height = mcVideo.width / oR;
				}else 
				{
					mcVideo.height = cH;
					mcVideo.width = mcVideo.height * oR;
				}
				break;
				
				default:
				
				mcVideo.y = 0;
				mcVideo.x = 0;
				
				mcVideo.width = cW;
				mcVideo.height = cH;
				break;
			}
		}
		//}endregion
		
		//{region EVENT HANDLERS
		
		//{region VIDEO EVENT HANDLERS
		private function app_BufferingHandler(e:PlaybackEvent):void 
		{
			mcBufferToggle.visible = true;
			Tweener.addTween(mcBufferToggle, {alpha:1, time:.3, transition:"easeOutBack"});
		}
		
		private function app_BufferFullHandler(e:PlaybackEvent):void 
		{
			Tweener.addTween(mcBufferToggle.mcBuffer.mcBufferTxt, { alpha:0, time: .3, transition:"easeOutQuint", onComplete: function ():void 
			{
				mcBufferToggle.mcBuffer.mcBufferTxt.visible = false;
			} } );
			
			
			Tweener.addTween(mcBufferToggle.mcBufferLoader.mcBufferLoaderProgress, {alpha:0, time: .3, transition:"easeOutQuint", onComplete: function ():void 
			{
				mcBufferToggle.mcBufferLoader.mcBufferLoaderProgress.visible = false;
			}});
			
			Tweener.addTween(mcBufferToggle, {alpha:0, time:.3, transition:"easeOutBack", onComplete: function ():void 
			{
				mcBufferToggle.visible = false;
			}});
		}
		
		private function app_BufferProgressHandler(e:PlaybackEvent):void 
		{
			//text Part
			mcBufferToggle.mcBuffer.mcBufferTxt.visible = true;
			mcBufferToggle.mcBuffer.mcBufferTxt.txt.text = String(Math.floor(e.info.progress * 100)) + "%";
			mcBufferToggle.mcBuffer.mcBufferTxt.Bg.width = mcBufferToggle.mcBuffer.mcBufferTxt.txt.textWidth;
			mcBufferToggle.mcBuffer.mcBufferTxt.Bg.height = mcBufferToggle.mcBuffer.mcBufferTxt.txt.textHeight;
			Tweener.addTween(mcBufferToggle.mcBuffer.mcBufferTxt, { alpha:1, time: .3, transition:"easeOutQuint" } );
			
			//grafic Part
			mcBufferToggle.mcBufferLoader.mcBufferLoaderProgress.visible = true;
			Tweener.addTween(mcBufferToggle.mcBufferLoader.mcBufferLoaderProgress, {alpha:1, time: .3, transition:"easeOutQuint"});
			mcBufferToggle.mcBufferLoader.mcBufferLoaderProgress.width = e.info.progress * (mcBufferToggle.mcBufferLoader.Bg.width - 6);
		}
		
		private function app_LoadProgress(e:PlaybackEvent):void 
		{
			mcProgressBar.mcProgressBuffer.visible = true;
			mcProgressBar.mcProgressBuffer.width = e.info.loadedBytes / e.info.totalBytes * (mcProgressBar.Bg.width - (mcProgressBar.mcTotalTime.Bg.width + mcProgressBar.mcCurrentTime.Bg.width));// + Resize.btnPadding));
		}
		
		private function app_PlaybackReadyHandler(e:PlaybackEvent):void 
		{
			var newW : Number = (componentW == 0)? stage.stageWidth : componentW;
			var newH : Number = (componentH == 0)? stage.stageHeight : componentH;
			updateVideoMode(newW, newH);
			mcVideo.smoothing = true;
		}
		
		private function app_PlaybackTimeUpdateHandler(e:PlaybackEvent):void 
		{
			mcProgressBar.mcCurrentTime.txt.text = e.info.currentTimeString;
			mcProgressBar.mcTotalTime.txt.text = e.info.totalTimeString;
			
			if (ProgressSlide.megaFlag) 
			{
				mcProgressBar.percentage = app.currentTime / app.totalTime;
			}else 
			{
				app.pause();
				mcController.mcPlayPauseToggle.mcPlay.visible = true;
				mcController.mcPlayPauseToggle.mcPause.visible = false;
				app.seek(mcProgressBar.percentage, true);
				if (mcVideo.alpha == 0) 
				{
					mcVideo.alpha = 1;
				}
			}
			if (mcProgressBar.percentage == 1 && !repeat)
			{
				mcController.mcPlayPauseToggle.mcPlay.visible = true;
				mcController.mcPlayPauseToggle.mcPause.visible = false;
			}
		}
		
		private function mcVideoHolderHit_MouseMoveHandler(e:MouseEvent):void 
		{
			Mouse.show();
			showController();
			t.reset();
			t.start();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			Mouse.hide();
			hideController();
		}
		
		private function app_ErrorHandler(e:PlaybackEvent):void 
		{
			mcVideoHolderHit.alpha = 1;
			mcVideoHolderHit.buttonMode = false;
			mcVideoHolderHit.mcTxt.txt.text = "Couldn't load the movieclip...";
			mcVideoHolderHit.mcTxt.Bg.width = mcVideoHolderHit.mcTxt.txt.textWidth;
			mcVideoHolderHit.mcTxt.Bg.height = mcVideoHolderHit.mcTxt.txt.textWidth;
			mcVideoHolderHit.mcTxt.visible = true;
			mcVideoHolderHit.mcTxt.alpha = 1;
			mcProgressBar.visible = false;
			mcController.visible = false;
		}
		
		private function timerAnimate(e:TimerEvent):void 
		{
			animateTitle();
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			showController();
		}
		
		private function rollOutHandler(e:Event):void 
		{
			hideController();
		}
		
		//}endregion
		
		//{region PLAYER CONTROLLER EVENT HANDLERS
		private function playPause_ClickHandler(e:MouseEvent):void 
		{
			mcTarget = e.target as MovieClip;
			
			switch (mcTarget.name) 
			{
				case "playBg":
					togglePlayPause();
				break;
				case "pauseBg":
					togglePlayPause();
				break;
				case "mcVideoHolderHit":
					togglePlayPause();
				break;
			}
		}
	
		private function volNormal_RollOverHandler(e:MouseEvent):void 
		{
			toggleVolume("OVER");
		}
		
		private function volOver_RollOverHandler(e:MouseEvent):void 
		{
			mcVolumeScrobber.toggleScrobber(true);
		}
		
		private function vol_MouseWheelHandler(e:MouseEvent):void 
		{
			volPercentage = mcVolumeScrobber.percentage += 0.05 * e.delta;	
			
			muteOver();
		}
		
		private function volOver_ClickHandler(e:MouseEvent):void 
		{
			volPercentage = mcVolumeScrobber.percentage;
			mcVolumeScrobber.percentage = 0;
			muteNormal();
		}
		
		private function volOver_RollOutHandler(e:MouseEvent):void 
		{
			mcVolumeScrobber.toggleScrobber(false);
			muteNormal();
		}
		
		private function volMute_RollOverHandler(e:MouseEvent):void 
		{
			mcVolumeScrobber.toggleScrobber(true);
			muteNormal();
		}
		
		private function volMute_ClickHandler(e:MouseEvent):void 
		{
			mcVolumeScrobber.percentage = volPercentage;
			toggleVolume("OVER");
		}
		
		private function volMute_RollOutHandler(e:MouseEvent):void 
		{
			mcVolumeScrobber.toggleScrobber(false);
			muteNormal();
		}

		private function keyUpHandler(e:KeyboardEvent):void 
		{
			switch (e.keyCode) 
			{
				case  Keyboard.SPACE:
				togglePlayPause();
				if (mcController.mcPlayPauseToggle.mcPlay.visible) 
				{
					showController();
				}else 
				{
					if (stage.displayState == StageDisplayState.FULL_SCREEN) 
					{
						hideController();
					}
				}
				break;
				case Keyboard.ENTER:
				if (mcSendMail.visible) 
				{
					mcSendMail.send();
				}
				break;
			}
		}

		private function fullscreenOn_rollOverHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcController.mcFullscreenToggle.mcFullscreenOn, {alpha: .90, time: .3, transition:"easeOutBack"});
		}
		
		private function fullscreenOn_ClickHandler(e:MouseEvent):void 
		{
			toggleFullscreen();
		}

		private function fullscreenOn_rollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcController.mcFullscreenToggle.mcFullscreenOn, {alpha: 1, time: .3, transition:"easeOutBack"});
		}

		private function fullscreenOff_rollOverHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcController.mcFullscreenToggle.mcFullscreenOff, {alpha: .90, time: .3, transition:"easeOutBack"});
		}
		
		private function fullscreenOff_ClickHandler(e:MouseEvent):void 
		{
			toggleFullscreen();
		}
		
		private function fullscreenOff_rollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcController.mcFullscreenToggle.mcFullscreenOff, {alpha: 1, time: .3, transition:"easeOutBack"});
		}
		
		private function fullscreenHandler(e:FullScreenEvent):void 
		{
			if (!mcController.mcFullscreenToggle.mcFullscreenOn.visible) 
			{
				t.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
				Mouse.show();
			}
			checkFullscreenBtn();
		}
		
		private function mailNormal_RollOverHandler(e:MouseEvent):void 
		{
			mcMiniMenu.mcMailToggle.mcMailOver.visible = true;
			Tweener.addTween(mcMiniMenu.mcMailToggle.mcMailOver, { alpha:1, time:.3, transition:"easeOutBack"} );
		}
		
		private function mailOver_ClickHandler(e:MouseEvent):void 
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN) 
			{
				toggleFullscreen();
				stage.focus = mcSendMail.mcMailInputTxt.txt;
			}
			
			if (mcEmbedded.visible) 
			{
				mcEmbedded.close();
				mcSendMail.close();
			}else 
			{
				mcSendMail.close();
			}
		}
		
		private function mailOver_RollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcMiniMenu.mcMailToggle.mcMailOver, {alpha:0, time:.3, transition:"easeOutBack", onComplete: function ():void 
			{
				mcMiniMenu.mcMailToggle.mcMailOver.visible = false;
			}});
		}
		
		private function embeddedNormal_RollOverHandler(e:MouseEvent):void 
		{
			mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver.visible = true;
			Tweener.addTween(mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver, { alpha:1, time:.3, transition:"easeOutBack"} );
		}
		
		private function embeddedOver_ClickHandler(e:MouseEvent):void 
		{
			if (mcSendMail.visible) 
			{
				mcSendMail.close();
				mcEmbedded.close();
			}else 
			{
				mcEmbedded.close();
			}
		}
		
		private function embeddedOver_RollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver, {alpha:0, time:.3, transition:"easeOutBack", onComplete: function ():void 
			{
				mcMiniMenu.mcEmbeddedToggle.mcEmbeddedOver.visible = false;
			}});
		}
		
		private function toggleFullscreen_DoubleClickHandler(e:MouseEvent):void 
		{
			toggleFullscreen();
			togglePlayPause();
		}
		
		private function mcVidHolderHit_MouseUpHandler(e:MouseEvent):void 
		{
			mcVolumeScrobber.toggleScrobber(false);
		}
		//}endregion
		
		private function xmlLoader_IoError(e:IOErrorEvent):void 
		{
			trace("XML Error \n", e.toString());
		}
		//}endregion
		
		//{region PROPERTIES
		public function get componentW():Number { return _componentW; }
		
		public function set componentW(value:Number):void 
		{
			_componentW = value;
		}
		
		public function get componentH():Number { return _componentH; }
		
		public function set componentH(value:Number):void 
		{
			_componentH = value;
		}
		
		public function get embeddedTextWidth():Number { return _embeddedTextWidth; }
		
		public function set embeddedTextWidth(value:Number):void 
		{
			_embeddedTextWidth = value;
		}
		
		public function get embeddedTextHeight():Number { return _embeddedTextHeight; }
		
		public function set embeddedTextHeight(value:Number):void 
		{
			_embeddedTextHeight = value;
		}
		
		public function get sendMailWidth():Number { return _sendMailWidth; }
		
		public function set sendMailWidth(value:Number):void 
		{
			_sendMailWidth = value;
		}
		
		public function get sendMailHeight():Number { return _sendMailHeight; }
		
		public function set sendMailHeight(value:Number):void 
		{
			_sendMailHeight = value;
		}
		
		public function get controllerPosOrder():String { return _controllerPosOrder; }
		
		public function set controllerPosOrder(value:String):void 
		{
			_controllerPosOrder = value;
		}
		
		public function get controllerPos():String { return _controllerPos; }
		
		public function set controllerPos(value:String):void 
		{
			_controllerPos = value;
		}
		
		public function get progressBarPosOrder():String { return _progressBarPosOrder; }
		
		public function set progressBarPosOrder(value:String):void 
		{
			_progressBarPosOrder = value;
		}
		
		public function get progressBarPos():String { return _progressBarPos; }
		
		public function set progressBarPos(value:String):void 
		{
			_progressBarPos = value;
		}
		
		public function get sendMailPosX():String { return _sendMailPosX; }
		
		public function set sendMailPosX(value:String):void 
		{
			_sendMailPosX = value;
		}
		
		public function get sendMailPosY():String { return _sendMailPosY; }
		
		public function set sendMailPosY(value:String):void 
		{
			_sendMailPosY = value;
		}
		
		public function get embeddedTextPosX():String { return _embeddedTextPosX; }
		
		public function set embeddedTextPosX(value:String):void 
		{
			_embeddedTextPosX = value;
		}
		
		public function get embeddedTextPosY():String { return _embeddedTextPosY; }
		
		public function set embeddedTextPosY(value:String):void 
		{
			_embeddedTextPosY = value;
		}
		
		public function get bufferPosX():String { return _bufferPosX; }
		
		public function set bufferPosX(value:String):void 
		{
			_bufferPosX = value;
		}
		
		public function get bufferPosY():String { return _bufferPosY; }
		
		public function set bufferPosY(value:String):void 
		{
			_bufferPosY = value;
		}
		
		public function get miniMenuPosX():String { return _miniMenuPosX; }
		
		public function set miniMenuPosX(value:String):void 
		{
			_miniMenuPosX = value;
		}
		
		public function get miniMenuPosY():String { return _miniMenuPosY; }
		
		public function set miniMenuPosY(value:String):void 
		{
			_miniMenuPosY = value;
		}
		
		public function get videoTitleAutoScroll():Boolean { return _videoTitleAutoScroll; }
		
		public function set videoTitleAutoScroll(value:Boolean):void 
		{
			_videoTitleAutoScroll = value;
		}
		
		public function get embeddedCode():String { return _embeddedCode; }
		
		public function set embeddedCode(value:String):void 
		{
			_embeddedCode = value;
		}
		
		public function get mail():String { return _mail; }
		
		public function set mail(value:String):void 
		{
			_mail = value;
		}
		
		public function get autoPlay():Boolean { return _autoPlay; }
		
		public function set autoPlay(value:Boolean):void 
		{
			_autoPlay = value;
		}
		
		public function get autoLoad():Boolean { return _autoLoad; }
		
		public function set autoLoad(value:Boolean):void 
		{
			_autoLoad = value;
		}
		
		public function get repeat():Boolean { return _repeat; }
		
		public function set repeat(value:Boolean):void 
		{
			_repeat = value;
		}
		
		public function get initialVolume():Number { return _initialVolume; }
		
		public function set initialVolume(value:Number):void 
		{
			_initialVolume = value;
		}
		
		public function get bufferTime():Number { return _bufferTime; }
		
		public function set bufferTime(value:Number):void 
		{
			_bufferTime = value;
		}
		
		public function get videoMode():String { return _videoMode; }
		
		public function set videoMode(value:String):void 
		{
			_videoMode = value;
		}
		
		public function get videoURL():String { return _videoURL; }
		
		public function set videoURL(value:String):void 
		{
			_videoURL = value;
		}
		
		public function get videoPrev():String { return _videoPrev; }
		
		public function set videoPrev(value:String):void 
		{
			_videoPrev = value;
		}
		
		public function get videoName():String { return _videoName; }
		
		public function set videoName(value:String):void 
		{
			_videoName = value;
		}
		
		public function get link():String { return _link; }
		
		public function set link(value:String):void 
		{
			_link = value;
		}
		
		public function get target():String { return _target; }
		
		public function set target(value:String):void 
		{
			_target = value;
		}
		
		public function get miniMenuVisible():Boolean { return _miniMenuVisible; }
		
		public function set miniMenuVisible(value:Boolean):void 
		{
			_miniMenuVisible = value;
		}
		
		public function get errorMessage():String { return _errorMessage; }
		
		public function set errorMessage(value:String):void 
		{
			_errorMessage = value;
		}
		
		public function get mailMessage():String { return _mailMessage; }
		
		public function set mailMessage(value:String):void 
		{
			_mailMessage = value;
		}
		
		public function get phpUrl():String { return _phpUrl; }
		
		public function set phpUrl(value:String):void 
		{
			_phpUrl = value;
		}
		
		public function get emailSubject():String { return _emailSubject; }
		
		public function set emailSubject(value:String):void 
		{
			_emailSubject = value;
		}
		
		public function get emailFooter():String { return _emailFooter; }
		
		public function set emailFooter(value:String):void 
		{
			_emailFooter = value;
		}
		
		public function get nickName():String { return _nickName; }
		
		public function set nickName(value:String):void 
		{
			_nickName = value;
		}
		
		public function get copyMessage():String { return _copyMessage; }
		
		public function set copyMessage(value:String):void 
		{
			_copyMessage = value;
		}
		
		public function get cR():Number { return _cR; }
		
		public function set cR(value:Number):void 
		{
			_cR = value;
		}
		
		public function get oR():Number { return _oR; }
		
		public function set oR(value:Number):void 
		{
			_oR = value;
		}
		
		public function get oH():Number { return _oH; }
		
		public function set oH(value:Number):void 
		{
			_oH = value;
		}
		
		public function get oW():Number { return _oW; }
		
		public function set oW(value:Number):void 
		{
			_oW = value;
		}
		
		public function get cH():Number { return _cH; }
		
		public function set cH(value:Number):void 
		{
			_cH = value;
		}
		
		public function get cW():Number { return _cW; }
		
		public function set cW(value:Number):void 
		{
			_cW = value;
		}
		
		public function get videoColor():uint { return _videoColor; }
		
		public function set videoColor(value:uint):void 
		{
			_videoColor = value;
		}
		
		public function get picMode():String { return _picMode; }
		
		public function set picMode(value:String):void 
		{
			_picMode = value;
		}
		
		public function get videoTitleScrollSpeed():Number { return _videoTitleScrollSpeed; }
		
		public function set videoTitleScrollSpeed(value:Number):void 
		{
			_videoTitleScrollSpeed = value;
		}
		
		public function get autoHide():Boolean { return _autoHide; }
		
		public function set autoHide(value:Boolean):void 
		{
			_autoHide = value;
		}
		
		public function get copyRight():String { return _copyRight; }
		
		public function set copyRight(value:String):void 
		{
			_copyRight = value;
		}
		
		public function get sendMailTitle():String { return _sendMailTitle; }
		
		public function set sendMailTitle(value:String):void 
		{
			_sendMailTitle = value;
		}
		
		public function get embeddedCodeTitle():String { return _embeddedCodeTitle; }
		
		public function set embeddedCodeTitle(value:String):void 
		{
			_embeddedCodeTitle = value;
		}
		
		public function get holdWidth():Number { return _holdWidth; }
		
		public function set holdWidth(value:Number):void 
		{
			_holdWidth = value;
		}
		
		public function get holdHeight():Number { return _holdHeight; }
		
		public function set holdHeight(value:Number):void 
		{
			_holdHeight = value;
		}
		//}endregion
	}
}