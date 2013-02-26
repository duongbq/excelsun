////////////////////////////////////////////////////////////////////////////////
//
//  OXYLUS
//  Copyright 2009 OXYLUS
//  All Rights Reserved.
//	@version 1;
//  http://www.oxylusflash.com
//  email: ciprian@oxylus.ro
//
////////////////////////////////////////////////////////////////////////////////
/**
 * @author 
 * Ciprian Chichirita
 */
package utils
{
	import flash.display.MovieClip;
	
	public class Utils
	{
		public function Utils() 
		{
			/**
			 * fitToSise, using example: object.fitToSize(container.Width, container.Height, true)
			 * the last param is to see if you want to scale down/ fit(in this case it will be set to true)
			 * or to scale up/fill(in this case it will be set to false)
			 */
			MovieClip.prototype.fitToSize = function(cW:Number, cH:Number, fit:Boolean):void 
			{
				var objRatio:Number = this.width / this.height;
				var cntRatio:Number = cW / cH;
				
					if (fit) 
					{
						if (objRatio > cntRatio) 
						{
							this.width = cW;
							this.height = this.width / objRatio;
						}else 
						{
							this.height = cH;
							this.width = this.height * objRatio;
						}
					}else //fill
					{
						if (objRatio < cntRatio) 
						{
							this.width = cW;
							this.height = this.width / objRatio;
						}else 
						{
							this.height = cH;
							this.width = this.height * objRatio;
						}
					}
			}
		}
		
		//get angle between 2 mc
		public static function getAngle(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var radians : Number = Math.atan2(y1 - y2, x1 - x2);
			return rad2deg(radians);
		}
		
		public static function rad2deg(rad:Number):Number 
		{
			return rad * (180 / Math.PI);
		}
		
		public static function deg2rad(deg:Number):Number 
		{
			return deg * (Math.PI/ 180);
		}
	}
	
}