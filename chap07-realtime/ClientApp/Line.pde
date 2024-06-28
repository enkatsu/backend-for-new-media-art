class Line {
  ArrayList<PVector> points;

  Line() {
    this.points = new ArrayList<PVector>();
  }

  void draw() {
    stroke(255);
    noFill();
    strokeWeight(3);
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape();
  }
}
