package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import PlayState;

class MenuState extends FlxState
{

    var easybutt:FlxSprite;
    var medbutt:FlxSprite;
    var hardbutt:FlxSprite;
    var insbutt:FlxSprite;
    var instext:FlxText;
    var clickSound:flixel.sound.FlxSound;
    
    override public function create()
    {
        super.create();

        //Creates the background
        var background:FlxSprite = new FlxSprite(0, 0);
        background.loadGraphic("assets/images/PIPES.png");
        add(background);

        //Easy Button
        easybutt = new FlxSprite(0, 0);
        easybutt.loadGraphic("assets/images/easy-unselected.png");
        easybutt.screenCenter();
        easybutt.x -= 180;
        add(easybutt);

        var text:FlxText = new FlxText(50, 50, 200, "EASY");
        text.size = 24;
        text.color = 0xFF000000;
        text.screenCenter();
        text.x -= 64;
        text.y += 13;
        add(text);

        //Medium Button
        medbutt = new FlxSprite(0, 0);
        medbutt.loadGraphic("assets/images/med-unselected.png");
        medbutt.screenCenter();
        medbutt.x += 180;
        add(medbutt);

        var text2:FlxText = new FlxText(50, 50, 200, "MEDIUM");
        text2.size = 24;
        text2.color = 0xFF000000;
        text2.screenCenter();
        text2.x += 273;
        text2.y += 13;
        add(text2);

        //Hard Button
        hardbutt = new FlxSprite(0, 0);
        hardbutt.loadGraphic("assets/images/hard-unselected.png");
        hardbutt.screenCenter();
        hardbutt.x -= 180;
        hardbutt.y += 150;
        add(hardbutt);

        var text3:FlxText = new FlxText(50, 50, 200, "Hard");
        text3.size = 24;
        text3.color = 0xFF000000;
        text3.screenCenter();
        text3.x -= 64;
        text3.y += 13 + 150;
        add(text3);

        //INSANE Button
        insbutt = new FlxSprite(0, 0);
        insbutt.loadGraphic("assets/images/insane-unselected.png");
        insbutt.screenCenter();
        insbutt.x += 180;
        insbutt.y += 150;
        add(insbutt);

        instext = new FlxText(50, 50, 200, "INSANE");
        instext.size = 24;
        instext.color = 0xFF000000;
        instext.screenCenter();
        instext.x += 278;
        instext.y += 13 + 150; 
        add(instext);

        //Sets background colour
        this.bgColor = 0xFFFAFAFF;

        //Ensure the volume is at max
        FlxG.sound.volume = 1.0; 

        //Saves clciking sound
        clickSound = new flixel.sound.FlxSound();
        clickSound = FlxG.sound.load("assets/sounds/707040__vilkas_sound__vs-button-click-03.mp3");    
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        
        //Highlights the easy button as necessary
        if (easybutt.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            easybutt.loadGraphic("assets/images/easy-selected.png");

            //And if clicked then takes to level
            if (FlxG.mouse.justPressed) {
                clickSound.play();
                FlxG.switchState(new PlayState(chooseLevel(1,2),3));
            }

        } else {
            //Undoes the highlight if no longer hovering
            easybutt.loadGraphic("assets/images/easy-unselected.png");
        }

        //Highlights the medium button as necessary
        if (medbutt.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            medbutt.loadGraphic("assets/images/med-selected.png");

            //And if clicked then takes to level
            if (FlxG.mouse.justPressed) {
                clickSound.play();
                FlxG.switchState(new PlayState(chooseLevel(3,6),4));
            }

        } else {
            //Undoes the highlight if no longer hovering
            medbutt.loadGraphic("assets/images/med-unselected.png");
        }

        //Highlights the hard button as necessary
        if (hardbutt.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            hardbutt.loadGraphic("assets/images/hard-selected.png");

            //And if clicked then takes to level
            if (FlxG.mouse.justPressed) {
                clickSound.play();
                FlxG.switchState(new PlayState(chooseLevel(7,9),6));
            }

        } else {
            //Undoes the highlight if no longer hovering
            hardbutt.loadGraphic("assets/images/hard-unselected.png");
        }

        //Highlights the INSANE button as necessary
        if (insbutt.overlapsPoint(FlxG.mouse.getWorldPosition()))
        {
            //Highlight if hovering
            insbutt.loadGraphic("assets/images/insane-selected.png");
            instext.color = 0xFFFF0000;

            //And if clicked then takes to level
            if (FlxG.mouse.justPressed) {
                clickSound.play();
                FlxG.switchState(new PlayState(10, 10));
            }

        } else {
            //Undoes the highlight if no longer hovering
            insbutt.loadGraphic("assets/images/insane-unselected.png");
            instext.color = 0xFF000000;
        }
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
