package com.michaelgreenhut.events;
import flash.events.Event;

/**
 * ...
 * @author Michael Greenhut
 */

class CustomEvent extends Event
{
	public var data:Dynamic;
	
	public function new(type:String, data:Dynamic = null,bubbles:Bool = false,cancelable:Bool = false) 
	{
		this.data = data;
		super(type, bubbles, cancelable);
	}
	
	public override function clone():Event 
	{
		return new CustomEvent(type, data, bubbles, cancelable);
	}
	
}