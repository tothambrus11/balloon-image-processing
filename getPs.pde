ArrayList<PVector> getPs(){
  ArrayList<PVector> tempPs = new ArrayList<PVector>();

  for (int x = (int) (movieWidth*0.3f); x < movieWidth*0.6f; x++) {
    for (int y = 0; y < movieHeight; y++) {
      cc = movie.get(x, y);
      cr=red(cc);
      cg=green(cc);
      cb=blue(cc);

      if (cr+cg+cb>200 && cr *1.2f < cb && cg * 0.3f < cb) {
        tempPs.add(new PVector(x, y));
      }
    }
  }
  
  return tempPs;
}

PVector getAvgPos(ArrayList<PVector> ps){
  PVector avg = new PVector();
  for(PVector p: ps){
    avg.add(p);
  }
  return avg.div(ps.size()+1);
}
