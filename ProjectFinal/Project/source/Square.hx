//Summon libraries
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

class Square extends FlxSprite{
	//Boolean to check if water is present
	private var wet:Bool;

	private var sprite:FlxSprite;
	private var priority:Int = 0;

	//Rotation
	private var direction:Int = 0;//The direction the pipe faces is an integer between 0 and 3. This number * 90 deg. is the orientation.

	//Square numbers
	private var row:Int;
	private var rowv:Int;
	private var column:Int;
	private var squareNum:Int;

	//Type of pipe (Start, Segment, Turn, Junction, or Terminus)
	private var type:String;

	//connections
	private var up:Bool = false;
	private var down:Bool = false;
	private var left:Bool = false;
	private var right:Bool = false;

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
				left = true;
				right = true;
			case "Right":
				sprite.loadGraphic("assets/images/right-empty.png");
				down = true;
				right = true;
			case "Start":
				sprite.loadGraphic("assets/images/start.png");
				right = true;
				priority = 100;
			case "Terminus":
				sprite.loadGraphic("assets/images/goal.png");
				right = true;
			case "Intersection":
				sprite.loadGraphic("assets/images/T-empty.png");
				right = true;
				down = true;
				left = true;
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
		for (i in 0...Math.floor(Math.random() % 4)) {
			this.rotate();
		}
	}

	//Accessors
	public function seeType():String {return type;}
	public function seeDir():Int{return direction;}
	public function moisture():Bool{return wet;}
	public function setPriority(priority:Int):Void{this.priority = priority;}
	public function getRow():Int{return row;}
	public function getRowv():Int{return rowv;}
	public function getColumn():Int{return column;}
	public function getSprite():FlxSprite{return sprite;}
	public function getDirections():Array<Bool>{return [up, right, down, left];}
	public function getPriority():Int{return priority;}

	//Methods to fill or clear the pipes
	public function flood(){
		if (!wet) {
			wet = true;
			this.updateS();
		}
	}
	public function dry(){
		if (type == "Start") return; //Ensures source does not run dry
		else {
			if (wet) {
				wet = false;
				priority = 0;
				this.updateS();
			}
		}
	}

	//Performs rotations (by 90 degrees)
	public function rotate(){
		direction++;
		if (direction == 4) direction = 0;
		sprite.angle = direction * 90;
		var pholder:Bool = up;
		up = left;
		left = down;
		down = right;
		right = pholder;
	}

	//Ensures accuracy by checking connections and mapping the grid's plumbing network
	public function updateS():Void {
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