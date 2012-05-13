unit Experim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, Buttons, Mask, ToolEdit, CurrEdit, RXCtrls,
  ComCtrls, Gauges;

type
  TFormExperim = class(TForm)
    Panel5: TPanel;
    Panel11: TPanel;
    Label7: TLabel;
    Bevel3: TBevel;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    StringGrid3: TStringGrid;
    Panel7: TPanel;
    Panel12: TPanel;
    Label8: TLabel;
    Bevel4: TBevel;
    StringGrid2: TStringGrid;
    Panel3: TPanel;
    Button1: TButton;
    Panel4: TPanel;
    Shape2: TShape;
    Panel6: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Bevel2: TBevel;
    Timer1: TTimer;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Bevel5: TBevel;
    Edit1: TRxCalcEdit;
    Edit2: TRxCalcEdit;
    Edit3: TRxCalcEdit;
    Edit4: TRxCalcEdit;
    Edit5: TRxCalcEdit;
    Bevel7: TBevel;
    RxLabel1: TRxLabel;
    Panel8: TPanel;
    Label19: TRxLabel;
    Label2: TLabel;
    Panel9: TPanel;
    RxLabel2: TRxLabel;
    Gauge1: TGauge;
    Bevel6: TBevel;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
    procedure StringGrid2DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormExperim: TFormExperim;

implementation

{$R *.DFM}

uses Common1, MySystProc, MyType, VarType, Main;

var Beg: TAVSp;
    LenV, Row, Col: word;
    CountTrue, NomOp: byte;

procedure MakeStrGr1;
var I, J: byte;
begin
  with FormExperim.StringGrid1 do
    begin
      ColWidths[0] := 48;
      Left := 7 + (DefaultColWidth + 1) * (5 - ElProt.Variant.KolFakt) div 2;
      ColCount := ElProt.Variant.KolFakt + 1;
      Width := 278 - (DefaultColWidth + 1) * (5 - ElProt.Variant.KolFakt);
      Cells[0, 0] := 'Фактор';
      Cells[0, 1] := '   Xmin';
      Cells[0, 2] := '   Xmax';
      Cells[0, 3] := '  Центр';
      Cells[0, 4] := 'Инт.вар.';
      for I := 1 to ElProt.Variant.KolFakt do
        begin
          Cells[I, 0] := '     ' + IntToStr(I);
          for J := 1 to 2 do
            begin
              Cells[I, J] := RealToStr(ElProt.Variant.OblPlan[I, J], 9, 1);
              Cells[I, 2 + J] := RealToStr(ElProt.Plan.Norm[I, J], 9, 1);
            end;
        end;
      Col := 1;
      Row := 3;
    end;
end;

procedure DrawStrGr2;
const
  DCol0 = 13;
  SGHeight = 238;
var I, J: byte;
begin
  with FormExperim.StringGrid2 do
    begin
      ColCount := ElProt.Variant.KolFakt + 1;
      RowCount := ElProt.Plan.N + 1;
      ColWidths[0] := DefaultColWidth + DCol0;
      Width := (DefaultColWidth + 1) * ColCount + DCol0 + 4;
      Height := (DefaultRowHeight + 1) * RowCount + 4;
      if Height > SGHeight then
        begin
          Height := SGHeight;
          Width := Width + 16;
        end;
      Left := (FormExperim.Panel12.Width - Width) div 2;
      Top := (FormExperim.Panel12.Height - Height) div 2 + 10;
      Cells[0, 0] := 'Точки';
      for I := 1 to ElProt.Variant.KolFakt do
        Cells[I, 0] := ' X' + IntToStr(I);
      for I := 1 to ElProt.Plan.N do
        Cells[0, I] := '    ' + IntToStr(I);
      for I := 1 to ElProt.Variant.KolFakt do
        for J := 1 to ElProt.Plan.N do
          Cells[I, J] := SPToStr(I, J);
    end;
end;

procedure MakeStrGr3;
var I, J: byte;
begin
  with FormExperim.StringGrid3 do
    begin
      ColCount := ElProt.Plan.M + 1;
      RowCount := ElProt.Plan.N + 1;
      Cells[0, 0] := ' Точки';
      for I := 1 to ColCount do
        Cells[I, 0] := '  Опыт ' + IntToStr(I);
      for I := 1 to RowCount do
        Cells[0, I] := '     ' + IntToStr(I);
      for J := 1 to ElProt.Plan.N do
        for I := 1 to ElProt.Plan.M do
          Cells[I, J] := RealToStr(0, 9, 3);
      ColWidths[0] := 40;
      Left := 7 + (DefaultColWidth + 1) * (4 - ElProt.Plan.M) div 2;
      Width := 278 - (DefaultColWidth + 1) * (4 - ElProt.Plan.M);
    end;
end;

procedure DrawOI;
const Delta = 24;
      Delta1 = 9;
begin
  with FormExperim do
    begin
      Edit1.Top := (Panel6.Height - Delta * (ElProt.Variant.KolFakt - 1) -
                    Edit1.Height) div 2;
      Label3.Top := Edit1.Top;
      Label4.Top := Edit1.Top + Delta1;
      Edit2.Top := Edit1.Top + Delta;
      Label5.Top := Edit2.Top;
      Label6.Top := Edit2.Top + Delta1;
      Edit3.Top := Edit2.Top + Delta;
      Label9.Top := Edit3.Top;
      Label10.Top := Edit3.Top + Delta1;
      Edit4.Top := Edit3.Top + Delta;
      Label11.Top := Edit4.Top;
      Label12.Top := Edit4.Top + Delta1;
      Edit5.Top := Edit4.Top + Delta;
      Label13.Top := Edit5.Top;
      Label14.Top := Edit5.Top + Delta1;
      Edit2.Visible := ElProt.Variant.KolFakt >= 2;
      Label5.Visible := Edit2.Visible;
      Label6.Visible := Edit2.Visible;
      Edit3.Visible := ElProt.Variant.KolFakt >= 3;
      Label9.Visible := Edit3.Visible;
      Label10.Visible := Edit3.Visible;
      Edit4.Visible := ElProt.Variant.KolFakt >= 4;
      Label11.Visible := Edit4.Visible;
      Label12.Visible := Edit4.Visible;
      Edit5.Visible := ElProt.Variant.KolFakt >= 5;
      Label13.Visible := Edit5.Visible;
      Label14.Visible := Edit5.Visible;
    end;
end;

procedure TFormExperim.FormActivate(Sender: TObject);
begin
  MakeStrGr1;
  DrawStrGr2;
  MakeStrGr3;
  DrawOI;
end;

procedure FireShape(var Panel: TPanel;
                    var Shape: TShape;
                    Color: TColor;
                    T, D: word;
                    U: real);
var BRect: TRect;
    BColor: TColor;
    R: real;

begin
  BRect := Shape.BoundsRect;
  BColor := Shape.Brush.Color;
  if D < 2 then
    D := 2;
  R := T;
  Shape.Brush.Color := Color;
  Shape.Show;
  while (Shape.BoundsRect.Left > 2) or
        (Shape.BoundsRect.Top > 2) or
        (Shape.BoundsRect.Right < Panel.Width - 2) or
        (Shape.BoundsRect.Bottom < Panel.Height - 2) do
    begin
      Shape.Setbounds(Shape.Left - D div 2, Shape.Top - D div 2,
                      Shape.Width + D, Shape.Height + D);
      if Shape.BoundsRect.Left < 2 then
        Shape.Left := 2;
      if Shape.BoundsRect.Top < 2 then
        Shape.Top := 2;
      if Shape.BoundsRect.Right > Panel.Width - 2 then
        Shape.Width := Panel.Width - 3;
      if Shape.BoundsRect.Bottom > Panel.Height - 2 then
        Shape.Height := Panel.Height - 3;
      Shape.Refresh;
      R := R * U;
      T := Round(R);
      if T < 1 then
        T := 1;
      Sleep(T);
    end;
  Shape.Brush.Color := BColor;
  Shape.BoundsRect := BRect;
  Shape.Hide;
end;

function NormToNatur(Norm: shortint;
                     X: byte): real;
begin
  NormToNatur := 0;
  case Norm of
    -1, 1: NormToNatur := ElProt.Plan.Norm[X, 1] + Norm *
                           ElProt.Plan.Norm[X, 2];
        0: NormToNatur := ElProt.Plan.Norm[X, 1];
    -2, 2: if Norm > 0 then
             NormToNatur := ElProt.Plan.Norm[X, 1] +
                            ElProt.Plan.Alfa * ElProt.Plan.Norm[X, 2]
           else
             NormToNatur := ElProt.Plan.Norm[X, 1] -
                            ElProt.Plan.Alfa * ElProt.Plan.Norm[X, 2];
  end;
end;

function CheckFaktOk(G: byte): boolean;
var X: byte;
    Ok: boolean;
begin
  Ok := true;
  for X := 1 to ElProt.Variant.KolFakt do
    begin
      case X of
        1: Ok := Ok and CheckReal(NormToNatur(ElProt.Plan.SPlan[X, G], X),
                                  FormExperim.Edit1.Value, 0.1);
        2: Ok := Ok and CheckReal(NormToNatur(ElProt.Plan.SPlan[X, G], X),
                                  FormExperim.Edit2.Value, 0.1);
        3: Ok := Ok and CheckReal(NormToNatur(ElProt.Plan.SPlan[X, G], X),
                                  FormExperim.Edit3.Value, 0.1);
        4: Ok := Ok and CheckReal(NormToNatur(ElProt.Plan.SPlan[X, G], X),
                                  FormExperim.Edit4.Value, 0.1);
        5: Ok := Ok and CheckReal(NormToNatur(ElProt.Plan.SPlan[X, G], X),
                                  FormExperim.Edit5.Value, 0.1);
      end;
    end;
  if Ok then
    Inc(CountTrue)
  else
    if CountTrue > 0 then
      Dec(CountTrue);
  CheckFaktOk := Ok;
end;

{ ---=== Denis.Begin ===--- }
{ ---=== Генератор случайных чисел ===--- }
 Type
   TGaussRandom = Object
    { M-Математическое ожидание D - Дисперсия }
     _M_,_D_,MaxGauss : Real;
    { - Инициализация генератора - }
     Constructor Init( _M,_D : Real );
    { - Кривая гаусса в этой точке - }
     Function Gauss( X,M,D : Real ):Real;
    { - Генерируем число - }
     Function RND( X : Real ):Real;
   End;

{ ---=== Инициализация генератора ===--- }
 Constructor TGaussRandom.Init( _M,_D:Real );
   Begin
     Randomize;
     _M_ := _M;
     _D_ := _D;
     MaxGauss := Gauss(_M_,_M_,_D_);
   End;

{ ---=== Кривая гаусса в этой точке ==--- }
{ M-Математическое ожидание D - Дисперсия }
 Function TGaussRandom.Gauss( X,M,D:Real ):Real;
   Begin
     Gauss:=1/(D*Sqrt(2*Pi))*Exp(-Sqr(X-M)/(2*Sqr(D)));
   End;

{ ---=== Генерируем число ==--- }
 Function TGaussRandom.RND( X:Real ):Real;
   Var R1,R2:Real;
   Begin
      Repeat
        R1:=(Random(50000)/25000)*X-X;
        R2:=(Random(50000)/50000)*MaxGauss;
      Until R2 < Gauss(R1+_M_,_M_,_D_);
      RND:=R1;
   End;
{ ---=== Denis.End ===--- }

function Otklik(G: byte): real;
var BF: myTBazFunc;
    R: real;

  function FaktValue(X, G: byte): real;
  begin
    case ElProt.Plan.SPlan[X, G] of
      -2: FaktValue := - ElProt.Plan.Alfa;
       2: FaktValue :=   ElProt.Plan.Alfa;
      else
        FaktValue := ElProt.Plan.SPlan[X, G];
    end;
  end;

  function BFValue(BF: myTBazFunc;
                   G: byte): real;
  var I: byte;
      R: real;
  begin
    R := 1;
    if BF in [F0..F12345] then
      for I := 1 to ElProt.Variant.KolFakt do
        if EdRazr(Ord(BF), I - 1) then
          R := R * FaktValue(I, G)
        else
    else
      R := Sqr(FaktValue(Ord(BF) - Ord(F12345), G));
    BFValue := R;
  end;

{ ---=== Denis.Begin ===--- }

{ Распределение Гаусса }

Var GaussRandom : TGaussRandom;
begin
 { !!! Внимание. Параметры помех в отклике находятся здесь !!! } 
  GaussRandom.Init( 0 {Математическое ожидание} ,5 {Дисперсия});
 { !!! Внимание. Параметры помех в отклике находятся здесь !!! } 
  R := GaussRandom.RND(10);
  for BF := F0 to F55 do
    R := R + BFValue(BF, G) * ElProt.Variant.Obj[BF];
  Otklik := R;
end;
{ ---=== Denis.End ===--- }

procedure EndExp;
begin
  if Beg = nil then
    begin
      FormExperim.Label2.Hide;
      FormExperim.Panel9.Hide;
      FormExperim.Label18.Hide;
      FormExperim.Label17.Hide;
      FormExperim.RxLabel2.Show;
      FormExperim.Button1.Enabled := false;
      FormExperim.Gauge1.Hide;
      FormExperim.Bevel6.Hide;
      MyMessageDlg('Примите поздравления!', 'Эксперимент закончен.' +
                   ' Можете приступить к обработке результатов.',
                   mtInformation, [mbOk]);
      ElProt.WorkItems := ElProt.WorkItems + [I3];
      ElProt.MItemsEn := ElProt.MItemsEn + [I4, I64];
      UpdateMenuAndButtons;
    end;
end;

procedure TFormExperim.Button1Click(Sender: TObject);
const Porog = 2;

  procedure DrawOp;
  begin
    Label18.Caption := 'Проводится опыт в точке';
    Label17.Hide;
    Label2.Show;
    RxLabel1.Caption := RealToStr(Otklik(Row + 1), 5, 3);
    FireShape(Panel4, Shape2, clLime, 150, 4, 0.8);
    Panel9.Caption := RxLabel1.Caption;
    Panel9.Show;
    Panel3.Refresh;
    while RxLabel1.Top < Panel1.Top + 2 do
      begin
        RxLabel1.Top := RxLabel1.Top + 1;
        RxLabel1.Refresh;
        Sleep(15);
      end;
    RxLabel1.Top := 225;
    StringGrid3.Row := Row + 1;
    StringGrid3.Col := Col + 1;
    StringGrid3.Cells[Col + 1, Row + 1] := RxLabel1.Caption;
    ElProt.Experim[Row + 1, Col + 1] := StrToReal(RxLabel1.Caption);
    StringGrid3.Refresh;
    Label16.Caption := '';
    Label16.Refresh;
    Panel9.Caption := '';
    Inc(NomOp);
    Gauge1.Progress := NomOp;
    Panel3.Refresh;
    EndExp;
  end;

  procedure DrawPodgOp;
  begin
    RandomRC(Beg, Row, Col, LenV);
    Label19.Caption := ' ' + IntToStr(Row + 1) + ' ';
    StringGrid2.Row := Row + 1;
    StringGrid2.Refresh;
    while Label19.Left <= Panel8.Width do
      begin
        Label19.Left := Label19.Left + 2;
        Label19.Refresh;
        Sleep(10);
      end;
    Label16.Caption := IntToStr(Row + 1);
    Label19.Left := 9;
    Label19.Refresh;
  end;

  procedure WriteFakt;
  begin
    Edit1.Value := NormToNatur(ElProt.Plan.SPlan[1, Row + 1], 1);
    Edit2.Value := NormToNatur(ElProt.Plan.SPlan[2, Row + 1], 2);
    Edit3.Value := NormToNatur(ElProt.Plan.SPlan[3, Row + 1], 3);
    Edit4.Value := NormToNatur(ElProt.Plan.SPlan[4, Row + 1], 4);
    Edit5.Value := NormToNatur(ElProt.Plan.SPlan[5, Row + 1], 5);
  end;

begin
  if not CheckFaktOk(Row + 1) then
    begin
      FireShape(Panel4, Shape2, clRed, 150, 4, 0.8);
      Panel3.Refresh;
      MyMessageDlg('Ошибка', 'Значения факторов указаны неверно.',
                    mtError, [mbOk]);
      Exit;
    end;
  Button1.Enabled := false;
  DrawOp;
  if CountTrue < Porog then
    begin
      Label2.Hide;
      Panel9.Hide;
      Label18.Caption := 'Проведите опыт в точке';
      Label17.Show;
      DrawPodgOp;
      Button1.Enabled := true;
    end
  else
    begin
      MyMessageDlg('Проведение эксперимента', 'Вы справились с контрольными ' +
                   'опытами и эксперимент будет закончен автоматически.',
                   mtInformation, [mbOk]);
      Gauge1.MaxValue := ElProt.Plan.N * ElProt.Plan.M;
      Gauge1.Progress := NomOp;
      Bevel6.Show;
      Gauge1.Show;
      Bevel7.Refresh;
      Button1.Enabled := false;
      while Beg <> nil do
        begin
          DrawPodgOp;
          WriteFakt;
          Panel3.Refresh;
          DrawOp;
        end;
    end;
end;

procedure TFormExperim.FormShow(Sender: TObject);
begin
  ElProt.WorkItems := ElProt.WorkItems - [I3..I44];
  ElProt.MItemsEn := ElProt.MItemsEn - [I4..I44, I64, I65];
  ElProt.MItemsEn := ElProt.MItemsEn + [I12];
{Инициализация эксперимента и результатов}
  NomOp := 0;
  IniExperim(ElProt.Experim);
  UpdateMenuAndButtons;
  Bevel6.Hide;
  Gauge1.Hide;
  RxLabel2.Hide;
  Panel4.Caption := '';
  Label2.Hide;
  Panel9.Caption := '';
  Panel9.Hide;
  Label19.ControlStyle := Label19.ControlStyle + [csNoDesignVisible, csOpaque];
  Randomize;
  StringGrid3.ColCount := ElProt.Plan.M + 1;
  StringGrid3.RowCount := ElProt.Plan.N + 1;
  LenV := StringGrid3.RowCount - 1;
  MakeArr(Beg, StringGrid3.RowCount - 1, StringGrid3.ColCount -1);
  RandomRC(Beg, Row, Col, LenV);
  StringGrid2.Row := Row + 1;
  Label19.Caption := ' ' + IntToStr(Row + 1);
  Label16.Caption := IntToStr(Row + 1);
  Label18.Top := 171;
  Label16.Top := 184;
  Label17.Top := 226;
  Panel4.Refresh;
  Timer1.Enabled := true;
end;

procedure TFormExperim.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  Button1.Enabled := true;
  Label18.Caption := 'Проведите опыт в точке';
  Label18.Show;
  Label17.Show;
  CountTrue := 0;
  while (Label18.Top > 14) or
        (Label19.Left < Panel8.Width) do
    begin
      if Label18.Top > 14 then
        begin
          Label18.Top := Label18.Top - 1;
          Label16.Top := Label16.Top - 1;
          Label17.Top := Label17.Top - 1;
          Panel4.Refresh;
        end;
      if Label19.Left < Panel3.Left + 5 then
        begin
          Label19.Left := Label19.Left + 1;
          Label19.Refresh;
        end;
      Sleep(5);
    end;
  Label19.Left := 9;
end;

procedure TFormExperim.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DelArr(Beg);
end;

procedure TFormExperim.StringGrid1DrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
begin
  with StringGrid1.Canvas do
    begin
      if (Row in [1, 2]) and (Col > 0) then
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

procedure TFormExperim.StringGrid1SelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
begin
  CanSelect := false;
end;

procedure TFormExperim.StringGrid2DrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
begin
  with StringGrid2.Canvas do
    begin
      if (Row > 0) and (Col > 0) then
        begin
          StringGrid2.DefaultDrawing := false;
          Font.Name := 'Symbol';
          Font.Size := 10;
          TextOut(Rect.Left, Rect.Top, StringGrid2.Cells[Col, Row]);
          StringGrid2.DefaultDrawing := true;
        end;
    end;
end;

end.
