//Summon libraries
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

//Summon libraries we created
import PlayState.Square;
import LevelData;

class PlayState extends FlxState
{
	//The grid
	var grid:Array<Square>;

	//Integers to note level and size
	var level:Int;
	var size:Int;

	//Difficulty
	var difficulty:String;

	//This function prepares the level for creation (back end)
    public function new(level:Int, size:Int){
    	super();
    	this.level = level;
    	this.size = size;
    	grid = [];

    	switch(level){
    		case 10:
    			difficulty = "INSANE";
    			grid = LevelData.grid10();
    			break;
			case 9:
    			difficulty = "HARD";
    			grid = LevelData.grid9();
    			break;
			case 8:
				difficulty = "HARD";
				grid = LevelData.grid8();
				break;
			case 7:
				difficulty = "HARD";
				grid = LevelData.grid7();
				break;
			case 6:
    			difficulty = "MEDIUM";
    			grid = LevelData.grid6();
    			break;
			case 5:
    			difficulty = "MEDIUM";
    			grid = LevelData.grid5();
    			break;
			case 4:
    			difficulty = "MEDIUM";
    			grid = LevelData.grid4();
    			break;
			case 3:
				difficulty = "MEDIUM";
				grid = LevelData.grid3();
				break;
			case 2:
				difficulty = "EASY";
				grid = LevelData.grid2();
				break;
			case 1:
    			difficulty = "EASY";
    			grid = LevelData.grid1();
    			break;
			default:
				break;
    	}
    }

    override public function create():Void
    {
        super.create();

        //Sets background colour
        this.bgColor = 0xFF000000;

        var title = new FlxText(0, 0, 0, "Hello, World!");
        title.screenCenter();
        add(title);

        //I DID NOT PUT MY WORK HERE AS I'M STILL WORKING ON THAT. IT WILL BE POSTED LATER ON
    }

    //The function to return to main menu and to reset level
    public function goToMenu(){FlxG.switchState(new MenuState());}
    public function reset(){FlxG.switchState(new PlayState(level, size));}

    override public function update(elapsed:Float)
	{
		super.update(elapsed);

		//THIS NEEDS SOME WORK TOO - ESPECIALLY IF WE ADD A TIMER
	}
}