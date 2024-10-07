package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import MenuState;

class LevelState extends FlxState
{

	var resetbutt:FlxSprite;
    var rect:FlxSprite;

    var timer:FlxTimer;
    var timertext:FlxText;
    var totaltime:Float = 0;
	
	override public function create()
	{
		super.create();

        //create resetbutton
        rect = new FlxSprite(100, 100);
        rect.makeGraphic(100, 50, 0xFF808080);
        rect.screenCenter();
        add(rect);
        resetbutt = new FlxSprite(0, 0);
        resetbutt.loadGraphic("assets/images/straight-empty.png");
        resetbutt.screenCenter();
        resetbutt.scale.set(0.5,0.5);
        resetbutt.y += 200;
        add(resetbutt);
        var text:FlxText = new FlxText(50, 50, 200, "RESET");
        rect.y += 200;
        text.size = 24;
        text.color = 0xFFFFFFFF;
        text.screenCenter();
        text.y += 201;
        text.x += 55;
        add(text);

        //create playspace
        var space:FlxSprite = new FlxSprite(0, 0);
        space.loadGraphic("assets/images/triangle.png");
        space.scale.set(0.3,0.3);
        space.screenCenter();
        add(space);

        //create timer
        timertext = new FlxText(10, 10, 100, "0:00");
        timertext.color = 0xFF000000;
        timertext.size = 24;
        timertext.screenCenter();
        timertext.y -= 200;
        timertext.x += 20;
        add(timertext);

        timer = new FlxTimer();
        timer.start(1, updateTimer, 0);

        //Sets background colour
        this.bgColor = 0xFFFAFAFF;		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
        
        //Highlights the start button as necessary
        if (rect.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            rect.color = 0xFFFF4040;

            //And if clicked then takes to main menu
            if (FlxG.mouse.justPressed) FlxG.resetState();

        } else {
            //Undoes the highlight if no longer hovering
            rect.color = 0xFF808080;
        }
	}

    // timer update function
    function updateTimer(timer:FlxTimer):Void {
        totaltime += 1;

        var minutes = Std.int(totaltime / 60);
        var seconds = Std.int(totaltime % 60);

        timertext.text = minutes + ":" + StringTools.lpad(Std.string(seconds), "0", 2);
    }

}

