package com.Tutorial 
{
	import adobe.utils.CustomActions;
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{		
		public static var singleton:PlayState;
		//message
		private var messageText:FadeText;
		
		//mode
		private var mode:int;
		private var modeTimer:Number;
		
		//activePlayer
		private var player:Player;
		//[Embed(source = "../../data/level0.txt", mimeType = "application/octet-stream")] public static var data_map:Class;
		//[Embed(source = "../../data/Tiles.png")] public static var data_tiles:Class;

		//public var myMap:FlxTilemap;
		
		//private var psArray:Array;
		//private var replayFrame:int;
		
		//public var _map:MapBase;
		
		public var tiles:BitmapData;
		
		private var level:DAMELevel;

		protected function onAddSpriteCallback(obj:FlxSprite):void
		{
			/*
			*/
		}
		
		public function PlayState() 
		{	
			super();
			singleton = this;
			
			
			//PlayerState.load();
			
			//psArray = new Array();
			
			mode = 0;
			modeTimer = 0;
			
			messageText = new FadeText(0, FlxG.height / 3, FlxG.width,"");
			messageText.setFormat(null, 16, 0xFFFFFFFF, "center");
			messageText.fadeOut(0.001);
			this.add(messageText);
		}
		override public function create():void 
		{
			super.create();
			level = new Level_Test1();
			
			player = new Player(FlxG.width / 2, FlxG.height / 2);
			player.kill();
			add(player);
			
			//PlayerState.load();
			
			//psArray = new Array();
			
			mode = 0;
			modeTimer = 0;
		}
		
		override public function update(): void 
		{
			
			super.update();
			
			switch (mode)
			{
				case 0: //loading
				if (modeTimer == 0)
				{
					messageText.text = "Loading";
					messageText.fadeIn(0.2);
					//player.reset(96, _map.mainLayer.height - 96);
					//player.x = 96;
					//player.y = myMap.height - 96;
					
					//FlxG.followAdjust(1.1, 0.5);
					//FlxG.followBounds(0, 0, _map.mainLayer.width, _map.mainLayer.height);
				}
				
				//FlxG.follow(player);
				modeTimer += FlxG.elapsed;
								
				//replayFrame++;
				
				//for (var i:int = 0; i < _map.spriteGroup.members.length; i++)
				//{
					//_map.spriteGroup.members[i].overlaps(player)
				//}
				
				if (level.isLoaded )
				{
					messageText.text = "Loaded!";
					messageText.fadeOut(0.5);
					mode++;
					modeTimer = 0;
					player.reset(FlxG.width / 2, 32);
				}
				
				//if (modeTimer > 2)
				//{
				//}
				break;
				case 1: //gameplay
				if (modeTimer == 0)
				{
					//replayFrame = 0;
					//psArray.push(player.getAndResetPlayerState());
					//mode = 0;
				}
				
				modeTimer += FlxG.elapsed;
				
				//if (modeTimer > 2)
				//{
				//}
				break;
				
			}
			
			player.collide(level.mainLayer);
		}
		
		override public function render(): void 
		{
			
			super.render();
			
			//for each (var ps:PlayerState in psArray)
			//{
				//ps.render(replayFrame);
			//}
			
		}
		
	}

}
