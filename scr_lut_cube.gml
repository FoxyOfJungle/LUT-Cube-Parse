
/// @desc Load .cube file
///
/// Returns JSON data with header and BGR colors buffer.
///
/// Returns -1 if it's not a valid .cube file.
/// @param {String} file_name The LUT .cube file
function lut_load_cube(file_name) {
	/*
		Returns:
		* surface: 32 bits
		* undefined: file not exists
		* -1: invalid cube file
	*/
	if (file_exists(file_name)) {
		// load file
		var _buff = buffer_load(file_name);
		//var _size = buffer_get_size(_buff);
		
		// read all text
		var _text = buffer_read(_buff, buffer_text);
		
		// meta
		var _lutdata = {
			comments : undefined,
			title : undefined,
			lut_size : undefined,
			domain_min : undefined,
			domain_max : undefined,
			type : undefined,
			data_buff : buffer_create(0, buffer_grow, 4),
		};
		
		// header positions
		// all before TITLE are comments
		var _hp_title = string_pos("TITLE", _text);
		if (_hp_title <= 0) return -1;
		if (_hp_title > 1) {
			_lutdata.comments = string_split( string_copy(_text, 1, _hp_title-1) , "#", true);
		}
		var _content_array = string_split_ext(_text, ["\n"], true);
		
		// parse each line
		var h = 0, hsize = array_length(_content_array);
		repeat(hsize) {
			var _line = _content_array[h]; // string
			var _line_split = string_split(_line, " ", true);
			//var _end_line_pos = string_length(_line);
			
			if (string_starts_with(_line, "#")) {
				// commends [unused here]
			} else
			if (string_starts_with(_line, "TITLE")) {
				_lutdata.title = _line_split[1];
			} else
			if (string_starts_with(_line, "LUT_1D_SIZE")) {
				_lutdata.lut_size = real(_line_split[1]);
				_lutdata.type = "1D";
			} else
			if (string_starts_with(_line, "LUT_3D_SIZE")) {
				_lutdata.lut_size = real(_line_split[1]);
				_lutdata.type = "3D";
			} else
			if (string_starts_with(_line, "DOMAIN_MIN")) {
				_lutdata.domain_min = [real(_line_split[1]), real(_line_split[2]), real(_line_split[3])];
			} else
			if (string_starts_with(_line, "DOMAIN_MAX")) {
				_lutdata.domain_max = [real(_line_split[1]), real(_line_split[2]), real(_line_split[3])];
			} else {
				// LUT data points
				if (array_length(_line_split) == 3) {
					buffer_write(_lutdata.data_buff, buffer_f32, real(_line_split[0])); // B
					buffer_write(_lutdata.data_buff, buffer_f32, real(_line_split[1])); // G
					buffer_write(_lutdata.data_buff, buffer_f32, real(_line_split[2])); // R
					buffer_write(_lutdata.data_buff, buffer_f32, 1); // A
				}
			}
			++h;
		}
		// reset write position and delete unused buff
		buffer_seek(_lutdata.data_buff, buffer_seek_start, 0);
		buffer_delete(_buff);
		// return
		return _lutdata;
	}
	return undefined;
}
