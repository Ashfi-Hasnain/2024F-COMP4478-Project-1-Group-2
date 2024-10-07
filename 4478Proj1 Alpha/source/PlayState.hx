//Summon libraries
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

//Summon libraries we created
import PlayState.Square;
import LevelData;

class Square extends FlxState{
	//Boolean to check if water is present
	private var wet:Bool;

	//Rotation
	private var direction:Int;//The direction the pipe faces is an integer between 0 and 3. This number * 90 deg. is the orientation.

	//Adjacent Squares
	private var up:Square;
	private var down:Square;
	private var left:Square;
	private var right:Square;

	//Square numbers
	private var row:Int;
	private var column:Int;
	private var squareNum:Int;

	//Type of pipe (Start, Segment, Turn, Junction, or Terminus)
	private var type:String;

	//Checks connection
	private var upConnect:Bool;
	private var downConnect:Bool;
	private var leftConnect:Bool;
	private var rightConnect:Bool;

	//Initialises the cell
	public function new(type:String, squareNum:Int, rowSize:Int){
		super();

		//Finds type, and determines if it is water source or not
		//Initially, only the source is wet. This will be updated to include cells connected to source.
		this.type = type;
		if (type == "Start") wet = true;
		else wet = false;

		//Stores square numbers
		this.squareNum = squareNum;
		column = squareNum % rowSize;
		row = (squareNum - column - 1)/rowSize;

		//Assigns a random orientation (0, 1, 2, or 3)
		direction = Math.floor(Math.random() % 4);

		//Neighbours are not identified yet
		up = null;
		down = null;
		left = null;
		right = null;
	}

	//Mutators for the neighbours
	public function setUp(up:Square) {this.up = up;}
	public function setDown(down:Square) {this.down = down;}
	public function setLeft(left:Square) {this.left = left;}
	public function setRight(right:Square) {this.right = right;}

	//Accessors
	public function seeType():String {return type;}
	public function seeDir():Int{return direction;}
	public function moisture():Bool{return wet;}

	//Methods to fill or clear the pipes
	public function flood(){if (!wet) wet = true;}
	public function dry(){
		if (type == "Start") return; //Ensures source does not run dry
		else wet = false;
	}

	//Performs rotations (by 90 degrees)
	public function rotate(){
		direction++;
		if (direction == 4) direction = 0;
	}

	//Updates squares
	public function checkConnections() {
		//Booleans to see if a connection is possible or not
		var thisEligible = true;

		//Stores type, orientation, and moisture of neighbour
		var neighbour:String;
		var nDirection:Int;

		if (up != null){
			switch (type) {
				//Determines if this pipe is facing up
				case "Segment":
					if (direction % 2 == 0) thisEligible = false;
					else thisEligible = true;
					break;
				case "Right":
					if (direction >= 2) thisEligible = true;
					else thisEligible = false;
					break;
				case "Start":
					if (direction == 3) thisEligible = true;
					else thisEligible = false;
					break;
				case "Terminus":
					if (direction == 3) thisEligible = true;
					else thisEligible = false;
					break;
				case "Intersection":
					if (direction == 0) thisEligible = false;
					else thisEligible = true;
					break;
				default:
					break;
			}

			//If so, ensures neighbouring pipe facing down
			if (thisEligible){
				neighbour = up.seeType();
				nDirection = up.seeDir();

				switch (neighbour) {
					//Determines if neighbouring pipe is facing down
					case "Segment":
						if (nDirection % 2 == 0) upConnect = false;
						else upConnect = true;
						break;
					case "Right":
						if (nDirection < 2) upConnect = true;
						else upConnect = false;
						break;
					case "Start":
						if (nDirection == 1) upConnect = true;
						else upConnect = false;
						break;
					case "Terminus":
						if (nDirection == 1) upConnect = true;
						else upConnect = false;
						break;
					case "Intersection":
						if (nDirection == 2) upConnect = false;
						else upConnect = true;
						break;
					default:
						break;
				}
			}
		}
		else upConnect = false;

		if (down != null){
			switch (type) {
				//Determines if this pipe is facing down
				case "Segment":
					if (direction % 2 == 0) thisEligible = false;
					else thisEligible = true;
					break;
				case "Right":
					if (direction < 2) thisEligible = true;
					else thisEligible = false;
					break;
				case "Start":
					if (direction == 1) thisEligible = true;
					else thisEligible = false;
					break;
				case "Terminus":
					if (direction == 1) thisEligible = true;
					else thisEligible = false;
					break;
				case "Intersection":
					if (direction == 2) thisEligible = false;
					else thisEligible = true;
					break;
				default:
					break;
			}

			//If so, ensures neighbouring pipe facing up
			if (thisEligible){
				neighbour = down.seeType();
				nDirection = down.seeDir();

				switch (neighbour) {
					//Determines if neighbouring pipe is facing up
					case "Segment":
						if (nDirection % 2 == 0) downConnect = false;
						else downConnect = true;
						break;
					case "Right":
						if (nDirection >= 2) downConnect = true;
						else downConnect = false;
						break;
					case "Start":
						if (nDirection == 3) downConnect = true;
						else downConnect = false;
						break;
					case "Terminus":
						if (nDirection == 3) downConnect = true;
						else downConnect = false;
						break;
					case "Intersection":
						if (nDirection == 0) downConnect = false;
						else downConnect = true;
						break;
					default:
						break;
				}
			}
		}
		else downConnect = false;

		if (left != null){
			switch (type) {
				//Determines if this pipe is facing left
				case "Segment":
					if (direction % 2 == 1) thisEligible = false;
					else thisEligible = true;
					break;
				case "Right":
					if (direction == 1 || direction == 2) thisEligible = true;
					else thisEligible = false;
					break;
				case "Start":
					if (direction == 2) thisEligible = true;
					else thisEligible = false;
					break;
				case "Terminus":
					if (direction == 2) thisEligible = true;
					else thisEligible = false;
					break;
				case "Intersection":
					if (direction == 3) thisEligible = false;
					else thisEligible = true;
					break;
				default:
					break;
			}

			//If so, ensures neighbouring pipe facing right
			if (thisEligible){
				neighbour = left.seeType();
				nDirection = left.seeDir();

				switch (neighbour) {
					//Determines if neighbouring pipe is facing right
					case "Segment":
						if (nDirection % 2 == 1) leftConnect = false;
						else leftConnect = true;
						break;
					case "Right":
						if (nDirection == 0 || nDirection == 3) leftConnect = true;
						else leftConnect = false;
						break;
					case "Start":
						if (nDirection == 0) leftConnect = true;
						else leftConnect = false;
						break;
					case "Terminus":
						if (nDirection == 0) leftConnect = true;
						else leftConnect = false;
						break;
					case "Intersection":
						if (nDirection == 1) leftConnect = false;
						else leftConnect = true;
						break;
					default:
						break;
				}
			}
		}
		else leftConnect = false;

		if (right != null){
			switch (type) {
				//Determines if this pipe is facing right
				case "Segment":
					if (direction % 2 == 1) thisEligible = false;
					else thisEligible = true;
					break;
				case "Right":
					if (direction == 0 || direction == 3) thisEligible = true;
					else thisEligible = false;
					break;
				case "Start":
					if (direction == 0) thisEligible = true;
					else thisEligible = false;
					break;
				case "Terminus":
					if (direction == 0) thisEligible = true;
					else thisEligible = false;
					break;
				case "Intersection":
					if (direction == 1) thisEligible = false;
					else thisEligible = true;
					break;
				default:
					break;
			}

			//If so, ensures neighbouring pipe facing left
			if (thisEligible){
				neighbour = right.seeType();
				nDirection = right.seeDir();


				switch (neighbour) {
					//Determines if neighbouring pipe is facing left
					case "Segment":
						if (nDirection % 2 == 1) rightConnect = false;
						else rightConnect = true;
						break;
					case "Right":
						if (nDirection == 1 || nDirection == 2) rightConnect = true;
						else rightConnect = false;
						break;
					case "Start":
						if (nDirection == 2) rightConnect = true;
						else rightConnect = false;
						break;
					case "Terminus":
						if (nDirection == 2) rightConnect = true;
						else rightConnect = false;
						break;
					case "Intersection":
						if (nDirection == 3) rightConnect = false;
						else rightConnect = true;
						break;
					default:
						break;
				}
			}
		}
		else rightConnect = false;
	}

	//Ensures the correct pipes are filled
	public function map(){
		//Ensures the correct pipes are filled
		if (type == "Start") {
			flood();
			return;
		}
		else {
			dry();
			//If connected to a filled pipe then let this fill too
			if (upConnect) if (up.moisture) flood();
			if (downConnect) if (down.moisture) flood();
			if (leftConnect) if (left.moisture) flood();
			if (rightConnect) if (right.moisture) flood();
		}
	}

	//Ensures accuracy by checking connections and mapping the grid's plumbing network
	override public function update(elapsed:Float):Void {
        super.update(elapsed);
        checkConnections();
        map();

        //THIS IS THE WHERE THE GRAPHICS SHOULD BE HANDELED
    }
}

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
