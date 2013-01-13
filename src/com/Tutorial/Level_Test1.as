//Code generated with DAME. http://www.dambots.com

package com.Tutorial
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
    import flash.events.*;
	import flash.geom.Rectangle;
	import flash.system.LoaderContext;
	import org.flixel.*;
    import flash.net.*;
	
	public class Level_Test1 extends DAMELevel
	{
		//Embedded media...
		//[Embed(source="../../data/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Group1Map1:Class;
		//[Embed(source="../../data/newTiles.png")] public var Img_Group1Map1:Class;

		//Tilemaps
		public var layerGroup1Map1:FlxTilemap;

		//Sprites

		private var urlLoader:URLLoader;// = new URLLoader();
        private var request:URLRequest;// = new URLRequest("http://charcoalstyles.com/Flash/Bob/map.csv");
        
		private var imgLoader:Loader;
		
		private var addToStage:Boolean;
		
		//loaded Data
		private var levelData:String;
		private var tiles:Class;
		
		private var loadEvent:int;

		public function Level_Test1(inAddToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			isLoaded = false;
			loadEvent = 0;
			try 
			{
				addToStage = inAddToStage;
				urlLoader = new URLLoader()
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				//request = new URLRequest("http://charcoalstyles.com/Flash/Bob/mapCSV_Group1_Map1.csv");
				request = new URLRequest("http://charcoalstyles.com/Flash/Bob/map.csv");
				urlLoader.addEventListener(Event.COMPLETE, loadComplete);
                urlLoader.load(request);
            } 
			catch (error:Error) 
			{
                trace("Unable to load requested document.");
            }
		}
		private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }
		
		private function  loadComplete(event:Event):void 
		{
			switch(loadEvent)
			{
				case 0: //loadedCSV
					levelData = urlLoader.data as String;
					
					trace("fing");
					request = new URLRequest("http://charcoalstyles.com/Flash/Bob/testTile.png");
					
					imgLoader = new Loader();
					imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
					imgLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
					imgLoader.load(request);
					trace("fiddd");
				break;
				case 1://loaded Tiles
					
					var image:Bitmap = Bitmap(imgLoader.content);
					
					PlayState.singleton.tiles = image.bitmapData;
					
					completeLoad();
				break;
			}
			
			loadEvent++;
		}

		private function completeLoad():void 
		{
		// Generate maps.
			layerGroup1Map1 = new FlxTilemap;
			layerGroup1Map1.loadMap(levelData, ImportedImage, 8,8 );
			layerGroup1Map1.x = 0.000000;
			layerGroup1Map1.y = 0.000000;
			layerGroup1Map1.scrollFactor.x = 1.000000;
			layerGroup1Map1.scrollFactor.y = 1.000000;
			layerGroup1Map1.collideIndex = 1;
			layerGroup1Map1.drawIndex = 1;

			//Add layers to the master group in correct order.
			masterLayer.add(layerGroup1Map1);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerGroup1Map1;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 320;
			boundsMaxY = 240;
			
			isLoaded = true;	
		}

	}
}
