import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

class PlayState extends FlxState
{
    var playbutt:FlxSprite;
    var rect:FlxSprite;

    override public function create():Void
    {
        super.create();

        var background:FlxSprite = new FlxSprite(0, 0);
        background.loadGraphic("assets/images/PIPES.png");
        add(background);

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

        this.bgColor = 0xFFFAFAFF;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        if (rect.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            playbutt.scale.set(1.2, 1.2);
            playbutt.loadGraphic("assets/images/straight-blue.png");
        } else {
        	playbutt.scale.set(1, 1);
        	playbutt.loadGraphic("assets/images/straight-empty.png");
        }
    }
}
