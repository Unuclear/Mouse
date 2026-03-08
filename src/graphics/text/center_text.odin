package text

import "core:c"
import "core:strings"
import "vendor:raylib"


DrawTextCenteredHorizontally :: proc(text: string, posY: c.int, fontSize: c.int, color: raylib.Color) {
	ctext := strings.clone_to_cstring(text)
	defer delete(ctext)

	// Get text pixel width
	text_width := raylib.MeasureText(ctext, fontSize)

	// Calculate centred x coordinate
	posX := (raylib.GetScreenWidth() - text_width) / 2

	raylib.DrawText(ctext, posX, posY, fontSize, color)
}
