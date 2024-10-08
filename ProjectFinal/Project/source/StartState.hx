import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import MenuState;

//Creates the start screen
class StartState extends FlxState
{
    var playbutt:FlxSprite;
    var rect:FlxSprite;
    var clickSound:flixel.sound.FlxSound;

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

        //Ensure the volume is at max
        FlxG.sound.volume = 1.0; 

        //Adds music:
        FlxG.sound.playMusic("assets/music/758937__timbre__8-bit-remix-of-timbres-freesound-753470.wav");
        //Saves clciking sound
        clickSound = new flixel.sound.FlxSound();
        clickSound = FlxG.sound.load("assets/sounds/707040__vilkas_sound__vs-button-click-03.wav");
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
            if (FlxG.mouse.justPressed) {
                clickSound.play();
                FlxG.switchState(new MenuState());
            }

        } else {
            //Undoes the highlight if no longer hovering
            playbutt.scale.set(1, 1);
            playbutt.loadGraphic("assets/images/straight-empty.png");
        }
    }
}

/*WORKS CITED

BUTTON SOUND: https://freesound.org/people/Vilkas_Sound/sounds/707040/
CHEER SOUND: https://freesound.org/people/GregorQuendel/sounds/481781/
MUSIC: https://freesound.org/people/Timbre/sounds/758937/

IMPLEMENTATION: https://haxeflixel.com/documentation/sound-and-music/*/
