var staticMap = "http://api.map.baidu.com/staticimage?center={0},{1}&width=400&height=300&zoom=14&markers={0},{1}&markerStyles=l,A";
var convertUrl = "http://api.map.baidu.com/geoconv/v1/?coords={0},{1}&from=1&to=5&ak=http://api.map.baidu.com/geoconv/v1/?coords=116.44773,39.971516&from=1&to=5&ak=DbQHNP1CTOovfpnjmsXcb4gG"

function readJsonFile(source, callback) {
    var xhr = new XMLHttpRequest;
    xhr.open("GET", source);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            var doc = xhr.responseText;
            console.log("JSON: " + doc)
            var json = JSON.parse(doc);
            callback(json);
        }
    }

    xhr.send();
}

String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};

function getStaticMap(longitude, latitude) {
    var staticMapUrl = staticMap.format(longitude, latitude);
    console.log("staticMapUrl: " + staticMapUrl);
    return staticMapUrl;
}

function convertCoordinates(longitude, latitude, callback) {
    var url = convertUrl.format(longitude, latitude);
    console.log("url: " + url)
    var x, y;

    readJsonFile( url, function(json) {
        console.log("json: " + json)
        console.log("result: " + json.result[0].x)
        console.log("result: " + json.result[0].y)
        x = json.result[0].x
        y = json.result[0].y

        var o = {
            longitude: x,
            latitude: y
        };

        callback(o)
    })
}
