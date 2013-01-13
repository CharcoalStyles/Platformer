package com.Tutorial 
{
	import org.flixel.*;
	public class PlayerStateFrame
	{
		public var bodX:Number;
		public var bodY:Number;
		public var bodAnimFrame:uint;
		public var hedX:Number;
		public var hedY:Number;
		public var hedAnimFrame:uint;
		public var facing:int;
		
		public function PlayerStateFrame(inBodX:Number, inBodY:Number, inBodAnim:uint, inHedX:Number, inHedY:Number, inHedAnim:uint, inFacing:uint) 
		{
			
			bodX = inBodX;
			bodY = inBodY;
			bodAnimFrame = inBodAnim;
			hedX = inHedX;
			hedY = inHedY;
			hedAnimFrame = inHedAnim;
			facing = inFacing;
		}
	}

}