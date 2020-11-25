unit u.Statistiche;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts;

type
  TFStat = class(TFrame)
    lyMain: TLayout;
    rBoard: TRectangle;
    txBonus: TText;
    txMuri: TText;
    txPerle: TText;
    txPunti: TText;
    txValBonus: TText;
    txValPerle: TText;
    txValMuri: TText;
    txValPunti: TText;
    Text1: TText;
    txValMalus: TText;
    Text3: TText;
    txValTime: TText;
    Rectangle1: TRectangle;
    Text5: TText;
    Text2: TText;
    Rectangle2: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
