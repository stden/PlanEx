unit VarDan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, MyType, MySystProc, StdCtrls, ExtCtrls, VarType, RXCtrls, Grids;

type
  TFormDanVar = class(TForm)
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    PopUp1_1: TMenuItem;
    PopUp1_2: TMenuItem;
    Shape1: TShape;
    Image1: TImage;
    Shape6: TShape;
    Bevel1: TBevel;
    Label1: TLabel;
    Memo1: TMemo;
    RxLabel1: TRxLabel;
    Bevel2: TBevel;
    StringGrid1: TStringGrid;
    Bevel3: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure PopUp1_2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDanVar: TFormDanVar;

function StrBazFunc(Variant: myTVariant): string;

implementation

{$R *.DFM}

procedure TFormDanVar.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormDanVar.PopUp1_2Click(Sender: TObject);
begin
  Close;
end;

function BazFuncToNumCell(BF: myTBazFunc): byte;
var I: byte;
begin
  I := 1;
  while ArrBF[ElProt.Variant.KolFakt, I] <> Ord(BF) do
    Inc(I);
  BazFuncToNumCell := I;
end;

function NumCellToBazFunc(NumCell: byte): myTBazFunc;
begin
  NumCellToBazFunc := myTBazFunc(ArrBF[ElProt.Variant.KolFakt, NumCell]);
end;

function BazFuncToStr(BF: myTBazFunc): string;
var I: byte;
    S: string[5];
begin
  S := '';
  if BF = F0 then
    S := '0'
  else
    if BF in [F1..F12345] then
      for I := 0 to ElProt.Variant.KolFakt - 1 do
        if EdRazr(Ord(BF), I) then
          S := S + IntToStr(I + 1)
        else
     else
       S := IntToStr(Ord(BF) - 31) + IntToStr(Ord(BF) - 31);
  BazFuncToStr := S;
end;

function StrBazFunc(Variant: myTVariant): string;
var I: byte;
    S: string;
begin
  S := '0';
  for I := 2 to Step2(Variant.KolFakt) + Variant.KolFakt do
    if (NumCellToBazFunc(I) in Variant.Model) or
       (I <= Variant.KolFakt + 1) then
      S := S + ', ' + BazFuncToStr(NumCellToBazFunc(I));
  StrBazFunc := S;
end;

procedure TFormDanVar.FormActivate(Sender: TObject);
var I, J: byte;

  procedure PrepearMemo1;
  var I: byte;
  begin
    Memo1.Lines.Strings[1] := 'Количество факторов объекта n = ' +
                              IntToStr(ElProt.Variant.KolFakt) + '.';
    for I := 7 to Memo1.Lines.Count - 5 do
      Memo1.Lines.Delete(I);
    Memo1.Lines.Strings[7] := StrBazFunc(ElProt.Variant);
  end;

begin
  ElProt.WorkItems := ElProt.WorkItems + [I21];
  RxLabel1.Caption := 'Вариант  ' + IntToStr(ElProt.Zadanie.NomVar);
  PrepearMemo1;
  StringGrid1.RowCount := ElProt.Variant.KolFakt + 1;
  StringGrid1.Cells[0, 0] := '  Фактор';
  for I := 1 to ElProt.Variant.KolFakt do
    StringGrid1.Cells[0, I] := '       X' + IntToStr(I);
  StringGrid1.Cells[1, 0] := '     Xmin';
  StringGrid1.Cells[2, 0] := '     Xmax';
  for I := 1 to ElProt.Variant.KolFakt do
    for J := 1 to 2 do
      StringGrid1.Cells[J, I] := '   ' +
                 RealToStr(ElProt.Variant.OblPlan[I, J], 9, 2);
  StringGrid1.Height := (StringGrid1.DefaultRowHeight + 1) *
                        (ElProt.Variant.KolFakt + 1) - 1;  
  Bevel3.Height := StringGrid1.Height + 3;
end;

procedure TFormDanVar.StringGrid1SelectCell(Sender: TObject; Col,
  Row: Integer; var CanSelect: Boolean);
begin
  CanSelect := false;
end;

procedure TFormDanVar.StringGrid1DrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
begin
  with StringGrid1.Canvas do
    begin
      if (Col in [1, 2]) and (Row > 0) then
        begin
          StringGrid1.DefaultDrawing := false;
          Brush.Color := clAqua;
          FillRect(Rect);
          Font.Color := clBlue;
          TextOut(Rect.Left, Rect.Top + 2, StringGrid1.Cells[Col, Row]);
          StringGrid1.DefaultDrawing := true;
        end;
    end;
end;

end.
