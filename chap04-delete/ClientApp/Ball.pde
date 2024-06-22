
class Ball {
  int id;
  float x, y, r;
  
  Ball(int id, float x, float y, float r) {
    this.id = id;
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
