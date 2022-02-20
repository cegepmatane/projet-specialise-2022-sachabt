extends Node

var money :=0
var potion := 0
var current_health := 5

func save():
	var save_dict = {
		"current_health" : current_health,
		"money" : money,
		"potion" : potion
	}
	return save_dict

func add_potion(number):
	potion+=number

func add_money(number):
	money += number
	print("money %s" % money)

func pay(cost):
	if money < cost :
		return false
	money -= cost
	return true

func use_potion():
	if potion<0:
		return false
	potion-=1
	return true
