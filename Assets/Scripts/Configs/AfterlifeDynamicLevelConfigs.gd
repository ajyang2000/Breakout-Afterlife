extends Resource

class_name AfterlifeDynamicLevelConfigs

const row_index = 0
const column_index = 1
const empty_spawn_chance = 2

# key = Level number
# value[0] = number of rows
# value[1] = number of columns
# value[2] = random spawn chance of empty
const level_difficulty = {
	'1': [3, 11, 0.2],
	'2': [4, 11, 0.15],
	'3': [5, 11, 0.1],
	'4': [3, 13, 0.2],
	'5': [4, 13, 0.15],
	'6': [5, 13, 0.1],
	'7': [3, 15, 0.2],
	'8': [4, 15, 0.15],
	'9': [5, 15, 0.1]
}

# -1 used to indicate do not increase the speed
const ball_speed_increase_interval_tiers = [-1, 60, 45]

const brick_hp_tiers = [1, 2, 3]

const boss_level_difficulty = {
	'1': [3, 15, 0.1],
	'2': [4, 15, 0.1],
	'3': [5, 15, 0.1]
}

#[0] = ball power 
#[1] = paddle speed
#[2] = ball speed
#[3] = shield hp
const boss_settings = {
	'1': [1, 1, 1, 5],
	'2': [3, 2, 2, 10],
	'3': [5, 3, 2, 20]
}
