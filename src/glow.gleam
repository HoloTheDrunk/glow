// std
import gleam/io
import gleam/float
// project
import types/vector.{Vec2}

pub fn main() {
  vector.length_sq(Vec2(1.0, 2.0))
  |> float.to_string
  |> io.println
}
