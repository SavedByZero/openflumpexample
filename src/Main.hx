package ;

import com.michaelgreenhut.ui.BSprite;
import com.michaelgreenhut.ui.Button;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import com.michaelgreenhut.openflump.*;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Michael Greenhut
 *  * Flump was created at Three Rings by Charlie Groves, Tim Conkling, and Bruno Garcia. 
 * This Flump parser for openFL was created by Michael Greenhut.
 * For directions on how to use Flump, visit:
 * http://threerings.github.io/flump/
	 * Note that this parser makes use of XML only (at the moment), so be sure to export your Flump files 
	 * using the XML option. 
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
			FlumpParser.get().loadPath("assets/format2/FlumpTester/resources.xml");
		var flumpMovie:FlumpMovie = FlumpParser.get().getMovieByName("FlumpTester/Test");
		Lib.current.stage.addChild(flumpMovie);
		flumpMovie.x = flumpMovie.y = 300;
		
		var baseButton:Button =  new Button(["assets/img/BaseButton0001.png"], ["assets/img/BaseButton0002.png"], ["assets/img/BaseButton0003.png"]);
		var playButton:Button = baseButton.inherit(["assets/img/Play.png"]);
		var rewindButton:Button = baseButton.inherit(["assets/img/Rewind.png"]);
		var frameForwardButton:Button = baseButton.inherit(["assets/img/FrameForward.png"]);
		var frameBackButton:Button = baseButton.inherit(["assets/img/FrameBack.png"]);
		//flumpMovie.play(function() { flumpMovie.rewind(); } );
		this.addChild(playButton);
		this.addChild(rewindButton);
		this.addChild(frameForwardButton);
		this.addChild(frameBackButton);
		
		rewindButton.x = 100;
		rewindButton.y = 100;
		playButton.x = rewindButton.x + rewindButton.width;
		playButton.y = rewindButton.y;
		
		frameBackButton.y = rewindButton.y + rewindButton.height;
		frameBackButton.x = rewindButton.x;
		
		frameForwardButton.x = frameBackButton.x + frameBackButton.width;
		frameForwardButton.y = frameBackButton.y;
		
		playButton.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) { flumpMovie.play(); } );
		rewindButton.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) { flumpMovie.rewind(); } );
		frameForwardButton.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) { flumpMovie.nextFrame(); } );
		frameBackButton.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) { flumpMovie.prevFrame(); } );
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
