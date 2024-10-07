//Summon libraries
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

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

	//Links neighbouring squares
	public function link(grid:Array<Square>, row:Int){
		var modulo:Int;
		for (i in 0..(grid.Size - 1)){
			modulo = i % row;
			if (modulo != 0) grid[i].setLeft(grid[i-1]);
			if (modulo != (row - 1)) grid[i].setRight(grid[i+1]);
			if (i >= row) grid[i].setUp(grid[i - row]);
			if (i < (grid.Size - row)) grid.setDown(grid[i + row]);
		}
	}

	//Grid 1
	public function grid1(grid:Array<Square>):Array<Square>{
		grid.add(new Square("Right", 0, 3));
		grid.add(new Square("Segment", 1, 3));
		grid.add(new Square("Right", 2, 3));
		grid.add(new Square("Terminus", 3, 3));
		grid.add(new Square("Start", 4, 3));
		grid.add(new Square("Intersection", 5, 3));
		grid.add(new Square("Terminus", 6, 3));
		grid.add(new Square("Straight", 7, 3));
		grid.add(new Square("Right", 8, 3));

		link(grid);

		return grid;
	}

	//Grid 2
	public function grid2(grid:Array<Square>):Array<Square>{
		grid.add(new Square("Right", 0, 3));
		grid.add(new Square("Segment", 1, 3));
		grid.add(new Square("Terminus", 2, 3));
		grid.add(new Square("Segment", 3, 3));
		grid.add(new Square("Terminus", 4, 3));
		grid.add(new Square("Start", 5, 3));
		grid.add(new Square("Right", 6, 3));
		grid.add(new Square("Intersection", 7, 3));
		grid.add(new Square("Right", 8, 3));

		link(grid);

		return grid;
	}

	//Grid 3
	public function grid3(grid:Array<Square>):Array<Square>{
		grid.add(new Square("Terminus", 0, 4));
		grid.add(new Square("Intersection", 1, 4));
		grid.add(new Square("Intersection", 2, 4));
		grid.add(new Square("Terminus", 3, 4));
		grid.add(new Square("Start", 4, 4));
		grid.add(new Square("Intersection", 5, 4));
		grid.add(new Square("Intersection", 6, 4));
		grid.add(new Square("Right", 7, 4));
		grid.add(new Square("Right", 8, 4));
		grid.add(new Square("Right", 9, 4));
		grid.add(new Square("Segment", 10, 4));
		grid.add(new Square("Terminus", 11, 4));
		grid.add(new Square("Terminus", 12, 4));
		grid.add(new Square("Terminus", 13, 4));
		grid.add(new Square("Intersection", 14, 4));
		grid.add(new Square("Terminus", 15, 4));

		link(grid);

		return grid;
	}

	//Grid 4
	public function grid4(grid:Array<Square>):Array<Square>{
		grid.add(new Square("Terminus", 0, 4));
		grid.add(new Square("Terminus", 1, 4));
		grid.add(new Square("Intersection", 2, 4));
		grid.add(new Square("Terminus", 3, 4));
		grid.add(new Square("Intersection", 4, 4));
		grid.add(new Square("Segment", 5, 4));
		grid.add(new Square("Intersection", 6, 4));
		grid.add(new Square("Terminus", 7, 4));
		grid.add(new Square("Intersection", 8, 4));
		grid.add(new Square("Start", 9, 4));
		grid.add(new Square("Intersection", 10, 4));
		grid.add(new Square("Right", 11, 4));
		grid.add(new Square("Right", 12, 4));
		grid.add(new Square("Terminus", 13, 4));
		grid.add(new Square("Right", 14, 4));
		grid.add(new Square("Terminus", 15, 4));

		link(grid);

		return grid;
	}

	//Grid 5
	public function grid5(grid:Array<Square>):Array<Square>{
		grid.add(new Square("Terminus", 0, 4));
		grid.add(new Square("Straight", 1, 4));
		grid.add(new Square("Intersection", 2, 4));
		grid.add(new Square("Terminus", 3, 4));
		grid.add(new Square("Terminus", 4, 4));
		grid.add(new Square("Terminus", 5, 4));
		grid.add(new Square("Intersection", 6, 4));
		grid.add(new Square("Right", 7, 4));
		grid.add(new Square("Intersection", 8, 4));
		grid.add(new Square("Intersection", 9, 4));
		grid.add(new Square("Intersection", 10, 4));
		grid.add(new Square("Straight", 11, 4));
		grid.add(new Square("Right", 12, 4));
		grid.add(new Square("Terminus", 13, 4));
		grid.add(new Square("Terminus", 14, 4));
		grid.add(new Square("Start", 15, 4));

		link(grid);

		return grid;
	}

	//Grid 6
	public function grid6(grid:Array<Square>):Array<Square>{
		grid.add(new Square("Terminus", 0, 4));
		grid.add(new Square("Right", 1, 4));
		grid.add(new Square("Terminus", 2, 4));
		grid.add(new Square("Terminus", 3, 4));
		grid.add(new Square("Straight", 4, 4));
		grid.add(new Square("Straight", 5, 4));
		grid.add(new Square("Start", 6, 4));
		grid.add(new Square("Intersection", 7, 4));
		grid.add(new Square("Intersection", 8, 4));
		grid.add(new Square("Intersection", 9, 4));
		grid.add(new Square("Intersection", 10, 4));
		grid.add(new Square("Intersection", 11, 4));
		grid.add(new Square("Right", 12, 4));
		grid.add(new Square("Terminus", 13, 4));
		grid.add(new Square("Terminus", 14, 4));
		grid.add(new Square("Terminus", 15, 4));

		link(grid);

		return grid;
	}

		//Grid 7
		public function grid6(grid:Array<Square>):Array<Square>{
			grid.add(new Square("Terminus", 0, 6));
			grid.add(new Square("Right", 1, 6));
			grid.add(new Square("Terminus", 2, 6));
			grid.add(new Square("Right", 3, 6));
			grid.add(new Square("Terminus", 4, 6));
			grid.add(new Square("Terminus", 5, 6));
			grid.add(new Square("Right", 6, 6));
			grid.add(new Square("Intersection", 7, 6));
			grid.add(new Square("Intersection", 8, 6));
			grid.add(new Square("Intersection", 9, 6));
			grid.add(new Square("Terminus", 10, 6));
			grid.add(new Square("Straight", 11, 6));
			grid.add(new Square("Right", 12, 6));
			grid.add(new Square("Right", 13, 6));
			grid.add(new Square("Terminus", 14, 6));
			grid.add(new Square("Intersection", 15, 6));
			grid.add(new Square("Right", 16, 6));
			grid.add(new Square("Straight", 17, 6));
			grid.add(new Square("Terminus", 18, 6));
			grid.add(new Square("Right", 19, 6));
			grid.add(new Square("Intersection", 20, 6));
			grid.add(new Square("Straight", 21, 6));
			grid.add(new Square("Straight", 22, 6));
			grid.add(new Square("Intersection", 23, 6));
			grid.add(new Square("Intersection", 24, 6));
			grid.add(new Square("Right", 25, 6));
			grid.add(new Square("Straight", 26, 6));
			grid.add(new Square("Terminus", 27, 6));
			grid.add(new Square("Terminus", 28, 6));
			grid.add(new Square("Right", 29, 6));
			grid.add(new Square("Terminus", 30, 6));
			grid.add(new Square("Right", 31, 6));
			grid.add(new Square("Intersection", 32, 6));
			grid.add(new Square("Intersection", 33, 6));
			grid.add(new Square("Straight", 34, 6));
			grid.add(new Square("Start", 35, 6));
	
			link(grid);
	
			return grid;
		}

			//Grid 8
			public function grid6(grid:Array<Square>):Array<Square>{
				grid.add(new Square("Right", 0, 6));
				grid.add(new Square("Intersection", 1, 6));
				grid.add(new Square("Right", 2, 6));
				grid.add(new Square("Right", 3, 6));
				grid.add(new Square("Straight", 4, 6));
				grid.add(new Square("Terminus", 5, 6));
				grid.add(new Square("Straight", 6, 6));
				grid.add(new Square("Terminus", 7, 6));
				grid.add(new Square("Straight", 8, 6));
				grid.add(new Square("Straight", 9, 6));
				grid.add(new Square("Right", 10, 6));
				grid.add(new Square("Terminus", 11, 6));
				grid.add(new Square("Intersection", 12, 6));
				grid.add(new Square("Terminus", 13, 6));
				grid.add(new Square("Intersection", 14, 6));
				grid.add(new Square("Intersection", 15, 6));
				grid.add(new Square("Intersection", 16, 6));
				grid.add(new Square("Right", 17, 6));
				grid.add(new Square("Right", 18, 6));
				grid.add(new Square("Right", 19, 6));
				grid.add(new Square("Straight", 20, 6));
				grid.add(new Square("Start", 21, 6));
				grid.add(new Square("Terminus", 22, 6));
				grid.add(new Square("Intersection", 23, 6));
				grid.add(new Square("Terminus", 24, 6));
				grid.add(new Square("Right", 25, 6));
				grid.add(new Square("Intersection", 26, 6));
				grid.add(new Square("Right", 27, 6));
				grid.add(new Square("Right", 28, 6));
				grid.add(new Square("Intersection", 29, 6));
				grid.add(new Square("Terminus", 30, 6));
				grid.add(new Square("Straight", 31, 6));
				grid.add(new Square("Intersection", 32, 6));
				grid.add(new Square("Terminus", 33, 6));
				grid.add(new Square("Terminus", 34, 6));
				grid.add(new Square("Terminus", 35, 6));
					
			link(grid);
	
			return grid;
		//Grid 9
		public function grid6(grid:Array<Square>):Array<Square>{
			grid.add(new Square("Terminus", 0, 6));
			grid.add(new Square("Intersection", 1, 6));
			grid.add(new Square("Intersection", 2, 6));
			grid.add(new Square("Straight", 3, 6));
			grid.add(new Square("Terminus", 4, 6));
			grid.add(new Square("Terminus", 5, 6));
			grid.add(new Square("Terminus", 6, 6));
			grid.add(new Square("Straight", 7, 6));
			grid.add(new Square("Straight", 8, 6));
			grid.add(new Square("Start", 9, 6));
			grid.add(new Square("Intersection", 10, 6));
			grid.add(new Square("Right", 11, 6));
			grid.add(new Square("Right", 12, 6));
			grid.add(new Square("Right", 13, 6));
			grid.add(new Square("Intersection", 14, 6));
			grid.add(new Square("Right", 15, 6));
			grid.add(new Square("Straight", 16, 6));
			grid.add(new Square("Terminus", 17, 6));
			grid.add(new Square("Terminus", 18, 6));
			grid.add(new Square("Intersection", 19, 6));
			grid.add(new Square("Right", 20, 6));
			grid.add(new Square("Terminus", 21, 6)); 
			grid.add(new Square("Straight", 22, 6));
			grid.add(new Square("Straight", 23, 6));
			grid.add(new Square("Right", 24, 6));
			grid.add(new Square("Intersection", 25, 6));
			grid.add(new Square("Intersection", 26, 6));
			grid.add(new Square("Right", 27, 6));
			grid.add(new Square("Intersection", 28, 6));
			grid.add(new Square("Intersection", 29, 6));
			grid.add(new Square("Right", 30, 6));
			grid.add(new Square("Terminus", 31, 6));
			grid.add(new Square("Terminus", 32, 6));
			grid.add(new Square("Right", 33, 6));
			grid.add(new Square("Right", 34, 6));
			grid.add(new Square("Terminus", 35, 6));
				
		link(grid);

		return grid;
		}

			//Grid 10
	public function grid6(grid:Array<Square>):Array<Square>{
			grid.add(new Square("Right", 0, 10));
			grid.add(new Square("Intersection", 1, 10));
			grid.add(new Square("Straight", 2, 10));
			grid.add(new Square("Straight", 3, 10));
			grid.add(new Square("Intersection", 4, 10));
			grid.add(new Square("Terminus", 5, 10));
			grid.add(new Square("Terminus", 6, 10));
			grid.add(new Square("Right", 7, 10));
			grid.add(new Square("Straight", 8, 10));
			grid.add(new Square("Right", 9, 10));
			grid.add(new Square("Terminus", 10, 10));
			grid.add(new Square("Terminus", 11, 10));
			grid.add(new Square("Terminus", 12, 10));
			grid.add(new Square("Intersection", 13, 10));
			grid.add(new Square("Intersection", 14, 10));
			grid.add(new Square("Terminus", 15, 10));
			grid.add(new Square("Straight", 16, 10));
			grid.add(new Square("Intersection", 17, 10));
			grid.add(new Square("Terminus", 18, 10));
			grid.add(new Square("Straight", 19, 10));
			grid.add(new Square("Terminus", 20, 10));
			grid.add(new Square("Terminus", 21, 10));
			grid.add(new Square("Intersection", 22, 10));
			grid.add(new Square("Right", 23, 10));
			grid.add(new Square("Straight", 24, 10));
			grid.add(new Square("Intersection", 25, 10));
			grid.add(new Square("Right", 26, 10));
			grid.add(new Square("Straight", 27, 10));
			grid.add(new Square("Right", 28, 10));
			grid.add(new Square("Right", 29, 10));
			grid.add(new Square("Straight", 30, 10));
			grid.add(new Square("Terminus", 31, 10));
			grid.add(new Square("Straight", 32, 10));
			grid.add(new Square("Terminus", 33, 10));
			grid.add(new Square("Start", 34, 10));
			grid.add(new Square("Straight", 35, 10));
			grid.add(new Square("Right", 36, 10));
			grid.add(new Square("Right", 37, 10));
			grid.add(new Square("Right", 38, 10));
			grid.add(new Square("Right", 39, 10));
			grid.add(new Square("Right", 40, 10));
			grid.add(new Square("Intersection", 41, 10));
			grid.add(new Square("Intersection", 42, 10));
			grid.add(new Square("Intersection", 43, 10));
			grid.add(new Square("Straight", 44, 10));
			grid.add(new Square("Intersection", 45, 10));
			grid.add(new Square("Intersection", 46, 10));
			grid.add(new Square("Right", 47, 10));
			grid.add(new Square("Right", 48, 10));
			grid.add(new Square("Right", 49, 10));
			grid.add(new Square("Right", 50, 10));
			grid.add(new Square("Intersection", 51, 10));
			grid.add(new Square("Straight", 52, 10));
			grid.add(new Square("Straight", 53, 10));
			grid.add(new Square("Terminus", 54, 10));
			grid.add(new Square("Intersection", 55, 10));
			grid.add(new Square("Intersection", 56, 10));
			grid.add(new Square("Straight", 57, 10));
			grid.add(new Square("Right", 58, 10));
			grid.add(new Square("Right", 59, 10));
			grid.add(new Square("Straight", 60, 10));
			grid.add(new Square("Terminus", 61, 10));
			grid.add(new Square("Right", 62, 10));
			grid.add(new Square("Straight", 63, 10));
			grid.add(new Square("Intersection", 64, 10));
			grid.add(new Square("Right", 65, 10));
			grid.add(new Square("Terminus", 66, 10));
			grid.add(new Square("Straight", 67, 10));
			grid.add(new Square("Terminus", 68, 10));
			grid.add(new Square("Straight", 69, 10));
			grid.add(new Square("Straight", 70, 10));
			grid.add(new Square("Terminus", 71, 10));
			grid.add(new Square("Intersection", 72, 10));
			grid.add(new Square("Right", 73, 10));
			grid.add(new Square("Intersection", 74, 10));
			grid.add(new Square("Right", 75, 10));
			grid.add(new Square("Intersection", 76, 10));
			grid.add(new Square("Right", 77, 10));
			grid.add(new Square("Straight", 78, 10));
			grid.add(new Square("Straight", 79, 10));
			grid.add(new Square("Right", 80, 10));
			grid.add(new Square("Straight", 81, 10));
			grid.add(new Square("Right", 82, 10));
			grid.add(new Square("Terminus", 83, 10));
			grid.add(new Square("Straight", 84, 10));
			grid.add(new Square("Straight", 85, 10));
			grid.add(new Square("Right", 86, 10));
			grid.add(new Square("Straight", 87, 10));
			grid.add(new Square("Right", 88, 10));
			grid.add(new Square("Straight", 89, 10));
			grid.add(new Square("Terminus", 90, 10));
			grid.add(new Square("Straight", 91, 10));
			grid.add(new Square("Straight", 92, 10));
			grid.add(new Square("Straight", 93, 10));
			grid.add(new Square("Right", 94, 10));
			grid.add(new Square("Right", 95, 10));
			grid.add(new Square("Terminus", 96, 10));
			grid.add(new Square("Terminus", 97, 10));
			grid.add(new Square("Straight", 98, 10));
			grid.add(new Square("Right", 99, 10));

		link(grid);

		return grid;
	}
}
