unit u.typeinfo;

interface

type
  oRecLivello = Record
    Livello: Integer;
    Mappa: Array[0..23, 0..33] of char;
    Bonus: Integer;
//    Perle: Integer;
    X: Integer;
    Y: Integer;
    ColorWall: Integer;
  End;
  oRecBestPlayer = Record
    Tempo: TTime;
    Punteggio: Integer;
    Cuori: Integer;
    Perle: Integer;
    Livelli: Integer;
    Mura: Integer;
    Malus: Integer;
    Public
      Procedure create;
  End;
  TRecArray = array[0..SizeOf(oRecLivello) - 1] of byte;
  oRecUDG = Record
    aBit: array[0..7, 0..7] of byte;  //
  End;
  oMovement = (drBassoDX, drBassoSX, drAltoDX, drAltoSX, drVert, drOriz);
  oDirection = (daSXDX, daDXSX, daALBA, daBAAL);

implementation

{ oRecBestPlayer }

procedure oRecBestPlayer.create;
begin
  Tempo := 0;
  Punteggio := 0;
  Cuori := 0;
  Perle := 0;
  Livelli := 0;
  Mura := 0;
  Malus := 0;
end;

end.
