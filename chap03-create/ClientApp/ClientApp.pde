import http.requests.*;

String API_URL = "http://localhost:3000/balls";
ArrayList<Ball> balls;

void setup() {
  size(640, 480);
  balls = new ArrayList<Ball>();
  loadBalls();
}

void draw() {
  background(0);
  for (Ball ball : balls) {
    ball.draw();
  }
}

void keyPressed() {
  if (key == 'c') {
    PostRequest post = new PostRequest(API_URL);
    post.addHeader("Content-Type", "application/json");
    JSONObject ball = new JSONObject();
    ball.setFloat("x", (float)mouseX / width);
    ball.setFloat("y", (float)mouseY / height);
    ball.setFloat("r", random(1));
    post.addData(ball.toString());
    post.send();

    balls.clear();
    loadBalls();
  }
}

void loadBalls() {
  GetRequest get = new GetRequest(API_URL);
  get.send();
  JSONObject result = parseJSONObject(get.getContent());
  JSONArray ballsData = result.getJSONArray("balls");
  for (int i = 0; i < ballsData.size(); i++) {
    JSONObject ballData = ballsData.getJSONObject(i);
    Ball ball = new Ball(
      ballData.getInt("id"),
      ballData.getFloat("x") * width,
      ballData.getFloat("y") * height,
      ballData.getFloat("r") * 9 + 1
      );
    balls.add(ball);
  }
}
