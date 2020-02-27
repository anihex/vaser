module vaser

// Scener is a simply interface of what a scene for the game has to implement.
// Structs that implement this interface can be added to the scene collection.
interface Scener {
	// create is called the first time the scene will be shown. The return value
	// indicated if the scene is ready for further usage. If it returns true,
	// the exit funcion is called when the scene will be disabled. And create
	// will be called again, once it will be loaded again.
	// This way it can free ressources if need be.
	create() bool

	// input got the same parameters the glfw callback gets. That is, without
	// the wnd value
	input(int, int, int, int)
	
	// update is called everytime shortly before the scene is rendered.
	update()

	// render is called after the scene was updated.
	render()

	// exit is used to free ressources. It is called, when the scene is unloaded.
	// This however depends on the return value of create(). If it's false, this
	// function can be a simply dummy.
	exit()
}
