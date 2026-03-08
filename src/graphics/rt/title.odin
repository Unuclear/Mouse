package rt

import "core:c"
import "vendor:raylib"

import "../text"


title: raylib.RenderTexture2D

createTitleRt :: proc(width, height: c.int) {
	title = raylib.LoadRenderTexture(width, height)

	raylib.BeginTextureMode(title)
	defer raylib.EndTextureMode()

	text.DrawTextCenteredHorizontally("MOUSE", 20, 250, raylib.BROWN)
	text.DrawTextCenteredHorizontally("PRESS ENTER or TAP to START the GAME", c.int(c.float(raylib.GetScreenHeight()) * 0.9), 20, raylib.BLACK)
}
