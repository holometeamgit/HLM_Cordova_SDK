/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        //Add event listeners
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
        document.querySelector('.ar').addEventListener('touchend', this.placeVideo.bind(this), false);
        document.querySelector('.tabs').addEventListener('click', this.switchTab.bind(this), false);
        document.querySelector('.videos').addEventListener('click', this.selectVideo.bind(this), false);
        document.querySelector('.focus').addEventListener( 'click', this.togglePlaceOnFocusSquare.bind(this), false);
//        document.querySelector('.nav').addEventListener('click', this.toggleNav.bind(this), false);
        
        //Render videos
        this.renderVideoList();
    },

    videos : [
          {
              video :'www/assets/videos/spin1.mp4',
              image : 'model1.jpg',
              label : 'Asos #1'
          },
          {
              video :'www/assets/videos/spin1.mp4',
              image : 'model2.jpg',
              label : 'Asos #2 (high qual)'
          },
          {
              video :'www/assets/videos/spin1.mp4',
              image : 'model2.jpg',
              label : 'Asos #2 (mid qual)'
          },
          {
              video :'www/assets/videos/spin1.mp4',
              image : 'model2.jpg',
              label : 'Asos #2 (low qual)'
          },
          {
              video : 'http://188.166.44.23/NapStreamExample.mp4',
              image : 'model2.jpg',
              label : 'Nap (stream)'
          }
    ],
    
    placeOnFocusSquare : true,
    
    togglePlaceOnFocusSquare : function(e){
        console.log(this.placeOnFocusSquare);
        this.placeOnFocusSquare = !this.placeOnFocusSquare;
        Holome.setPlaceOnFocusSquare(this.placeOnFocusSquare);
    },
    
    toggleNav : function(){
        let nav = document.querySelector('.navigation');
        if(nav.style.display == 'none') {
            nav.style.display = 'block';
        } else {
            nav.style.display = 'none';
        }
    },
    
    renderVideoList: function (){
        let container = document.querySelector('.videos');
        this.videos.forEach( (v) => {
                            container.innerHTML += `<li>
                                                        <img data-video="${v.video}" src="./assets/img/${v.image}" />
                                                        ${v.label}
                                                    </li>`;
        });
    },
    
    switchTab : function(e){
        let link = e.target;
        if(link.dataset.tab == 'videos') {
            document.querySelector('.ar').style.display = 'none';
            document.querySelector('.videos').style.display = 'block';
        } else {
            this.goToARView();
        }
    },
    
    goToARView : function(){
        document.querySelector('.ar').style.display = 'block';
        document.querySelector('.videos').style.display = 'none';
    },
    
    videoLoadingComplete : function() {
//        Holome.playVideo();
    },
    
    videoPlaced : function(){
        alert('placedVideo');
    },
    
    placeVideo : function(e){
        let touches = e.changedTouches[0];
        let x = touches.pageX,
            y = touches.pageY;
        Holome.placeVideo({x : x, y: y});
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function() {
        let arFrame = document.querySelector('.ar').getBoundingClientRect();
            arFrame.y += 20;//Adjust for status bar - Can remove the need for this if no status bar in app
        Holome.initHolome({
                            frame  : arFrame,
                            placeOnFocusSquare : this.placeOnFocusSquare,
                            focusSquareData : {
                                size:           0.57,
                                thickness:                 0.018,
                                scaleForClosedSquare:      0.97,
                                sideLengthForOpenSegments: 0.2,
                                animationDuration:         0.7,
                                primaryColor: '#ffa500',
                                fillColor:   null,
                                fillImage: 'www/assets/videos/model2.jpg'
                            }
                        },
            (msg) => {
              //Select video
              this.switchVideo();
            },(err) => {
                console.log(err);
        });
        //Example methods from Holome
        Holome.addEventListener('videoLoadingComplete', this.videoLoadingComplete.bind(this), false);
    },

    selectVideo : function(e){
        let video = e.target;
        if(video.dataset.video) {
            this.switchVideo(video.dataset.video);
        }
        
        this.goToARView();
    },
    
    switchVideo : function(video) {
        video = video || this.videos[0].video;
        Holome.switchVideo(video)
    },

};

app.initialize();
