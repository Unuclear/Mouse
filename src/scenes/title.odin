package scenes

import "core:c"
import "vendor:raylib"

import "../graphics/rt"


InitTitle :: proc() {
	screenWidth, screenHeight := raylib.GetScreenWidth(), raylib.GetScreenHeight()
	rt.createTitleRt(screenWidth, screenHeight)
}

UpdateTitle :: proc() {
	// Press Enter or tap screen to start the game
	if raylib.IsKeyPressed(raylib.KeyboardKey.ENTER) || raylib.IsGestureDetected(raylib.Gesture.TAP) {
		UnloadTitle()

		currentScene = .Stage1
		InitStage1()

		return
	}

	// Check if window was resized
	screenWidth, screenHeight := raylib.GetScreenWidth(), raylib.GetScreenHeight()
	if screenWidth != rt.title.texture.width || screenHeight != rt.title.texture.height {
		// Unload old render texture
		raylib.UnloadRenderTexture(rt.title)

		// Create new one with new screen dimensions
		rt.createTitleRt(screenWidth, screenHeight)
	}
}

DrawTitle :: proc() {
	raylib.DrawTextureRec(
		rt.title.texture,
		raylib.Rectangle{0, 0, c.float(rt.title.texture.width), -c.float(rt.title.texture.height)}, // y-axis is flipped
		raylib.Vector2{},
		raylib.WHITE
	)
}

UnloadTitle :: proc() {
	raylib.UnloadRenderTexture(rt.title)
}
