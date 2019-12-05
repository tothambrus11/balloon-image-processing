void movieEvent(Movie movie) {
  movie.read();
  ps = getPs();
  avgPos = getAvgPos(ps).copy();
  aps.add(avgPos);
}
