module vaser
// Tileset is an image that is divided in tiles
// TODO: Translate from Go to V
struct Tileset {
	// XMLName      xml.Name
	name        string
	tile_width  int
	tile_height int
	tile_count  int
	columns     int
	// Image        Image
	// tiles        []*ebiten.Image
	// tileW, tileH int
	// StartIndex   int
}
