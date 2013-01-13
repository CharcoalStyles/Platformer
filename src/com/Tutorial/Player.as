package com.Tutorial 
{
	import flash.display.InteractiveObject;
	import org.flixel.*;
	public class Player extends FlxSprite
	{
		[Embed(source = '../../data/Bob_Base.png')] private var tBody:Class;
		[Embed(source = '../../data/hats/topHat.png')] private var tTopHat:Class;
		
		//[Embed(source = '../../data/player_head.png')] private var tHead:Class;
				
		//head
		//public var head:FlxSprite;
		//private const headYoffset:int = 9;
		//private const BIG_HEAD_MODE:Boolean = false;.
		
		//hat
		public var hat:FlxSprite;
		public var hatXOffests:Array = [6, 6, 2, 2, 3, 6, 4, 4, 3];
		public var hatYOffests:Array = [3, 4, 4, 3, 0, 0, 0, 1, 3];
		
		//vertical movement
		private var jumping:Boolean = false;
		private var jumpCounter:int = 0;
		
		private const GRAVITY:int = 900;
		
		private const MAX_JUMP:int = 650;// 700;// 400;
		private const INIT_JUMP:int = 200;// 250;// 150;
		
		//private const TERMINAL_VELOCITY:int = 500;
		private const WJ_TERMINAL_VELOCITY:int = 50;
		
		private const WJ_MOD:Number = 0.75;
		
		//horizontal movement
		//- Ground Movement
		private const MOVE_SPEED:int = 35;// 50;
		private const MAX_SPEED:int = 300;// 400;
		//- Hover Movement
		private var hovering:Boolean = false;
		private var hoverCounter:Number = 0;
		private const HOVER_TIME:Number = 0.70;
		//- Air Control
		private const AIR_CONTROL:Number = 0.4;// 0.333;
		//-wall jump
		private const WJ_X_SPEED:int = 150;// 300;
		//-friction
		private const NORM_FRICTION:Number = 0.9;
		private const MOD_FRICTION:Number = 0.985;
		private var currentFriction:Number;
		
		//switches
		//- walljump
		public var onLeftWall:Boolean = false;
		public var onRightWall:Boolean = false;
		private var walljumping:Boolean = false;
		
		//temp Variables
		private var collideTile:FlxPoint;
		
		//stickyWJ
		private var onWallTimer:Number;
		private const WJ_STICKY_TIME:Number = 0.25;
		private var wallJumpXpos:Number;
		
		//particles
		public static var jumpEmitter:FadeEmitter;
		public static var hoverEmitter:FadeEmitter;
				
		private var i:int = 0;
		
		private var thisPlayerState:PlayerState;
		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			thisPlayerState = new PlayerState();
			loadGraphic(tBody, true, true, 16, 16);
			
			color = 0xFFAAAAAA + (FlxU.random() * 0x00666666);
			
			addAnimation("Walkr", [0, 1], 40);
			addAnimation("Walkl", [2, 3], 40);
			addAnimation("wallHumpingl", [4]);
			addAnimation("wallHumpingr", [5]);
			addAnimation("fly", [6,7],15);
			addAnimation("Stopped", [8]);
			
			//head = new FlxSprite(x, y - headYoffset);
			//head.loadGraphic(tHead, true, true, 12, 11);
			//head.addAnimation("anim", [0, 1, 2, 3, 4, 5, 6], 15);
			//head.play("anim");
			//if (BIG_HEAD_MODE)
			//{
				//head.scale = new FlxPoint(1.5, 1.5);
			//}
						
            acceleration.y = GRAVITY; 
			
			facing = FlxSprite.RIGHT;
			
			width = 14;
			height = 14;
			offset = new FlxPoint(1, 1);
			
			jumpEmitter = new FadeEmitter();
			jumpEmitter.gravity = 0;
			jumpEmitter.setXSpeed(-25, 25);
			jumpEmitter.setYSpeed(-5, -10);
			var s:FlxSprite;
			var particles:uint = 20;
			for(var i:uint = 0; i < particles; i++)
			{
				s = new FlxSprite();
				s.createGraphic(2, 2);
				s.color = 0xCCCCCC;
				s.alpha = 0.5;
				s.exists = false;
				jumpEmitter.add(s);
			}
			
			hoverEmitter = new FadeEmitter();
			hoverEmitter.gravity = GRAVITY / 4;
			hoverEmitter.setXSpeed(-1, 1);
			hoverEmitter.setYSpeed(10, 20);
			hoverEmitter.setRotation(0, 0)
			particles = 350;
			for(i = 0; i < particles; i++)
			{
				s = new FlxSprite();
				s.createGraphic(8, 2);
				s.color = color;
				s.exists = false;
				hoverEmitter.add(s);
			}
			
			hat = new FlxSprite(x, y);
			hat.loadGraphic(tTopHat, true, true, 8, 8);
		}
		private var tXVel:Number = 0;

		override public function update():void 
		{			
			//resetteh temp velocity
			tXVel = 0;
			
			//get input and set the temp velocity
			if(FlxG.keys.pressed("LEFT"))
			{
				tXVel = -MOVE_SPEED;
			}
			else if (FlxG.keys.pressed("RIGHT"))
			{ 
				tXVel = MOVE_SPEED;           
			}
			
			//if we're in the air, modify the temp velocity
			if (!onFloor)
			{
				velocity.x *= 0.98;
				tXVel *= AIR_CONTROL;
			}
			else if (velocity.x != 0) // and if we're not, add friction
			{
				velocity.x *= currentFriction;
				if (velocity.x < 5 && velocity.x > -5)
				{
					velocity.x = 0;
				}
			}
				
			if (onLeftWall || onRightWall)
			{
				onWallTimer += FlxG.elapsed;
				
				if (onWallTimer < WJ_STICKY_TIME)
					tXVel = 0;
				
				if (x != wallJumpXpos)
				{
					onLeftWall = false;
					onRightWall = false;
				}
				
				if (onLeftWall)
					tXVel += -MOVE_SPEED * 0.2;
				else if (onRightWall)
					tXVel += MOVE_SPEED * 0.2;
			}
				
			
			//if we're not at either end of max velocty, add the temp velocity
			if (velocity.x > -MAX_SPEED && velocity.x < MAX_SPEED)
			{
				velocity.x += tXVel;
			}
			
			//fix the direction the sprites face
			if (velocity.x > 0)
			{
				//facing = FlxSprite.RIGHT;
				//head.facing = FlxSprite.RIGHT;
			}
			else if (velocity.x < 0)
			{
				//facing = FlxSprite.LEFT;
				//head.facing = FlxSprite.LEFT;
			}
			
			
			if (FlxG.keys.justPressed("X")) // just pressed
			{
				if (onFloor)
				{
					velocity.y = -INIT_JUMP;
					jumpCounter += INIT_JUMP;
					jumping = true;
					jumpEmitter.at(this);
					jumpEmitter.y += height / 2;
					jumpEmitter.start(true, 0.5, 20);
				}
				else if (onLeftWall || onRightWall)
				{
					walljumping = true;
					velocity.y = -INIT_JUMP * WJ_MOD;
					jumpCounter += INIT_JUMP;
					jumping = true;
					jumpEmitter.at(this);
					jumpEmitter.y += height / 2;
					jumpEmitter.start(true, 0.5, 20);
						onWallTimer = 0;
					
					if (onLeftWall)
					{
						velocity.x = WJ_X_SPEED;
						onLeftWall = false;
					}
					else
					{
						velocity.x = -WJ_X_SPEED;
						onRightWall = false;
					}
				}
				else if (hoverCounter < HOVER_TIME && velocity.y >= -INIT_JUMP / 2)
				{
					hovering = true;
					hoverCounter += FlxG.elapsed;
					acceleration.y = 0; 
					velocity.y = 0;
					hoverEmitter.at(this);
					hoverEmitter.x += velocity.x / 30;
					hoverEmitter.y += height / 2;
					hoverEmitter.start(true, 0.25, 1);
				}
			}
			else if (FlxG.keys.pressed("X")) //still pressed
			{
				if (jumping)
				{
					velocity.y -= (MAX_JUMP - INIT_JUMP) * FlxG.elapsed;
					jumpCounter += (MAX_JUMP - INIT_JUMP) * FlxG.elapsed;
					if (jumpCounter >= MAX_JUMP)
					{
						jumping = false;
					}
				}
				else if (hovering)
				{
					if (hoverCounter < HOVER_TIME)
					{
						hoverCounter += FlxG.elapsed;
						hoverEmitter.at(this);
						hoverEmitter.x += velocity.x / 30;
						hoverEmitter.y += height / 2;
						hoverEmitter.start(true, 0.25, 1);
					}
					else
					{
						acceleration.y = GRAVITY; 
					}
				}
			}
			else //released
			{
				if (jumping)
				{
					jumping = false;
					jumpCounter = 0;
				}
				
				if (hovering)
				{
					acceleration.y = GRAVITY; 
				}
			}
			
			if (onLeftWall || onRightWall)
			{
				if (velocity.y > WJ_TERMINAL_VELOCITY)
				{
					velocity.y = WJ_TERMINAL_VELOCITY;
				}
			}
			
			super.update();
			jumpEmitter.update();
			hoverEmitter.update();
			
			//head Update
			//head.update();
			//if ( frame == 1)
			//{
				//head.y = y + 1;
			//}
			//else {
				//head.y = y + 2;
			//}
			
			//animing updates
			//if (onLeftWall || onRightWall)
			//{
				//play("wallHumping");
			//}
			//else if (jumping)
			//{
				//play("fly");
			//}
			//else if (velocity.x == 0)
			//{
				//play("Stopped");
			//}
			//else if (velocity.x != 0)
			//{
			   //_curAnim.delay = 10 / Math.abs(velocity.x);
				//if (velocity.x < MAX_SPEED / 2)
					//_curAnim.delay = 1 / 5;
				//
			   //play("Walk");
			//}
			
			//hat update
			hat.x = x + hatXOffests[frame];
			hat.y = y - 8 + hatYOffests[frame];
			if (frame == 2 ||
				frame == 3 ||
				frame == 5)
				hat.facing = FlxSprite.LEFT;
				else
				hat.facing = FlxSprite.RIGHT;

			if (onLeftWall)
			{
				play("wallHumpingl");
			}
			else if (onRightWall)
			{
				play("wallHumpingr");
			}
			else if (jumping)
			{
				play("fly");
			}
			else if (velocity.x == 0)
			{
				play("Stopped");
			}
			else if (velocity.x != 0)
			{
			   //_curAnim.delay = 10 / Math.abs(velocity.x);
				if (velocity.x < MAX_SPEED / 2)
					_curAnim.delay = 1 / 5;
				
				if (velocity.x > 0)
					play("Walkr");
				else
					play("Walkl");
			}

			//head.x = x;
			//thisPlayerState.push(new PlayerStateFrame(x, y, frame, head.x, head.y, head.frame, facing));
		}
		
		private function jump():void 
		{			
			velocity.y = -MAX_JUMP / 1.5;
			jumpCounter += MAX_JUMP / 1.5;
			jumping = true;
			jumpEmitter.at(this);
			jumpEmitter.y += height / 2;
			jumpEmitter.start(true, 0.5, 20);
		}
		
		public function getAndResetPlayerState():PlayerState 
		{
			var ret:PlayerState = thisPlayerState;
			thisPlayerState = new PlayerState();
			return ret;
		}
		
		override public function render():void 
		{
			super.render();
			//head.x = x;
			//head.render();
			jumpEmitter.render();
			hoverEmitter.render();
			hat.render();
		}
		
		private function checkTile(xOff:int, yOff:int):int
		{
			collideTile = new FlxPoint( -100, -100);
			var returnInt:int = 0;
			var dist:int = 10;
			while (returnInt == 0 && dist < 100)
			{
				dist  += 5;
				//TODO: shit here
				//PlayState.singleton._map.mainLayer.ray(x + width / 2, y + height / 2, x + (xOff * dist), y + (yOff * dist), collideTile);
				//returnInt = PlayState.singleton._map.mainLayer.getTile(collideTile.x / 12, collideTile.y / 12);
			}
			
			//FlxG.log("Hit: " + returnInt + " - Dist: " + dist);
			
			return returnInt;
		}
		
		override public function hitBottom(Contact:FlxObject, Velocity:Number):void 
		{
			super.hitBottom(Contact, Velocity);
			walljumping = false;
			hovering = false;
			hoverCounter = 0;
			jumpCounter = 0;
			onLeftWall = false;
			onRightWall = false;
						onWallTimer = 0;
			
						
			currentFriction = NORM_FRICTION;
			/*		
			switch (checkTile(0,1))
			{
				case 1: //normal Block
					currentFriction = NORM_FRICTION;
				break;
				case 2: //death block
					dead = true;
				break;
				case 3: // slide block
					currentFriction = MOD_FRICTION;
				break;
				case 4: //jump Block
					jump();
				break;
				case 5: // ??? block (end?)
				break;
			}*/
		}
		
		override public function hitTop(Contact:FlxObject, Velocity:Number):void 
		{
			jumpCounter = MAX_JUMP;
			jumping = false;
			
					currentFriction = NORM_FRICTION;
					/*
			switch (checkTile(0,-1))
			{
				case 1: //normal Block
					currentFriction = NORM_FRICTION;
				break;
				case 2: //death block
					dead = true;
				break;
				case 3: // slide block
					currentFriction = MOD_FRICTION;
				break;
				case 4: //jump Block
					jump();
				break;
				case 5: // ??? block (end?)
				break;
			}*/
		}
		
		
		override public function collide(Object:FlxObject = null):Boolean 
		{
			//onLeftWall = false;
			//onRightWall = false;
			return super.collide(Object);
		}
		
		override public function hitLeft(Contact:FlxObject, Velocity:Number):void 
		{
			//collideTile = new FlxPoint();
			//PlayState.singleton._map.layerMain.ray(x, y, x - 32, y, collideTile);
			velocity.x *= 0.25;
			
			if (!onLeftWall)
					{
						walljumping = false;
						onLeftWall = true;
						onWallTimer = 0;
						wallJumpXpos = x;
					}
					/*
			switch (checkTile(-1,0))
			{
				case 1: //normal Block
					if (!onLeftWall)
					{
						walljumping = false;
						onLeftWall = true;
						onWallTimer = 0;
						wallJumpXpos = x;
					}
					//currentFriction = NORM_FRICTION;
				break;
				case 2: //death block
					dead = true;
				break;
				case 3: // slide block
					//currentFriction = MOD_FRICTION;
				break;
				case 4: //jump Block
					//jump();
				break;
				case 5: // ??? block (end?)
				break;
			}*/
			if (!onFloor)
			{
				walljumping = false;
				onLeftWall = true;
			}
		}
		override public function hitRight(Contact:FlxObject, Velocity:Number):void 
		{
			//collideTile = new FlxPoint();
			//PlayState.singleton._map.layerMain.ray(x, y, x + 32, y, collideTile);
			velocity.x *= 0.25;
			
			if (!onRightWall)
					{
						walljumping = false;
						onRightWall = true;
						onWallTimer = 0;
						wallJumpXpos = x;
					}
					/*
			switch (checkTile(1,0))
			{
				case 1: //normal Block
					if (!onRightWall)
					{
						walljumping = false;
						onRightWall = true;
						onWallTimer = 0;
						wallJumpXpos = x;
					}
					//currentFriction = NORM_FRICTION;
				break;
				case 2: //death block
					dead = true;
				break;
				case 3: // slide block
					//currentFriction = MOD_FRICTION;
				break;
				case 4: //jump Block
					//jump();
				break;
				case 5: // ??? block (end?)
				break;
			}*/
			if (!onFloor)
			{
				walljumping = false;
				onRightWall = true;
			}
		}
	}

}