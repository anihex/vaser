module vaser

import gg
import glfw
import gx
import freetype
import os
import gl
import stbi

// Image is used to store the texture-id and the dimensions of the loaded image
struct Image {
	id u32
	width f32
	height f32
}

// Game holds all data of the game. The assets, the scenes and the graphics
// context
pub struct Game {
mut:
	gg         &gg.GG
	ft         &freetype.FreeType
	images     map[string]Image
	is_running bool
	scenes map[string]Scener
	current_scene string
}

// new creates a new Instance of Game. It initilises GLFW, opens the window and
// it also flips the loaded images if need be.
pub fn new(w, h int, title string, flip_image bool) &Game {
	glfw.init_glfw()
	stbi.set_flip_vertically_on_load(flip_image)
	mut game := &Game{
		gg: gg.new_context(gg.Cfg{
			width: w
			height: h
			use_ortho: true
			create_window: true
			window_title: title
			window_user_ptr: 0
		})
		ft: freetype.new_context(gg.Cfg{
			width: w
			height: h
			use_ortho: true
			font_size: 18
			scale: 2
			window_user_ptr: 0
		})
		images: map[string]Image
		is_running: true
	}
	game.gg.window.set_user_ptr(game)
	game.gg.window.onkeydown(key_down)
	return game
}

// load_image loads an image, creates a texture out of it and stores it in the
// assets of the game.
pub fn (game mut Game) load_image(key, filename string) {
	tex_id, w, h := create_image(filename)
	if tex_id == 0 {
		return
	}
	img := Image{
		id: tex_id
		width: w
		height: h
	}
	game.images[key] = img
}

// draw_image takes an image and draws it onto the screen
pub fn (game &Game) draw_image(key string, x, y int) {
	img := game.images[key]
	game.gg.draw_image(x, y, img.width, img.height, img.id)
}

// run starts the main game. It handles the updates of the active scene and it
// also renders them.
pub fn (game &Game) run() {
	for game.is_running {
		gg.clear(gx.Black)

		scene := game.scenes[game.current_scene]
		scene.render()

		game.gg.render()
		if game.gg.window.should_close() {
			game.gg.window.destroy()
			return
		}
		glfw.post_empty_event() // force window redraw
	}
}

// add_scene adds a new scene to the game. The key allows for an easy switch to
// different scenes.
pub fn (game mut Game) add_scene(key string, scene Scener) {
	if game.current_scene == "" {
		game.current_scene = key
	}
	game.scenes[key] = scene
}

// key_down handles the keyboard input of the window. It sends the informations
// to the current active scene.
fn key_down(wnd voidptr, key, code, action, mods int) {
	if action != 2 && action != 1 {
		return
	}
	// Fetch the game object stored in the user pointer
	game := &Game(glfw.get_window_user_pointer(wnd))
	if game.current_scene == "" {
		return
	}

	scene := game.scenes[game.current_scene]
	scene.input(key, code, action, mods)
}

// create_image is a slightly modified version of vlib. Not only returns it the
// tex_id, it also returns the width and the height.
fn create_image(file string) (u32, f32, f32) {
	//println('gg create image "$file"')
	if file.contains('twitch') {
		return u32(0), f32(0), f32(0)// TODO
	}
	if !os.exists(file) {
		println('gg create image no such file "$file"')
		return u32(0), f32(0), f32(0)
	}
	texture := gl.gen_texture()
	img := stbi.load(file)
	w := img.width
	h := img.height
	gl.bind_2d_texture(texture)
	img.tex_image_2d()
	gl.generate_mipmap(C.GL_TEXTURE_2D)
	img.free()

	return texture, f32(w), f32(h)
}
