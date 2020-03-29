class Audio {
  
  void whitenoise() {
    if (thunderstorm.isPlaying()) thunderstorm.pause(); 
    if (!whitenoise.isPlaying()) {
      whitenoise.amp(0.5);
      whitenoise.loop();
    }
  }
  
  void thunder() {
    if (whitenoise.isPlaying()) whitenoise.pause();
    if (!thunderstorm.isPlaying()) {
      thunderstorm.amp(1);
      thunderstorm.loop();
    }
  }
}
