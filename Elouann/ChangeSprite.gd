extends Sprite2D

func ChangeSprite2D(NewSprite: Sprite2D, Player: int):
	if Player == 0:
		texture = NewSprite.texture
