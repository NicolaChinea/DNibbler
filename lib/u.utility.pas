unit u.utility;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Objects
  ,  u.typeinfo
  ;

  procedure ByteArrayToFIle(const ByteArray: TRecArray; const FileName: string);
  function FIleToByteArray(const FileName: string): TRecArray;
  procedure CreateUDG;
  procedure DrawMap(Const aLivello: oRecLivello; Var rWMain: TRectangle);

implementation

uses
   FMX.Graphics, u.Constant.Loc, u.graph;

procedure ByteArrayToFIle(const ByteArray: TRecArray; const FileName: string);
var Count : integer;
    F: FIle of Byte;
    pTemp: Pointer;
begin
  AssignFile( F, FileName );
  Rewrite(F);
  try
    Count := Length( ByteArray );
    pTemp := @ByteArray[0];
    BlockWrite(F, pTemp^, Count );
  finally
    CloseFile( F );
  end;
end;

function FIleToByteArray(const FileName: string): TRecArray;
var Count: integer;
    F: FIle of Byte;
    pTemp: Pointer;
begin
  AssignFile( F, FileName );
  Reset(F);
  try
    Count := FileSize( F );
    pTemp := @Result[0];
    BlockRead(f,pTemp^,count);
  finally
    CloseFile( F );
  end;
end;

procedure CreateUDG;
var bitdata1: TBitmapData;
    i, x, y: Integer;
    sTemp: String;
  function IntToBin(Value: Byte): String;
  var
    i: Integer;
    pStr: PChar;
  begin
    SetLength( Result,8);
    pStr := PChar(Pointer(Result));
    for i := 7 downto 0 do begin
      pStr[i] := Char(Ord('0') + ((Value shr (7 - i)) and 1));
    end;
  end;
begin
  for i := 0 to CS_SPRITE do
  begin
    oSprite[i] := TBitmap.Create;
    oSprite[i].Width := 8;
    oSprite[i].Height := 8;
    if (oSprite[i].Map(TMapAccess.ReadWrite, bitdata1)) then
    try
      for y := 0 to 7 do
      begin
        sTemp := IntToBin(aUDG[i][y]);
        for x := 0 to CS_BYTE do
        begin
          if sTemp[x+1] = '1' then
            bitdata1.SetPixel(x, y, TAlphaColorRec.Black);
        end;
      end;
    finally
      oSprite[i].Unmap(bitdata1);
    end;

 //   MakePNG(oSprite[i], 'sprite\'+i.ToString+'.png');
//    oSprite[i].SaveToFile('sprite\'+i.ToString+'.bmp');
  end;
end;

procedure DrawMap(const aLivello: oRecLivello; Var rWMain: TRectangle);
var
  i: Integer;
  j: Integer;
  z: Integer;
  s: String;
begin
  for i := 0 to CS_MAPPA_H do
  begin
    for j := 0 to CS_MAPPA_W do
      if aLivello.Mappa[i][j]  ='2' then
      begin
        DrawSprite(rWMain, oSprite[2], i, j, TAlphaColorRec.Blueviolet, TAlphaColorRec.Yellow);
        oMappa[I, J] := 2;
      end
      else if aLivello.Mappa[i][j] ='3' then
      begin
        DrawSprite(rWMain, oSprite[6], i, j, TAlphaColorRec.Blueviolet, TAlphaColorRec.Black);
        oMappa[I, J] := 2;
      end
      else if aLivello.Mappa[i][j] ='4' then
      begin
        DrawSprite(rWMain, oSprite[7], i, j, TAlphaColorRec.Blueviolet, TAlphaColorRec.Black);
        oMappa[I, J] := 2;
      end
      else if aLivello.Mappa[i][j] ='5' then
      begin
        DrawSprite(rWMain, oSprite[8], i, j, TAlphaColorRec.Blueviolet, TAlphaColorRec.Black);
        oMappa[I, J] := 2;
      end
      else if aLivello.Mappa[i][j] ='6' then
      begin
        DrawSprite(rWMain, oSprite[9], i, j, TAlphaColorRec.Blueviolet, TAlphaColorRec.Black);
        oMappa[I, J] := 2;
      end
      else if aLivello.Mappa[i][j] ='7' then
      begin
        DrawSprite(rWMain, oSprite[10], i, j, TAlphaColorRec.Blueviolet, TAlphaColorRec.Black);
        oMappa[I, J] := 2;
      end
      else if aLivello.Mappa[i][j] ='8' then
      begin
        DrawSprite(rWMain, oSprite[11], i, j, TAlphaColorRec.Blueviolet, TAlphaColorRec.Black);
        oMappa[I, J] := 2;
      end
      else if aLivello.Mappa[i][j] ='0' then
      begin
        DrawSprite(rWMain, oSprite[12], i, j, TAlphaColorRec.Chartreuse, TAlphaColorRec.Black);
        oMappa[I, J] := 0;
      end
      else if aLivello.Mappa[i][j] ='A' then
      begin
        DrawSprite(rWMain, oSprite[13], i, j, TAlphaColorRec.Blueviolet, TAlphaColorRec.Black);
        oMappa[I, J] := 2;
      end
      else if aLivello.Mappa[i][j] ='9' then
      begin
        DrawSprite(rWMain, oSprite[5], i, j, TAlphaColorRec.red, TAlphaColorRec.Black);
        oMappa[I, J] := 9;
      end;
  end;
end;

end.
