import java.util.ArrayList;

final int PLAY = 1100;
final int BOXSIZE = 20;
final int GAP = 2;
final int SNAKECOLOR = 0;
final int FOODCOLOR = 50;
final int GRID = 50;

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
  food f;
  snake() {
    serpant = new ArrayList<box>();
    x = GRID/2;
    y = GRID/2;
    serpant.add(new box(x, y, SNAKECOLOR));
    serpant.add(new box(x+1, y, SNAKECOLOR));
    serpant.add(new box(x+2, y, SNAKECOLOR));
    serpant.add(new box(x+3, y, SNAKECOLOR));
    f = new food();
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
      serpant.add(new box(serpant.get(serpant.size()-1).getx(), serpant.get(serpant.size()-1).gety(), SNAKECOLOR));
      f = new food();
    }
    
    if (x > 50 || x < 0 || y > 50 || y < 0) noLoop();
  }
  
  void direct(int dir) {
    switch(dir) {
      case 0:
        // right
        if (prevdir != 2) {
          vely = 0;
          velx = 1;
        }
        break;
      case 1:
        // up
        if (prevdir != 3) {
          vely = -1;
          velx = 0;
        }
        break;
      case 2:
        // left
        if (prevdir != 0) {
          vely = 0;
          velx = -1;
        }
        break;
      case 3:
        // down
        if (prevdir != 1) {
          vely = 1;
          velx = 0;
        }
        break;
    }
    prevdir = dir;
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
  size(1100, 1100);
  frameRate(4);
  background(34,139,34);
  direction = 0;
  prevdir = 0;
  s = new snake();
  s.direct(direction);
}
