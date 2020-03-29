class Audio {
  
  void whitenoise() {
    // turn off thunderstorm audio
    if (thunderstorm.isPlaying()) thunderstorm.amp(0.1); 
    
    // start white noise audio
    if (!noise.isPlaying()) {
      println("Now Playing: whitenoise");
      noise.amp(0.5);
      noise.play();
    }
  }
  
  void thunder() {
    // turn off white noise audio
    if (noise.isPlaying()) noise.stop();
    
    // play thunderstorm audio
    thunderstorm.amp(1);
    if (!thunderstorm.isPlaying()) {
      println("Now Playing: thunderstorm");
      thunderstorm.loop();
    }
  }
}
