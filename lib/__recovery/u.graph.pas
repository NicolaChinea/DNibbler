unit u.graph;

interface
uses
  FMX.Graphics // for TCanvas
  , System.UITypes // for TAlphaColorRec + others
  , System.Math.Vectors  // for TPolygon + others
  , FMX.Objects;

  Function GetColor(Const nColor: Integer): TAlphaColor;
  procedure DrawText(var Region: Trectangle; const sText: String; Y1, X1: Single; Const Color, background: TAlphaColor);
  procedure Cls(var Region: Trectangle; Color: TAlphaColor = TAlphaColorRec.Black);
  procedure MakePNG(Var aImage: TBitmap; Const filename: string);
  Procedure DrawSprite(var Region: Trectangle; const oBmp: TBitmap; Y1, X1: Single; Const Color, background: TAlphaColor; lOver:Boolean = true);


implementation
uses
  System.Types, FMX.Types, System.Classes, FMX.Surfaces, System.SysUtils;


Function GetColor(Const nColor: Integer): TAlphaColor;
begin
  case nColor of
    0: Result := TAlphaColorRec.Black;
    1: Result := TAlphaColorRec.Blue;
    2: Result := TAlphaColorRec.Green;
    3: Result := TAlphaColorRec.Cyan;
    4: Result := TAlphaColorRec.Red;
    5: Result := TAlphaColorRec.Magenta;
    6: Result := TAlphaColorRec.Brown;
    7: Result := TAlphaColorRec.White;
    8: Result := TAlphaColorRec.Grey;
    9: Result := TAlphaColorRec.Lightblue;
   10: Result := TAlphaColorRec.Lightgreen;
   11: Result := TAlphaColorRec.Lightcyan;
   12: Result := TAlphaColorRec.Red;
   13: Result := TAlphaColorRec.Lightcoral;
   14: Result := TAlphaColorRec.Yellow;
   15: Result := TAlphaColorRec.White;
  else
    Result := TAlphaColorRec.Black;
  end;
end;

Procedure DrawSprite(var Region: Trectangle; const oBmp: TBitmap; Y1, X1: Single; Const Color, background: TAlphaColor; lOver:Boolean = true);
var mRect, mRectSource: TRectF;
  sWidth: Single;
  sHeight: Single;
  FB: TBrush;
  bitdata1: TBitmapData;
  y: Integer;
  x: Integer;
  oLocalBMP: TBitmap;
begin
  if assigned(Region.Fill.Bitmap.Bitmap.Canvas) then
  begin
    Region.Fill.Bitmap.Bitmap.Canvas.BeginScene();
    oLocalBMP := TBitmap.Create;
    try
      oLocalBMP.Assign(oBmp);
      if (oBmp.Map(TMapAccess.ReadWrite, bitdata1)) then
      try
        for y := 0 to 7 do
          for x := 0 to 7 do
            if bitdata1.GetPixel(x, y) <> 0  then
              bitdata1.SetPixel(x, y, Color)
            else
            begin
              if background <> 0 then
                bitdata1.SetPixel(x, y, background);
            end;
      finally
        oBmp.Unmap(bitdata1);
      end;

      Region.Fill.Bitmap.Bitmap.canvas.Stroke.Kind := TBrushKind.None;
      Region.Fill.Bitmap.Bitmap.canvas.Stroke.Thickness := 0;

      sWidth  := 8;
      sHeight := 8;

      X1 := (X1 * sWidth);
      Y1 := (Y1 * sHeight);

      mRect.Create(X1, Y1, X1 + sWidth, Y1 + sHeight);
      mRectSource.Create(0, 0, oBmp.Width, oBmp.Height);
      if not lOver then
      begin
        FB := TBrush.Create(TBrushKind.bkSolid, Background);
        Region.Fill.Bitmap.Bitmap.Canvas.FillRect(mrect,0,0,[],1,FB);
        FreeAndNil(FB);
      end;
      Region.Fill.Bitmap.bitmap.Canvas.DrawBitmap(oBmp, mRectSource, mRect, 1.0);
    finally
      Region.Fill.Bitmap.Bitmap.Canvas.EndScene;
      oBmp.Assign(oLocalBMP);
      oLocalBMP.Free;
      oLocalBMP := Nil;
    end;
  end;
end;

procedure DrawText(var Region:Trectangle;const sText: String; Y1, X1: Single; Const Color, Background: TAlphaColor );
var mRect: TRectF;
  sWidth: Single;
  sHeight: Single;
  FB: TBrush;
begin
  if assigned(Region.Fill.Bitmap.Bitmap.Canvas) then begin
    Region.Fill.Bitmap.Bitmap.Canvas.BeginScene();
    try
      Region.Fill.Bitmap.bitmap.Canvas.Font.Family := 'Courier New';
      Region.Fill.Bitmap.bitmap.Canvas.Font.size := 8;
      Region.Fill.Bitmap.Bitmap.canvas.Stroke.Kind := TBrushKind.None;
      Region.Fill.Bitmap.Bitmap.canvas.Stroke.Thickness := 0;
      Region.Fill.Bitmap.bitmap.Canvas.Fill.Color := Color;

      sWidth  := 8;//Region.Fill.Bitmap.bitmap.Canvas.TextWidth('X');
      sHeight := 8;//Region.Fill.Bitmap.bitmap.Canvas.TextHeight('X');

      X1 := (X1 * sWidth);
      Y1 := (Y1 * sHeight);

      sWidth  := 8 * Length(sText);//Region.Fill.Bitmap.bitmap.Canvas.TextWidth(sText);
      sHeight := Region.Fill.Bitmap.bitmap.Canvas.TextHeight(sText);
      mRect.Create(X1, Y1, X1 + sWidth, Y1 + sHeight);

      FB := TBrush.Create(TBrushKind.bkSolid, Background);
      Region.Fill.Bitmap.Bitmap.Canvas.FillRect(mrect,0,0,[],1,FB);
      FreeAndNil(FB);
      Region.Fill.Bitmap.bitmap.Canvas.FillText(mRect, sText, false, 1.0, [], TTextAlign.Leading, TTextAlign.Center);
    finally
      Region.Fill.Bitmap.Bitmap.Canvas.EndScene;
    end;
  end;
end;

procedure Cls(var Region:Trectangle; Color: TAlphaColor = TAlphaColorRec.Black);
Var X1, Y1: Integer;
    mRect: TRectF;
    FB: TBrush;
begin
  if assigned(Region.Fill.Bitmap.Bitmap.Canvas) then begin
    Region.Fill.Bitmap.Bitmap.Canvas.BeginScene();
    try
      X1 := 0;
      Y1 := 0;
      mRect.Create(X1, Y1, X1 + Region.Width, Y1 + Region.Height);
      FB := TBrush.Create(TBrushKind.bkSolid, Color);
      Region.Fill.Bitmap.Bitmap.Canvas.FillRect(mrect,0,0,[],1,FB);
      FreeAndNil(FB);
    finally
      Region.Fill.Bitmap.Bitmap.Canvas.EndScene;
    end;
  end;
end;

procedure MakePNG(Var aImage: TBitmap; Const filename: string);
var
  Stream: TMemoryStream;
  Surf: TBitmapSurface;
  aFile : string;
begin
  Stream := TMemoryStream.Create;
  aImage.SaveToStream(Stream);
  try
    Stream.Position := 0;
    Surf := TBitmapSurface.Create;
    try
      Surf.Assign(aImage);
      if not TBitmapCodecManager.SaveToStream(
                       Stream,
                       Surf,
                       '.png') then
        raise EBitmapSavingFailed.Create(
              'Error saving Bitmap to png');
    finally
      Surf.Free;
    end;
    Stream.Position := 0;
    aImage.LoadFromStream(Stream);
    Stream.Position := 0;
    Stream.SaveToFile(filename);
  finally
    Stream.Free;
  end;
end;

end.
