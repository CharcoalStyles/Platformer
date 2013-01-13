package com.Tutorial 
{
	import org.flixel.*;
	public class PlayerState
	{
		public static var head:FlxSprite;
		public static var body:FlxSprite;
		[Embed(source = '../../data/player_body.png')] private static var tBody:Class;
		[Embed(source = '../../data/player_head.png')] private static var tHead:Class;
		
		private var playerStateFrames:Array;
		
		public function PlayerState() 
		{
			playerStateFrames = new Array();
		}
		
		public function push(inPlayerStateFrame:PlayerStateFrame):void 
		{
			playerStateFrames.push(inPlayerStateFrame);
		}
		
		public static function load():void 
		{
			body = new FlxSprite(-100, -100);
			body.loadGraphic(tBody, true, true, 12, 24);
			body.alpha = 0.33;
		
			body.addAnimation("Walk", [0, 1, 2, 1], 10);
			body.addAnimation("wallHumping", [3]);
			body.addAnimation("Stopped", [1]);
		
			head = new FlxSprite(-100, -100);
			head.loadGraphic(tHead, true, true, 12, 11);
			head.alpha = 0.5;
			
			head.addAnimation("anim", [0, 1, 2, 3, 4, 5, 6], 15);
			head.play("anim");
		}
		
		public function render(frame:int):void 
		{
			if (frame >= playerStateFrames.length)
			{
				frame = playerStateFrames.length - 1;
			}
			
			body.x = playerStateFrames[frame].bodX;
			body.y = playerStateFrames[frame].bodY;
			body.facing = playerStateFrames[frame].facing;
			body.frame = playerStateFrames[frame].bodAnimFrame;
			body.render();
			
			head.x = playerStateFrames[frame].hedX;
			head.y = playerStateFrames[frame].hedY;
			head.facing = playerStateFrames[frame].facing;
			head.frame = playerStateFrames[frame].hedAnimFrame;
			head.render();
		}
	}

}