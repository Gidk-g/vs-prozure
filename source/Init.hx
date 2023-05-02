package;

import flixel.FlxG;
import flixel.FlxState;
import cpp.CPPInterface;

class Init extends FlxState
{
	public override function create()
	{
		super.create();

		#if cpp
		CPPInterface.darkMode();
		#end

		#if cpp
		cpp.NativeGc.enable(true);
		cpp.NativeGc.run(true);
		#end

		FlxG.switchState(Type.createInstance(Main.initialState, []));
	}
}
