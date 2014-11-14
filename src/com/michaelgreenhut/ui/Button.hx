package com.michaelgreenhut.ui;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.Lib;
import flash.text.TextField;
import flash.text.Font;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.filters.ColorMatrixFilter;
import openfl.Assets;

/**
 * ...
 * @author Michael Greenhut
 */
class Button extends Sprite
{
	private var _up:BSprite;
	private var _over:BSprite;
	private var _down:BSprite;
	private var _upPaths:Array<String>;
	private var _overPaths:Array<String>;
	private var _downPaths:Array<String>;
	private var _current:BSprite;
	private var _toggleButton:Bool;
	private var _active:Bool;
	private var _tint:Sprite;
	private var _grey:Bool;
	private var _matrix:Array<Float>;

	public function new(upPaths:Array<String>, overPaths:Array<String>, downPaths:Array<String>, toggleButton:Bool = false) 
	{
		_upPaths = upPaths;
		_overPaths = overPaths;
		_downPaths = downPaths;
		_toggleButton = toggleButton;
		_matrix = [ .33,.33,.33,0,0,.33,.33,.33,0,0,.33,.33,.33,0,0,.33,.33,.33,1,0 ];
		super();
		buttonMode = true;
		_up = new BSprite(upPaths);
		_over = new BSprite(overPaths);
		_down = new BSprite(downPaths);
		
		addChild(_up);
		_current = _up;
		addEventListener(MouseEvent.MOUSE_UP, upState);
		addEventListener(MouseEvent.ROLL_OUT, upState);
		addEventListener(MouseEvent.ROLL_OVER, overState);
		addEventListener(MouseEvent.MOUSE_DOWN, downState);
	}

	public function addTint(color:Int, alph:Float = 0.33, rounded:Bool = true):Void 
	{
		_tint = new Sprite();
		_tint.graphics.beginFill(color,alph);
		//_focusButton.graphics.beginFill(0xff536d,alph);
		if (rounded)
			_tint.graphics.drawRoundRect(0,0,width,height,12,12);
		else 
			_tint.graphics.drawRect(0,0,width,height);

		switchTo(_current);

	}

	public function isGrey()
	{
		return _grey;
	}

	public function grey(value:Bool):Void 
	{
		//_matrix = new Array<Float>();
		_grey = value;
		if (_grey)
		{
			this.filters = [new ColorMatrixFilter( _matrix)];
		}
		else 
		{
			this.filters = [];
		}

	}
	
	public function toggleOff():Void 
	{
		if (_toggleButton)
		{
			_active = false;
			switchTo(_up);
		}
	}
	
	public function inherit(additionalImages:Array<String>):Button 
	{
		return new Button(_upPaths.concat(additionalImages), _overPaths.concat(additionalImages), _downPaths.concat(additionalImages));
	}
	
	private function upState(e:MouseEvent):Void 
	{
		if (!_toggleButton)
				switchTo(_up);
	}
	
	private function downState(e:MouseEvent):Void 
	{
		if (_toggleButton)
		{
			_active = !_active;
			switchTo(_active ? _down : _up);
		}
		else 
			switchTo(_down);
	}
	
	private function overState(e:MouseEvent):Void 
	{
		if (!_toggleButton)
			switchTo(_over);
	}
	
	private function switchTo(next:BSprite):Void 
	{
		if (_grey)
			return;
		removeChild(_current);
		_current = next;
		addChild(_current);
		if (_tint != null)
			addChild(_tint);
	}
	
	
}