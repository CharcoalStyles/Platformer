package com.Tutorial 
{
	import org.flixel.*;
	
	public class Sign extends FlxGroup
	{
		[Embed(source = '../../data/Sign.png')] private var tSign:Class;
		
		private var sign:FlxSprite;
		private var note:FadeText;
		
		private static var num:int = 0;
		
		private var fadedIn:Boolean = false;
		
		public function Sign(X:Number,Y:Number):void 
		{
			super();
			sign = new FlxSprite(X, Y);
			sign.loadGraphic(tSign, false, true, 24, 16);
			add(sign);
			
			num++;
			
			note = new FadeText(X - 64, Y - 32, 128, "Sign - " + num.toFixed() + "\nNow I'm adding a long sentense to see where stuff is rendered. YAY!");
			note.setFormat(null, 8, 0xFFFFFFFF, "left", 0xFF000000);
			note.fadeOut(0.01); 
			add(note);
		}
		
		override public function overlaps(Object:FlxObject):Boolean 
		{			
			var retBool:Boolean = false;
			if (Object.x > sign.x - 8 && Object.x < sign.x + sign.width + 8 &&
				Object.y > sign.y - 10 && Object.y < sign.y + sign.height + 10)
			{
				if (!fadedIn)
				{
					fadedIn = true;
					note.fadeIn(0.5);
				}
				retBool = true;
			}
			else 
			{
				if (fadedIn)
				{
					fadedIn = false;
					note.fadeOut(0.5);
				}
				retBool = false;
			}
			return retBool;
		}
		
		public function setMessage(inMessage:String):void 
		{
			note.text = inMessage;
		}
	}

}