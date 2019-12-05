import processing.video.*;

class Video {
  String title;
  String path;
  float x, y, w, h;

  Video(String _title, String _path) {
    title = _title;
    path = _path;
  }

  void start() {
    if (movie != null) {
      movie.pause();
      movie = null;
    }
    ps = new ArrayList<PVector>();
    aps = new ArrayList<PVector>();
    movie = new Movie(context, path);
    movie.play();
  }

  void setPos(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void drawButton() {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      fill(0, 255, 255);
    } else {
      fill(0, 255, 255, 128);
    }
    stroke(0, 255, 255);
    strokeWeight(1);

    rect(x, y, w, h);

    noStroke();

    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      fill(0);
    }

    textAlign(CENTER, CENTER);
    text(title, x, y, w, h);
    textAlign(LEFT, TOP);
  }

  void mousePressed() {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      currentVideo = this;
      isPlaying = true;
      start();
    }
  }
}
