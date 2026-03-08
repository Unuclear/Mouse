package main

import "core:fmt"
import "core:mem"
import "vendor:raylib"

import "config"
import "raylib_logo"
import "scenes"


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

	// Show Raylib logo
	raylib_logo.raylibLogoAnimation(fps=config.Fps)

	raylib.SetTargetFPS(config.Fps)
	//--------------------------------------------------------------------------------------

	// Free memory on exit
	defer switch scenes.currentScene {
		case .Title:
			scenes.UnloadTitle()
		case .Stage1:
			scenes.UnloadStage1()
	}

	// Main loop
	for !raylib.WindowShouldClose() {
		// Update
		//----------------------------------------------------------------------------------
		switch scenes.currentScene {
			case .Title:
				scenes.UpdateTitle()
			case .Stage1:
				scenes.UpdateStage1()
		}
		//----------------------------------------------------------------------------------

		// Draw
		//----------------------------------------------------------------------------------
		raylib.BeginDrawing()
		defer raylib.EndDrawing()

		raylib.ClearBackground(raylib.RAYWHITE)

		switch scenes.currentScene {
			case .Title:
				scenes.DrawTitle()
			case .Stage1:
				scenes.DrawStage1()
		}
		//----------------------------------------------------------------------------------
	}
}
