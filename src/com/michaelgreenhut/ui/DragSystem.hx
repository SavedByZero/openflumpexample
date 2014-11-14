package com.michaelgreenhut.ui;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Michael Greenhut
 */
class DragSystem extends EventDispatcher
{

	private var _targetSprite:Sprite;
	private var _offsetX:Float;
	private var _offsetY:Float;
	private var _oldX:Float;
	private var _oldY:Float;
	private var _speedX:Float;
	private var _speedY:Float;
	private var _moving:Bool;

	public static var STARTED_MOVING:String = "startedMoving";
	public static var STOPPED_MOVING:String = "stoppedMoving";
	public static var BEING_DRAGGED:String = "beingDragged";
	
	public function new(targetSprite:Sprite = null) 
	{
		super();
		if (targetSprite != null)
			attach(targetSprite);

	}
	
	public function attach(ts:Sprite):Void 
	{
		_targetSprite = ts;
		_targetSprite.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		//_downConnection = _targetSprite.pointerDown.connect(onDown);
	}
	
	public function speedX():Float
	{
		return _speedX;
	}
	
	public function speedY():Float
	{
		return _speedY;
	}
	
	public function release():Void 
	{
		_targetSprite.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
		_targetSprite.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
		_targetSprite.removeEventListener(MouseEvent.MOUSE_UP, onUp);
		_targetSprite = null;
	}
	
	private function onMove(pe:MouseEvent):Void 
	{
		
		if (_moving == false)
			this.dispatchEvent(new Event(STARTED_MOVING));
		_moving = true;
		_targetSprite.x = _targetSprite.parent.mouseX - _offsetX;
		_targetSprite.y = _targetSprite.parent.mouseY - _offsetY;
		_targetSprite.dispatchEvent(new Event(BEING_DRAGGED));
		_speedX = _targetSprite.x - _oldX;
		_speedY = _targetSprite.y - _oldY;
		_oldX = _targetSprite.x;
		_oldY = _targetSprite.y;
		
		//trace(_speedX, _speedY);
	}
	
	private function onDown(e:MouseEvent):Void 
	{
		
		cast(_targetSprite.parent, DisplayObjectContainer).addChild(_targetSprite);
		
		_offsetX = _targetSprite.parent.mouseX - _targetSprite.x;
		_offsetY = _targetSprite.parent.mouseY - _targetSprite.y;
		
		//_moveConnection = System.pointer.move.connect(onMove);
		_targetSprite.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		_targetSprite.addEventListener(MouseEvent.MOUSE_UP, onUp);
		//_upConnection = System.pointer.up.connect(onUp);
		
	
	//	_outConnection = _targetSprite.pointerOut.connect(onUp);
	}
	
	private function onOut(pe:MouseEvent):Void 
	{
		//onUp(pe);
	}
	
	private function onUp(pe:MouseEvent):Void 
	{
		trace("onUp");
		//_moveConnection.dispose();
		//_upConnection.dispose();
		_moving = false;
		_targetSprite.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
		_targetSprite.removeEventListener(MouseEvent.MOUSE_UP, onUp);
		this.dispatchEvent(new Event(STOPPED_MOVING));
		//stoppedMoving.emit();
	
	}
	
	public function moving():Bool
	{
		return _moving;
	}
	
}