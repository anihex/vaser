module vaser
// Scener is a simply interface of what a scene for the game has to implement.
// Structs that implement this interface can be added to the scene collection.
interface Scener {
	// create is called before the game switches to the scene. The scene can
	// prepare it's content here.
	create()
	// input got the same parameters the glfw callback gets. That is, without
	// the wnd value
	input (string)
	// update is called everytime shortly before the scene is rendered.
	update()
	// render is called after the scene was updated.
	render()
	// exit is used to free ressources. It is called, when the scene is unloaded.
	// This happens, when the game switches and the "reset-scene" was true.
	exit  ()
	// keys returns an array of keybindings. Only keys that match the content
	// trigger the input handler.
	keys  ()[]KeyMap
}
