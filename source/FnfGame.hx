package;

import flixel.FlxGame;
import cpp.CPPInterface;
import openfl.events.Event;

class FnfGame extends FlxGame
{
    override function create(_:Event)
    {
		#if cpp
		CPPInterface.darkMode();
		#end

		#if cpp
		cpp.NativeGc.enable(true);
		cpp.NativeGc.run(true);
		#end

        super.create(_);
    }
}