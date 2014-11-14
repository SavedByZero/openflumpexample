package com.michaelgreenhut.ui;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Michael Greenhut
 */
class BSprite extends Sprite
{

	public function new(bdLinks:Array<String>) 
	{
		super();
		for (i in 0...bdLinks.length)
		{
			var bm:Bitmap = new Bitmap(Assets.getBitmapData(bdLinks[i]));
			addChild(bm);
			bm.x = this.width / 2 - bm.width / 2;
			bm.y = this.height / 2 - bm.height / 2;
		}
	}
	
}