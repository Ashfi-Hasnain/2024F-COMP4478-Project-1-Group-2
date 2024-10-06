import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

//Creates the start screen
class StartState extends FlxState
{
    var playbutt:FlxSprite;
    var rect:FlxSprite;

    override public function create():Void
    {
        super.create();

        //Creates a background
        var background:FlxSprite = new FlxSprite(0, 0);
        background.loadGraphic("assets/images/PIPES.png");
        add(background);

        /*Creates the button - looks like a straight pipe painted grey,
        but to do that, a grey rectangle needs to be inserted
        It also has a textbox within it to say "PLAY"*/
        rect = new FlxSprite(100, 100);
        rect.makeGraphic(200, 100, 0xFF808080);
        rect.screenCenter();
        add(rect);
        playbutt = new FlxSprite(0, 0);
        playbutt.loadGraphic("assets/images/straight-empty.png");
        playbutt.screenCenter();
        add(playbutt);
        var text:FlxText = new FlxText(50, 50, 200, "PLAY");
        text.size = 24;
        text.color = 0xFFFFFFFF;
        text.screenCenter();
        text.x += 60;
        add(text);

        //Sets background colour
        this.bgColor = 0xFFFAFAFF;
    }

    //Updates start screen as necessary
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        //Highlights the start button as necessary
        if (rect.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            playbutt.scale.set(1.2, 1.2);
            playbutt.loadGraphic("assets/images/straight-blue.png");

            //And if clicked then takes to main menu
            if (FlxG.mouse.justPressed) FlxG.switchState(new MenuState());

        } else {
            //Undoes the highlight if no longer hovering
            playbutt.scale.set(1, 1);
            playbutt.loadGraphic("assets/images/straight-empty.png");
        }
    }
}