//Summon libraries
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import Square;

class PlayState extends FlxState
{
	//The grid
	var grid:Array<Square>;

	var space:FlxSprite;

	//Integers to note level and size
	var level:Int;
	var size:Int;

	//Difficulty
	var difficulty:String;

	var resetbutt:FlxSprite;
    var rect:FlxSprite;

    var exitbutt:FlxSprite;

    var timer:FlxTimer;
    var timertext:FlxText;
    var totaltime:Float = 0;

    var allWet:Bool = false;
    var wintext:FlxText;

    var psx:Int;
    var psy:Int;

    //Audio sounds
    var clickSound:flixel.sound.FlxSound;
    var cheer:flixel.sound.FlxSound;

	//This function prepares the level for creation (back end)
    public function new(level:Int, size:Int){
    	super();
    	this.level = level;
    	this.size = size;
    	grid = [];

    	switch(level){
    		case 10:
    			difficulty = "INSANE";
    			grid = grid10(grid);
			case 9:
    			difficulty = "HARD";
    			grid = grid9(grid);
			case 8:
				difficulty = "HARD";
				grid = grid8(grid);
			case 7:
				difficulty = "HARD";
				grid = grid7(grid);
			case 6:
    			difficulty = "MEDIUM";
    			grid = grid6(grid);
			case 5:
    			difficulty = "MEDIUM";
    			grid = grid5(grid);
			case 4:
    			difficulty = "MEDIUM";
    			grid = grid4(grid);
			case 3:
				difficulty = "MEDIUM";
				grid = grid3(grid);
			case 2:
				difficulty = "EASY";
				grid = grid2(grid);
			case 1:
    			difficulty = "EASY";
    			grid = grid1(grid);
			default:
    	}
    	for (i in 0...grid.length) {
    		add(grid[i].getSprite());
    	}
    }

    override public function create():Void
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

        //create exit button
        exitbutt = new FlxSprite(0, 0);
        exitbutt.loadGraphic("assets/images/exit.png");
        exitbutt.x += 10;
        exitbutt.y += 10;
        add(exitbutt);

        //create playspace
        space = new FlxSprite(0, 0);
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

        wintext = new FlxText(275, 180, 500, "LEVEL CLEAR");		//Wintext creation
        wintext.size = 50;
        wintext.alpha = 0;
        wintext.y -= 130;
        add(wintext);

        //Sets background colour
        this.bgColor = 0xFFFAFAFF;

        //Ensure the volume is at max
        FlxG.sound.volume = 1.0; 

        //Saves clciking sound
        clickSound = new flixel.sound.FlxSound();
        clickSound = FlxG.sound.load("assets/sounds/707040__vilkas_sound__vs-button-click-03.mp3");	

        //Saves cheer sound
        cheer = new flixel.sound.FlxSound();
        cheer = FlxG.sound.load("assets/sounds/481781__gregorquendel__crowd-cheering-strong-cheering-2-short.wav");
    }

    //The function to return to main menu and to reset level
    public function goToMenu(){FlxG.switchState(new MenuState());}
    public function reset(){
    	clickSound.play();
    	FlxG.switchState(new PlayState(level, size));
    }

    override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!allWet) {
			//Exit button back to level select
			if (exitbutt.overlapsPoint(FlxG.mouse.getWorldPosition()) && FlxG.mouse.justPressed) {
				FlxG.switchState(new MenuState());
			}

			//Highlights the reset button as necessary
	        if (rect.overlapsPoint(FlxG.mouse.getWorldPosition()))
	        {
	            //Highlight if hovering
	            rect.color = 0xFFFF4040;

	            //And if clicked then resets state
	            if (FlxG.mouse.justPressed) FlxG.switchState(new PlayState(level, size));

	        } else {
	            //Undoes the highlight if no longer hovering
	            rect.color = 0xFF808080;
	        }

	        var mousepos = FlxG.mouse.getWorldPosition();
	        for (i in 0...grid.length) {
				var bounds = new FlxRect(
		    		grid[i].getSprite().x - grid[i].getSprite().origin.x * grid[i].getSprite().scale.x + 100,
		    		grid[i].getSprite().y - grid[i].getSprite().origin.y * grid[i].getSprite().scale.y + 100,
		    		grid[i].getSprite().frameWidth * grid[i].getSprite().scale.x * 0.9,
		    		grid[i].getSprite().frameHeight * grid[i].getSprite().scale.y* 0.9
					);
	        	if (bounds.containsPoint(mousepos) && FlxG.mouse.justPressed) {
	        		grid[i].rotate();
	        	}
	        }

	        checkWater();

	        //Checks if victory conditions are met
			allWet = true;
			for (i in 0...grid.length){
				if (grid[i].moisture() == false) allWet = false;
			}
			if (allWet) victory();
		}
	}

	public function victory(){
		cheer.play();
		wintext.color = FlxColor.GREEN;
    	wintext.alpha = 1;
    	wintext.x -= 130;
    	space.alpha = 0.5;
    	timer.cancel();
    	var timer = new FlxTimer();
		timer.start(3.5, function(timer:FlxTimer) {
	        FlxG.switchState(new MenuState());
	    });
	}

	public function checkWater() {
		for (i in 0...grid.length) {
        	var directions:Array<Bool> = grid[i].getDirections();	//puts the in/outputs of a pipe in an array
        	var water:Bool = false;
        	if(grid[i].getPriority() != 100) {						//checks if any adjacent pipes are connected and have water with a higher priority
        		if (directions[0] == true && grid[i].getRowv() != 0) {
	        		if (grid[i - size].getPriority() > grid[i].getPriority() && grid[i - size].getDirections()[2] == true) {
	        			grid[i].setPriority(grid[i - size].getPriority() -1);
	        			grid[i].flood();
	        			water = true;
	        		}
	        	}
	        	if (directions[2] == true && grid[i].getRowv() != size-1) {
	        		if (grid[i + size].getPriority() > grid[i].getPriority() && grid[i + size].getDirections()[0] == true) {
	        			grid[i].setPriority(grid[i + size].getPriority() -1);
	        			grid[i].flood();
	        			water = true;
	        		}
	        	}
	        	if (directions[1] == true && grid[i].getColumn() != size-1) {
	        		if (grid[i + 1].getPriority() > grid[i].getPriority() && grid[i + 1].getDirections()[3] == true) {
	        			grid[i].setPriority(grid[i + 1].getPriority() -1);
	        			grid[i].flood();
	        			water = true;
	        		}
	        	}
	        	if (directions[3] == true && grid[i].getColumn() != 0) {
	        		if (grid[i - 1].getPriority() > grid[i].getPriority() && grid[i - 1].getDirections()[1] == true) {
	        			grid[i].setPriority(grid[i - 1].getPriority() -1);
	        			grid[i].flood();
	        			water = true;
	        		}
	        	}
	        	if (water == false) {
	        		grid[i].dry();
	        	}
        	}
        }
	}

	/*
	//Links neighbouring squares
	public function link(grid:Array<Square>, row:Int){
		var modulo:Int;
		for (i in 0...(grid.length - 1)){
			modulo = i % row;
			if (modulo != 0) grid[i].setLeft(grid[i-1]);
			if (modulo != (row - 1)) grid[i].setRight(grid[i+1]);
			if (i >= row) grid[i].setUp(grid[i - row]);
			if (i < (grid.length - row)) grid[i].setDown(grid[i + row]);
		}
	}
	*/

	//Grid 1
	public function grid1(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Right", 0, 3));
	    grid.push(new Square("Segment", 1, 3));
	    grid.push(new Square("Right", 2, 3));
	    grid.push(new Square("Terminus", 3, 3));
	    grid.push(new Square("Start", 4, 3));
	    grid.push(new Square("Intersection", 5, 3));
	    grid.push(new Square("Terminus", 6, 3));
	    grid.push(new Square("Segment", 7, 3));
	    grid.push(new Square("Right", 8, 3));

	    return grid;
	}

	//Grid 2
	public function grid2(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Right", 0, 3));
	    grid.push(new Square("Segment", 1, 3));
	    grid.push(new Square("Terminus", 2, 3));
	    grid.push(new Square("Segment", 3, 3));
	    grid.push(new Square("Terminus", 4, 3));
	    grid.push(new Square("Start", 5, 3));
	    grid.push(new Square("Right", 6, 3));
	    grid.push(new Square("Intersection", 7, 3));
	    grid.push(new Square("Right", 8, 3));

	    return grid;
	}

	//Grid 3
	public function grid3(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Terminus", 0, 4));
	    grid.push(new Square("Intersection", 1, 4));
	    grid.push(new Square("Intersection", 2, 4));
	    grid.push(new Square("Terminus", 3, 4));
	    grid.push(new Square("Start", 4, 4));
	    grid.push(new Square("Intersection", 5, 4));
	    grid.push(new Square("Intersection", 6, 4));
	    grid.push(new Square("Right", 7, 4));
	    grid.push(new Square("Right", 8, 4));
	    grid.push(new Square("Right", 9, 4));
	    grid.push(new Square("Segment", 10, 4));
	    grid.push(new Square("Terminus", 11, 4));
	    grid.push(new Square("Terminus", 12, 4));
	    grid.push(new Square("Terminus", 13, 4));
	    grid.push(new Square("Intersection", 14, 4));
	    grid.push(new Square("Terminus", 15, 4));

	    return grid;
	}

	//Grid 4
	public function grid4(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Terminus", 0, 4));
	    grid.push(new Square("Terminus", 1, 4));
	    grid.push(new Square("Intersection", 2, 4));
	    grid.push(new Square("Terminus", 3, 4));
	    grid.push(new Square("Intersection", 4, 4));
	    grid.push(new Square("Segment", 5, 4));
	    grid.push(new Square("Intersection", 6, 4));
	    grid.push(new Square("Terminus", 7, 4));
	    grid.push(new Square("Intersection", 8, 4));
	    grid.push(new Square("Start", 9, 4));
	    grid.push(new Square("Intersection", 10, 4));
	    grid.push(new Square("Right", 11, 4));
	    grid.push(new Square("Right", 12, 4));
	    grid.push(new Square("Terminus", 13, 4));
	    grid.push(new Square("Right", 14, 4));
	    grid.push(new Square("Terminus", 15, 4));

	    return grid;
	}

	//Grid 5
	public function grid5(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Terminus", 0, 4));
	    grid.push(new Square("Segment", 1, 4));
	    grid.push(new Square("Intersection", 2, 4));
	    grid.push(new Square("Terminus", 3, 4));
	    grid.push(new Square("Terminus", 4, 4));
	    grid.push(new Square("Terminus", 5, 4));
	    grid.push(new Square("Intersection", 6, 4));
	    grid.push(new Square("Right", 7, 4));
	    grid.push(new Square("Intersection", 8, 4));
	    grid.push(new Square("Intersection", 9, 4));
	    grid.push(new Square("Intersection", 10, 4));
	    grid.push(new Square("Segment", 11, 4));
	    grid.push(new Square("Right", 12, 4));
	    grid.push(new Square("Terminus", 13, 4));
	    grid.push(new Square("Terminus", 14, 4));
	    grid.push(new Square("Start", 15, 4));

	    return grid;
	}

	//Grid 6
	public function grid6(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Terminus", 0, 4));
	    grid.push(new Square("Right", 1, 4));
	    grid.push(new Square("Terminus", 2, 4));
	    grid.push(new Square("Terminus", 3, 4));
	    grid.push(new Square("Segment", 4, 4));
	    grid.push(new Square("Segment", 5, 4));
	    grid.push(new Square("Start", 6, 4));
	    grid.push(new Square("Intersection", 7, 4));
	    grid.push(new Square("Intersection", 8, 4));
	    grid.push(new Square("Intersection", 9, 4));
	    grid.push(new Square("Intersection", 10, 4));
	    grid.push(new Square("Intersection", 11, 4));
	    grid.push(new Square("Right", 12, 4));
	    grid.push(new Square("Terminus", 13, 4));
	    grid.push(new Square("Terminus", 14, 4));
	    grid.push(new Square("Terminus", 15, 4));

	    return grid;
	}

	//Grid 7
	public function grid7(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Terminus", 0, 6));
	    grid.push(new Square("Right", 1, 6));
	    grid.push(new Square("Terminus", 2, 6));
	    grid.push(new Square("Right", 3, 6));
	    grid.push(new Square("Terminus", 4, 6));
	    grid.push(new Square("Terminus", 5, 6));
	    grid.push(new Square("Right", 6, 6));
	    grid.push(new Square("Intersection", 7, 6));
	    grid.push(new Square("Intersection", 8, 6));
	    grid.push(new Square("Intersection", 9, 6));
	    grid.push(new Square("Terminus", 10, 6));
	    grid.push(new Square("Segment", 11, 6));
	    grid.push(new Square("Right", 12, 6));
	    grid.push(new Square("Right", 13, 6));
	    grid.push(new Square("Terminus", 14, 6));
	    grid.push(new Square("Intersection", 15, 6));
	    grid.push(new Square("Right", 16, 6));
	    grid.push(new Square("Segment", 17, 6));
	    grid.push(new Square("Terminus", 18, 6));
	    grid.push(new Square("Right", 19, 6));
	    grid.push(new Square("Intersection", 20, 6));
	    grid.push(new Square("Segment", 21, 6));
	    grid.push(new Square("Segment", 22, 6));
	    grid.push(new Square("Intersection", 23, 6));
	    grid.push(new Square("Intersection", 24, 6));
	    grid.push(new Square("Right", 25, 6));
	    grid.push(new Square("Segment", 26, 6));
	    grid.push(new Square("Terminus", 27, 6));
	    grid.push(new Square("Terminus", 28, 6));
	    grid.push(new Square("Right", 29, 6));
	    grid.push(new Square("Terminus", 30, 6));
	    grid.push(new Square("Right", 31, 6));
	    grid.push(new Square("Intersection", 32, 6));
	    grid.push(new Square("Intersection", 33, 6));
	    grid.push(new Square("Segment", 34, 6));
	    grid.push(new Square("Start", 35, 6));

	    return grid;
	}

	//Grid 8
	public function grid8(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Right", 0, 6));
	    grid.push(new Square("Intersection", 1, 6));
	    grid.push(new Square("Right", 2, 6));
	    grid.push(new Square("Right", 3, 6));
	    grid.push(new Square("Segment", 4, 6));
	    grid.push(new Square("Terminus", 5, 6));
	    grid.push(new Square("Segment", 6, 6));
	    grid.push(new Square("Terminus", 7, 6));
	    grid.push(new Square("Segment", 8, 6));
	    grid.push(new Square("Segment", 9, 6));
	    grid.push(new Square("Right", 10, 6));
	    grid.push(new Square("Terminus", 11, 6));
	    grid.push(new Square("Intersection", 12, 6));
	    grid.push(new Square("Terminus", 13, 6));
	    grid.push(new Square("Intersection", 14, 6));
	    grid.push(new Square("Intersection", 15, 6));
	    grid.push(new Square("Intersection", 16, 6));
	    grid.push(new Square("Right", 17, 6));
	    grid.push(new Square("Right", 18, 6));
	    grid.push(new Square("Right", 19, 6));
	    grid.push(new Square("Segment", 20, 6));
	    grid.push(new Square("Start", 21, 6));
	    grid.push(new Square("Terminus", 22, 6));
	    grid.push(new Square("Intersection", 23, 6));
	    grid.push(new Square("Terminus", 24, 6));
	    grid.push(new Square("Right", 25, 6));
	    grid.push(new Square("Intersection", 26, 6));
	    grid.push(new Square("Right", 27, 6));
	    grid.push(new Square("Right", 28, 6));
	    grid.push(new Square("Intersection", 29, 6));
	    grid.push(new Square("Terminus", 30, 6));
	    grid.push(new Square("Segment", 31, 6));
	    grid.push(new Square("Intersection", 32, 6));
	    grid.push(new Square("Terminus", 33, 6));
	    grid.push(new Square("Terminus", 34, 6));
	    grid.push(new Square("Terminus", 35, 6));

	    return grid;
	}

	//Grid 9
	public function grid9(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Terminus", 0, 6));
	    grid.push(new Square("Intersection", 1, 6));
	    grid.push(new Square("Intersection", 2, 6));
	    grid.push(new Square("Segment", 3, 6));
	    grid.push(new Square("Terminus", 4, 6));
	    grid.push(new Square("Terminus", 5, 6));
	    grid.push(new Square("Terminus", 6, 6));
	    grid.push(new Square("Segment", 7, 6));
	    grid.push(new Square("Segment", 8, 6));
	    grid.push(new Square("Start", 9, 6));
	    grid.push(new Square("Intersection", 10, 6));
	    grid.push(new Square("Right", 11, 6));
	    grid.push(new Square("Right", 12, 6));
	    grid.push(new Square("Right", 13, 6));
	    grid.push(new Square("Intersection", 14, 6));
	    grid.push(new Square("Right", 15, 6));
	    grid.push(new Square("Segment", 16, 6));
	    grid.push(new Square("Terminus", 17, 6));
	    grid.push(new Square("Terminus", 18, 6));
	    grid.push(new Square("Intersection", 19, 6));
	    grid.push(new Square("Right", 20, 6));
	    grid.push(new Square("Terminus", 21, 6)); 
	    grid.push(new Square("Segment", 22, 6));
	    grid.push(new Square("Segment", 23, 6));
	    grid.push(new Square("Right", 24, 6));
	    grid.push(new Square("Intersection", 25, 6));
	    grid.push(new Square("Intersection", 26, 6));
	    grid.push(new Square("Right", 27, 6));
	    grid.push(new Square("Intersection", 28, 6));
	    grid.push(new Square("Intersection", 29, 6));
	    grid.push(new Square("Right", 30, 6));
	    grid.push(new Square("Terminus", 31, 6));
	    grid.push(new Square("Terminus", 32, 6));
	    grid.push(new Square("Right", 33, 6));
	    grid.push(new Square("Right", 34, 6));
	    grid.push(new Square("Terminus", 35, 6));

	    return grid;
	}

	//Grid 10
	public function grid10(grid:Array<Square>):Array<Square>{
	    grid.push(new Square("Right", 0, 10));
	    grid.push(new Square("Intersection", 1, 10));
	    grid.push(new Square("Segment", 2, 10));
	    grid.push(new Square("Segment", 3, 10));
	    grid.push(new Square("Intersection", 4, 10));
	    grid.push(new Square("Terminus", 5, 10));
	    grid.push(new Square("Terminus", 6, 10));
	    grid.push(new Square("Right", 7, 10));
	    grid.push(new Square("Segment", 8, 10));
	    grid.push(new Square("Right", 9, 10));
	    grid.push(new Square("Terminus", 10, 10));
	    grid.push(new Square("Terminus", 11, 10));
	    grid.push(new Square("Terminus", 12, 10));
	    grid.push(new Square("Intersection", 13, 10));
	    grid.push(new Square("Intersection", 14, 10));
	    grid.push(new Square("Terminus", 15, 10));
	    grid.push(new Square("Segment", 16, 10));
	    grid.push(new Square("Intersection", 17, 10));
	    grid.push(new Square("Terminus", 18, 10));
	    grid.push(new Square("Segment", 19, 10));
	    grid.push(new Square("Terminus", 20, 10));
	    grid.push(new Square("Terminus", 21, 10));
	    grid.push(new Square("Intersection", 22, 10));
	    grid.push(new Square("Right", 23, 10));
	    grid.push(new Square("Segment", 24, 10));
	    grid.push(new Square("Intersection", 25, 10));
	    grid.push(new Square("Right", 26, 10));
	    grid.push(new Square("Segment", 27, 10));
	    grid.push(new Square("Right", 28, 10));
	    grid.push(new Square("Right", 29, 10));
	    grid.push(new Square("Segment", 30, 10));
	    grid.push(new Square("Terminus", 31, 10));
	    grid.push(new Square("Segment", 32, 10));
	    grid.push(new Square("Terminus", 33, 10));
	    grid.push(new Square("Start", 34, 10));
	    grid.push(new Square("Segment", 35, 10));
	    grid.push(new Square("Right", 36, 10));
	    grid.push(new Square("Right", 37, 10));
	    grid.push(new Square("Right", 38, 10));
	    grid.push(new Square("Right", 39, 10));
	    grid.push(new Square("Right", 40, 10));
	    grid.push(new Square("Intersection", 41, 10));
	    grid.push(new Square("Intersection", 42, 10));
	    grid.push(new Square("Intersection", 43, 10));
	    grid.push(new Square("Segment", 44, 10));
	    grid.push(new Square("Intersection", 45, 10));
	    grid.push(new Square("Intersection", 46, 10));
	    grid.push(new Square("Right", 47, 10));
	    grid.push(new Square("Right", 48, 10));
	    grid.push(new Square("Right", 49, 10));
	    grid.push(new Square("Right", 50, 10));
	    grid.push(new Square("Intersection", 51, 10));
	    grid.push(new Square("Segment", 52, 10));
	    grid.push(new Square("Segment", 53, 10));
	    grid.push(new Square("Terminus", 54, 10));
	    grid.push(new Square("Intersection", 55, 10));
	    grid.push(new Square("Intersection", 56, 10));
	    grid.push(new Square("Segment", 57, 10));
	    grid.push(new Square("Right", 58, 10));
	    grid.push(new Square("Right", 59, 10));
	    grid.push(new Square("Segment", 60, 10));
	    grid.push(new Square("Terminus", 61, 10));
	    grid.push(new Square("Right", 62, 10));
	    grid.push(new Square("Segment", 63, 10));
	    grid.push(new Square("Intersection", 64, 10));
	    grid.push(new Square("Right", 65, 10));
	    grid.push(new Square("Terminus", 66, 10));
	    grid.push(new Square("Segment", 67, 10));
	    grid.push(new Square("Terminus", 68, 10));
	    grid.push(new Square("Segment", 69, 10));
	    grid.push(new Square("Segment", 70, 10));
	    grid.push(new Square("Terminus", 71, 10));
	    grid.push(new Square("Intersection", 72, 10));
	    grid.push(new Square("Right", 73, 10));
	    grid.push(new Square("Intersection", 74, 10));
	    grid.push(new Square("Right", 75, 10));
	    grid.push(new Square("Intersection", 76, 10));
	    grid.push(new Square("Right", 77, 10));
	    grid.push(new Square("Segment", 78, 10));
	    grid.push(new Square("Segment", 79, 10));
	    grid.push(new Square("Right", 80, 10));
	    grid.push(new Square("Segment", 81, 10));
	    grid.push(new Square("Right", 82, 10));
	    grid.push(new Square("Terminus", 83, 10));
	    grid.push(new Square("Segment", 84, 10));
	    grid.push(new Square("Segment", 85, 10));
	    grid.push(new Square("Right", 86, 10));
	    grid.push(new Square("Segment", 87, 10));
	    grid.push(new Square("Right", 88, 10));
	    grid.push(new Square("Segment", 89, 10));
	    grid.push(new Square("Terminus", 90, 10));
	    grid.push(new Square("Segment", 91, 10));
	    grid.push(new Square("Segment", 92, 10));
	    grid.push(new Square("Segment", 93, 10));
	    grid.push(new Square("Right", 94, 10));
	    grid.push(new Square("Right", 95, 10));
	    grid.push(new Square("Terminus", 96, 10));
	    grid.push(new Square("Terminus", 97, 10));
	    grid.push(new Square("Segment", 98, 10));
	    grid.push(new Square("Right", 99, 10));

	    return grid;
	}

	// timer update function
    function updateTimer(timer:FlxTimer):Void {
        totaltime += 1;

        var minutes = Std.int(totaltime / 60);
        var seconds = Std.int(totaltime % 60);

        timertext.text = minutes + ":" + StringTools.lpad(Std.string(seconds), "0", 2);
    }
}
