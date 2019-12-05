import processing.video.*;

Movie movie;
float movieWidth = 1280;
float movieHeight = 720;
float showWidth = 1280;
float showHeight = 720;

ArrayList<PVector> ps;
ArrayList<PVector> aps; // average positions

imageProcessing context;

Video[] videos = new Video[]{
  new Video("Kicsi 1", "kicsi1.mov"), 
  new Video("Kicsi 2", "kicsi2.mov"), 
  new Video("Közepes 1", "kozepes1.mov"), 
  new Video("Közepes 2", "kozepes2.mov"), 
  new Video("Nagy 1", "nagy1.mov"), 
  new Video("Nagy 2", "nagy2.mov"), 
};

Video currentVideo;
StartStopVideo ssVideo;
boolean isPlaying = true;
void setup() {
  size(1600, 900);
  background(0);

  textFont(createFont("VT323-Regular.ttf", 100));

  textSize(250);
  textAlign(CENTER, CENTER);
  fill(0, 255, 255);
  text("LOADING...", 0, 0, width, height);
  textAlign(LEFT, TOP);
  context = this;

  currentVideo = videos[0];
  
  float w = 130;
  float h = 60;
  for(int i = 0; i < videos.length; i++){
    videos[i].setPos(showWidth + 20 + (w + 20)*(i%2),((int)(i/2))*(h+20) + 150, w, h);
  }
  
  ssVideo = new StartStopVideo(showWidth + 20, videos[videos.length-1].y + videos[videos.length-1].h + 20, 130, 60);
}
int cc;
float cr;
float cg;
float cb;

float cmInPixels = 50f/20f; // 50 pixels are 20cm
PVector avgPos = new PVector();

int movieFrameCount = 0;

boolean highlightBalloon = true;


float getVel(int i) {
  return getVel(i, true);
}

float getVel(int i, boolean allowRecursion) {
  if (i >= aps.size() || i < 1) return 0;
  float deltaY = (aps.get(i).y - aps.get(i-1).y) / cmInPixels;

  float vel = deltaY * movie.frameRate;
  if (vel <= 10 && allowRecursion) {
    if (i > 1 && i < aps.size() - 1) {
      vel = (getVel(i-1, false) + getVel(i+1, false))/2f;
    } else if (i > 1) {
      vel = getVel(i-1, false);
    } else if (i < aps.size() - 1) {
      vel = getVel(i+1, false);
    }
  }
  return vel;
}
