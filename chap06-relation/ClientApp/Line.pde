color[] colors = {
  #FF0000,
  #00FF00,
  #0000FF,
  #FFFF00,
  #FF00FF,
  #00FFFF,
};

class Line {
  int id;
  ArrayList<PVector> points;

  Line() {
    this.id = -1;
    this.points = new ArrayList<PVector>();
  }

  Line(int id, ArrayList<PVector> points) {
    this.id = id;
    this.points = (ArrayList<PVector>)points.clone();
  }

  void draw() {
    stroke(id == -1 ? #FFFFFF : colors[id % colors.length]);
    noFill();
    strokeWeight(3);
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape();
  }
}
