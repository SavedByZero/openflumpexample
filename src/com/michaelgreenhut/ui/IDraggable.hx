package com.michaelgreenhut.ui;

/**
 * @author Michael Greenhut
 */

interface IDraggable 
{
	function makeDraggable():Void; 
	function makeUndraggable():Void;
	function isBeingDragged():Bool;
}