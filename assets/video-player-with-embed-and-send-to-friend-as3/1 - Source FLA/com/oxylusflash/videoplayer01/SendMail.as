package com.oxylusflash.videoplayer01
{
	//{region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.Timer;
	
	import com.oxylusflash.videoplayer01.VideoPlayer;
	
	import caurina.transitions.Tweener;
	//}endregion	
	
	public class SendMail extends MovieClip
	{
		//{region PUBLIC FIELDS
		public var mcMailBoxTitle : MovieClip;
		public var mcMailInputTxt : MovieClip;
		public var mcToggleMailClose : MovieClip;
		public var mcToggleMailSendBtn : MovieClip;
		public var mcInvalidMail : MovieClip;
		public var Bg : MovieClip;
		//}endregion
		
		//{region PRIVATE FIELDS
		private var emailExpression : RegExp;
		private var url : URLRequest;
		private var urlVar : URLVariables;
		private var loader : URLLoader;
		//}endregion
		
		//{region CONSTRUCTOR
		public function SendMail() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		//}endregion
		
		//{region INIT
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			mcToggleMailClose.mcMailCloseNormal.addEventListener(MouseEvent.ROLL_OVER, mcMailCloseNormal_RollOverHandler, false, 0, true);
			mcToggleMailClose.mcMailCloseOver.addEventListener(MouseEvent.CLICK, mcMailCloseOver_ClickHandler, false, 0, true);
			mcToggleMailClose.mcMailCloseOver.addEventListener(MouseEvent.ROLL_OUT, mcMailCloseOver_RollOutHandler, false, 0, true);
			
			mcToggleMailSendBtn.mcMailSendBtnNormal.addEventListener(MouseEvent.ROLL_OVER, mcMailSendBtnNormal_RollOverHandler, false, 0, true);
			mcToggleMailSendBtn.mcMailSendBtnOver.addEventListener(MouseEvent.CLICK, mcMailSendBtnOver_ClickHandler, false, 0, true);
			mcToggleMailSendBtn.mcMailSendBtnOver.addEventListener(MouseEvent.ROLL_OUT, mcMailSendBtnOver_RollOutHandler, false, 0, true);
		}
		//}endregion
		
		//{region EVENT HANDLERS
		private function mcMailCloseNormal_RollOverHandler(e:MouseEvent):void 
		{
			mcToggleMailClose.mcMailCloseOver.visible = true;
			Tweener.addTween(mcToggleMailClose.mcMailCloseOver, {alpha:1, time:.3, transition:"easeOutCubic"});
		}
		
		private function mcMailCloseOver_ClickHandler(e:MouseEvent):void 
		{
			close();
		}
		
		private function mcMailCloseOver_RollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcToggleMailClose.mcMailCloseOver, {alpha:0, time:.3, transition:"easeInCubic", onComplete: function ():void 
			{
			mcToggleMailClose.mcMailCloseOver.visible = false;
			}});
		}
		
		private function mcMailSendBtnNormal_RollOverHandler(e:MouseEvent):void 
		{
			mcToggleMailSendBtn.mcMailSendBtnOver.visible = true;
			Tweener.addTween(mcToggleMailSendBtn.mcMailSendBtnOver, {alpha:1, time:.3, transition:"easeOutCubic"});
		}
		
		private function mcMailSendBtnOver_ClickHandler(e:MouseEvent):void 
		{
			send();
		}
		
		private function loader_CompleteHandler(e:Event):void 
		{
			var xml:XML = new XML(loader.data);
			if (xml.message.text() == "sent")
			{
				mcInvalidMail.txt.text = "e-mail sent successfully!";
				Tweener.addTween(mcInvalidMail, {alpha:1, time:.3, transition:"easeOutBack", onComplete:function ():void 
				{
					Tweener.addTween(mcInvalidMail, { alpha:0, time:.3, delay:2,  transition:"easeOutBack" } );
					//mcInvalidMail.visible = false;
				}});
				
			}else 
			{
				mcInvalidMail.txt.text = "couldn't send the e-mail";
				Tweener.addTween(mcInvalidMail, {alpha:1, time:.3, transition:"easeOutBack"});
			}
		}
		
		private function loader_IoError(e:IOErrorEvent):void 
		{
			mcInvalidMail.txt.text = "php Error";
			Tweener.addTween(mcInvalidMail, {alpha:1, time:.3, transition:"easeOutBack"});
			trace(e.toString());
		}
		
		private function mcMailSendBtnOver_RollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcToggleMailSendBtn.mcMailSendBtnOver, {alpha:0, time:.3, transition:"easeInCubic", onComplete:function ():void 
			{
				mcToggleMailSendBtn.mcMailSendBtnOver.visible = false;
			}});
		}
		//}endregion
		
		//{region METHODS
		internal function send():void 
		{
			if (isValidEmail(mcMailInputTxt.txt.text.toString())) 
			{
					url = new URLRequest(VideoPlayer.getInstance().phpUrl);
					url.method = URLRequestMethod.POST;
					
					urlVar = new URLVariables();
					urlVar.sender_mail = VideoPlayer.getInstance().mail;
					urlVar.sender_message = VideoPlayer.getInstance().mailMessage;
					urlVar.sender_footer = VideoPlayer.getInstance().emailFooter;
					urlVar.sender_subject = VideoPlayer.getInstance().emailSubject;
					urlVar.sender_name = VideoPlayer.getInstance().nickName;
					urlVar.receiver_mail = mcMailInputTxt.txt.text.toString();
					
					url.data = urlVar;
					
					loader = new URLLoader(url);
					loader.addEventListener(Event.COMPLETE, loader_CompleteHandler, false, 0, true);
					loader.addEventListener(IOErrorEvent.IO_ERROR, loader_IoError, false, 0, true);
					loader.dataFormat = URLLoaderDataFormat.TEXT;
					loader.load(url);
					
					mcInvalidMail.visible = true;
				
					mcMailInputTxt.txt.text = "";
			}else 
			{
				mcInvalidMail.txt.text = VideoPlayer.getInstance().errorMessage;
				mcInvalidMail.visible = true;
				Tweener.addTween(mcInvalidMail, {alpha:1, time:.3, transition:"easeOutBack", onComplete: function ():void 
				{
					Tweener.addTween(mcInvalidMail, { alpha:0, delay: 2, time:.3, transition:"easeInBack" } );
				}});
			}
		}
		
		private function isValidEmail(e:String):Boolean 
		{
			emailExpression	 = /^([a-zA-Z0-9._-]|[!#\$%&'\*\+\/=\?\^`\{\|\}~])+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,9}$/i
			
			return emailExpression.test(e);
		}
		
		internal function close():void 
		{
			if (!this.visible) 
			{
				this.visible = true;
				Tweener.addTween(this, { alpha: 1, time:.5, transition:"easeOutCirc" } );
				VideoPlayer.getInstance().stage.focus = mcMailInputTxt.txt;
				
			}else 
			{
				Tweener.addTween(this, {alpha: 0, time:.5, transition:"easeInCirc", onComplete: function ():void 
				{
					this.visible = false;
					mcMailInputTxt.txt.text = "";
					mcInvalidMail.txt.text = "";
					mcInvalidMail.visible = false;
					mcInvalidMail.alpha = 0;
				}});
			}
		}
		//}endregion
	}
	
}