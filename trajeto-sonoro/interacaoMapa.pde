//zoom e movimento -> teclado
void keyPressed() 
{
  //ZOOM
  if (key == '=' || key == '+') {
    println("zoomIn");
    int zoomFix = map.getZoomLevel() + 1;
    map.zoomAndPanTo(width/2, height/2, zoomFix);
  } else if (key == '-') {
    println("zoomOut");
    int zoomFix = map.getZoomLevel() - 1;
    map.zoomAndPanTo(width/2, height/2, zoomFix);
  }
  //PAN MOVIMENT
  if (key == CODED) {
    if (keyCode == UP) {
      println("cima");
      map.panUp();
    } else if (keyCode == DOWN) {
      println("baixo");
      map.panDown();
    } else if (keyCode == RIGHT) {
      println("direita");
      map.panRight();
    } else if (keyCode == LEFT) {
      println("esquerda");
      map.panLeft();
    }
  }
}



//Botões zoom e movimento -> tela
void mousePressed() {
  if (mousePressed) 
  {
    if (bt[4].hasClicked()) {
      println("botao + clicado");
      int zoomFix = map.getZoomLevel() + 1;
      map.zoomAndPanTo(width/2, height/2, zoomFix);
      //map.zoomIn();
    }
    if (bt[5].hasClicked()) {
      println("botao - clicado");
      int zoomFix = map.getZoomLevel() - 1;
      map.zoomAndPanTo(width/2, height/2, zoomFix);
    }
  }
}

void interacaoSetas() {
  if (mousePressed) 
  {
    //if (mousePressed) ----- fazer isso como no key
    if (bt[0].hasClicked()) {
      println("botao UP clicado");
      int screenPosition_x = width/2;
      int screenPosition_y = height/2;
      map.panTo(screenPosition_x, screenPosition_y - 10);
    }
    if ( bt[1].hasClicked()) {
      println("botao RIGHT clicado");
      int screenPosition_x = width/2;
      int screenPosition_y = height/2;
      map.panTo(screenPosition_x + 10, screenPosition_y);
    }
    if ( bt[2].hasClicked()) {
      println("botao DOWN clicado");
      int screenPosition_x = width/2;
      int screenPosition_y = height/2;
      map.panTo(screenPosition_x, screenPosition_y + 10);
    }
    if ( bt[3].hasClicked()) {
      println("botao LEFT clicado");
      int screenPosition_x = width/2;
      int screenPosition_y = height/2;
      map.panTo(screenPosition_x - 10, screenPosition_y);
    }
  }
}

//Botões Audio
void mouseClicked() 
{
  for (int i = 0; i < btAudio.length; i++) 
  {
    if (btAudio[i].hasClickedbtAudio()) {
      println("Botão "+i+ " click");
    }
  }
}