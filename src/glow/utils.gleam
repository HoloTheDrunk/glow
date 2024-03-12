import gleam/float
import gleam/int

pub fn fmod(a: Float, b: Float) -> Float {
  a -. int.to_float(float.truncate(a /. b)) *. b
}
