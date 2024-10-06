import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

class MenuState extends FlxState
{
    var eButton:FlxSprite;
    var eRect:FlxSprite;
    var mButton:FlxSprite;
    var mRect:FlxSprite;
    var hButton:FlxSprite;
    var hRect:FlxSprite;
    var iButton:FlxSprite;
    var iRect:FlxSprite;

    override public function create():Void
    {
        super.create();

        //Creates a background
        var background:FlxSprite = new FlxSprite(0, 0);
        background.loadGraphic("assets/images/PIPES.png");
        add(background);

        //AND THE GRAPHICS GO HERE...PLEASE WRITE THE CODE FOR ME SO I CAN DO THE LEVELS
        
    }

//PLEASE REVISE THIS SECTION...I THINK ITS PERFECT BUT COULD USE TWEAKING

    //Updates start screen as necessary
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        //Highlights the easy button as necessary
        if (eRect.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            eButton.scale.set(1.2, 1.2);
            eButton.loadGraphic("assets/images/straight-blue.png");

            //And if clicked then takes to main menu
            if (FlxG.mouse.justPressed) easyClick();

        } else {
            //Undoes the highlight if no longer hovering
            eButton.scale.set(1, 1);
            eButton.loadGraphic("assets/images/straight-empty.png");
        }


        //Highlights the medium button as necessary
        if (mRect.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            mButton.scale.set(1.2, 1.2);
            mButton.loadGraphic("assets/images/straight-blue.png");

            //And if clicked then takes to main menu
            if (FlxG.mouse.justPressed) medClick();

        } else {
            //Undoes the highlight if no longer hovering
            mButton.scale.set(1, 1);
            mButton.loadGraphic("assets/images/straight-empty.png");
        }


        //Highlights the hard button as necessary
        if (eRect.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            eButton.scale.set(1.2, 1.2);
            eButton.loadGraphic("assets/images/straight-blue.png");

            //And if clicked then takes to main menu
            if (FlxG.mouse.justPressed) hardClick();

        } else {
            //Undoes the highlight if no longer hovering
            eButton.scale.set(1, 1);
            eButton.loadGraphic("assets/images/straight-empty.png");
        }


        //Highlights the insane button as necessary
        if (mRect.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            mButton.scale.set(1.2, 1.2);
            mButton.loadGraphic("assets/images/straight-blue.png");

            //And if clicked then takes to main menu
            if (FlxG.mouse.justPressed) insClick();

        } else {
            //Undoes the highlight if no longer hovering
            mButton.scale.set(1, 1);
            mButton.loadGraphic("assets/images/straight-empty.png");
        }
    }

//THIS PART IS ALL GOOD. YOU NEED TO MODIFY THE BUTTONS ABOVE SO THAT CLICKING THEM CALLS THESE FUNCTIONS:
    function easyClick(){
        new PlayState(chooseLevel(1,2),3);
    }

    function medClick(){
        new PlayState(chooseLevel(3,6),4);
    }

    function hardClick(){
        new PlayState(chooseLevel(7,9),6);
    }

    function insClick(){
        new PlayState(10,7);
    }

    //Generates a random level
    function chooseLevel(min:Int, max:Int):Int{
        if (min == max) return min;
        else{
            var options = max - min + 1;
            var random = Math.floor(Math.random() % options);
            return (min + random);
        }
    }
}