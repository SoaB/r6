module vector2

import math

pub struct Vec2 {
pub mut:
	x f32
	y f32
}

pub fn (v Vec2) zero() Vec2 {
	return Vec2{0.0, 0.0}
}

pub fn (v Vec2) clone() Vec2 {
	return Vec2{v.x, v.y}
}

pub fn equal(a Vec2, b Vec2) bool {
	if a.x != b.x || a.y != b.y {
		return false
	}
	return true
}

pub fn add(a Vec2, b Vec2) Vec2 {
	return Vec2{a.x + b.x, a.y + b.y}
}

pub fn (mut v Vec2) add_value(val f32) {
	v.x += val
	v.y += val
}

pub fn sub(a Vec2, b Vec2) Vec2 {
	return Vec2{a.x - b.x, a.y - b.y}
}

pub fn (mut v Vec2) sub_value(val f32) {
	v.x -= val
	v.y -= val
}

pub fn (v Vec2) length() f32 {
	return math.sqrtf((v.x * v.x) + (v.y * v.y))
}

pub fn (v Vec2) length_square() f32 {
	return (v.x * v.x) + (v.y * v.y)
}

pub fn dot_product(a Vec2, b Vec2) Vec2 {
	return Vec2{a.x * b.x, a.y * b.y}
}

pub fn distance(a Vec2, b Vec2) f32 {
	return math.sqrtf((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y))
}

pub fn angle(a Vec2, b Vec2) f32 {
	mut fret := math.atan2(b.y - a.y, b.x - a.x) * 180.0 / math.pi
	return f32(360 - fret)
}

pub fn (mut v Vec2) scale(s f32) {
	v.x *= s
	v.y *= s
}

pub fn multiply(a Vec2, b Vec2) Vec2 {
	return Vec2{a.x * b.x, a.y * b.y}
}

pub fn (mut v Vec2) negate() {
	v.x = -v.x
	v.y = -v.y
}

pub fn divide(a Vec2, b Vec2) Vec2 {
	if b.x != 0 && b.y != 0 {
		return Vec2{a.x / b.x, a.y / b.y}
	}
	return Vec2{a.x, b.y}
}

pub fn (mut v Vec2) divide_value(a f32) {
	if a != 0 {
		v.x /= a
		v.y /= a
	}
}

pub fn (mut v Vec2) normalize() {
	length := math.sqrtf((v.x * v.x) + (v.y * v.y))
	if length != 0 {
		v.x = v.x / length
		v.y = v.y / length
	}
}

pub fn lerp(a Vec2, b Vec2, m f32) Vec2 {
	return Vec2{a.x + m * (b.x - a.x), a.y + m * (b.x - a.y)}
}

pub fn reflect(a Vec2, b Vec2) Vec2 {
	dot_product := a.x * b.x + a.y * b.y
	return Vec2{a.x - (2.0 * b.x) * dot_product, a.y - (2.0 * b.y) * dot_product}
}

pub fn (mut v Vec2) rotate(angle f32) {
	v.x = v.x * math.cosf(angle) - v.y * math.sinf(angle)
	v.y = v.x * math.sinf(angle) + v.y * math.cosf(angle)
}

pub fn (mut v Vec2) limit(n f32) {
	mut l := (v.x * v.x) + (v.y * v.y)
	if (n * n) <= l {
		l = math.sqrtf(l)
		ra := n / l
		v.x *= ra
		v.y *= ra
	}
}
