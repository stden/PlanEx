unit Obrabotka;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Tabnotbk, RxCalc, Grids, RXCtrls, StdCtrls, Mask,
  ToolEdit, CurrEdit;

type
  TFormObrabotka = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    StringGrid1: TStringGrid;
    Bevel5: TBevel;
    Panel1: TPanel;
    Bevel6: TBevel;
    RxCalcEdit1: TRxCalcEdit;
    Button1: TButton;
    Label1: TLabel;
    RxLabel1: TRxLabel;
    Label2: TLabel;
    RxLabel2: TRxLabel;
    Panel2: TPanel;
    Bevel7: TBevel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Panel3: TPanel;
    Bevel8: TBevel;
    Label6: TLabel;
    Button2: TButton;
    RxCalcEdit2: TRxCalcEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ComboBox2: TComboBox;
    Label9: TLabel;
    Label12: TLabel;
    Panel4: TPanel;
    Bevel9: TBevel;
    StringGrid2: TStringGrid;
    Label13: TLabel;
    Label14: TLabel;
    Bevel10: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Panel5: TPanel;
    Bevel11: TBevel;
    Label18: TLabel;
    Button3: TButton;
    Button4: TButton;
    Label19: TLabel;
    RxLabel3: TRxLabel;
    RxLabel4: TRxLabel;
    Panel6: TPanel;
    Bevel12: TBevel;
    Label20: TLabel;
    Button5: TButton;
    RxCalcEdit3: TRxCalcEdit;
    Label21: TLabel;
    Label22: TLabel;
    procedure PageControl1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure StringGrid2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormObrabotka: TFormObrabotka;

implementation

{$R *.DFM}

uses MyType, MySystProc, Common1;

var Porog, NumOk: byte;
    TKohr: myTTablKohr;
    TStud: myTTablStud;
    TFish: myTTablFish;

procedure ShowRezExp;
var I, M: byte;

  procedure ShowParOp;
  var I, J: byte;
  begin
    with FormObrabotka.StringGrid1 do
      begin
        for I := 1 to M do
          Cells[I, 0] := '  Опыт ' + IntToStr(I);
        for I := 1 to ElProt.Plan.N do
          for J := 1 to M do
            Cells[J, I] := RealToStr(ElProt.Experim[I, J], 5, 3);
      end;
  end;

  procedure ShowSrAndDisp;
  var I, J: byte;
  begin
    with FormObrabotka.StringGrid1 do
      begin
        Cells[M + 1, 0] := ' Среднее';
        Cells[M + 2, 0] := 'Дисперсия';
        for I := 1 to ElProt.Plan.N do
          for J := 5 to 6 do
            Cells[J - 4 + M, I] := RealToStr(ElProt.Experim[I, J], 5, 3);
      end;
  end;

begin
  if I412 in ElProt.WorkItems then
    M := 0
  else
    M := ElProt.Plan.M;
  with FormObrabotka.StringGrid1 do
    begin
      ColCount := M + 3;
      RowCount := ElProt.Plan.N + 1;
      ColWidths[0] := 42;
      ColWidths[ColCount - 1] := 63;
      if I412 in ElProt.WorkItems then
        if RowCount < 21 then
          begin
            Width := 166;
            Height := 382 - (21 - RowCount) * (DefaultRowHeight + 1);
            Left := 20;
            Top := 13 + (21 - RowCount) * (DefaultRowHeight + 1) div 2;
            FormObrabotka.Bevel5.Left := 203;
          end
        else
          begin
            Width := 182;
            Height := 382;
            Left := 12;
            Top := 13;
            FormObrabotka.Bevel5.Left := 203;
          end
      else
        if RowCount < 21 then
          begin
            Width := 382 - (7 - ColCount) * (DefaultColWidth + 1);
            Height := 382 - (21 - RowCount) * (DefaultRowHeight + 1);
            Left := 13 + (7 - ColCount) * (DefaultColWidth + 1) div 2;
            Top := 13 + (21 - RowCount) * (DefaultRowHeight + 1) div 2;
            FormObrabotka.Bevel5.Left := 405;
          end
        else
          begin
            Width := 398 - (7 - ColCount) * (DefaultColWidth + 1);
            Height := 382;
            Left := 6 + (7 - ColCount) * (DefaultColWidth + 1) div 2;
            Top := 13;
            FormObrabotka.Bevel5.Left := 405;
          end;
      Cells[0, 0] := ' Точки';
      for I := 1 to ElProt.Plan.N do
        Cells[0, I] := '     ' + IntToStr(I);
    end;
    ShowParOp;
    ShowSrAndDisp;
end;

procedure SrednAndDisp;
begin
  Porog := 1;
  NumOk := 0;
  with FormObrabotka do
    begin
      if I412 in ElProt.WorkItems then
        begin
          Panel1.Hide;
          Exit;
        end
      else
        Panel1.Show;
      Label1.Visible := not (I411 in ElProt.WorkItems);
      Label2.Visible := (I411 in ElProt.WorkItems) and
                        (not (I412 in ElProt.WorkItems));
      Randomize;
      StringGrid1.Row := Random(ElProt.Plan.N - 1) + 1;
      if not (I411 in ElProt.WorkItems) then
        StringGrid1.Col := ElProt.Plan.M + 1
      else
        StringGrid1.Col := ElProt.Plan.M + 2;
      RxLabel1.Caption := IntToStr(StringGrid1.Row);
      RxCalcEdit1.Value := 0;
      RxCalcEdit1.SetFocus;
    end;
end;

function SDisp: real;
var I: byte;
    R: real;
begin
  R := 0;
  for I := 1 to ElProt.Plan.N do
    R := R + ElProt.Experim[I, 6];
  SDisp := R;
end;

function NablZnKohr: real;
var I: byte;
    Max: real;
begin
  Max := 0;
  for I := 1 to ElProt.Plan.N do
    if ElProt.Experim[I, 6] > Max then
      Max := ElProt.Experim[I, 6];
  if Max = 0 then
    NablZnKohr := 0
  else
    NablZnKohr := Max / SDisp;
end;

procedure DrawTabl(UrZn: integer);
const S = 'Таблица критических значений критерия Кохрена для уровня значимости';
var I, J: byte;
    F: myTFileKohr;
    S1: string[20];
begin
  if UrZn = 0 then
    FormObrabotka.Label13.Caption := S + ' 0.01'
  else
    FormObrabotka.Label13.Caption := S + ' 0.05';
  AssignFile(F, 'TKohren.stt');
  Reset(F);
  Seek(F, UrZn);
  Read(F, TKohr);
  CloseFile(F);
  with FormObrabotka.StringGrid2 do
    begin
      for I := 1 to 6 do
        Cells[I, 0] := '      n = ' + IntToStr(Round(TKohr[I, 0]));
      for I := 1 to 15 do
        Cells[0, I] := '     m = ' + IntToStr(Round(TKohr[0, I]));
      for I := 1 to 6 do
        for J := 1 to 15 do
          begin
            Str(TKohr[I, J]: 9: 4, S1);
            Cells[I, J] := S1;
          end;
    end;
end;

function Nu0: byte;
begin
  Nu0 := ElProt.Plan.M - 1;
end;

function Mu0: byte;
begin
  Mu0 := ElProt.Plan.N;
end;

function Nu(Col, Max: integer;
            Krit: char): byte;
begin
  if Col < 1 then
    Col := 1;
  if Col > Max then
    Col := Max;
  Nu := 0;
  case Krit of
    'K': Nu := Round(TKohr[Col, 0]);
    'S': Nu := Round(TStud[Col, 0]);
    'F': Nu := Round(TFish[Col, 0]);
  end;
end;

function Mu(Row, Max: integer;
            Krit: char): byte;
begin
  if Row < 1 then
    Row := 1;
  if Row > Max then
    Row := Max;
  Mu := 0;
  case Krit of
    'K': Mu := Round(TKohr[0, Row]);
    'S': Mu := Round(TStud[0, Row]);
    'F': Mu := Round(TFish[0, Row]);
  end;
end;

function G(Col, Row: byte): real;
begin
  G := StrToReal(FormObrabotka.StringGrid2.Cells[Col, Row]);
end;

function Gradient(P1, P2: TPoint): byte;
var X, Y: integer;
begin
  Gradient := 0;
  X := P2.X - P1.X;
  Y := P2.Y - P1.Y;
  if (X = 0) and (Y = 0) then
    Gradient := 0;
  if (X > 0) and (Y = 0) then
    Gradient := 1;
  if (X < 0) and (Y = 0) then
    Gradient := 2;
  if (X = 0) and (Y < 0) then
    Gradient := 3;
  if (X = 0) and (Y > 0) then
    Gradient := 4;
  if (X > 0) and (Y < 0) then
    Gradient := 5;
  if (X < 0) and (Y < 0) then
    Gradient := 6;
  if (X < 0) and (Y > 0) then
    Gradient := 7;
  if (X > 0) and (Y > 0) then
    Gradient := 8;
end;

function FindXOk(X, MaxC: integer;
                 Krit: char): boolean;
var I: byte;
    Ok: boolean;
begin
  Ok := false;
  for I := 1 to MaxC do
    case Krit of
      'K': Ok := Ok or (Round(TKohr[I, 0]) = X);
      'S': Ok := Ok or (Round(TStud[I, 0]) = X);
      'F': Ok := Ok or (Round(TFish[I, 0]) = X);
    end;
  FindXOk := Ok;
end;

function FindYOk(Y, MaxR: integer;
                 Krit: char): boolean;
var I: byte;
    Ok: boolean;
begin
  Ok := false;
  for I := 1 to MaxR do
    case Krit of
      'K': Ok := Ok or (Round(TKohr[0, I]) = Y);
      'S': Ok := Ok or (Round(TStud[0, I]) = Y);
      'F': Ok := Ok or (Round(TFish[0, I]) = Y);
    end;
  FindYOk := Ok;
end;

function KriterOk(P1, P2: TPoint;
                  Col, Row, MaxC, MaxR: integer;
                  Krit: char): boolean;
begin
  KriterOk := false;
  case Gradient(P1, P2) of
    0: KriterOk := true;
    1: KriterOk := (not FindXOk(P2.X, MaxC, Krit)) and
                   (Nu(Col + 1, MaxC, Krit) > P2.X);
    2: KriterOk := (not FindXOk(P2.X, MaxC, Krit)) and
                   (Nu(Col - 1, MaxC, Krit) < P2.X);
    3: KriterOk := (not FindYOk(P2.Y, MaxR, Krit)) and
                   (Mu(Row - 1, MaxR, Krit) < P2.Y);
    4: KriterOk := (not FindYOk(P2.Y, MaxR, Krit)) and
                   (Mu(Row + 1, MaxR, Krit) > P2.Y);
    5: KriterOk := (not FindXOk(P2.X, MaxC, Krit)) and
                   (Nu(Col + 1, MaxC, Krit) > P2.X) and
                   (not FindYOk(P2.Y, MaxR, Krit)) and
                   (Mu(Row - 1, MaxR, Krit) < P2.Y);
    6: KriterOk := (not FindXOk(P2.X, MaxC, Krit)) and
                   (Nu(Col - 1, MaxC, Krit) < P2.X) and
                   (not FindYOk(P2.Y, MaxR, Krit)) and
                   (Mu(Row - 1, MaxR, Krit) < P2.Y);
    7: KriterOk := (not FindXOk(P2.X, MaxC, Krit)) and
                   (Nu(Col - 1, MaxC, Krit) < P2.X) and
                   (not FindYOk(P2.Y, MaxR, Krit)) and
                   (Mu(Row + 1, MaxR, Krit) > P2.Y);
    8: KriterOk := (not FindXOk(P2.X, MaxC, Krit)) and
                   (Nu(Col + 1, MaxC, Krit) > P2.X) and
                   (not FindYOk(P2.Y, MaxR, Krit)) and
                   (Mu(Row + 1, MaxR, Krit) > P2.Y);
  end;
end;

function KritZnKrit(P1, P2: TPoint;
                    Col, Row, MaxC, MaxR: integer;
                    Krit: char): real;
var G1, G2, G3, G4: TPoint;
    X0, Y0, DX, DY: real;

  procedure Points(var G1, G2, G3, G4: TPoint);
  begin
    case Gradient(P1, P2) of
      1, 4, 8: begin
           G1 := Point(Col, Row);
           G2 := Point(Col + 1, Row);
           G3 := Point(Col, Row + 1);
           G4 := Point(G2.X, G3.Y);
         end;
      2, 7: begin
           G2 := Point(Col, Row);
           G1 := Point(Col - 1, Row);
           G3 := Point(G1.X, Row + 1);
           G4 := Point(G2.X, G3.Y);
         end;
      3, 5: begin
           G3 := Point(Col, Row);
           G1 := Point(Col, Row - 1);
           G2 := Point(Col + 1, G1.Y);
           G4 := Point(G2.X, G3.Y);
         end;
      6: begin
           G4 := Point(Col, Row);
           G2 := Point(Col, Row - 1);
           G3 := Point(Col - 1, G4.Y);
           G1 := Point(G2.X, G3.Y);
         end;
    end;
  end;

begin
  if Gradient(P1, P2) = 0 then
    begin
      KritZnKrit := G(Col, Row);
      Exit;
    end;
  Points(G1, G2, G3, G4);
  X0 := (Nu(G1.X, MaxC, Krit) + Nu(G2.X, MaxC, Krit)) / 2;
  Y0 := (Mu(G1.Y, MaxR, Krit) + Mu(G3.Y, MaxR, Krit)) / 2;
  DX := Abs(Nu(G1.X, MaxC, Krit) - Nu(G2.X, MaxC, Krit)) / 2;
  DY := Abs(Mu(G1.Y, MaxR, Krit) - Mu(G3.Y, MaxR, Krit)) / 2;
  KritZnKrit := ((G(G1.X, G1.Y) + G(G2.X, G2.Y) + G(G3.X, G3.Y) + G(G4.X, G4.Y)) +
  ( - G(G1.X, G1.Y) + G(G2.X, G2.Y) - G(G3.X, G3.Y) + G(G4.X, G4.Y)) *
  (P2.X - X0) / DX +
  ( - G(G1.X, G1.Y) - G(G2.X, G2.Y) + G(G3.X, G3.Y) + G(G4.X, G4.Y)) *
  (P2.Y - Y0) / DY +
  (G(G1.X, G1.Y) - G(G2.X, G2.Y) - G(G3.X, G3.Y) + G(G4.X, G4.Y)) *
  (P2.X - X0) * (P2.Y - Y0) / DX / DY) / 4;
end;

procedure ShowWospr;
var S: string[10];
begin
  with FormObrabotka do
    begin
{Выбор критерия}
      RxLabel2.Visible := I412 in ElProt.WorkItems;
      Panel2.Visible := RxLabel2.Visible and (not (I4141 in ElProt.WorkItems));
      if Panel2.Visible then
        ComboBox1.SetFocus;
{Вывод критерия и суммы дисперсий}
      Label4.Visible := (I4141 in ElProt.WorkItems) and (not Panel2.Visible);
      Label5.Caption := RealToStr(SDisp, 5, 3);
      Label5.Visible := Label4.Visible;
{Ввод наблюдаемого значения критерия}
      Panel3.Visible := (I4141 in ElProt.WorkItems) and
                        (not (I4142 in ElProt.WorkItems));
{Показ наблюдаемого значения}
      Label7.Visible := (I4141 in ElProt.WorkItems) and
                        (not Panel3.Visible);
      Label8.Caption := RealToStr(NablZnKohr, 5, 3);
      Label8.Visible := Label7.Visible;
{Выбор и показ уровня значимости}
      Label10.Visible := I4142 in ElProt.WorkItems;
      if ElProt.RezObrab.UrZnVospr = 0 then
        ComboBox2.ItemIndex := -1
      else
        if CheckReal(0.01, ElProt.RezObrab.UrZnVospr, 0.1) then
          ComboBox2.ItemIndex := 0
        else
          ComboBox2.ItemIndex := 1;
      ComboBox2.Visible := Label10.Visible and (not rShow);
      if ComboBox2.Visible then
        ComboBox2.SetFocus;
      Str(ElProt.RezObrab.UrZnVospr: 4: 2, S);
      Label11.Caption := S;
      Label11.Visible := Label10.Visible and rShow;
{Выбор критического значения}
      if (not rShow) and (I4143 in ElProt.WorkItems) and
         (not (I4144 in ElProt.WorkItems)) then
        if not Panel4.Visible then
          begin
            DrawTabl(ComboBox2.ItemIndex);
            Panel4.Show;
          end
        else
      else
        Panel4.Hide;
{Показ критического значения}
      Label9.Visible := I4144 in ElProt.WorkItems;
      Str(ElProt.RezObrab.KrZnV: 6: 4, S);
      Label12.Caption := S;
      Label12.Visible := Label9.Visible;
{Вопрос о воспроизводимости}
      Panel5.Visible := (not rShow) and (I4144 in ElProt.WorkItems) and
         (not (I414 in ElProt.WorkItems));
{Вывод воспроизводимости}
      Label19.Caption := 'На выбранном уровне значимости эксперимент';
      if ElProt.RezObrab.KrZnV > NablZnKohr then
        begin
          RxLabel3.Font.Color := clBlue;
          RxLabel3.Caption := 'воспроизводим.';
        end
      else
        begin
          RxLabel3.Font.Color := clRed;
          RxLabel3.Caption := 'невоспроизводим.';
        end;
      Label19.Visible := I414 in ElProt.WorkItems;
      RxLabel3.Visible := I414 in ElProt.WorkItems;
{Оценка дисперсии шума}
      RxLabel4.Visible := ((not rShow) and (I414 in ElProt.WorkItems)) or
                          (I413 in ElProt.WorkItems);
      Panel6.Visible := (not rShow) and (I414 in ElProt.WorkItems) and
         (not (I413 in ElProt.WorkItems));
      Label21.Visible := I413 in ElProt.WorkItems;
      Label22.Caption := RealToStr(SDisp / ElProt.Plan.N, 8, 5);
      Label22.Visible := I413 in ElProt.WorkItems;
    end;
end;

procedure MakeTabSheet1;
begin
  ShowRezExp;
  SrednAndDisp;
  ShowWospr;
end;

procedure TFormObrabotka.PageControl1Change(Sender: TObject);
begin
  {   }
end;

procedure TFormObrabotka.FormActivate(Sender: TObject);
begin
  MakeTabSheet1;
end;

procedure TFormObrabotka.Button1Click(Sender: TObject);
var
  Etalon: real;
  I: byte;
begin
  {Ввод средних и дисперсий отклика}
  if not (I411 in ElProt.WorkItems) then
    Etalon := Srednee(StringGrid1.Rows[StringGrid1.Row], ElProt.Plan.M)
  else
    Etalon := Dispersia(StringGrid1.Rows[StringGrid1.Row], ElProt.Plan.M);
  if CheckReal(Etalon, RxCalcEdit1.Value, 0.1) then
    Inc(NumOk)
  else
    MyMessageDlg('Ошибка', 'Значение вычислено неверно. Еще одна попытка.',
                  mtError, [mbOk]);
  if NumOk = Porog then
    if not (I411 in ElProt.WorkItems) then
      begin
        ChangeWorkItems([I411], [], [I12, I65], []);
        for I := 1 to ElProt.Plan.N do
          begin
            ElProt.Experim[I, 5] := Srednee(StringGrid1.Rows[I], ElProt.Plan.M);
            StringGrid1.Cells[ElProt.Plan.M + 1, I] :=
                             RealToStr(ElProt.Experim[I, 5], 5, 3);
          end;
      end
    else
      begin
        ChangeWorkItems([I412], [], [I12], []);
        for I := 1 to ElProt.Plan.N do
          begin
            ElProt.Experim[I, 6] := Dispersia(StringGrid1.Rows[I], ElProt.Plan.M);
            StringGrid1.Cells[ElProt.Plan.M + 2, I] :=
                              RealToStr(ElProt.Experim[I, 6], 5, 3);
          end;
      end;
  MakeTabSheet1;
end;

procedure TFormObrabotka.ComboBox1Change(Sender: TObject);
begin
  {Выбор критерия Кохрена}
  if ComboBox1.ItemIndex <> 4 then
    MyMessageDlg('Ошибка', 'Не тот критерий. Попробуйте еще.',
                  mtError, [mbOk])
  else
    ChangeWorkItems([I4141], [], [I12], []);
  MakeTabSheet1;
end;

procedure TFormObrabotka.Button2Click(Sender: TObject);
begin
  {Ввод наблюдаемого значения критерия Кохрена}
  if CheckReal(NablZnKohr, RxCalcEdit2.Value, 0.1) then
    ChangeWorkItems([I4142], [], [I12], [])
  else
    MyMessageDlg('Ошибка', 'Наблюдаемое значение критерия определено неверно.',
                  mtError, [mbOk]);
  MakeTabSheet1;
end;

procedure TFormObrabotka.ComboBox2Change(Sender: TObject);
begin
{Выбор уровня значимости}
  ChangeWorkItems([I4143], [I4144, I414], [I12], []);
  if ComboBox2.ItemIndex = 0 then
    ElProt.RezObrab.UrZnVospr := 0.01
  else
    ElProt.RezObrab.UrZnVospr := 0.05;
  MakeTabSheet1;
end;

procedure TFormObrabotka.StringGrid2Click(Sender: TObject);
begin
  with StringGrid2 do
    if KriterOk(Point(Nu(Col, ColCount - 1, 'K'), Mu(Row, RowCount - 1, 'K')),
                Point(ElProt.Plan.M - 1, ElProt.Plan.N),
                Col, Row, ColCount - 1, RowCount - 1, 'K') then
      begin
        ChangeWorkItems([I4144], [], [I12], []);
        ElProt.RezObrab.KrZnV :=
                KritZnKrit(Point(Nu(Col, ColCount - 1, 'K'),
                                 Mu(Row, RowCount - 1, 'K')),
                Point(ElProt.Plan.M - 1, ElProt.Plan.N),
                Col, Row, ColCount - 1, RowCount - 1, 'K');
      end
    else
      MyMessageDlg('Ошибка', 'Критическое значение критерия определено неверно.',
                    mtError, [mbOk]);
  MakeTabSheet1;
end;

procedure TFormObrabotka.Button3Click(Sender: TObject);
begin
  if ElProt.RezObrab.KrZnV <= NablZnKohr then
    MyMessageDlg('Ошибка', 'Вы сделали неверный вывод. На выбранном уровне ' +
                 'значимости эксперимент нельзя считать воспроизводимым.',
                 mtError, [mbOk]);
  ChangeWorkItems([I414], [], [I12], []);
  MakeTabSheet1;
end;

procedure TFormObrabotka.Button4Click(Sender: TObject);
begin
  if ElProt.RezObrab.KrZnV > NablZnKohr then
    MyMessageDlg('Ошибка', 'Вы сделали неверный вывод. На выбранном уровне ' +
                 'значимости эксперимент можно считать воспроизводимым.',
                 mtError, [mbOk]);
  ChangeWorkItems([I414], [], [I12], []);
  MakeTabSheet1;
end;

procedure TFormObrabotka.Button5Click(Sender: TObject);
begin
  if CheckReal(SDisp / ElProt.Plan.N, RxCalcEdit3.Value, 0.1) then
    ChangeWorkItems([I413], [], [I12], [])
  else
    MyMessageDlg('Ошибка', 'Оценка дисперсии ошибки определена неверно. ' +
                 'Попробуйте еще раз.',
                 mtError, [mbOk]);
  MakeTabSheet1;
end;

end.
