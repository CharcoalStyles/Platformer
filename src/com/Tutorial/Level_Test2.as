//Code generated with DAME. http://www.dambots.com

package com.Tutorial
{
	import org.flixel.*;
	public class Level_Test2 extends DAMELevel
	{
		//Embedded media...
		[Embed(source="../../data/mapCSV_Group1_Bkgrnd.csv", mimeType="application/octet-stream")] public var CSV_Group1Bkgrnd:Class;
		[Embed(source="../../data/newTiles.png")] public var Img_Group1Bkgrnd:Class;
		[Embed(source="../../data/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Group1Map1:Class;
		[Embed(source="../../data/newTiles.png")] public var Img_Group1Map1:Class;

		//Tilemaps
		public var layerGroup1Bkgrnd:FlxTilemap;
		public var layerGroup1Map1:FlxTilemap;

		//Sprites


		public function Level_Test2(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Bkgrnd = new FlxTilemap;
			layerGroup1Bkgrnd.loadMap( new CSV_Group1Bkgrnd, Img_Group1Bkgrnd, 8,8 );
			layerGroup1Bkgrnd.x = 0.000000;
			layerGroup1Bkgrnd.y = 0.000000;
			layerGroup1Bkgrnd.scrollFactor.x = 1.000000;
			layerGroup1Bkgrnd.scrollFactor.y = 1.000000;
			layerGroup1Bkgrnd.collideIndex = 1;
			layerGroup1Bkgrnd.drawIndex = 1;
			layerGroup1Map1 = new FlxTilemap;
			layerGroup1Map1.loadMap( new CSV_Group1Map1, Img_Group1Map1, 8,8 );
			layerGroup1Map1.x = 0.000000;
			layerGroup1Map1.y = 0.000000;
			layerGroup1Map1.scrollFactor.x = 1.000000;
			layerGroup1Map1.scrollFactor.y = 1.000000;
			layerGroup1Map1.collideIndex = 1;
			layerGroup1Map1.drawIndex = 1;

			//Add layers to the master group in correct order.
			masterLayer.add(layerGroup1Bkgrnd);
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
