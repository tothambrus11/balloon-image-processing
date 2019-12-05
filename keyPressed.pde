void keyPressed() {
  if (keyCode == 32) { // Stop / start loop
    ssVideo.isStopped = !ssVideo.isStopped;
    if (!ssVideo.isStopped) {
      currentVideo.start();
    }
  } else if (keyCode == 72) {
    highlightBalloon = !highlightBalloon;
  }
}
