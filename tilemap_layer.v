module vaser
// TilemapLayer stores the structure of a single layer of a json tilemap
// TODO: Translate from Go to V
struct TilemapLayer {
	compression    string
	// data          interface{}
	encoding       string
	height         int
	name           string
	opacity        f64
	type_          string
	visible        bool
	width          int
	x              int
	y              int
	// properties    map[string]interface{}
	property_types map[string]string
	// DecodedData   [][]int
}
