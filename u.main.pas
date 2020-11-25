unit u.main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects
  , System.IOUtils
  , u.Constant.Loc
  , u.typeinfo, FMX.Controls.Presentation, FMX.StdCtrls, u.Statistiche,
  u.HallFame
  ;

type

  TFMain = class(TForm)
    lyMain: TLayout;
    rFondo: TRectangle;
    rBoard: TRectangle;
    Rectangle2: TRectangle;
    tmMain: TTimer;
    rtHead: TRectangle;
    txVite: TText;
    txBonus: TText;
    txMuri: TText;
    txPerle: TText;
    txPunti: TText;
    txValVite: TText;
    txValBonus: TText;
    txValPerle: TText;
    txValMuri: TText;
    txValPunti: TText;
    Image1: TImage;
    Text1: TText;
    txValMalus: TText;
    Text3: TText;
    txValTime: TText;
    rExit: TRectangle;
    rNewGame: TRectangle;
    Text2: TText;
    Text4: TText;
    Timer: TTimer;
    Rectangle1: TRectangle;
    txFame: TText;
    FStat1: TFStat;
    rColore: TRectangle;
    FHallFame1: TFHallFame;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;  Shift: TShiftState);
    procedure tmMainTimer(Sender: TObject);
    procedure btStartClick(Sender: TObject);
    procedure btExit1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FStat1Text5Click(Sender: TObject);
    procedure txFameClick(Sender: TObject);
    procedure FHallFame1Text4Click(Sender: TObject);
  private
//    MapLevel: TRecArray;
    nLevel: Integer;
    y: Integer;
    x: Integer;
    nCodaIndex: Integer;
    nCodaCreate: Integer;
    nCodaLung: Integer;
    nBonus: Integer;
    nPerle, nBonusConta, nMuri, nMalus: Integer;
    nPunteggio: Integer;
    nVite: Integer;
    fTempo: TTime;
    BestPoint: Array of oRecBestPlayer;
    procedure LoadNextlvl(const aLevel: Integer);
    Procedure SettaVariabili(const aRec: oRecLivello);
    Procedure ShowStat;
    procedure ClearCoda;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;


implementation

{$R *.fmx}

uses u.graph, u.utility, d.dati;

procedure TFMain.btExit1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFMain.btStartClick(Sender: TObject);
begin
  nLevel := 1;
  LoadNextlvl(nLevel);
  nPunteggio := 0;
  nVite := 3;
  nPerle := 0;
  nBonusConta := 0;
  nMuri := 0;
  nMalus := 0;
  txValVite.Text := nVite.ToString;
  tmMain.Enabled := True;
  DMDati.T_HIGHSCORE.Append;
  DMDati.T_HIGHSCOREDATA.AsDateTime := Now;
  DMDati.T_HIGHSCORE.Post;
end;

procedure TFMain.ClearCoda;
var
  I: Integer;
  TY: Integer;
  TX: Integer;
begin
  for I := 704 downto 0 do
  begin
    TY := oCoda[I][1];
    TX := oCoda[I][2];
    if (TY > 0) or (TX > 0) then
    begin
      DrawSprite(rFondo, oSprite[4], ty, tx, TAlphaColorRec.Black, 0);
      oMappa[TY][TX] := -1;
      oCoda[I][1] := 0;
      oCoda[I][2] := 0;
    end;
  end;
end;

procedure TFMain.FHallFame1Text4Click(Sender: TObject);
begin
  FHallFame1.Visible := False;
  DMDati.Q_HallFame.Close;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  FStat1.Visible := False;
  FHallFame1.Visible := False;
  CreateUDG;
  nLevel := 1;
  x := 0;
  y := 0;
end;

procedure TFMain.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CS_SPRITE do
    FreeAndNil(oSprite[i]);
end;

procedure TFMain.LoadNextlvl(const aLevel: Integer);
Var  MyArray : TRecArray absolute oRecLevel;
   oo: TFile;
begin

   MyArray:=filetobytearray('livelli\Livello_' + aLevel.ToString + '.lev');
   ClearCoda;
   DrawMap(oRecLevel, rFondo);
   SettaVariabili(oRecLevel);
   SetLength(BestPoint, Length(BestPoint) + 1);
   BestPoint[High(BestPoint)].create;
   BestPoint[High(BestPoint)].Livelli := aLevel;
end;


procedure TFMain.SettaVariabili(const aRec: oRecLivello);
begin
   x := oRecLevel.X-5;
   y := oRecLevel.Y;
   oCoda[1][1] := Y;
   oCoda[1][2] := X;
   nCodaIndex := 1;
   nCodaCreate := 4;
   nCodaLung := 1;
   fTempo := 0;
   Timer.Enabled := True;
   oVerso := daSXDX;
   oVersoOld := oVerso;
   oCodaDir := drOriz;
   nBonus := 0;
end;

procedure TFMain.ShowStat;
Var nLiv: Integer;
begin
  nLiv := Length(BestPoint);
  DMDati.T_Livelli.Append;
  DMDati.T_LivelliID_HIGH.AsInteger := DMDati.T_HIGHSCOREID.AsInteger;
  DMDati.T_LivelliCUORI.AsInteger := BestPoint[High(BestPoint)].Cuori;
  DMDati.T_LivelliLIVELLO.AsInteger := nLiv;
  DMDati.T_LivelliMALUS.AsInteger := BestPoint[High(BestPoint)].Malus;
  DMDati.T_LivelliMURA.AsInteger := BestPoint[High(BestPoint)].Mura;
  DMDati.T_LivelliPERLE.AsInteger := BestPoint[High(BestPoint)].Perle;
  DMDati.T_LivelliPUNTI.AsInteger := BestPoint[High(BestPoint)].Punteggio;
  BestPoint[High(BestPoint)].Tempo := fTempo;
  DMDati.T_LivelliTEMPO.AsString := formatdatetime('hh:nn:ss', ftempo);
  DMDati.T_Livelli.Post;
  FStat1.Visible := True;
  FStat1.txValTime.Text := formatdatetime('hh:nn:ss', ftempo);
  FStat1.txValBonus.Text := BestPoint[High(BestPoint)].Cuori.ToString;
  FStat1.txValPunti.Text := BestPoint[High(BestPoint)].Punteggio.ToString;
  FStat1.txValPerle.Text := BestPoint[High(BestPoint)].Perle.ToString;
  FStat1.txValMuri.Text := BestPoint[High(BestPoint)].Mura.ToString;
  FStat1.txValMalus.Text := BestPoint[High(BestPoint)].Malus.ToString;

end;

procedure TFMain.TimerTimer(Sender: TObject);
begin
  fTempo := ftempo + ((CS_MINUTO /60));
  txValTime.Text := formatdatetime('hh:nn:ss', ftempo);
end;

procedure TFMain.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  oVersoOld := oVerso;
  IF (Key = 38) and (overso in [daSXDX, daDXSX] ) then oVerso := daBAAL;  {SU}
  IF (Key = 40) and (overso in [daSXDX, daDXSX] ) then oVerso := daALBA;   {GIU}
  IF (Key = 37) and (overso in [daBAAL, daALBA] ) then oVerso := daDXSX;  {SX}
  IF (Key = 39) and (overso in [daBAAL, daALBA] ) then oVerso := daSXDX;  {DX}

  case key of
    37: begin
          if oVersoOld = daBAAL then oCodaDir := drBassoSX
          else if oVersoOld = daALBA then oCodaDir := drAltoSX;
        end;
    38: begin
          if oVersoOld = daSXDX then oCodaDir := drAltoSX
          else if oVersoOld = daDXSX then oCodaDir := drAltoDX;
        end;
    39: begin
          if oVersoOld = daBAAL then oCodaDir := drBassoDX
          else if oVersoOld = daALBA then oCodaDir := drAltoDX;
        end;
    40: begin
          if oVersoOld = daSXDX then oCodaDir := drBassoSX
          else if oVersoOld = daDXSX then oCodaDir := drBassoDX;
        end;
  end;
end;

procedure TFMain.FStat1Text5Click(Sender: TObject);
begin
  FStat1.Visible := False;
  if nLevel = 6 then
    nLevel := 1;
  LoadNextlvl(nLevel);
  tmMain.Enabled := True;
end;

procedure TFMain.tmMainTimer(Sender: TObject);
var MapValue: Integer;
  nOldX: Integer;
  nOldY: Integer;
  oTemp: oDirection;
  TY: Integer;
  TX: Integer;
  n: Integer;
begin

  nOldX := x;
  nOldY := y;

  if oVerso = daSXDX then
    x := x + 1
  else if oVerso = daDXSX then
    x := x - 1
  else if oVerso = daALBA then
    y := y + 1
  else if oVerso = daBAAL then
    y := y - 1;

  MapValue := oMappa[y, x];


  if MapValue = 2 then
  begin
    X := nOldX;
    Y := nOldY;
    nPunteggio := nPunteggio - 5;
    BestPoint[High(BestPoint)].Punteggio := BestPoint[High(BestPoint)].Punteggio - 5;
    nMuri := nMuri + 1;
    BestPoint[High(BestPoint)].Mura := BestPoint[High(BestPoint)].Mura + 1;
    oCodaDir := oCodaDirOld;
    if oVerso <> oVersoOld then
      oVerso := oVersoOld;
    exit;
  end
  else
  begin
    oMappa[Y][X] := 1;
    if MapValue = 1 then
    begin
      tmMain.Enabled := False;
      tmMain.Interval := 400;
      nCodaCreate := 4;
      nCodaLung := 1;
      X := oRecLevel.X;
      Y := oRecLevel.Y;
      nVite := nvite - 1;
      txValVite.Text := nVite.ToString;
      nCodaIndex := 1;
      if nVite = 0 then
      begin
        DMDati.T_HIGHSCORE.Edit;
        DMDati.T_HIGHSCOREPUNTI.AsInteger := nPunteggio;
        DMDati.T_HIGHSCORELIVELLO.AsInteger := Length(BestPoint);
        DMDati.T_HIGHSCORENOME.AsString := InputBox('Nome', 'Inserire il nominativo','');
        DMDati.T_HIGHSCORE.Post;
        ShowMessage('Game Over');
        exit;
      end;
      ClearCoda;
      oVerso := daSXDX;
      tmMain.Enabled := True;
      Exit;
    end
    else if MapValue = 9 then
    begin
      tmMain.Interval := tmMain.Interval - 1;
      nBonus := nBonus + 1;
      nCodaCreate := nCodaCreate + 2;
      nPunteggio := nPunteggio + 50;
      nBonusConta := nBonusConta + 1;
      BestPoint[High(BestPoint)].Punteggio := BestPoint[High(BestPoint)].Punteggio + 50;
      BestPoint[High(BestPoint)].Cuori := BestPoint[High(BestPoint)].Cuori + 1;
      if nBonus = oRecLevel.Bonus then
      begin
        tmMain.Enabled := False;
        Timer.Enabled := False;
        nBonus := 0;
        nLevel := nLevel + 1;
        ShowStat;
      end;
    end
    else if MapValue = 0 then
    begin
      nPunteggio := nPunteggio + 5;
      nPerle := nPerle + 1;
      BestPoint[High(BestPoint)].Punteggio := BestPoint[High(BestPoint)].Punteggio + 5;
      BestPoint[High(BestPoint)].Perle := BestPoint[High(BestPoint)].Perle + 1;
    end
    else if MapValue = -1 then
    begin
      nPunteggio := nPunteggio - 2;
      BestPoint[High(BestPoint)].Punteggio := BestPoint[High(BestPoint)].Punteggio - 2;
      nMalus := nMalus - 2;
      BestPoint[High(BestPoint)].Malus := BestPoint[High(BestPoint)].Malus - 2;
    end;
    oVersoOld := oVerso;
  end;

  case oCodaDir of
    drBassoDX: n := 15; {15}
    drBassoSX: n := 16; {16}
    drAltoDX:  n := 17; {17}
    drAltoSX:  n := 18; {18}
    drOriz:  n := 19; {19}
    drVert:  n := 20; {20}
  end;
  DrawSprite(rFondo, oSprite[n], oCoda[nCodaIndex][1], oCoda[nCodaIndex][2], TAlphaColorRec.Black, TAlphaColorRec.Seagreen,False);

  case oVerso of
    daSXDX, daDXSX: oCodaDir := drOriz ;
    daBAAL, daALBA: oCodaDir := drVert ;
  end;
  oCodaDirOld := oCodaDir;
  nCodaIndex := nCodaIndex + 1;
  IF nCodaIndex = 705 then
    nCodaIndex := 1;
  oCoda[nCodaIndex][0] := MapValue;
  oCoda[nCodaIndex][1] := Y;
  oCoda[nCodaIndex][2] := X;

  case oVerso of
    daSXDX: n := 23;
    daDXSX: n := 24;
    daBAAL: n := 21;
    daALBA: n := 22;
  end;
  DrawSprite(rFondo, oSprite[n], oCoda[nCodaIndex][1], oCoda[nCodaIndex][2], TAlphaColorRec.Black, TAlphaColorRec.Tomato,False);
//  DrawSprite(rtHead, oSprite[n], 0, 0, TAlphaColorRec.Tomato, TAlphaColorRec.Tomato, false);
//  rtHead.Position.x := oCoda[nCodaIndex][2] ;
//  rtHead.Position.y := oCoda[nCodaIndex][1] ;
  if not(nCodaCreate >= 0) then
  begin
    TY := oCoda[nCodaLung][1];
    TX := oCoda[nCodaLung][2];
    DrawSprite(rFondo, oSprite[4], ty, tx, TAlphaColorRec.Black, 0);
    oMappa[TY][TX] := -1;
    nCodaLung := nCodaLung + 1;
    IF nCodaLung >= 705 then nCodaLung := 1;
  end
  else
    nCodaCreate := nCodaCreate - 1;
  if (x > 0) and (y > 0) then
  begin
    txValPunti.Text := nPunteggio.ToString;
    txValBonus.Text := nBonusConta.ToString;
    txValPerle.Text := nPerle.ToString;
    txValMuri.Text  := nMuri.ToString;
    txValMalus.Text := nMalus.ToString;
  end;
end;

procedure TFMain.txFameClick(Sender: TObject);
begin
//
  DMDati.Q_HallFame.Open;
  FHallFame1.Visible := true;
end;

end.
