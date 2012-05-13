unit My;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function RealToStr(R: real;
                   Len, Dec: byte): string;
function MyMessageDlg(Const Title, Msg: string;
                     AType: TMsgDlgType;
                     AButtons: TMsgDlgButtons): Word;
implementation

{$R *.DFM}

function RealToStr(R: real;
                   Len, Dec: byte): string;
var S: string[10];
begin
  Str(R: Len: Dec, S);
  RealToStr := S;
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
          end;
      ShowModal;
      MyMessageDlg := ModalResult;
    end;
end;

end.
