module vaser

interface Scener {
	create() bool
	input(int, int, int, int)
	update()
	render()
	exit()
}
