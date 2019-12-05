class StartStopVideo {
  float x, y, w, h;
  boolean isStopped;

  StartStopVideo(float x, float y, float w, float h) {
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    isStopped = false;
  }

  void draw() {
    if (checkHover()) {
      if (isStopped) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
    } else {
      if (isStopped) {
        fill(0, 255, 0, 128);
      } else {
        fill(255, 0, 0, 128);
      }
    }
    if (isStopped) {
      stroke(0, 255, 0);
    } else {
      stroke(255, 0, 0);
    }
    rect(x, y, w, h);

    noStroke();
    if (isStopped) {
      if (checkHover()) {
        fill(0, 128, 0);
      }
      beginShape();
      vertex(x + h/3f, y + h/3f);
      vertex(x + h*2/3f, y + h/2f);
      vertex(x + h/3f, y + h*2/3);
      endShape(CLOSE);
      textAlign(LEFT, CENTER);
      textSize(20);
      text("PLAY", x + h, y-2, w - h, h);
      textAlign(LEFT, TOP);
    } else {
      if (checkHover()) {
        fill(128, 0, 0);
      }
      rect(x + h/3, y + h/3, h/3, h/3);
      textAlign(LEFT, CENTER);
      textSize(20);
      text("STOP", x + h, y-2, w - h, h);
      textAlign(LEFT, TOP);
    }
  }

  boolean checkHover() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }

  void mousePressed() {
    if (checkHover()) {
      isPlaying = true;
      isStopped = ! isStopped;
    }
  }
}
