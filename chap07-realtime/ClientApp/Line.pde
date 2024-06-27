class Line {
  ArrayList<PVector> points;
  String painterId = null;

  Line(String painterId) {
    this.painterId = painterId;
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
