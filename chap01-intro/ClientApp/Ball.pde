
class Ball {
  float x, y, r;
  
  Ball(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void draw() {
    noStroke();
    ellipse(x, y, r * 2, r * 2);
  }
}
