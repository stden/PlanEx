unit ShowExperim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls, RXCtrls;

type
  TFormShowExperim = class(TForm)
    StringGrid1: TStringGrid;
    Bevel1: TBevel;
    RxLabel1: TRxLabel;
    SecretPanel1: TSecretPanel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormShowExperim: TFormShowExperim;

implementation

{$R *.DFM}

uses MyType, Common1, MySystProc;

procedure Kino;
begin
  with FormShowExperim.SecretPanel1 do
    begin
      if not ShowedExp then
        begin
          Lines[3] := 'Количество факторов:  ' + IntToStr(ElProt.Variant.KolFakt);
          Lines[5] := 'Тип эксперимента:  ' + TypeExpToStr(ElProt.Plan.TypePlan);
          Lines[7] := 'Степень дробности:  ' + IntToStr(ElProt.Plan.StDrobn);
          Lines[9] := 'Количество точек спектра:  ' + IntToStr(ElProt.Plan.N);
          Lines[11] := 'Число параллельных опытов:  ' + IntToStr(ElProt.Plan.M);
          ShowedExp := true;
        end;
      Active := true;
    end;
end;

procedure TFormShowExperim.FormActivate(Sender: TObject);
var I, J: byte;
begin
  Kino;
  with StringGrid1 do
    begin
      ColCount := ElProt.Plan.M + 1;
      RowCount := ElProt.Plan.N + 1;
      if RowCount < 15 then
        begin
          Width := 310 - (5 - ColCount) * (DefaultColWidth + 1);
          Height := 274 - (15 - RowCount) * (DefaultRowHeight + 1);
          Left := 53 + (5 - ColCount) * (DefaultColWidth + 1) div 2;
          Top := 59 + (15 - RowCount) * (DefaultRowHeight + 1) div 2;
        end
      else
        begin
          Width := 326 - (5 - ColCount) * (DefaultColWidth + 1);
          Height := 274;
          Left := 45 + (5 - ColCount) * (DefaultColWidth + 1) div 2;
          Top := 59;
        end;
      Cells[0, 0] := '    Точки';
      for I := 1 to ElProt.Plan.N do
        Cells[0, I] := '        ' + IntToStr(I);
      for I := 1 to ElProt.Plan.M do
        Cells[I, 0] := '   Опыт ' + IntToStr(I);
      for I := 1 to ElProt.Plan.N do
        for J := 1 to ElProt.Plan.M do
          Cells[J, I] := RealToStr(ElProt.Experim[I, J], 5, 3);
    end;
end;

end.
