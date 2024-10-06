import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

import PlayState.Square;

class levelData{
	//Links neighbouring squares
	public static function link(grid:Array<Square>, row:Int){
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
	public static function grid1(grid:Array<Square>):Array<Square>{
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
	public static function grid2(grid:Array<Square>):Array<Square>{
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
	public static function grid3(grid:Array<Square>):Array<Square>{
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
	public static function grid4(grid:Array<Square>):Array<Square>{
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
	public static function grid5(grid:Array<Square>):Array<Square>{
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
	public static function grid6(grid:Array<Square>):Array<Square>{
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
		public static function grid6(grid:Array<Square>):Array<Square>{
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
			public static function grid6(grid:Array<Square>):Array<Square>{
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
		public static function grid6(grid:Array<Square>):Array<Square>{
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
	public static function grid6(grid:Array<Square>):Array<Square>{
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


	/*GRIDS 7 AND 10 NEED TO BE CREATED.

	ALL YOU HAVE TO DO IS COPY THE FUNCTIONS ABOVE,
	ENSURE THEY STAY STATIC
	AND ONLY ADD NEW LINES, CHANGING THE MIDDLE NUMBERS AS THE INDEX*/
}