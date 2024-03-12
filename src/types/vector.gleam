// std
import gleam/float
import gleam/result
// project
import utils.{fmod}

pub type Vector {
  Vec2(x: Float, y: Float)
  Vec3(x: Float, y: Float, z: Float)
  Vec4(x: Float, y: Float, z: Float, w: Float)
}

fn mismatch(a: Vector, b: Vector) -> String {
  "Mismatched vector dimensions: " <> to_string(a) <> " and " <> to_string(b)
}

pub fn add(a: Vector, b: Vector) -> Vector {
  case a, b {
    Vec2(x, y), Vec2(a, b) -> Vec2(x +. a, y +. b)
    Vec3(x, y, z), Vec3(a, b, c) -> Vec3(x +. a, y +. b, z +. c)
    Vec4(x, y, z, w), Vec4(a, b, c, d) -> Vec4(x +. a, y +. b, z +. c, w +. d)
    _, _ ->
      mismatch(a, b)
      |> panic()
  }
}

pub fn sub(a: Vector, b: Vector) -> Vector {
  case a, b {
    Vec2(x, y), Vec2(a, b) -> Vec2(x -. a, y -. b)
    Vec3(x, y, z), Vec3(a, b, c) -> Vec3(x -. a, y -. b, z -. c)
    Vec4(x, y, z, w), Vec4(a, b, c, d) -> Vec4(x -. a, y -. b, z -. c, w -. d)
    _, _ ->
      mismatch(a, b)
      |> panic()
  }
}

pub fn mul(a: Vector, v: Float) -> Vector {
  case a {
    Vec2(x, y) -> Vec2(x *. v, y *. v)
    Vec3(x, y, z) -> Vec3(x *. v, y *. v, z *. v)
    Vec4(x, y, z, w) -> Vec4(x *. v, y *. v, z *. v, w *. v)
  }
}

pub fn div(a: Vector, v: Float) -> Vector {
  case a {
    Vec2(x, y) -> Vec2(x /. v, y /. v)
    Vec3(x, y, z) -> Vec3(x /. v, y /. v, z /. v)
    Vec4(x, y, z, w) -> Vec4(x /. v, y /. v, z /. v, w /. v)
  }
}

pub fn mod(a: Vector, v: Float) -> Vector {
  case a {
    Vec2(x, y) -> Vec2(fmod(x, v), fmod(y, v))
    Vec3(x, y, z) -> Vec3(fmod(x, v), fmod(y, v), fmod(z, v))
    Vec4(x, y, z, w) -> Vec4(fmod(x, v), fmod(y, v), fmod(z, v), fmod(w, v))
  }
}

pub fn dot(a: Vector, b: Vector) -> Float {
  case a, b {
    Vec2(x, y), Vec2(a, b) -> x *. a +. y *. b
    Vec3(x, y, z), Vec3(a, b, c) -> x *. a +. y *. b +. z *. c
    Vec4(x, y, z, w), Vec4(a, b, c, d) -> x *. a +. y *. b +. z *. c +. w *. d
    _, _ ->
      mismatch(a, b)
      |> panic()
  }
}

pub fn length_sq(v: Vector) -> Float {
  dot(v, v)
}

pub fn length(v: Vector) -> Float {
  length_sq(v)
  |> float.square_root
  |> result.unwrap(0.0)
}

pub fn normalize(v: Vector) -> Vector {
  div(v, length(v))
}

pub fn resize(v: Vector, length: Float) -> Vector {
  normalize(v)
  |> mul(length)
}

pub fn to_string(v: Vector) -> String {
  let x = float.to_string(v.x)
  let coord = fn(value: Float) -> String { ", " <> float.to_string(value) }
  case v {
    Vec2(_, y) -> "Vec2(" <> x <> coord(y) <> ")"
    Vec3(_, y, z) -> "Vec3(" <> x <> coord(y) <> coord(z) <> ")"
    Vec4(_, y, z, w) -> "Vec4(" <> x <> coord(y) <> coord(z) <> coord(w) <> ")"
  }
}
