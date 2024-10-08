//Summon libraries
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

class Square extends FlxSprite{
	//Boolean to check if water is present
	private var wet:Bool;

	private var sprite:FlxSprite;

	//Rotation
	private var direction:Int;//The direction the pipe faces is an integer between 0 and 3. This number * 90 deg. is the orientation.

	//Adjacent Squares
	private var up:Square;
	private var down:Square;
	private var left:Square;
	private var right:Square;

	//Square numbers
	private var row:Int;
	private var rowv:Int;
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
		row = Std.int((squareNum - column - 1)/rowSize);
		rowv = Std.int(squareNum/rowSize); //row number for visuals

		//Inserts the sprites
		sprite = new FlxSprite(0, 0);
		switch (type) {
			case "Segment":
				sprite.loadGraphic("assets/images/straight-empty.png");
			case "Right":
				sprite.loadGraphic("assets/images/right-empty.png");
			case "Start":
				sprite.loadGraphic("assets/images/start.png");
			case "Terminus":
				sprite.loadGraphic("assets/images/goal.png");
			case "Intersection":
				sprite.loadGraphic("assets/images/T-empty.png");
			default:
		}
		var mover:Float;
		var scaler:Float;
		var starter:Array<Int> = [0, 0];
		switch (rowSize) {
			case 3:
				scaler = 0.4;
				starter = [160, 160];
			case 4:
				scaler = 0.3;
				starter = [150, 150];
			case 6:
				scaler = 0.2;
				starter = [140, 140];
			case 10:
				scaler = 0.125;
				starter = [140, 140];
			default:
				mover = 0;
				scaler = 0;
		}
		mover = 200 * scaler;
		sprite.screenCenter();
		sprite.x -= starter[0] - mover - column * mover;
		sprite.y -= starter[1] - mover - rowv * mover;
		sprite.scale.set(scaler , scaler);

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
	public function getRow():Int{return row;}
	public function getColumn():Int{return column;}
	public function getSprite():FlxSprite{return sprite;}

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
		sprite.angle = direction * 90;
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
				case "Right":
					if (direction >= 2) thisEligible = true;
					else thisEligible = false;
				case "Start":
					if (direction == 3) thisEligible = true;
					else thisEligible = false;
				case "Terminus":
					if (direction == 3) thisEligible = true;
					else thisEligible = false;
				case "Intersection":
					if (direction == 0) thisEligible = false;
					else thisEligible = true;
				default:
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
					case "Right":
						if (nDirection < 2) upConnect = true;
						else upConnect = false;
					case "Start":
						if (nDirection == 1) upConnect = true;
						else upConnect = false;
					case "Terminus":
						if (nDirection == 1) upConnect = true;
						else upConnect = false;
					case "Intersection":
						if (nDirection == 2) upConnect = false;
						else upConnect = true;
					default:
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
				case "Right":
					if (direction < 2) thisEligible = true;
					else thisEligible = false;
				case "Start":
					if (direction == 1) thisEligible = true;
					else thisEligible = false;
				case "Terminus":
					if (direction == 1) thisEligible = true;
					else thisEligible = false;
				case "Intersection":
					if (direction == 2) thisEligible = false;
					else thisEligible = true;
				default:
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
					case "Right":
						if (nDirection >= 2) downConnect = true;
						else downConnect = false;
					case "Start":
						if (nDirection == 3) downConnect = true;
						else downConnect = false;
					case "Terminus":
						if (nDirection == 3) downConnect = true;
						else downConnect = false;
					case "Intersection":
						if (nDirection == 0) downConnect = false;
						else downConnect = true;
					default:
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
				case "Right":
					if (direction == 1 || direction == 2) thisEligible = true;
					else thisEligible = false;
				case "Start":
					if (direction == 2) thisEligible = true;
					else thisEligible = false;
				case "Terminus":
					if (direction == 2) thisEligible = true;
					else thisEligible = false;
				case "Intersection":
					if (direction == 3) thisEligible = false;
					else thisEligible = true;
				default:
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
					case "Right":
						if (nDirection == 0 || nDirection == 3) leftConnect = true;
						else leftConnect = false;
					case "Start":
						if (nDirection == 0) leftConnect = true;
						else leftConnect = false;
					case "Terminus":
						if (nDirection == 0) leftConnect = true;
						else leftConnect = false;
					case "Intersection":
						if (nDirection == 1) leftConnect = false;
						else leftConnect = true;
					default:
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
				case "Right":
					if (direction == 0 || direction == 3) thisEligible = true;
					else thisEligible = false;
				case "Start":
					if (direction == 0) thisEligible = true;
					else thisEligible = false;
				case "Terminus":
					if (direction == 0) thisEligible = true;
					else thisEligible = false;
				case "Intersection":
					if (direction == 1) thisEligible = false;
					else thisEligible = true;
				default:
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
					case "Right":
						if (nDirection == 1 || nDirection == 2) rightConnect = true;
						else rightConnect = false;
					case "Start":
						if (nDirection == 2) rightConnect = true;
						else rightConnect = false;
					case "Terminus":
						if (nDirection == 2) rightConnect = true;
						else rightConnect = false;
					case "Intersection":
						if (nDirection == 3) rightConnect = false;
						else rightConnect = true;
					default:
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
			if (upConnect) {if (up.moisture()) flood();}
			if (downConnect) {if (down.moisture()) flood();}
			if (leftConnect) {if (left.moisture()) flood();}
			if (rightConnect) {if (right.moisture()) flood();}
		}
	}

	//Ensures accuracy by checking connections and mapping the grid's plumbing network
	public function updateS():Void {
        checkConnections();
        map();

        //Updates the sprites
		switch (type) {
			case "Segment":
				if (wet) sprite.loadGraphic("assets/images/straight-blue.png");
				else sprite.loadGraphic("assets/images/straight-empty.png");
			case "Right":
				if (wet) sprite.loadGraphic("assets/images/right-blue.png");
				else sprite.loadGraphic("assets/images/right-empty.png");
			case "Start":
				if (wet) sprite.loadGraphic("assets/images/start.png");
				else sprite.loadGraphic("assets/images/goal.png");
			case "Terminus":
				if (wet) sprite.loadGraphic("assets/images/start.png");
				else sprite.loadGraphic("assets/images/goal.png");
			case "Intersection":
				if (wet) sprite.loadGraphic("assets/images/T-blue.png");
				else sprite.loadGraphic("assets/images/T-empty.png");
			default:
		}
    }
}