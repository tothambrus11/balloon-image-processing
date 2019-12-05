boolean startVideo = true;
void draw() {
  if (startVideo) {
    startVideo = false;
    currentVideo.start();
  }
  background(0);
  image(movie, 0, 0, showWidth, showHeight);

  noStroke();

  fill(0, 130);
  rect(0, 0, movieWidth*0.3, movieHeight);
  rect(movieWidth*0.6f, 0, movieWidth*0.4, movieHeight);


  // IF NOT PLAYING GET CURRENT FRAME
  if (!isPlaying) {
    ps = getPs();
    avgPos = getAvgPos(ps).copy();
  }
  // DRAW CURSOR =====================================
  strokeWeight(1.5);

  stroke(0, 0, 0);

  line(0, avgPos.y, showWidth, avgPos.y);
  line(avgPos.x, 0, avgPos.x, showHeight);

  stroke(0, 255, 255);

  pushMatrix();
  //translate(1, 1);
  line(0, avgPos.y, showWidth, avgPos.y);
  line(avgPos.x, 0, avgPos.x, showHeight);
  popMatrix();

  stroke(0, 0, 0);
  noFill();
  pushMatrix();
  translate(avgPos.x, avgPos.y);
  circle(0, 0, 120);
  line(-90, 10, -90, -10);
  line(90, 10, 90, -20);
  line(-10, 90, 10, 90);
  line(-10, -90, 10, -90);
  popMatrix();

  stroke(0, 255, 255);
  pushMatrix();
  //translate(1, 1);
  noFill();
  pushMatrix();
  translate(avgPos.x, avgPos.y);
  circle(0, 0, 120);
  line(-90, 10, -90, -10);
  line(90, 10, 90, -20);
  line(-10, 90, 10, 90);
  line(-10, -90, 10, -90);
  popMatrix();
  popMatrix();


  fill(0, 255, 255);
  textSize(18);
  text("(x: "+avgPos.x/cmInPixels/100+" m; y: " + avgPos.y/cmInPixels/100 + " m)", avgPos.x + 50, avgPos.y + 50);
  text("y: " + avgPos.y/cmInPixels/100 + " m", 10, avgPos.y+20);
  text("x: " + avgPos.x/cmInPixels/100 + " m", avgPos.x + 10, 20);  



  // DRAW BALLOON
  stroke(0, 255, 255);
  strokeWeight(3);
  for (int i = 0; i < aps.size()-1; i++) {
    line(aps.get(i).x, aps.get(i).y, aps.get(i+1).x, aps.get(i+1).y);
  }

  stroke(0, 255, 255);
  strokeWeight(1);
  if (highlightBalloon) {
    for (int i = 0; i < ps.size(); i+=1) {
      point(ps.get(i).x, ps.get(i).y);
    }
  }


  // DRAW GRAPH =========================================================================
  fill(0);
  noStroke();
  rect(0, showHeight, showWidth, height - showHeight);
  final float zoomConstantX = 20;
  final float zoomConstantY = 0.4;

  stroke(0, 255, 255);
  fill(0, 255, 255, 128);

  pushMatrix();
  beginShape();
  translate(0, showHeight);

  vertex(0, 0);
  for (int i = 1; i < aps.size(); i++) {
    vertex(i*zoomConstantX, getVel(i) * zoomConstantY);
  }
  vertex((aps.size()-1) * zoomConstantX, 0);

  endShape(CLOSE);
  popMatrix();

  if (mouseX < zoomConstantX * (aps.size() - 1) && mouseY > showHeight) {
    textSize(18);
    int pos = (int)(mouseX/zoomConstantX + 0.5f);

    line(zoomConstantX*pos, showHeight, zoomConstantX*pos, height);
    float time = pos / movie.frameRate;
    text(round(time*1000)/1000f + "s", pos * zoomConstantX + 10, showHeight + 0);

    
    float vel = getVel(pos);
    line(0, vel * zoomConstantY + showHeight , width, vel * zoomConstantY + showHeight);    
    text(vel/100 + " m/s", 10, vel * zoomConstantY + showHeight);
    textAlign(RIGHT, TOP);
    text(vel/100 + " m/s", width - 10, vel * zoomConstantY + showHeight);
    textAlign(LEFT, TOP);
    
    noStroke();
    fill(0, 255, 255);
    circle(pos * zoomConstantX, vel * zoomConstantY + showHeight, 10);
    if (mousePressed && !isPlaying) {
      movie.jump(time);
      movie.read();
    }
  }

  // DRAW RANDOM STATS ===================================================================
  float velSum = 0;
  for (int i = 1; i < aps.size(); i++) {
    velSum += getVel(i);
  }
  textSize(20);
  text("Átlagsebesség: " + velSum / (aps.size()-1) / 100 + " m/s", showWidth + 20, 30);
  text("Végsebesség: " + getVel(aps.size()-1) / 100 + " m/s", showWidth + 20, 60);
  text("Esés időtartama: " + movie.duration() + " s", showWidth + 20, 90);
  // DRAW VIDEO SELECTION BUTTONS ========================================================
  for (Video v : videos) {
    v.drawButton();
  }

  // DRAW STOP/PLAY BUTTON ===============================================================
  ssVideo.draw();

  stroke(255, 0, 0);


  // RESTART MOVIE IF NEEDED =============================================================
  if (movie.time() == movie.duration()) {
    if (!ssVideo.isStopped) {
      currentVideo.start();
    } else {
      isPlaying = false;
    }
  }
}
