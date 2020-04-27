

# Cordova Holome SDK
Cordova plugin that allows holome SDK integration

# Installation

```cordova plugin add https://holome.visualstudio.com/cordova-plugin-holome-sdk/_git/cordova-plugin-holome-sdk```

Add the following snippets to your config.xml
```xml
<platform name="ios">
  <preference name="UseSwiftLanguageVersion" value="4.2" />
</platform>
```

```xml
 <edit-config target="NSCameraUsageDescription" file="*-Info.plist" mode="merge">
     <string>This application will use the camera for Augmented Reality.</string>
 </edit-config>
```


# Methods

### initHolome(options, [successCallback, errorCallback])

Starts the holome instance
<br>

<strong>Options:</strong>
All options stated are optional and will default to values here

* `placeonFocusSquare` - Defaults to ```true```
* `frame` - Frame of the ARView. Required
* `focusSquareData` - Custom focus square data. Required

```javascript
let options = {
	x: 0,
	placeOnFocusSquare : true,
	focusSquareData : {
		size: 0.57,
		thickness: 0.018,
		scaleForClosedSquare:  0.97,
		sideLengthForOpenSegments: 0.2,
		animationDuration: 0.7,
		primaryColor: '#ffa500',
		fillColor: null,
		fillImage: 'model2.jpg'
	}
};

Holome.initHolome(options);
```

### addEventListener(event, [callback])

<info>Listens to event from Holome.</info>
<ul>
	<li>videoLoadingComplete</li>
	<li>focusHide</li>
	<li>focusUnhide</li>
	<li>focusDisplayAsBillboard</li>
	<li>displayAsOpen</li>
	<li>displayAsClosed</li>
	<li>videoLoading</li>
	<li>videoLoadingComplete</li>
	<li>videoError</li>
	<li>videoPlayerStateChanged</li>
	<li>videoPlaced</li>
	<li>videoNodeHidden</li>
</ul>

<br/>

```javascript
Holome.addEventListener("videoLoadingComplete", (data)=>{
});
```

### setPlaceOnFocusSquare(placeOnFocusSquare)

<info>Sets bool placeOnFocusSquare.</info><br/>

```javascript
Holome.setPlaceonFocusSquare(true);
```

### zoomVideo(scale)

<info>Zoom the current holome Video.</info><br/>

```javascript
Holome.setPlaceonFocusSquare(0.4);
```

### playVideo()

<info>Play the current video.</info><br/>

```javascript
Holome.playVideo();
```

### pauseVideo()

<info>Pause the current video.</info><br/>

```javascript
Holome.pauseVideo();
```

### stopVideo()

<info>Stop the current video.</info><br/>
```javascript
Holome.stopVideo();
```

### placeVideo()

<info>Places the current video. Will only use the x,y if placeOnFocusSquare is set to false</info><br/>

```javascript
Holome.placeVideo({
	x: 0,
	y: 0
});
```


### switchVideo(video, successCallback, [errorCallback])

<info>Switch the current video. First it will try to access the a file, it searches in `'assets/videos'` If not found it assumes the video paramteter is a URL stream and will try to load.</info><br/>

```javascript
Holome.switchVideo('video1.mp4', (msg) =>{
}, (err) => {
});
```