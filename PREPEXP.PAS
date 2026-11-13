unit PrepExp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Spin, Grids, RXSpin;

type
  TFormPrepExp = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Label6: TLabel;
    Bevel2: TBevel;
    Label7: TLabel;
    Bevel3: TBevel;
    Label8: TLabel;
    Bevel4: TBevel;
    ComboBox1: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button1: TButton;
    StringGrid1: TStringGrid;
    Button3: TButton;
    Label12: TLabel;
    Label13: TLabel;
    StringGrid2: TStringGrid;
    Panel13: TPanel;
    Shape1: TShape;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Label14: TLabel;
    Button2: TButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    ComboBoxDopF: TComboBox;
    ComboBoxGS1: TComboBox;
    ComboBoxGS2: TComboBox;
    EditStarSt: TEdit;
    Panel14: TPanel;
    Panel15: TPanel;
    Memo1: TMemo;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Bevel5: TBevel;
    RxSpinEdit1: TRxSpinEdit;
    RxSpinEdit2: TRxSpinEdit;
    RxSpinEditM: TRxSpinEdit;
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure Button3Click(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Longint;
      const Value: string);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure StringGrid2SelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
    procedure StringGrid2DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure Button2Click(Sender: TObject);
    procedure SpinEditMChange(Sender: TObject);
    procedure ComboBoxDopFChange(Sender: TObject);
    procedure ComboBoxGS1Change(Sender: TObject);
    procedure ComboBoxGS2Change(Sender: TObject);
    procedure EditStarStChange(Sender: TObject);
    procedure EditStarStExit(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrepExp: TFormPrepExp;

implementation

uses Main, MyType, VarDan, VarType, MySystProc, Common1;

{$R *.DFM}

var
  DFEPrigoden: boolean;

procedure PanelsPos(NP: byte);

  procedure Pos(var Panel: TPanel;
                Top, Left: integer;
                Up: boolean);
    begin
      if Up then
        begin
          Panel.Top := Top - 4;
          Panel.Left := Left - 4;
        end
      else
        begin
          Panel.Top := Top;
          Panel.Left := Left;
        end;
    end;

begin
  with FormPrepExp do
    begin
      Pos(Panel2, Panel1.Top, Panel1.Left, NP = 1);
      Pos(Panel3, Panel4.Top, Panel4.Left, NP = 2);
      Pos(Panel5, Panel6.Top, Panel6.Left, NP = 3);
      Pos(Panel7, Panel8.Top, Panel8.Left, NP = 4);
    end;
end;

procedure TFormPrepExp.Panel2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(1);
end;

procedure TFormPrepExp.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(0);
end;

procedure TFormPrepExp.Panel3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(2);
end;

procedure TFormPrepExp.Panel5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(3);
end;

procedure TFormPrepExp.Panel7MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(4);
end;

procedure Draw1;
begin
  with FormPrepExp do
    begin
      Label4.Caption := 'n = ' + IntToStr(ElProt.Variant.KolFakt);
      Label5.Caption := StrBazFunc(ElProt.Variant);
    end;
end;

procedure Draw2;
begin
  with FormPrepExp do
    begin
      if (I22 in ElProt.WorkItems) or
         (I221 in ElProt.WorkItems) then
        Label6.Font.Color := clNavy
      else
        Label6.Font.Color := clRed;
      ComboBox1.ItemIndex := Ord(ElProt.Plan.TypePlan) - 1;
      RxSpinEdit1.Value := ElProt.Plan.StDrobn;
      RxSpinEdit2.Value := ElProt.Plan.N;
    end;
end;

procedure MakeStrGr1;
var I, J: byte;
begin
  with FormPrepExp.StringGrid1 do
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

procedure Draw3;
begin
  with FormPrepExp do
    begin
      if I23 in ElProt.WorkItems then
        Label7.Font.Color := clNavy
      else
        Label7.Font.Color := clRed;
      MakeStrGr1;
      StringGrid1.Visible := I22 in ElProt.WorkItems;
      Button3.Enabled := I22 in ElProt.WorkItems;
      Label12.Visible := not (I22 in ElProt.WorkItems);
    end;
end;

function SPToStr(X, G: byte): string;
begin
  case ElProt.Plan.SPlan[X, G] of
    -2: SPToStr := ' -a';
    -1: SPToStr := ' -1';
     0: SPToStr := '   0';
     1: SPToStr := ' +1';
     2: SPToStr := ' +a';
  else
     SPToStr := '';
  end;
end;

procedure DrawStrGr2;
const
  DCol0 = 13;
  SGHeight = 310;
var I, J: byte;
begin
  with FormPrepExp.StringGrid2 do
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
      Left := (FormPrepExp.Panel12.Width - Width) div 2;
      Top := (FormPrepExp.Panel12.Height - Height) div 2 + 10;
      Cells[0, 0] := 'Точки';
      for I := 1 to ElProt.Variant.KolFakt do
        Cells[I, 0] := ' X' + IntToStr(I);
      for I := 1 to ElProt.Plan.N do
        Cells[0, I] := '    ' + IntToStr(I);
      for I := 1 to ElProt.Variant.KolFakt do
        for J := 1 to ElProt.Plan.N do
          Cells[I, J] := SPToStr(I, J);
      Show;
      SetFocus;
    end;
end;

function BazFuncToNumCell(BF: myTBazFunc): byte;
var I: byte;
begin
  I := 1;
  while ArrBF[ElProt.Variant.KolFakt, I] <> Ord(BF) do
    Inc(I);
  BazFuncToNumCell := I;
end;

procedure MakeList1;
var I, J: byte;
    S: string[20];
begin
  FormPrepExp.ComboBoxDopF.Items.Clear;
  for I := 2 to Step2(ElProt.Variant.KolFakt) do
    begin
      S := BazFuncToStr(IntToBazFunc(I));
      J := 1;
      while J < Length(S) do
        begin
          Insert(', ', S, J + 1);
          Inc(J, 3);
        end;
      FormPrepExp.ComboBoxDopF.Items.Add(S);
    end;
end;

procedure MakeList2;
var I, J: byte;
    S: string[20];
begin
  FormPrepExp.ComboBoxGS1.Items.Clear;
  for I := 2 to Step2(ElProt.Variant.KolFakt) do
    begin
      S := BazFuncToStr(IntToBazFunc(I));
      J := 1;
      while J <= Length(S) do
        begin
          Insert(' X', S, J);
          Inc(J, 3);
        end;
      FormPrepExp.ComboBoxGS1.Items.Add(S);
    end;
end;

procedure DrawBottom;
var I: byte;
begin
  with FormPrepExp do
    begin
      Button2.Enabled := I22 in ElProt.WorkItems;
      Label15.Visible := I22 in ElProt.WorkItems;
      RxSpinEditM.Value := ElProt.Plan.M;
      RxSpinEditM.Visible := Label15.Visible;
      Label16.Visible := (I22 in ElProt.WorkItems) and
                         ((ElProt.Plan.TypePlan = DFE) or
                          ((ElProt.Plan.TypePlan = OCKP) and
                           (ElProt.Variant.KolFakt = 5))) ;
      MakeList1;
      ComboBoxDopF.Visible := Label16.Visible;
      I := 0;
      SetRazr(I, ElProt.Plan.GS1.X - 1, true);
      if ElProt.Plan.StDrobn = 2 then
        SetRazr(I, ElProt.Plan.GS2.X - 1, true);
      ComboBoxDopF.ItemIndex := BazFuncToNumCell(myTBazFunc(I)) - 2;
      if ElProt.Plan.GS1.X <> 0 then
        Label17.Caption := 'Генерирующее соотношение  Х' +
                           IntToStr(ElProt.Plan.GS1.X) + '  =';
      Label17.Visible := Label16.Visible and (ElProt.Plan.GS1.X <> 0);
      MakeList2;
      ComboBoxGS1.Visible := Label17.Visible;
      ComboBoxGS1.ItemIndex := BazFuncToNumCell(ElProt.Plan.GS1.GS) - 2;
      if (ElProt.Plan.StDrobn = 2) and (ElProt.Plan.GS2.X <> 0) then
        Label18.Caption := 'Генерирующее соотношение  Х' +
                           IntToStr(ElProt.Plan.GS2.X) + '  =';
      Label18.Visible := (I22 in ElProt.WorkItems) and
                         (ElProt.Plan.StDrobn = 2) and
                         (ElProt.Plan.GS2.X <> 0);
      ComboBoxGS2.Items := ComboBoxGS1.Items;
      ComboBoxGS2.Visible := Label18.Visible;
      ComboBoxGS2.ItemIndex := BazFuncToNumCell(ElProt.Plan.GS2.GS) - 2;
      Label19.Visible := (I22 in ElProt.WorkItems) and
                         (ElProt.Plan.TypePlan = OCKP);
      EditStarSt.Visible := Label19.Visible;
    end;
end;

procedure Draw4;
begin
  with FormPrepExp do
    begin
      if I24 in ElProt.WorkItems then
        Label8.Font.Color := clNavy
      else
        Label8.Font.Color := clRed;
      Label13.Visible := not (I241 in ElProt.WorkItems);
      Panel13.Visible := not Label13.Visible;
      if Panel13.Visible then
        DrawStrGr2
      else
        StringGrid2.Hide;
    end;
end;

procedure DrawForm;
begin
  IniExperim(ElProt.Experim);
{      IniRezultat(ElProt.Rezultat);}
  ElProt.WorkItems := ElProt.WorkItems - [I3, I4..I44];
  ElProt.MItemsEn := ElProt.MItemsEn - [I3, I4..I44, I64, I65];
  ElProt.MItemsEn := ElProt.MItemsEn + [I12];
  Draw1;
  Draw2;
  Draw3;
  Draw4;
  DrawBottom;
end;

function StrToTypeExp(S: string): myTExper;
begin
  if S = 'ПФЭ' then
    StrToTypeExp := PFE
  else
    if S = 'ДФЭ' then
      StrToTypeExp := DFE
    else
      if S = 'ОЦКП' then
        StrToTypeExp := OCKP
      else
        if S = 'РЦКП' then
          StrToTypeExp := RCKP
        else
          if S = 'УЦКП' then
            StrToTypeExp := UCKP
          else
            StrToTypeExp := None;
end;

function KolTSP: byte;
begin
  case StrToTypeExp(AnsiUpperCase(Trim(FormPrepExp.ComboBox1.Text))) of
    PFE: KolTSP := Step2(ElProt.Variant.KolFakt);
    DFE: KolTSP := Step2(ElProt.Variant.KolFakt - Round(FormPrepExp.RxSpinEdit1.Value));
    OCKP: KolTSP := Step2(ElProt.Variant.KolFakt - Round(FormPrepExp.RxSpinEdit1.Value)) +
                    2 * ElProt.Variant.KolFakt + 1;
    else
      KolTSP := 0;
  end;
end;

function TypeExperOk: boolean;
var Ok: boolean;
begin
  Ok := (TypeExpToStr(ElProt.Variant.TypeExper) =
        AnsiUpperCase(Trim(FormPrepExp.ComboBox1.Text))) and
        (ElProt.Variant.P = Round(FormPrepExp.RxSpinEdit1.Value));
  if not Ok then
    Rezult := MyMessageDlg('Предупреждение', 'Тип эксперимента не соответствует заданной модели.' +
                 'Вы настаиваете на проведении такого эксперимента?',
                 mtConfirmation, [mbYes, mbNo]);
  if Rezult = mrYes then
    begin
      ElProt.WorkItems := ElProt.WorkItems + [I221];
      Ok := true;
    end
  else
    ElProt.WorkItems := ElProt.WorkItems - [I221];
  if (AnsiUpperCase(Trim(FormPrepExp.ComboBox1.Text)) = 'ДФЭ') and
     (Step2(ElProt.Variant.KolFakt - Round(FormPrepExp.RxSpinEdit1.Value)) <
      ElProt.Variant.KolFakt + 1) then
    begin
      MyMessageDlg('Ошибка', 'Эксперимент с такой степенью дробности не имеет смысла.',
                   mtError, [mbOk]);
      Ok := false;
    end;
  if ((AnsiUpperCase(Trim(FormPrepExp.ComboBox1.Text)) = 'ПФЭ') and
     (FormPrepExp.RxSpinEdit1.Value > 0)) or
     ((AnsiUpperCase(Trim(FormPrepExp.ComboBox1.Text)) = 'ДФЭ') and
     (FormPrepExp.RxSpinEdit1.Value = 0)) then
    begin
      MyMessageDlg('Ошибка', 'Степень дробности не соответствует типу эксперимента.',
                   mtError, [mbOk]);
      Ok := false;
    end;
  if FormPrepExp.RxSpinEdit2.Value <> KolTSP then
    begin
      MyMessageDlg('Ошибка', 'Количество точек спектра плана определено неверно.',
                   mtError, [mbOk]);
      Ok := false;
    end;
  TypeExperOk := Ok;
end;

procedure TFormPrepExp.Button1Click(Sender: TObject);
begin
  Rezult := mrYes;
  if (I22 in ElProt.WorkItems) and ((I23 in ElProt.WorkItems) or
     (I24 in ElProt.WorkItems)) then
    Rezult := MyMessageDlg('Предупреждение', 'Если Вы измените тип эксперимента, ' +
                   'то все последующие этапы придется ваполнять заново. ' +
                   'Согласны?', mtConfirmation, [mbYes, mbNo]);
  if Rezult = mrYes then
    begin
      IniPlan(ElProt.Plan);
      ElProt.WorkItems := [I21];
      ElProt.MItemsEn := ElProt.MItemsEn + [I11, I12];
      UpdateMenuAndButtons;
      if TypeExperOk then
        begin
          ElProt.WorkItems := ElProt.WorkItems + [I22];
          ElProt.Plan.TypePlan := StrToTypeExp(ComboBox1.Text);
          ElProt.Plan.StDrobn := Round(RxSpinEdit1.Value);
          ElProt.Plan.N := Round(RxSpinEdit2.Value);
          if (ElProt.Plan.TypePlan = PFE) or
             ((ElProt.Plan.TypePlan = OCKP) and
              (ElProt.Plan.StDrobn = 0)) then
            ElProt.WorkItems := ElProt.WorkItems + [I241];
          Label6.Font.Color := clNavy;
          Draw3;
          Draw4;
          DrawBottom;
        end;
    end
  else
    Draw2;
end;

procedure TFormPrepExp.FormActivate(Sender: TObject);
begin
  DrawForm;
end;

procedure TFormPrepExp.StringGrid1SelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
begin
  CanSelect := Row > 2;
end;

procedure TFormPrepExp.StringGrid1DrawCell(Sender: TObject; Col,
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

function NormalOk: boolean;
var Ok: boolean;
    I: byte;
    D: real;
begin
  Ok := true;
  I := 1;
  while Ok and (I <= ElProt.Variant.KolFakt) do
    begin
      if ElProt.Plan.TypePlan = OCKP then
        D := Sqrt(Sqrt(Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn - 2) *
                 (Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn) +
                        2 * ElProt.Variant.KolFakt + 1)) -
            Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn - 1)) *
            StrToReal(FormPrepExp.StringGrid1.Cells[I, 4])
      else
        D := StrToReal(FormPrepExp.StringGrid1.Cells[I, 4]);
      Ok := (StrToReal(FormPrepExp.StringGrid1.Cells[I, 3]) <> 0) and
           ((StrToReal(FormPrepExp.StringGrid1.Cells[I, 3]) + D <=
             StrToReal(FormPrepExp.StringGrid1.Cells[I, 2])) and
            (StrToReal(FormPrepExp.StringGrid1.Cells[I, 3]) - D >=
             StrToReal(FormPrepExp.StringGrid1.Cells[I, 1])));
      Inc(I);
    end;
  if not Ok then
    MyMessageDlg('Ошибка', 'Нормирование факторов выполнено некорректно.',
                  mtError, [mbOk]);
  NormalOk := Ok;
end;

procedure TFormPrepExp.Button3Click(Sender: TObject);
var I, J: byte;
begin
  Rezult := mrYes;
  if I3 in ElProt.WorkItems then
    Rezult := MyMessageDlg('Предупреждение', 'Если Вы измените нормировку факторов, ' +
                   'то эксперимент и обработку его результатов придется ваполнять заново. ' +
                   'Согласны?', mtConfirmation, [mbYes, mbNo]);
  if Rezult = mrYes then
    begin
      ElProt.WorkItems := ElProt.WorkItems - [I23, I3, I41..I44];
      ElProt.MItemsEn := ElProt.MItemsEn - [I3, I41..I44, I63..I65];
      ElProt.MItemsEn := ElProt.MItemsEn + [I12];
      UpdateMenuAndButtons;
      if NormalOk then
        begin
          ElProt.WorkItems := ElProt.WorkItems + [I23];
          for I := 1 to ElProt.Variant.KolFakt do
            for J := 1 to 2 do
              ElProt.Plan.Norm[I, J] := StrToReal(StringGrid1.Cells[I, J + 2]);
          Draw3;
          if I24 in ElProt.WorkItems then
            begin
              MyMessageDlg('Примите поздравления!', 'Вы закончили подготовку эксперимента' +
                     ' и можете приступить к его проведению.',
                     mtInformation, [mbOk]);
              ElProt.MItemsEn := ElProt.MItemsEn + [I3, I63];
              FormPrepExp.Hide;
            end;
        end;
    end
  else
    Draw3;
end;

procedure TFormPrepExp.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Longint; const Value: string);
begin
  StrToReal(Value);
end;

procedure RButCheck(N: byte);
begin
  with FormPrepExp do
    begin
      RadioButton1.Checked := N = 1;
      RadioButton2.Checked := N = 2;
      RadioButton3.Checked := N = 3;
      RadioButton4.Checked := N = 4;
      RadioButton5.Checked := N = 5;
      if N = 1 then
        RadioButton1.Font.Color := clBlue
      else
        RadioButton1.Font.Color := clBlack;
      if N = 2 then
        RadioButton2.Font.Color := clBlue
      else
        RadioButton2.Font.Color := clBlack;
      if N = 3 then
        RadioButton3.Font.Color := clBlue
      else
        RadioButton3.Font.Color := clBlack;
      if N = 4 then
        RadioButton4.Font.Color := clBlue
      else
        RadioButton4.Font.Color := clBlack;
      if N = 5 then
        RadioButton5.Font.Color := clBlue
      else
        RadioButton5.Font.Color := clBlack;
    end;
end;

procedure TFormPrepExp.RadioButton1Click(Sender: TObject);
begin
  RButCheck(1);
end;

procedure TFormPrepExp.RadioButton2Click(Sender: TObject);
begin
  RButCheck(2);
end;

procedure TFormPrepExp.RadioButton3Click(Sender: TObject);
begin
  RButCheck(3);
end;

procedure TFormPrepExp.RadioButton4Click(Sender: TObject);
begin
  RButCheck(4);
end;

procedure TFormPrepExp.RadioButton5Click(Sender: TObject);
begin
  RButCheck(5);
end;

function RButToStr: string;
begin
  with FormPrepExp do
    begin
      if RadioButton1.Checked then
        RButToStr := ' ' + RadioButton1.Caption;
      if RadioButton2.Checked then
        RButToStr := ' ' + RadioButton2.Caption;
      if RadioButton3.Checked then
        RButToStr := ' ' + RadioButton3.Caption;
      if RadioButton4.Checked then
        RButToStr := ' ' + RadioButton4.Caption;
      if RadioButton5.Checked then
        RButToStr := ' ' + RadioButton5.Caption;
    end;
end;

procedure TFormPrepExp.StringGrid2SelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
begin
  StringGrid2.Cells[Col, Row] := RButToStr;
end;

function SPToInt(Str: string): shortint;
begin
  SPToInt := - 100;
  if Str = ' -a' then
    SPToInt := -2;
  if Str = ' -1' then
    SPToInt := -1;
  if Str = '   0' then
    SPToInt := 0;
  if Str = ' +1' then
    SPToInt := 1;
  if Str = ' +a' then
    SPToInt := 2;
end;

procedure TFormPrepExp.StringGrid2DrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
begin
  with StringGrid2.Canvas do
    begin
      if (Row > 0) and (Col > 0) then
        begin
          StringGrid2.DefaultDrawing := false;
          Brush.Color := clWhite;
          if StringGrid2.Cells[Col, Row] = ' +a' then
            Brush.Color := clFuchsia;
          if StringGrid2.Cells[Col, Row] = ' +1' then
            Brush.Color := clYellow;
          if StringGrid2.Cells[Col, Row] = ' -1' then
            Brush.Color := clLime;
          if StringGrid2.Cells[Col, Row] = ' -a' then
            Brush.Color := clAqua;
          FillRect(Rect);
          Font.Name := 'Symbol';
          Font.Size := 10;
          Font.Color := clBlack;
          TextOut(Rect.Left, Rect.Top, StringGrid2.Cells[Col, Row]);
          StringGrid2.DefaultDrawing := true;
          ElProt.Plan.SPlan[Col, Row] := SPToInt(StringGrid2.Cells[Col, Row]);
        end;
    end;
end;

function CheckSP: boolean;
var I: byte;
    Ok: boolean;
  function RowJdro(Row: byte): boolean;
  var I: byte;
      Ok: boolean;
    function DopFOk(X: byte;
                    GS: myTBazFunc;
                    Row: byte): boolean;
    var I: byte;
        P: shortint;
    begin
      P := 1;
      for I := 1 to ElProt.Variant.KolFakt do
        if EdRazr(Ord(GS), I - 1) then
          P := P * ElProt.Plan.Splan[I, Row];
      DopFOk := ElProt.Plan.Splan[X, Row] = P;
    end;
  begin
    Ok := true;
    for I := 1 to ElProt.Variant.KolFakt do
      Ok := Ok and (((ElProt.Plan.Splan[I, Row] = -1) or
                     (ElProt.Plan.Splan[I, Row] = 1)) and
              ((not (I in [ElProt.Plan.GS1.X, ElProt.Plan.GS2.X])) or
    (((I = ElProt.Plan.GS1.X) and DopFOk(I, ElProt.Plan.GS1.GS, Row)) or
    ((I = ElProt.Plan.GS2.X) and DopFOk(I, ElProt.Plan.GS2.GS, Row)))));
    RowJdro := Ok;
  end;
  function RowCentr(Row: byte): boolean;
  var I: byte;
      Ok: boolean;
  begin
    Ok := true;
    for I := 1 to ElProt.Variant.KolFakt do
      Ok := Ok and (ElProt.Plan.Splan[I, Row] = 0);
    RowCentr := Ok;
  end;
  function RowStar(Row: byte): boolean;
  var I, J: byte;
      Ok: boolean;
  begin
    Ok := true;
    J := 0;
    for I := 1 to ElProt.Variant.KolFakt do
      begin
        Ok := Ok and ((ElProt.Plan.Splan[I, Row] in [0, 2]) or
                      (ElProt.Plan.Splan[I, Row] = -2));
        if (ElProt.Plan.Splan[I, Row] = -2) or
           (ElProt.Plan.Splan[I, Row] = 2) then
          Inc(J);
      end;
    RowStar := Ok and (J = 1);
  end;
  function DFEOk: boolean;
  var I, J, K, N, P: byte;
      SB: set of byte;
      Ok: boolean;
  begin
    SB := [];
    N := 0;
    for I := 1 to ElProt.Plan.N do
      if RowJdro(I) then
        begin
          K := 0;
          P := 0;
          for J := 1 to ElProt.Variant.KolFakt do
            if (not (J in [ElProt.Plan.GS1.X, ElProt.Plan.GS2.X])) then
               if (ElProt.Plan.SPlan[J, I] = 1) then
                 SetRazr(K, J - 1 - P, true)
               else
            else
              Inc(P);
          SB := SB + [K];
          Inc(N);
        end;
    Ok := N = Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn);
    for I := 0 to N - 1 do
      Ok := Ok and (I in SB);
    DFEOk := Ok;
  end;
  function StarsOk: boolean;
  var I, J, K: byte;
      Ok: boolean;
      AF: array [1..5] of ShortInt;
  begin
    J := 0;
    for K := 1 to ElProt.Variant.KolFakt do
      AF[K] := 0;
    for I := 1 to ElProt.Plan.N do
      if RowStar(I) then
        begin
          Inc(J);
          for K := 1 to ElProt.Variant.KolFakt do
            case ElProt.Plan.SPlan[K, I] of
              2: Inc(AF[K]);
             -2: Dec(AF[K]);
            end;
        end;
    Ok := true;
    for K := 1 to ElProt.Variant.KolFakt do
      Ok := Ok and (AF[K] = 0);
    StarsOk := Ok and (J = 2 * ElProt.Variant.KolFakt);
  end;
  function CentrOk: boolean;
  var I, J: byte;
  begin
    J := 0;
    for I := 1 to ElProt.Plan.N do
      if RowCentr(I) then
        Inc(J);
    CentrOk := J = 1;
  end;
begin
  Ok := true;
  case ElProt.Plan.TypePlan of
    PFE, DFE:
      begin
        for I := 1 to ElProt.Plan.N do
          Ok := Ok and RowJdro(I);
        Ok := Ok and DFEOk;
      end;
    OCKP:
      Ok := DFEOk and StarsOk and CentrOk;
  end;
  if not Ok then
    MyMessageDlg('Ошибка', 'Спектр плана содержит ошибки. Найдите и исправьте их.',
                  mtError, [mbOk]);
  CheckSP := Ok;
end;

function SPlanOk: boolean;
var Ok: boolean;
    A: real;
begin
  Ok := true;
  if ElProt.Plan.M < 2 then
    begin
      MyMessageDlg('Ошибка', 'Количество параллельных опытов выбрано неверно.',
                   mtError, [mbOk]);
      Ok := false;
    end;
  if ElProt.Plan.TypePlan = OCKP then
    begin
      ElProt.Plan.Alfa := StrToReal(FormPrepExp.EditStarSt.Text);
      if ElProt.Plan.Alfa = 0 then
        begin
          MyMessageDlg('Предупреждение', 'Вы забыли определить звездное плечо.',
                   mtInformation, [mbOk]);
          Ok := false;
        end;
      A := Sqrt(Sqrt(Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn - 2) *
                 (Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn) +
                        2 * ElProt.Variant.KolFakt + 1)) -
            Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn - 1));
      if not CheckReal(ElProt.Plan.Alfa, A, 0.1) then
        begin
          MyMessageDlg('Ошибка', 'Звездное плечо вычислено неверно.',
                     mtError, [mbOk]);
          Ok := false;
        end;
    end;
  SPlanOk := Ok and CheckSP;
end;

function MakeOK(GenS: myTGS): myTBazFunc;
var I: byte;
begin
  I := Ord(GenS.GS);
  SetRazr(I, GenS.X - 1, true);
  MakeOK := myTBazFunc(I);
end;

procedure MakeOOK(var OOK: myTOOK);
begin
  OOK[1] := F0;
  OOK[2] := MakeOK(ElProt.Plan.GS1);
  if ElProt.Plan.StDrobn = 2 then
    begin
      OOK[3] := MakeOK(ElProt.Plan.GS2);
      OOK[4] := myTBazFunc(Ord(OOK[2]) xor Ord(OOK[3]));
    end;
end;

procedure SetMemo1;
var I: byte;
    OOK: myTOOK;
    Tmp: myTBazFunc;

  function MemoLine(BF: myTBazFunc): string;
  var S: string;

    function ConvertBF(BF: myTBazfunc): string;
    var I, J: byte;
        S: string[100];
    begin
      S := BazFuncToStr(BF);
      J := 1;
      while J <= Length(S) do
        begin
          Insert(' X', S, J);
          Inc(J, 3);
        end;
      J := Length(S);
      for I := 1 to (84 - J div 3 * 17) div 3 do
        S := S + ' ';
      if BF = F0 then
        S := ' 1                       ';
      ConvertBF := S;
    end;

  begin
    S := '      ' + ConvertBF(BF);
    Tmp := myTBazFunc(Ord(BF) xor Ord(OOK[2]));
    DFEPrigoden := not (Tmp in ElProt.Variant.Model);
    S := S + '  = ' + ConvertBF(Tmp);
    if ElProt.Plan.StDrobn = 2 then
      begin
        Tmp := myTBazFunc(Ord(BF) xor Ord(OOK[3]));
        DFEPrigoden := DFEPrigoden and (not (Tmp in ElProt.Variant.Model));
        S := S + '  = ' + ConvertBF(Tmp);
        Tmp := myTBazFunc(Ord(BF) xor Ord(OOK[4]));
        DFEPrigoden := DFEPrigoden and (not (Tmp in ElProt.Variant.Model));
        S := S + '  = ' + ConvertBF(Tmp);
      end;
    MemoLine := S;
  end;

begin
  with FormPrepExp do
    begin
      Memo1.Lines.Clear;
      MakeOOK(OOK);
      Memo1.Lines.Add(MemoLine(F0));
      for I := 2 to Step2(ElProt.Variant.KolFakt) do
        if (IntToBazFunc(I) in ElProt.Variant.Model) or
           (I <= ElProt.Variant.KolFakt + 1) then
          Memo1.Lines.Add(MemoLine(IntToBazFunc(I)));
      if ElProt.Plan.StDrobn = 1 then
          Memo1.Width := 220
      else
          Memo1.Width := 420;
      if Memo1.Lines.Count > 12 then
        begin
          Memo1.ScrollBars := ssVertical;
          Memo1.Width := Memo1.Width + 16;
        end
      else
        Memo1.ScrollBars := ssNone;
      Memo1.Left := (Panel15.Width - Memo1.Width) div 2;
    end;
end;

procedure TFormPrepExp.Button2Click(Sender: TObject);
begin
  ElProt.MItemsEn := ElProt.MItemsEn + [I11, I12];
  UpdateMenuAndButtons;
  if SPlanOk then
    begin
      if ElProt.Plan.StDrobn > 0 then
        begin
          Panel14.Show;
          Panel15.Show;
          SetMemo1;
        end
      else
        begin
          MyMessageDlg('Примите поздравления!', 'Вы закончили подготовку эксперимента' +
                   ' и можете приступить к его проведению.',
                   mtInformation, [mbOk]);
          ElProt.WorkItems := ElProt.WorkItems + [I24];
          ElProt.MItemsEn := ElProt.MItemsEn + [I3, I63];
          FormPrepExp.Hide;
          UpdateMenuAndButtons;
        end;
    end;
end;

procedure TFormPrepExp.SpinEditMChange(Sender: TObject);
begin
  ElProt.Plan.M := Round(RxSpinEditM.Value);
end;

procedure TFormPrepExp.ComboBoxDopFChange(Sender: TObject);
var I, Count: byte;
    DF: set of byte;
begin
  DF := [];
  Count := 0;
  for I := 1 to ElProt.Variant.KolFakt do
    if Pos(IntToStr(I), ComboBoxDopF.Text) > 0 then
      begin
        DF := DF + [I];
        Inc(Count);
      end;
  if Count > ElProt.Plan.StDrobn then
      MyMessageDlg('Ошибка', 'Дополнительные факторы выбраны неверно.',
                   mtError, [mbOk])
  else
    begin
      Count := 1;
      for I := 1 to ElProt.Variant.KolFakt do
        if I in DF then
          if Count = 1 then
            begin
              ElProt.Plan.GS1.X := I;
              Inc(Count);
            end
          else
            ElProt.Plan.GS2.X := I;
      DrawBottom;
    end;
end;

function GenSOk: boolean;
var Ok: boolean;
  function GSOk(NomItem, X: integer): boolean;
  begin
    GSOk := (KolEdRazr(Ord(IntToBazFunc(NomItem + 2))) > 1) and
        (not EdRazr(Ord(IntToBazFunc(NomItem + 2)), X - 1))
  end;
begin
  Ok := true;
  with FormPrepExp do
    begin
      if ElProt.Plan.StDrobn = 1 then
        begin
          Ok := GSOk(ComboBoxGS1.ItemIndex, ElProt.Plan.GS1.X);
          if Ok then
            ElProt.WorkItems := ElProt.WorkItems + [I241]
          else
            ElProt.WorkItems := ElProt.WorkItems - [I241];
        end
      else
        if Trim(ComboBoxGS1.Text) <> '' then
          if Trim(ComboBoxGS2.Text) <> '' then
            begin
              Ok := GSOk(ComboBoxGS1.ItemIndex, ElProt.Plan.GS1.X) and
                    GSOk(ComboBoxGS2.ItemIndex, ElProt.Plan.GS2.X) and
                    GSOk(ComboBoxGS1.ItemIndex, ElProt.Plan.GS2.X) and
                    GSOk(ComboBoxGS2.ItemIndex, ElProt.Plan.GS1.X) and
                    (ComboBoxGS1.ItemIndex <> ComboBoxGS2.ItemIndex);
              if Ok then
                ElProt.WorkItems := ElProt.WorkItems + [I241]
              else
                ElProt.WorkItems := ElProt.WorkItems - [I241];
            end
          else
            Ok := GSOk(ComboBoxGS1.ItemIndex, ElProt.Plan.GS1.X) and
                  GSOk(ComboBoxGS1.ItemIndex, ElProt.Plan.GS2.X)
        else
          if Trim(ComboBoxGS2.Text) <> '' then
            Ok := GSOk(ComboBoxGS2.ItemIndex, ElProt.Plan.GS2.X) and
                  GSOk(ComboBoxGS2.ItemIndex, ElProt.Plan.GS1.X);
      if not Ok then
        MyMessageDlg('Ошибка', 'Генерирующее соотношение выбрано неверно.',
                     mtError, [mbOk]);
    end;
  GenSOk := Ok;
end;

procedure TFormPrepExp.ComboBoxGS1Change(Sender: TObject);
begin
  if GenSOk then
    ElProt.Plan.GS1.GS := IntToBazFunc(ComboBoxGS1.ItemIndex + 2);
  Draw4;
end;

procedure TFormPrepExp.ComboBoxGS2Change(Sender: TObject);
begin
  if GenSOk then
    ElProt.Plan.GS2.GS := IntToBazFunc(ComboBoxGS2.ItemIndex + 2);
  Draw4;
end;

procedure TFormPrepExp.EditStarStChange(Sender: TObject);
begin
  ElProt.Plan.Alfa := StrToReal(EditStarSt.Text);
end;

procedure TFormPrepExp.EditStarStExit(Sender: TObject);
var A: real;
begin
  A := Sqrt(Sqrt(Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn - 2) *
                 (Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn) +
                        2 * ElProt.Variant.KolFakt + 1)) -
            Step2(ElProt.Variant.KolFakt - ElProt.Plan.StDrobn - 1));
  if not CheckReal(ElProt.Plan.Alfa, A, 0.1) then
    MyMessageDlg('Ошибка', 'Вы не могли бы точнее вычислить звездное плечо?',
                     mtError, [mbOk]);
end;

procedure TFormPrepExp.Button6Click(Sender: TObject);
begin
  Panel14.Hide;
  Panel15.Hide;
end;

procedure TFormPrepExp.Button4Click(Sender: TObject);
begin
  if not DFEPrigoden then
    begin
      Rezult := MyMessageDlg('Ошибка', 'Построенный Вами эксперимент не позволит получить' +
                           ' раздельные оценки параметров заданной модели.' +
                           ' Вы настаиваете на проведении построенного эксперимента?',
                  mtError, [mbYes, mbNo]);
      if Rezult = mrYes then
        begin
          ElProt.WorkItems := ElProt.WorkItems + [I24, I242];
          if I23 in ElProt.WorkItems then
            begin
              ElProt.MItemsEn := ElProt.MItemsEn + [I3, I63];
              MyMessageDlg('', 'Вы закончили подготовку эксперимента' +
                   ' и можете приступить к его проведению.',
                   mtInformation, [mbOk]);
              FormPrepExp.Hide;
            end
          else
            FormPrepExp.Button6Click(Sender);
        end
      else
        begin
          ElProt.WorkItems := ElProt.WorkItems - [I24, I242];
          ElProt.MItemsEn := ElProt.MItemsEn - [I3, I63];
          FormPrepExp.Button6Click(Sender);
        end
    end
  else
    if I23 in ElProt.WorkItems then
      begin
        MyMessageDlg('Примите поздравления!', 'Вы закончили подготовку эксперимента' +
                     ' и можете приступить к его проведению.',
                     mtInformation, [mbOk]);
        ElProt.WorkItems := ElProt.WorkItems + [I24];
        ElProt.MItemsEn := ElProt.MItemsEn + [I3, I63];
        FormPrepExp.Hide;
      end
    else
      FormPrepExp.Button6Click(Sender);
  UpdateMenuAndButtons;
end;

procedure TFormPrepExp.Button5Click(Sender: TObject);
begin
  if DFEPrigoden then
    begin
      Rezult := MyMessageDlg('Ошибка', 'Построенный Вами эксперимент позволяет получить' +
                           ' раздельные оценки параметров заданной модели.' +
                           ' Будете проводить построенный эксперимент?',
                  mtError, [mbYes, mbNo]);
      if Rezult = mrYes then
        begin
          ElProt.WorkItems := ElProt.WorkItems + [I24];
          if I23 in ElProt.WorkItems then
            begin
              ElProt.MItemsEn := ElProt.MItemsEn + [I3, I63];
              FormPrepExp.Hide;
            end
          else
            FormPrepExp.Button6Click(Sender);
        end
      else
        begin
          ElProt.WorkItems := ElProt.WorkItems - [I24, I242];
          ElProt.MItemsEn := ElProt.MItemsEn - [I3, I63];
          FormPrepExp.Button6Click(Sender);
        end
    end
  else
    begin
      Rezult := MyMessageDlg('', 'Верно. Построенный эксперимент не позволит получить' +
                           ' раздельные оценки параметров заданной модели.' +
                           ' Будете проводить построенный эксперимент?',
                  mtConfirmation, [mbYes, mbNo]);
      if Rezult = mrYes then
        begin
          ElProt.WorkItems := ElProt.WorkItems + [I24, I242];
          if I23 in ElProt.WorkItems then
            begin
              ElProt.MItemsEn := ElProt.MItemsEn + [I3, I63];
              MyMessageDlg('', 'Вы закончили подготовку эксперимента' +
                  ' и можете приступить к его проведению.',
                   mtInformation, [mbOk]);
              FormPrepExp.Hide;
            end
          else
            FormPrepExp.Button6Click(Sender);
        end
      else
        begin
          ElProt.WorkItems := ElProt.WorkItems - [I24, I242];
          ElProt.MItemsEn := ElProt.MItemsEn - [I3, I63];
          FormPrepExp.Button6Click(Sender);
        end
    end;
  UpdateMenuAndButtons;
end;

end.
