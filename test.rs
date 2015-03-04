#![feature(box_syntax)]

use std::fmt;

fn main()
{	
	let a:Vec<i32> = vec![];
	let p = Point::new(123, 456);

	println!("{}", p);
}

struct Point
{
	x: i32,
	y: i32
}

impl Point
{
	fn new(x:i32, y:i32) -> Point
	{
		return Point{x:x, y:y};
	}
}

impl fmt::Display for Point
{
	fn fmt(&self, f: &mut fmt::Formatter) -> Result<(), fmt::Error>
	{
		write!(f, "({}, {})", self.x, self.y)
	}
}







