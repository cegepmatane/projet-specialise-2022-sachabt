extends Node

var money :=0
var potion := 0


func add_potion(number):
	potion+=number

func add_money(number):
	money += number

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
