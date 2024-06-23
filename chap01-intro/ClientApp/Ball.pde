
class Ball {
  float x, y, r;
  
  Ball(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void draw() {
    noStroke();
    fill(100, 200, 250);
    ellipse(x, y, r * 2, r * 2);
  }
}
