int squareX; // 四角形のx座標
int squareY; // 四角形のy座標
int squareSize = 100; // 四角形のサイズ
color squareColor; // 四角形の色

boolean newSquare = true; // 新しい四角形が必要かどうかを示すフラグ

float arm1_length = 250; // アーム1の長さ
float arm2_length = 250; // アーム2の長さ
float arm1_angle; // アーム1の角度
float arm2_angle; // アーム2の角度

void setup() {
  size(1280, 720);
  strokeWeight(5);
}

void draw() {
  noCursor();
  background(255);

  float x0 = width/2;
  float y0 = height/2;
  float x = mouseX - x0;
  float y = mouseY - y0;
  
  float dx = mouseX - width / 2;
  float dy = mouseY - height / 2;
  float distance = sqrt(dx * dx + dy * dy);
  arm2_length = min(distance, 480); // アーム2の最大長さを制限
  
  // 新しい四角形が必要な場合
  if (newSquare) {
    squareX = int(random(width - squareSize)); // ランダムなx座標
    squareY = int(random(height - squareSize)); // ランダムなy座標
    squareColor = color(random(255), random(255), random(255)); // ランダムな色
    newSquare = false; // 新しい四角形の表示が完了したのでフラグをfalseに設定
  }
  
  // 四角形を描画
  fill(squareColor);
  rect(squareX, squareY, squareSize, squareSize);
  
  // マウスの位置に円を描画
  stroke(0);
  ellipse(mouseX, mouseY, 10, 10);

  // アーム1の角度を計算
  float acos1 = sq(x) + sq(y) + sq(arm1_length) - sq(arm2_length);
  float acos2 = 2 * arm1_length * sqrt(sq(x) + sq(y));
  if (mouseX >= x0) {
    arm1_angle = acos(acos1 / acos2) + atan(y / x);
  } else {
    arm1_angle = acos(acos1 / acos2) + atan(y / x) + PI;
  }
  
  // アーム1の根元を描画
  stroke(0);
  line(x0, y0, x0 + arm1_length * cos(arm1_angle), y0 + arm1_length * sin(arm1_angle));

  // アーム2の角度を計算
  float acos3 = sq(arm1_length) + sq(arm2_length) - (sq(x) + sq(y));
  float acos4 = 2 * arm1_length * arm2_length;
  float x2 = x0 + arm1_length * cos(arm1_angle);
  float y2 = y0 + arm1_length * sin(arm1_angle);
  arm2_angle = PI + acos(acos3 / acos4);
  
  // アーム2の先端を描画
  stroke(0);
  line(x2, y2, x2 + arm2_length * cos(arm1_angle + arm2_angle), y2 + arm2_length * sin(arm1_angle + arm2_angle));
}

void keyPressed() {
  // 'r' キーが押されたとき
  if (key == 'r' || key == 'R') {
    newSquare = true; // 新しい四角形が必要なのでフラグをtrueに設定
  }
}

void mousePressed() {
  // マウスの座標と四角形の座標の間の距離を計算
  float d = dist(mouseX, mouseY, squareX + squareSize / 2, squareY + squareSize / 2);
  // 距離が四角形のサイズの半分よりも小さい場合、四角形がクリックされたとみなす
  if (d < squareSize / 2) {
    // 四角形の色をランダムに変更
    squareColor = color(random(255), random(255), random(255));
  }
}
