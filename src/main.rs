use std::path::PathBuf;

fn main() {
	let path = std::env::current_dir().unwrap();

	let mut path_buf = PathBuf::new();
	let mut segments = Vec::new();
	for path_segment in path.iter() {
		path_buf.push(path_segment);
		segments.push(path_buf.clone());
	}

	for segment in segments.iter().rev().filter_map(|p| p.to_str()) {
		print!("{} ", segment);
	}
}
