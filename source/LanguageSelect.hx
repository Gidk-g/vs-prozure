package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.input.keyboard.FlxKey;

class LanguageSelect extends MusicBeatState
{
	public static var leftState:Bool = false;

	var heyText:FlxText;
	var selectedText:FlxText;

	override function create()
	{
		super.create();

		heyText = new FlxText(0, 0, FlxG.width,
			LanguageData.languageInformationText[ClientPrefs.langNo],
			32);
		heyText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		add(heyText);

		selectedText = new FlxText(0, 500, FlxG.width,
			LanguageData.currentlySelectedLangText[ClientPrefs.langNo] + LanguageData.listForLangSelectList[ClientPrefs.langNo][ClientPrefs.langCurSelected],
			32);
		selectedText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		add(selectedText);

		changeOption();
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if(controls.UI_LEFT_P) {
				changeOption(-1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (controls.UI_RIGHT_P) {
				changeOption(1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (controls.ACCEPT) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;

				// do not swap these two lines with each other
				ClientPrefs.langNo = ClientPrefs.langCurSelected;
				ClientPrefs.language = LanguageData.languageList[ClientPrefs.langNo][ClientPrefs.langCurSelected];
				// polski - LanguageData.languageList[0][0]
				// english - LanguageData.languageList[1][1]

				ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxTween.tween(heyText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new TitleState());
					}
				});
				FlxTween.tween(selectedText, {alpha: 0}, 1, {});
			}
		}
		super.update(elapsed);
	}

	function changeOption(bruh:Int = 0):Void
	{
		ClientPrefs.langCurSelected += bruh;

		if (ClientPrefs.langCurSelected >= LanguageData.languageList[ClientPrefs.langNo].length)
			ClientPrefs.langCurSelected = 0;
		if (ClientPrefs.langCurSelected < 0)
			ClientPrefs.langCurSelected = LanguageData.languageList[ClientPrefs.langNo].length - 1;

		selectedText.text = LanguageData.currentlySelectedLangText[ClientPrefs.langNo] + LanguageData.listForLangSelectList[ClientPrefs.langNo][ClientPrefs.langCurSelected];
	}
}
