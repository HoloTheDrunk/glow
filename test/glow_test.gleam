import gleam/float
import gleeunit
import gleeunit/should
import types/vector.{Vec2}

const float_threshold = 1.0e-6

pub fn main() {
  gleeunit.main()
}

pub fn vec_add_test() {
  vector.add(Vec2(1.0, 2.0), Vec2(3.0, 4.0))
  |> should.equal(Vec2(4.0, 6.0))
}

pub fn vec_sub_test() {
  vector.sub(Vec2(1.0, 2.0), Vec2(3.0, 4.0))
  |> should.equal(Vec2(-2.0, -2.0))
}

pub fn vec_mul_test() {
  vector.mul(Vec2(1.0, 2.0), 4.0)
  |> should.equal(Vec2(4.0, 8.0))
}

pub fn vec_div_test() {
  vector.div(Vec2(1.0, 2.0), 0.0)
  |> should.equal(Vec2(0.0, 0.0))

  vector.div(Vec2(1.0, 2.0), 4.0)
  |> should.equal(Vec2(0.25, 0.5))
}

pub fn vec_mod_test() {
  let res = vector.mod(Vec2(2.1, 3.2), 0.4)
  case
    float.absolute_value(res.x -. 0.1) <. float_threshold
    || float.absolute_value(res.y) <. float_threshold
  {
    False -> Nil
    True -> should.fail()
  }
}

pub fn vec_dot_test() {
  vector.dot(Vec2(1.0, 0.0), Vec2(0.0, 1.0))
  |> should.equal(0.0)

  vector.dot(Vec2(1.0, 0.0), Vec2(1.0, 0.0))
  |> should.equal(1.0)
}

pub fn vec_length_test() {
  vector.length_sq(Vec2(3.0, 4.0))
  |> should.equal(25.0)

  vector.length(Vec2(3.0, 4.0))
  |> should.equal(5.0)
}

pub fn normalize() {
  vector.normalize(Vec2(3.0, 4.0))
  |> should.equal(Vec2(0.6, 0.8))
}

pub fn resize() {
  vector.resize(Vec2(1.0, 0.0), 4.0)
  |> should.equal(Vec2(4.0, 0.0))
}
