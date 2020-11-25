unit u.Constant.Loc;

interface

uses
   FMX.Graphics
  ,u.typeinfo
  ;
CONST
  CS_WIDTH  = 176;
  CS_HEIGHT = 176;
  CS_SPRITE =  24;

  CS_MAPPA_W = 33;
  CS_MAPPA_H = 23;
  CS_BYTE = 7;

  CS_MINUTO = 0.00069444444444;

Var
  aUDG: array[0..CS_SPRITE, 0..CS_BYTE] of integer = ( (36,126,153,102,102,153,126,36), {0/1}
                                          (60, 66, 165, 129, 165, 153, 66, 60), { 1 1}
                                          (4, 4, 4, 255, 64, 64, 64, 255),      { 2 2}
                                          (60, 66, 165, 129, 129, 153, 66, 60), { 3 3}
                                          (255, 255, 255, 255, 255, 255, 255, 255), { 4 4}
                                          (0,36,126,126,126,60,24,0),  {5/9}
                                          (60,36,228,156,148,252,0,0), { 6/3 }
                                          (60,36,39,57,41,63,0,0), { 7/4}
                                          (0,0,63,41,57,39,36,60), {8/5}
                                          (0,0,252,148,156,228,36,60), {9/6}
                                          (0,0,255,153,153,255,0,0), {10/7}
                                          (60,36,36,60,60,36,36,60), {11/8}
                                          (0,0,0,24,24,0,0,0), {12/9}
                                          (0,126,66,90,90,66,126,0), {13/A}
                                          (255,231,195,129,129,195,231,255),  {14/B}
                                          (255,255,224,192,192,192,195,195), { 15/C basso destra}
                                          (255,255,7,3,3,3,195,195),  {16/D basso sinistra}
                                          (195,195,192,192,192,224,255,255),  {17/E alto destra}
                                          (195,195,3,3,3,7,255,255),  {18/F alto sinistra}
                                          (255,255,66,0,0,66,255,255), {19/G orizzontale}
                                          (195,231,195,195,195,195,231,195), {20/H verticale}
                                          (255,231,195,195,129,129,129,195), {21 testa su}
                                          (195,129,129,129,129,195,195,231), {22 testa giù}
                                          (255,135,1,0,0,1,135,255),         {23 testa dx}
                                          (255,225,128,0,0,128,225,255)      {24 testa sx}

                                       );
  oSprite: Array[0..CS_SPRITE] of TBitMap;
  oMappa: Array[0..CS_MAPPA_H, 0..CS_MAPPA_W] of Integer;
  oCoda: Array[0..704, 0..2] of Integer;
  oRecLevel: oRecLivello;
  oVerso: oDirection;
  oVersoOld: oDirection;
  oCodaDir: oMovement;
  oCodaDirOld: oMovement;


implementation

end.
