import java.util.ArrayList;

final int PLAY = 990;
final int BOXSIZE = 20;
final int GAP = 2;
final int SNAKECOLOR = 0;
final int FOODCOLOR = 45;
final int GRID = 45;

int direction;
int prevdir;

class box {
  int x, y, c;
  box (int x, int y, int c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }
  
  int getx() {
    return x;
  }
  int gety() {
    return y;
  }
  
  void displayBox() {
    fill(c, c, c);
    //fill(255,127,80);
    rect(1 + (x*(BOXSIZE + GAP)), 1+(y*(BOXSIZE + GAP)), BOXSIZE, BOXSIZE);
  }
}

class snake {
  ArrayList<box> serpant;
  int x, y;
  int velx, vely;
  // box head;
  food f;
  snake() {
    serpant = new ArrayList<box>();
    x = GRID/2;
    y = GRID/2;
    for (int i = 0; i < 5; i++) {
      serpant.add(new box(x + i, y, SNAKECOLOR));
    }
    //head = serpant.get(0);
    f = new food(); //<>//
  }
  
  void displaySnake() {
    x+=velx;
    y+=vely;
    for (int i = 0; i < serpant.size(); i++) {
      this.serpant.get(i).displayBox();
    }
    this.serpant.remove(0);
    this.serpant.add(new box(x, y, SNAKECOLOR));
    f.displayFood();
    
    if ((x == f.getx()) && (y == f.gety())) {
      // get bigger, make new food
      serpant.add(new box(serpant.get(0).getx(), serpant.get(0).gety(), SNAKECOLOR));
      f = new food();
    }
    if (x > GRID || x < 0 || y > GRID || y < 0) noLoop();
    if (headInBody()) noLoop();
  }
  
  boolean headInBody() {
    int a, b;
    a = serpant.get(serpant.size()-1).getx();
    b = serpant.get(serpant.size()-1).gety();
    for (int i = serpant.size()-2; i > 0; i--) { //<>//
      println(serpant.get(i).getx() + " " + serpant.get(i).gety() + ":" + a + " " + b);
      if ((serpant.get(i).getx() == a ) && (serpant.get(i).gety() == b)) {
        return true;
      }
    }
    return false;
  }
  
  void direct(int dir) {
    if (prevdir != dir) {
    switch(dir) {
      case 0:
        // right
        if (prevdir != 2) {
          vely = 0;
          velx = 1;
          prevdir = dir;
        }
        break;
      case 1:
        // up
        if (prevdir != 3) {
          vely = -1;
          velx = 0;
          prevdir = dir;
        }
        break;
      case 2:
        // left
        if (prevdir != 0) {
          vely = 0;
          velx = -1;
          prevdir = dir;
        }
        break;
      case 3:
        // down
        if (prevdir != 1) {
          vely = 1;
          velx = 0;
          prevdir = dir;
        }
        break;
    }
    }
  }
}

class food {
  int x,y;
  box b;
  food() {
    x = (int)random(GRID-1);
    y = (int)random(GRID-1);
    b = new box(x, y, FOODCOLOR);
  }
  
  int getx() {
    return this.x;
  }
  
  int gety() {
    return this.y;
  }
  
  void displayFood() {
    b.displayBox();
  }
}

snake s;

void draw() {
  background(34,139,34);
  s.direct(direction);  //<>//
  s.displaySnake();
}

void keyPressed() {
  //if (key == CODED) {
    if (key == 'd') {
      direction = 0;
    }
    else if (key == 'w') {
      direction = 1;
    }
    else if (key == 'a') {
      direction = 2;
    }
    else if (key == 's') {
      direction = 3;
    }
  //}
}

void setup() {
  size(990, 990);
  frameRate(5);
  background(34,139,34);
  direction = 0;
  prevdir = 5;
  s = new snake();
  s.direct(direction);
}
