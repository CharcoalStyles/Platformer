package com.Tutorial 
{
	import org.flixel.*;
		
	public class ProcMap extends MapBase {
		[Embed(source = "../../data/Tiles.png")] public var Img_MainLayer:Class;
		
		public function ProcMap(inLevel:String) 
		{
			_setCustomValues();
			
			/*layerTileShadow = new FlxTilemap();// new CSV_TileShadow, Img_TileShadow, 14, 0);
			//layerTileShadow.loadMap(new CSV_TileShadow, Img_TileShadow, 12, 12);
			//layerTileShadow.collideIndex = 60;
			//layerTileShadow.drawIndex = 1;
			//layerTileShadow.x = 0;
			//layerTileShadow.y = 0;
			//layerTileShadow.scrollFactor.x = 1.000000;
			//layerTileShadow.scrollFactor.y = 1.000000;*/
			
			layerMainLayer = new FlxTilemap();//new CSV_MainLayer, Img_MainLayer,1,1);
			layerMainLayer.loadMap(inLevel, Img_MainLayer, 12, 12);
			layerMainLayer.collideIndex = 1;
			layerMainLayer.drawIndex = 1;
			layerMainLayer.x = 0;
			layerMainLayer.y = 0;
			layerMainLayer.scrollFactor.x = 1.000000;
			layerMainLayer.scrollFactor.y = 1.000000;
			
			/*layerNearBkgrnd = new FlxTilemap();//new CSV_NearBkgrnd, Img_NearBkgrnd,1,1);
			layerNearBkgrnd.loadMap(new CSV_NearBkgrnd, Img_NearBkgrnd, 12, 12);
			layerNearBkgrnd.collideIndex = 60;
			layerNearBkgrnd.x = 0;
			layerNearBkgrnd.y = 0;
			layerNearBkgrnd.scrollFactor.x = 0.800000;
			layerNearBkgrnd.scrollFactor.y = 0.900000;*/
			
			/*layerFarBkgrnd = new FlxTilemap();//new CSV_FarBkgrnd, Img_FarBkgrnd,1,1);
			layerFarBkgrnd.loadMap(new CSV_FarBkgrnd, Img_FarBkgrnd, 12, 12);
			layerFarBkgrnd.collideIndex = 60;
			layerFarBkgrnd.drawIndex = 1;
			layerFarBkgrnd.x = 0;
			layerFarBkgrnd.y = 0;
			layerFarBkgrnd.scrollFactor.x = 0.500000;
			layerFarBkgrnd.scrollFactor.y = 0.750000;*/
		}
	}
}