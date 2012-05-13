unit ShowPlan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls;

type
  TFormPlan = class(TForm)
    Panel2: TPanel;
    Panel9: TPanel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel10: TPanel;
    Label6: TLabel;
    Bevel2: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Panel5: TPanel;
    Panel11: TPanel;
    Label7: TLabel;
    Bevel3: TBevel;
    StringGrid1: TStringGrid;
    Panel7: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Panel12: TPanel;
    Label8: TLabel;
    Bevel4: TBevel;
    StringGrid2: TStringGrid;
    Button2: TButton;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Panel14: TPanel;
    Panel15: TPanel;
    Bevel5: TBevel;
    Memo1: TMemo;
    Label24: TLabel;
    Bevel6: TBevel;
    Label25: TLabel;
    Button1: TButton;
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
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
    procedure StringGrid2SelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
    procedure StringGrid2DrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPlan: TFormPlan;

implementation

{$R *.DFM}

uses
  MyType, VarDan, Common1, MySystProc, VarType;

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
  with FormPlan do
    begin
      Pos(Panel2, Panel1.Top, Panel1.Left, NP = 1);
      Pos(Panel3, Panel4.Top, Panel4.Left, NP = 2);
      Pos(Panel5, Panel6.Top, Panel6.Left, NP = 3);
      Pos(Panel7, Panel8.Top, Panel8.Left, NP = 4);
    end;
end;

procedure TFormPlan.Panel2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(1);
end;

procedure TFormPlan.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(0);
end;

procedure TFormPlan.Panel3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(2);
end;

procedure TFormPlan.Panel5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(3);
end;

procedure TFormPlan.Panel7MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  PanelsPos(4);
end;

procedure Draw1;
begin
  with FormPlan do
    begin
      Label4.Caption := 'n = ' + IntToStr(ElProt.Variant.KolFakt);
      Label5.Caption := StrBazFunc(ElProt.Variant);
    end;
end;

procedure Draw2;
begin
  with FormPlan do
    begin
      Label12.Caption := TypeExpToStr(ElProt.Plan.TypePlan);
      Label13.Caption := IntToStr(ElProt.Plan.StDrobn);
      Label14.Caption  := IntToStr(ElProt.Plan.N);
    end;
end;

procedure MakeStrGr1;
var I, J: byte;
begin
  with FormPlan.StringGrid1 do
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
  SGHeight = 310;
var I, J: byte;
begin
  with FormPlan.StringGrid2 do
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
      Left := (FormPlan.Panel12.Width - Width) div 2;
      Top := (FormPlan.Panel12.Height - Height) div 2 + 10;
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

procedure DrawBottom;
var I: byte;
    S: string[20];
begin
  with FormPlan do
    begin
      Label20.Caption := IntToStr(ElProt.Plan.M);
      Label16.Visible := (ElProt.Plan.TypePlan = DFE) or
                          ((ElProt.Plan.TypePlan = OCKP) and
                           (ElProt.Variant.KolFakt = 5));
      Button2.Visible := Label16.Visible;
      I := 0;
      SetRazr(I, ElProt.Plan.GS1.X - 1, true);
      if ElProt.Plan.StDrobn = 2 then
        SetRazr(I, ElProt.Plan.GS2.X - 1, true);
      S := BazFuncToStr(myTBazFunc(I));
      if ElProt.Plan.StDrobn = 2 then
        Insert(', ', S, 2);
      Label21.Caption := S;
      Label21.Visible := Label16.Visible;
      Label17.Caption := 'Генерирующее соотношение  Х' +
                           IntToStr(ElProt.Plan.GS1.X) + '  =';
      Label17.Visible := Label16.Visible;
      S := BazFuncToStr(ElProt.Plan.GS1.GS);
      I := 1;
      while I <= Length(S) do
        begin
          Insert(' X', S, I);
          Inc(I, 3);
        end;
      Label22.Caption := S;
      Label22.Visible := Label17.Visible;
      if ElProt.Plan.StDrobn = 2 then
        Label18.Caption := 'Генерирующее соотношение  Х' +
                           IntToStr(ElProt.Plan.GS2.X) + '  =';
      Label18.Visible := ElProt.Plan.StDrobn = 2;
      Label19.Visible := ElProt.Plan.TypePlan = OCKP;
      if Label18.Visible then
        begin
          S := BazFuncToStr(ElProt.Plan.GS2.GS);
          I := 1;
          while I <= Length(S) do
            begin
              Insert(' X', S, I);
              Inc(I, 3);
            end;
          Label23.Caption := S;
        end;
      if Label19.Visible then
        Label23.Caption := RealToStr(ElProt.Plan.Alfa, 5, 3);
      Label23.Visible := Label18.Visible or Label19.Visible;
    end;
end;

procedure TFormPlan.FormActivate(Sender: TObject);
begin
  Draw1;
  Draw2;
  MakeStrGr1;
  DrawStrGr2;
  DrawBottom;
end;

procedure TFormPlan.StringGrid1DrawCell(Sender: TObject; Col, Row: Longint;
  Rect: TRect; State: TGridDrawState);
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

procedure TFormPlan.StringGrid1SelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
begin
  CanSelect := false;
end;

procedure TFormPlan.StringGrid2SelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
begin
  CanSelect := false;
end;

procedure TFormPlan.StringGrid2DrawCell(Sender: TObject; Col, Row: Longint;
  Rect: TRect; State: TGridDrawState);
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
        end;
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
  with FormPlan do
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

procedure TFormPlan.Button2Click(Sender: TObject);
begin
  Panel14.Show;
  Panel15.Show;
  SetMemo1;
  if DFEPrigoden then
    Label25.Caption := 'Эксперимент пригоден для получения раздельных оценок ' +
                       'параметров модели'
  else
    Label25.Caption := 'Раздельные оценоки параметров модели получить нельзя';
end;

procedure TFormPlan.Button1Click(Sender: TObject);
begin
  Panel14.Hide;
  Panel15.Hide;
end;

end.
