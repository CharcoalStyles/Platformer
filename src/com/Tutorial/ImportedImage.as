package com.Tutorial 
{
	import flash.display.BitmapData;
	
	public class ImportedImage {
		
		public var bitmapData:BitmapData;
		
		public function ImportedImage():void {
			bitmapData = PlayState.singleton.tiles;
		}
		
	}
	

}