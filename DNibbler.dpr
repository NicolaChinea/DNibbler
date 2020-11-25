program DNibbler;

uses
  System.StartUpCopy,
  FMX.Forms,
  u.main in 'u.main.pas' {FMain},
  u.Constant.Loc in 'u.Constant.Loc.pas',
  u.Statistiche in 'u.Statistiche.pas' {FStat: TFrame},
  d.dati in 'd.dati.pas' {DMDati: TDataModule},
  u.HallFame in 'u.HallFame.pas' {FHallFame: TFrame},
  u.graph in 'lib\u.graph.pas',
  u.typeinfo in 'lib\u.typeinfo.pas',
  u.utility in 'lib\u.utility.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TDMDati, DMDati);
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
