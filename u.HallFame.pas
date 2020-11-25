unit u.HallFame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, System.Rtti, FMX.Grid.Style, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.Components, FMX.ListView, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid;

type
  TFHallFame = class(TFrame)
    lyMain: TLayout;
    rFondo: TRectangle;
    Grid1: TGrid;
    Text4: TText;
    Grid2: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    Text1: TText;
    Rectangle1: TRectangle;
    procedure Text4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses d.dati;

procedure TFHallFame.Text4Click(Sender: TObject);
begin
  Self.Visible := False;
end;

end.
