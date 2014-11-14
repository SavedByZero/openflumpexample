package com.michaelgreenhut.ui;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Michael Greenhut
 */
class Draggable extends Sprite implements IDraggable
{	
	public static var STARTED_MOVING:String;
	public static var STOPPED_MOVING:String;
	//private var _startConnector:SignalConnection;
	//private var _stopConnector:SignalConnection;
	
	private var _dragSystem:DragSystem;

	public function new() 
	{
		super();
		
		//startedMoving = new Signal1<IDraggable>();
		//stoppedMoving = new Signal1<IDraggable>();
	}
	
	public function makeDraggable():Void 
	{
		if (_dragSystem == null)
		{
			_dragSystem = new DragSystem(this);
			_dragSystem.addEventListener(DragSystem.STARTED_MOVING, startMoving);
			_dragSystem.addEventListener(DragSystem.STOPPED_MOVING, stopMoving);
			//_texture.graphics.drawTexture(_draggableSymbol,0,0); //writePixels(_draggableSymbol.readPixels(0, 0, _draggableSymbol.width, _draggableSymbol.height), 0, 0, _draggableSymbol.width, _draggableSymbol.height);
		}
	}
	
	public function isBeingDragged():Bool
	{
		return (_dragSystem != null);
	}
	
	public function makeUndraggable():Void 
	{
		_dragSystem.release();
		//_draggableSymbol.dispose();
		_dragSystem = null;
	}
	
	public function startMoving(e:Event):Void
	{
		this.dispatchEvent(e);
		//startedMoving.emit(this);
		
	}
	
	public function stopMoving(e:Event):Void 
	{
		this.dispatchEvent(e);
	}
	
	public function destroy():Void 
	{
	
		if (_dragSystem != null)
		{
			_dragSystem.release();
			_dragSystem.removeEventListener(DragSystem.STARTED_MOVING, startMoving);
			_dragSystem.removeEventListener(DragSystem.STOPPED_MOVING, stopMoving);
		}
		
		_dragSystem = null;
		
		
	}
	
}