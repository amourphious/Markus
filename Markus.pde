import apwidgets.*;
import android.text.InputType;
import android.view.inputmethod.EditorInfo;

APWidgetContainer container;
APEditText textField;

PImage currentScreen, temp, markus, fr;

int currentTextPositionX, currentTextPositionY;
int margin;
int paintToolbarX, paintToolbarY, paintToolbarSizeX, paintToolbarSizeY;
int paintToolSizeX, paintToolSizeY;
PImage inkpen, paintbrush, marker, eraser, pencil, ballpen;
int paintToolx, inkpenY, paintbrushY, markerY, eraserY, pencilY, ballpenY;

boolean showPaintToolbar, showingPaintToolbar;

int textToolbarX, textToolbarY, textToolbarSizeX, textToolbarSizeY;
int textToolSizeX, textToolSizeY;
PImage incFont, decFont, tempsave;
int textToolx, incFontY, decFontY, tempsaveY;

boolean showTextToolbar, showingTextToolbar;

int mainToolbarX, mainToolbarY, mainToolbarSizeX, mainToolbarSizeY, mainToolSizeX, mainToolSizeY;
int colorToolbarButtonX, colorToolbarButtonY, colorToolbarButtonSizeX, colorToolbarButtonSizeY;
int paintToolbarButtonX, paintToolbarButtonY;
int textToolbarButtonX, textToolbarButtonY;
int saveToolbarButtonX, saveToolbarButtonY;
int reloadToolbarButtonX, reloadToolbarButtonY;
PImage paintToolbarButton, textToolbarButton, colorToolbarButton, saveButton, reloadButton;

int textFieldX, textFieldY, textFieldSizeX, textFieldSizeY, textSize;

PImage colorGrid, colorGrid2;

boolean showColorGrid, showingColorGrid;

color c;

String noteName;


int currentTool;

float pspeed = 0;

int csave;

PImage currentFrame;



boolean showFlashScreen;

void setup() {
  orientation(LANDSCAPE);
  rectMode(CENTER);
  imageMode(CENTER);
  margin = width/40;
  background(255);
  frameRate(100);
  smooth();
  paintToolbarX = width;
  paintToolbarY = height/2;
  paintToolbarSizeX = width/7;
  paintToolbarSizeY = height - 4*margin;
  paintToolSizeX = paintToolbarSizeX - 2*margin;
  paintToolSizeY = (paintToolbarSizeY - margin)/6;
  paintToolx = width;
  inkpenY = 5*margin/2 + paintToolSizeY/2;
  ballpenY = inkpenY + paintToolSizeY;
  pencilY = ballpenY + paintToolSizeY;
  markerY = pencilY + paintToolSizeY;
  paintbrushY = markerY + paintToolSizeY;
  eraserY = paintbrushY + paintToolSizeY;
  inkpen = loadImage("inkpen.png");
  paintbrush = loadImage("paintbrush.png");
  marker = loadImage("marker.png");
  eraser = loadImage("eraser.png");
  pencil = loadImage("pencil.png");
  ballpen = loadImage("ballpen.png");

  showPaintToolbar = true;
  showingPaintToolbar = false;
  csave = 0;
  textToolbarX = width;
  textToolbarY = height/2;
  textToolbarSizeX = width/7;
  textToolbarSizeY = height/2;
  textToolSizeX = textToolbarSizeX/2 - margin;
  textToolSizeY = (textToolbarSizeY - 2*margin)/3 - margin/3;
  textToolx = width - textToolSizeX/2 - margin/2;
  decFontY = height/2;
  incFontY = decFontY - textToolSizeY - margin/3;
  tempsaveY = decFontY + textToolSizeY + margin/3;
  incFont = loadImage("incFont.png");
  decFont = loadImage("decFont.png");
  tempsave = loadImage("tempsave.png");
  showTextToolbar = false;
  showingTextToolbar = false;

  mainToolbarX = width/2 - 5*margin/2;
  mainToolbarY = height - 3*margin;
  mainToolbarSizeX = width - 5*margin;
  mainToolbarSizeY = 6*margin;
  mainToolSizeX = (mainToolbarSizeX - 2*margin)/8;
  mainToolSizeY = mainToolSizeX;
  colorToolbarButtonX = margin + mainToolSizeX/2;
  colorToolbarButtonY = mainToolbarY;
  paintToolbarButtonX = colorToolbarButtonX + 3*margin + mainToolSizeX/2;
  paintToolbarButtonY = mainToolbarY;
  textToolbarButtonX = colorToolbarButtonX + 3*margin + mainToolSizeX/2;
  textToolbarButtonY = mainToolbarY;
  saveToolbarButtonX = textToolbarButtonX + 3*margin + mainToolSizeX/2;
  saveToolbarButtonY = mainToolbarY;
  reloadToolbarButtonX = saveToolbarButtonX + 3*margin + mainToolSizeX/2;
  reloadToolbarButtonY = mainToolbarY;
  paintToolbarButton = loadImage("paintbrushicon.png");
  textToolbarButton = loadImage("kbicon.png");
  colorToolbarButton = loadImage("colortoolbarbutton.png");
  saveButton = loadImage("savebutton.png");
  reloadButton = loadImage("reloadbutton.png");

  textFieldX = reloadToolbarButtonX + mainToolSizeX/2 + margin;
  textFieldY = mainToolbarY - mainToolbarSizeY/2 + margin;
  textFieldSizeX = mainToolbarSizeX - mainToolbarX - 4*margin;
  textFieldSizeY = mainToolbarSizeY - 2*margin;
  textField = new APEditText(textFieldX, textFieldY, textFieldSizeX, textFieldSizeY);
  container = new APWidgetContainer(this); //create new container for widgets
  container.addWidget(textField);

  colorGrid = loadImage("colorgrid.png");
  colorGrid2 = loadImage("colorgrid2.png");
  showColorGrid = false;
  showingColorGrid = false;
  c = color(0);

  noteName = "note";
  textSize = 18;

  showFlashScreen = true;  
  markus = loadImage("Markus.png");
  currentTool = 0;
  currentTextPositionX = width/2;
  currentTextPositionY = height/2;
}

void draw() {
  if (showFlashScreen) {
    image(markus, width/2, height/2, width, height);
    container.hide();
    println(frameCount);
    if (frameCount > 300) {
      background(255);
      showFlashScreen = false;
    }
  }
  else {
    if (showPaintToolbar) {
      noStroke();
      fill(235, 232, 216);
      rect(paintToolbarX, paintToolbarY, paintToolbarSizeX, paintToolbarSizeY, margin/2);
      if (currentTool == 0)
        image(inkpen, paintToolx - margin, inkpenY, paintToolSizeX, paintToolSizeY);
      else
        image(inkpen, paintToolx, inkpenY, paintToolSizeX, paintToolSizeY);
      if (currentTool == 1)
        image(ballpen, paintToolx - margin, ballpenY, paintToolSizeX, paintToolSizeY);
      else
        image(ballpen, paintToolx, ballpenY, paintToolSizeX, paintToolSizeY);
      if (currentTool == 2)
        image(pencil, paintToolx - margin, pencilY, paintToolSizeX, paintToolSizeY);
      else
        image(pencil, paintToolx, pencilY, paintToolSizeX, paintToolSizeY);
      if (currentTool == 3)
        image(marker, paintToolx - margin, markerY, paintToolSizeX, paintToolSizeY);
      else
        image(marker, paintToolx, markerY, paintToolSizeX, paintToolSizeY);
      if (currentTool == 4)  
        image(paintbrush, paintToolx - margin, paintbrushY, paintToolSizeX, paintToolSizeY);
      else
        image(paintbrush, paintToolx, paintbrushY, paintToolSizeX, paintToolSizeY);
      if (currentTool == 5)
        image(eraser, paintToolx - margin, eraserY, paintToolSizeX, paintToolSizeY);
      else
        image(eraser, paintToolx, eraserY, paintToolSizeX, paintToolSizeY);
      container.hide();
      rect(mainToolbarX, mainToolbarY, mainToolbarSizeX, mainToolbarSizeY);
      image(textToolbarButton, textToolbarButtonX, textToolbarButtonY, mainToolSizeX, mainToolSizeY);
      //image(colorToolbarButton, colorToolbarButtonX, colorToolbarButtonY, mainToolSizeX, mainToolSizeY);
      image(saveButton, saveToolbarButtonX, saveToolbarButtonY, mainToolSizeX, mainToolSizeY);
      image(reloadButton, reloadToolbarButtonX, reloadToolbarButtonY, mainToolSizeX, mainToolSizeY);
      if (showColorGrid && mousePressed) {
        image(colorGrid2, colorToolbarButtonX, colorToolbarButtonY, mainToolSizeX, mainToolbarSizeY);
        if (dist(mouseX, 0, colorToolbarButtonX, 0) <= mainToolSizeX/2 && dist(0, mouseY, 0, colorToolbarButtonY) <= mainToolSizeY/2)
          c = get(mouseX, mouseY);
      }
      else
        image(colorToolbarButton, colorToolbarButtonX, colorToolbarButtonY, mainToolSizeX, mainToolSizeY);
      fill(c);
      rect(mainToolbarSizeX+margin, mainToolbarY, margin, mainToolbarSizeY);
      imageMode(CORNER);
      image(colorGrid, textFieldX, textFieldY, textFieldSizeX, textFieldSizeY);
      imageMode(CENTER);
    }
    if (showTextToolbar) {
      noStroke();
      fill(235, 232, 216);
      rect(textToolbarX, textToolbarY, textToolbarSizeX, textToolbarY, margin);
      image(incFont, textToolx, incFontY, textToolSizeX, textToolSizeY);
      image(decFont, textToolx, decFontY, textToolSizeX, textToolSizeY);
      image(tempsave, textToolx, tempsaveY, textToolSizeX, textToolSizeY);
      rect(mainToolbarX, mainToolbarY, mainToolbarSizeX, mainToolbarSizeY);
      //image(colorToolbarButton, colorToolbarButtonX, colorToolbarButtonY, mainToolSizeX, mainToolSizeY);
      image(saveButton, saveToolbarButtonX, saveToolbarButtonY, mainToolSizeX, mainToolSizeY);
      image(reloadButton, reloadToolbarButtonX, reloadToolbarButtonY, mainToolSizeX, mainToolSizeY);
      image(paintToolbarButton, paintToolbarButtonX, paintToolbarButtonY, mainToolSizeX, mainToolSizeY);
      container.show();
      if (showColorGrid && mousePressed) {
        image(colorGrid2, colorToolbarButtonX, colorToolbarButtonY, mainToolSizeX, mainToolbarSizeY);
        if (dist(mouseX, 0, colorToolbarButtonX, 0) <= mainToolSizeX/2 && dist(0, mouseY, 0, colorToolbarButtonY) <= mainToolSizeY/2 && showTextToolbar)
          c = get(mouseX, mouseY);
      }
      else
        image(colorToolbarButton, colorToolbarButtonX, colorToolbarButtonY, mainToolSizeX, mainToolSizeY);
      fill(c);
      rect(mainToolbarSizeX+margin, mainToolbarY, margin, mainToolbarSizeY);
      if (currentTool == 9) {
        currentsave();
        currentTool = 0;
      }
      if (currentTool == 6 || currentTool == 7 || currentTool == 10) {
        textSize(textSize);
        imageMode(CORNER);
        image(fr, 0, 0, width - paintToolbarSizeX/2, height - mainToolbarSizeY);
        imageMode(CENTER);
        text(textField.getText(), currentTextPositionX, currentTextPositionY);
      }
    }
  }
}

void mousePressed() {
  if (!showFlashScreen) {
    if (dist(mouseX, 0, paintToolbarButtonX, 0) <= mainToolSizeX/2 && dist(0, mouseY, 0, paintToolbarButtonY) <= mainToolSizeY/2 ) {
      showPaintToolbar = !showPaintToolbar;
      showTextToolbar = !showTextToolbar;
      fill(255);
      rect(mainToolbarX, mainToolbarY, mainToolbarSizeX, mainToolbarSizeY);
      rect(paintToolbarX, paintToolbarY, paintToolbarSizeX+1, paintToolbarSizeY+1);
      if (showTextToolbar)
        currentTool = 9;
    }


    if (dist(mouseX, 0, colorToolbarButtonX, 0) <= mainToolSizeX/2 && dist(0, mouseY, 0, colorToolbarButtonY) <= mainToolSizeY/2) {
      showColorGrid = true;
    }
    else
      showColorGrid = false;


    if (dist(mouseX, 0, reloadToolbarButtonX, 0) <= mainToolSizeX/2 && dist(0, mouseY, 0, reloadToolbarButtonY) <= mainToolSizeY/2) {
      rectMode(CORNER);
      noStroke();
      fill(255);
      rect(0, 0, width - paintToolbarSizeX/2 +1, height - mainToolbarSizeY +1);
      rectMode(CENTER);
      if (showTextToolbar)
        currentsave();
    }

    if (dist(mouseX, 0, saveToolbarButtonX, 0) <= mainToolSizeX/2 && dist(0, mouseY, 0, saveToolbarButtonY) <= mainToolSizeY/2 && csave == 0) {


      try {
        currentsave();
        PImage img = get(0, 0, width - paintToolbarSizeX/2, height - mainToolbarSizeY);
        img.save("//sdcard//NoteMaker/note"+str(frameCount)+".png");
        csave = 1;
        println("saved");
      }
      catch(Exception e) {
        PImage img = get(0, 0, width - paintToolbarSizeX/2, height - mainToolbarSizeY);
        img.save(str(frameCount)+".png");
        println("unable to save image !");
      }
    }

    if (showPaintToolbar) {
      if (dist(mouseX, 0, paintToolx, 0) <= paintToolSizeX/2 && dist(0, mouseY, 0, inkpenY) <= paintToolSizeY/2) {
        currentTool = 0;
      }
      else {
        if (dist(mouseX, 0, paintToolx, 0) <= paintToolSizeX/2 && dist(0, mouseY, 0, ballpenY) <= paintToolSizeY/2) {
          currentTool = 1;
        }
        else {
          if (dist(mouseX, 0, paintToolx, 0) <= paintToolSizeX/2 && dist(0, mouseY, 0, pencilY) <= paintToolSizeY/2) {
            currentTool = 2;
          }
          else {
            if (dist(mouseX, 0, paintToolx, 0) <= paintToolSizeX/2 && dist(0, mouseY, 0, markerY) <= paintToolSizeY) {
              currentTool = 3;
            }
            else {
              if (dist(mouseX, 0, paintToolx, 0) <= paintToolSizeX/2 && dist(0, mouseY, 0, paintbrushY) <= paintToolSizeY) {
                currentTool = 4;
              }
              else {
                if (dist(mouseX, 0, paintToolx, 0) <= paintToolSizeX/2 && dist(0, mouseY, 0, eraserY) <= paintToolSizeY) {
                  currentTool = 5;
                }
              }
            }
          }
        }
      }
    }
    if (showTextToolbar && dist(mouseX, 0, textToolx, 0) <= textToolSizeX/2) {
      if (dist(0, mouseY, 0, incFontY) <= textToolSizeY/2) {
        currentTool = 6;
        textSize--;
      }
      if (dist(0, mouseY, 0, decFontY) <= textToolSizeY/2) {
        currentTool = 7;
        textSize++;
      }
      if (dist(0, mouseY, 0, tempsaveY) <= textToolSizeY/2) {
        currentTool = 8;
        textField.setText("");
        currentsave();
      }
    }
    if (dist(mouseX, 0, textFieldX + textFieldSizeX/2, 0) <= textFieldSizeX/2 && dist(0, mouseY, 0, textFieldY + textFieldSizeY/2) <= textFieldSizeY/2 && showPaintToolbar) {
      currentTool = 10;
      c = get(mouseX, mouseY);
      noStroke();
      fill(c);
      rect(mainToolbarSizeX+margin, mainToolbarY, margin, mainToolbarSizeY);
    }
  }
}

void mouseDragged() {
  if (!showFlashScreen) {
    if (dist(mouseX, 0, textFieldX + textFieldSizeX/2, 0) <= textFieldSizeX/2 && dist(0, mouseY, 0, textFieldY + textFieldSizeY/2) <= textFieldSizeY/2 ) {
      c = get(mouseX, mouseY);
      noStroke();
      fill(c);
      rect(mainToolbarSizeX+margin, mainToolbarY, margin, mainToolbarSizeY);
    }
    if (showPaintToolbar) {
      csave = 0;
      if (currentTool == 0) {
        inkPenSim(pmouseX, pmouseY, mouseX, mouseY);
      }
      if (currentTool == 1) {
        penSim(pmouseX, pmouseY, mouseX, mouseY);
      }
      if (currentTool == 2) {
        pencilSim(pmouseX, pmouseY, mouseX, mouseY);
      }
      if (currentTool == 3) {
        markerSim(pmouseX, pmouseY, mouseX, mouseY);
      }
      if (currentTool == 4) {
        paintbrushSim(pmouseX, pmouseY, mouseX, mouseY);
      }
      if (currentTool == 5) {
        eraserSim(pmouseX, pmouseY, mouseX, mouseY);
      }
    }
    if (showTextToolbar && mouseY < height-mainToolbarSizeY && mouseX < width-paintToolbarSizeX/2) {
      println(textField.getText());
      textSize(textSize);
      imageMode(CORNER);
      image(fr, 0, 0);
      imageMode(CENTER);
      if(mousePressed)
        text(textField.getText(), mouseX, mouseY);
      currentTextPositionX = mouseX;
      currentTextPositionY = mouseY;
      csave = 0;
    }
  }
}


void inkPenSim(float px, float py, float x, float y) {
  float speed = dist(0, py, 0, y);
  float speed1 = dist(px, py, x, y);
  float inc = 2;
  float weight = 5;
  stroke(c);
  strokeWeight(3);
  strokeCap(ROUND);
  if (py<=y) {
    float factor = map(speed, 0, 10, 0, 1);
    float factor1 = map(speed1, 0, 10, 0, 1);
    factor = constrain(factor, 0.1, 1);
    factor1 = constrain(factor1, 0, 1);
    factor1 = 0;
    if (pspeed>speed1)
      weight = weight + inc*(factor + factor1);
    else
      weight = weight + inc*(factor - factor1);
    weight = constrain(weight, 2, 5);
    strokeWeight(weight);
    line(px, py, x, y);
  }
  else {
    float factor = map(speed, 0, 10, 0, 1);
    float factor1 = map(speed1, 0, 10, 0, 1);
    factor = constrain(factor, 0.1, 1);
    factor1 = constrain(factor1, 0, 1);
    factor1 = 0;
    if (pspeed>speed1)
      weight = weight - inc*(factor - factor1);
    else
      weight = weight - inc*(factor + factor1);
    weight = constrain(weight, 2, 5);
    strokeWeight(weight);
    line(px, py, x, y);
  }
  pspeed = speed1;
}

void penSim(float px, float py, float x, float y) {
  stroke(c);
  strokeWeight(2);
  strokeCap(SQUARE);
  line(px, py, x, y);
}

void eraserSim(int px, int py, int x, int y) {
  stroke(255);
  strokeCap(ROUND);
  strokeWeight(20);
  line(px, py, x, y);
}

void markerSim(int x, int y, int x2, int y2) {
  stroke(c, 10);
  strokeWeight(30);
  int w = x2 - x ;
  int h = y2 - y ;
  int dx1 = 0, dy1 = 0, dx2 = 0, dy2 = 0 ;
  if (w<0) dx1 = -1 ; 
  else if (w>0) dx1 = 1 ;
  if (h<0) dy1 = -1 ; 
  else if (h>0) dy1 = 1 ;
  if (w<0) dx2 = -1 ; 
  else if (w>0) dx2 = 1 ;
  int longest = abs(w) ;
  int shortest = abs(h) ;
  if (!(longest>shortest)) {
    longest = abs(h) ;
    shortest = abs(w) ;
    if (h<0) dy2 = -1 ; 
    else if (h>0) dy2 = 1 ;
    dx2 = 0 ;
  }
  int numerator = longest >> 1 ;
  for (int i=0;i<=longest;i++) {
    if (x !=x2 || y!=y2)
      point(x, y);
    numerator += shortest ;
    if (!(numerator<longest)) {
      numerator -= longest ;
      x += dx1 ;
      y += dy1 ;
    } 
    else {
      x += dx2 ;
      y += dy2 ;
    }
  }
}

void paintbrushSim(float px, float py, float x, float y) {
  float speed = dist(px, py, x, y);
  float factor = map(speed, 0, 30, 5, 0.5);
  float alpha = 2*factor;
  float strk = 6*factor;
  strk = constrain(strk, 25, 30);
  float r, g, b;
  alpha = constrain(alpha, 3, 10);
  stroke(c, alpha);
  strokeWeight(0.5);
  if (mousePressed) {
    paint((int)(px), (int)(py), (int)(x), (int)(y), c, alpha, strk);
  }
}

void pencilSim(float px, float py, float x, float y) {
  stroke(c, 70);
  strokeWeight(1);
  strokeCap(SQUARE);
  line(px, py, x, y);
}

void currentsave() {
  save("tmp_note.png");
  currentScreen = loadImage("tmp_note.png");
  fr = currentScreen.get(0,0,width - paintToolbarSizeX/2, height - mainToolbarSizeY);
  textField.setText("");
}

void paint(int x, int y, int x2, int y2, color col, float alpha, float strk) {
  stroke(col, alpha);
  strokeWeight(strk);
  int w = x2 - x ;
  int h = y2 - y ;
  int dx1 = 0, dy1 = 0, dx2 = 0, dy2 = 0 ;
  if (w<0) dx1 = -1 ; 
  else if (w>0) dx1 = 1 ;
  if (h<0) dy1 = -1 ; 
  else if (h>0) dy1 = 1 ;
  if (w<0) dx2 = -1 ; 
  else if (w>0) dx2 = 1 ;
  int longest = abs(w) ;
  int shortest = abs(h) ;
  if (!(longest>shortest)) {
    longest = abs(h) ;
    shortest = abs(w) ;
    if (h<0) dy2 = -1 ; 
    else if (h>0) dy2 = 1 ;
    dx2 = 0 ;
  }
  int numerator = longest >> 1 ;
  for (int i=0;i<=longest;i++) {
    if (x !=x2 || y!=y2)
      point(x, y);
    numerator += shortest ;
    if (!(numerator<longest)) {
      numerator -= longest ;
      x += dx1 ;
      y += dy1 ;
    } 
    else {
      x += dx2 ;
      y += dy2 ;
    }
  }
}

