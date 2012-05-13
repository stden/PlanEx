unit MySystProc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function Step2(I: byte): byte;
function EdRazr(I, R: byte): boolean;
procedure SetRazr(var I: byte;
                  NR: byte;
                  Zn: boolean);
function KolEdRazr(I: byte): byte;
function Cnm(n, m: byte): word;
function RealToStr(R: real;
                   Len, Dec: shortint): string;
function StrToReal(S: string): real;
function MyMessageDlg(Const Title, Msg: string;
                     AType: TMsgDlgType;
                     AButtons: TMsgDlgButtons): Word;
function CheckReal(Etalon, R, Err: real): boolean;

implementation

{$R *.DFM}

function Step2(I: byte): byte;
begin
  Step2 := 1 Shl I;
end;

procedure SetRazr(var I: byte;
                  NR: byte;
                  Zn: boolean);
begin
  if Zn then
    I := I or (1 shl NR)
  else
    I := I and (not (1 shl NR));
end;

function EdRazr(I, R: byte): boolean;
begin
  EdRazr := I and (1 Shl R) > 0;
end;

function KolEdRazr(I: byte): byte;
var N, S: byte;
begin
  S := 0;
  for N := 0 to 5 do
    if EdRazr(I, N) then
      Inc(S);
  KolEdRazr := S;
end;

function Cnm(n, m: byte): word;
begin
  if m = 0 then
    Cnm := 1
  else
    Cnm := Round(Cnm(n, m - 1) * (n - m + 1) / m);
end;

function RealToStr(R: real;
                   Len, Dec: shortint): string;
var S: string[40];
begin
  if Abs(R) >= 10 then
    Dec := 1;
  if Abs(R) < 10 then
    Dec := 2;
  if Abs(R) < 0.1 then
    Dec := 3;
  if Abs(R) < 0.01 then
    Dec := 4;
  if Abs(R) < 0.001 then
    Dec := 5;
  if Abs(R) < 0.0001 then
    Dec := 6;
  if Abs(R) = 0 then
    Dec := 2;
  Str(R: Len: Dec, S);
  RealToStr := S;
end;

function StrToReal(S: string): real;
var Code: integer;
    R: real;
begin
  StrToReal := 0;
  if (Trim(S) <> '') and (S[Length(S)] <> '.') then
    begin
      Val(Trim(S), R, Code);
      if code <> 0 then
        MyMessageDlg('Ошибка', 'Ошибка при вводе вещественной величины', mtError,
                     [mbOk])
      else
        StrToReal := R;
    end;    
end;

function MyMessageDlg(Const Title, Msg: string;
                     AType: TMsgDlgType;
                     AButtons: TMsgDlgButtons): Word;
var I: byte;
    Form: TForm;
begin
  Form := CreateMessageDialog(Msg, AType, AButtons);
  with Form do
    begin
      Caption := Title;
      for I := 0 to ComponentCount - 1 do
        if Components[I] is TButton then
          begin
            if TButton(Components[I]).Caption = '&Yes' then
              TButton(Components[I]).Caption := 'Да';
            if TButton(Components[I]).Caption = '&No' then
              TButton(Components[I]).Caption := 'Нет';
            if TButton(Components[I]).Caption = 'Cancel' then
              TButton(Components[I]).Caption := 'Отменить';
            if TButton(Components[I]).Caption = 'OK' then
              TButton(Components[I]).Caption := 'Дальше';
          end;
      ShowModal;
      MyMessageDlg := ModalResult;
    end;
end;

function CheckReal(Etalon, R, Err: real): boolean;
begin
  CheckReal := (Abs(R) >= Abs(Etalon) * (1 - Err)) and
               (Abs(R) <= Abs(Etalon) * (1 + Err));
end;

end.
