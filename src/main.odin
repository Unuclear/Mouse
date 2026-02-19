package main

import "core:fmt"
import "core:mem"
import "vendor:raylib"

import "config"


main :: proc() {
	// Detects memory leaks
	when ODIN_DEBUG {
		track: mem.Tracking_Allocator
		mem.tracking_allocator_init(&track, context.allocator)
		context.allocator = mem.tracking_allocator(&track)

		defer {
			if len(track.allocation_map) > 0 {
				fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
				for _, entry in track.allocation_map {
					fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
				}
			}
			mem.tracking_allocator_destroy(&track)
		}
	}

	// Initialization
	//--------------------------------------------------------------------------------------
	raylib.SetConfigFlags({raylib.ConfigFlag.WINDOW_RESIZABLE})

	raylib.InitWindow(config.ScreenWidth, config.ScreenHeight, "Mouse")
	defer raylib.CloseWindow()
	raylib.SetWindowMinSize(config.ScreenWidth, config.ScreenHeight)

	raylib.SetTargetFPS(config.Fps)
	//--------------------------------------------------------------------------------------

	// Main loop
	for !raylib.WindowShouldClose() {
		// Update
		//----------------------------------------------------------------------------------
		//----------------------------------------------------------------------------------

		// Draw
		//----------------------------------------------------------------------------------
		raylib.BeginDrawing()
		defer raylib.EndDrawing()

		raylib.ClearBackground(raylib.RAYWHITE)
		//----------------------------------------------------------------------------------
	}
}
