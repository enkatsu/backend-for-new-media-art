
class Ball {
  float x, y, r;
  
  Ball(float x, float y, float r, color c) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void draw() {
    noStroke();
    fill(c);
    ellipse(x, y, r * 2, r * 2);
  }
}
