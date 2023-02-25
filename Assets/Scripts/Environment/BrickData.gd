extends Resource

class_name BrickData

const _brick_normal = "res://Assets/Sprites/brick_normal.png"
const _brick_bonus = "res://Assets/Sprites/brick_bonus.png"
const _brick_special = "res://Assets/Sprites/brick_special.png"
const _brick_strong = "res://Assets/Sprites/brick_strong.png"
const _brick_classic = "res://Assets/Sprites/classic_brick.png"
	
enum BrickType{
	CLASSIC
	NORMAL, 
	BONUS,
	SPECIAL, 
	STRONG
}

var _destructible_bricks = [BrickType.STRONG]

func get_brick_texture(type: int) -> Resource:
	match type:
		BrickType.CLASSIC:
			return load(_brick_classic)
		BrickType.NORMAL:
			return load(_brick_normal)
		BrickType.STRONG:
			return load(_brick_strong)
		BrickType.SPECIAL:
			return load(_brick_special)
		BrickType.BONUS:
			return load(_brick_bonus)
	return load(_brick_classic)

func get_brick_health(type: int, base_hit_points: int) -> int:
	match type:
		BrickType.CLASSIC:
			return 1
		BrickType.NORMAL:
			return base_hit_points
		BrickType.STRONG:
			return base_hit_points
		BrickType.SPECIAL:
			return base_hit_points + 2
		BrickType.BONUS:
			return base_hit_points + 4
	return base_hit_points
	
func get_brick_is_destructible(type: int) -> bool:
	return type in _destructible_bricks
