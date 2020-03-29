class Audio {
  
  void whitenoise() {
    thunderstorm.stop();
    whitenoise.amp(0.5);
    whitenoise.loop();
  }
  
  void thunder() {
    whitenoise.stop();
    thunderstorm.amp(1);
    thunderstorm.loop();
  }
}
