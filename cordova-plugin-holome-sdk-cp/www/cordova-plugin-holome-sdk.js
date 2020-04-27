var exec = require('cordova/exec');

/**
 * Init holome below webview
 */
exports.initHolome = function(arg0, success, error) {
  	exec(success, error, 'Holome', 'initHolome', [arg0]);
};

exports.setPlaceOnFocusSquare = function(arg0, success, error) {
	exec(success, error, 'Holome', 'setPlaceOnFocusSquare', [arg0]);
};

exports.switchVideo = function(arg0, success, error) {
  	exec(success, error, 'Holome', 'switchVideo', [arg0]);
};
               
exports.placeVideo = function(arg0, success, error) {
	exec(success, error, 'Holome', 'placeVideo', [arg0]);
};
exports.addEventListener = function(arg0, success, error) {
	exec(success, error, 'Holome', 'addEventListener', [arg0]);
};