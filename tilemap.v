module vaser

// import os
// import json
// Tilemap stores the structure of a Tilemap in JSON format.
struct Tilemap {
	height         int [json:'height']
	layers         []TilemapLayer [json:'layers']
	next_object_id int [json:'nextobjectid']
	orientation    string [json:'orientation']
	// properties    map[string]interface{} [json:'properties']
	property_types map[string]string [json:'propertytypes']
	render_order   string [json:'renderorder']
	tiled_version  string [json:'tiledversion']
	tile_height    int [json:'tileheight']
	tilesets       []TilesetInfo [json:'tilesets']
	tile_width     int [json:'tilewidth']
	type_          string [json:'type']
	version        int [json:'version']
	width          int [json:'width']
mut:
	raw_tilesets   []&Tileset [skip]
	game           &Game [skip]
}

// TODO: Translate from Go to V
// pub fn new_tilemap_from_tiled_json(g &Game, filename string, tilesets []&Tileset) ?Tilemap {
// 	empty_map := Tilemap{
// 		game: g
// 	}
	// file := os.read_file(filename) or {
	// 	return empty_map
	// }
	// decoded_map := json.decode(Tilemap,file) or {
	// 	return empty_map
	// }
	// println('${decoded_map.height}')
	// decoded_map.game = g
	// decoded_map.raw_tilesets = tilesets
	// byteData, err := ioutil.ReadFile(filename)
	// if err != nil {
	// return nil, err
	// }
	// var result Tilemap
	// err = json.Unmarshal(byteData, &result)
	// if err != nil {
	// return nil, err
	// }
	// for _, layer := range result.Layers {
	// err = layer.Decode()
	// if err != nil {
	// return nil, err
	// }
	// }
	// result.RawTilesets = tilesets
	// result.game = g
	// return &result, nil
// 	return empty_map
// }
