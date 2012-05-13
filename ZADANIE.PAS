unit Zadanie;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, MyType, MySystProc, VarType, Buttons, Mask,
  ToolEdit, RXSpin;

type
  TFormZadanie = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditName: TEdit;
    EditGrupp: TEdit;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    FilenameEdit1: TFilenameEdit;
    RxSpinEdit1: TRxSpinEdit;
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EditNomVarClick(Sender: TObject);
    procedure FilenameEdit1AfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormZadanie: TFormZadanie;

implementation

{$R *.DFM}

uses Main, VarDan;

var New: boolean;

procedure TFormZadanie.FormActivate(Sender: TObject);
begin
  ElZadanie := ElProt.Zadanie;
  EditName.Text := ElZadanie.Name;
  EditGrupp.Text := ElZadanie.Grupp;
  RxSpinEdit1.MaxValue := 0;
  RxSpinEdit1.MinValue := 0;
  RxSpinEdit1.Value := 0;
  RxSpinEdit1.Enabled := false;
  FileNameEdit1.Text := '*.dat';
end;

procedure TFormZadanie.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormZadanie.Button1Click(Sender: TObject);

  procedure CheckNameAndGrupp;
  begin
    if (CompareText(ElZadanie.Name, ElProt.Zadanie.Name) <> 0) or
       (CompareText(ElZadanie.Grupp, ElProt.Zadanie.Grupp) <> 0) then
      begin
        ElProt.MItemsEn := ElProt.MItemsEn + [I11, I12];
        ElProt.Zadanie := ElZadanie;
        Close;
      end
    else
      Close;
  end;

  procedure NewWork;
  begin
    Inicial;
    ElProt.MItemsEn := ElProt.MItemsEn + [I11, I12, I21, I22, I23];
    ElProt.Zadanie := ElZadanie;
    AssignFile(FVar, ElZadanie.FNVar);
    Reset(FVar);
    Seek(FVar, ElZadanie.NomVar - 1);
    Read(FVar, ElProt.Variant);
    CloseFile(FVar);
    New := true;
    Close;
  end;

begin
  ElZadanie.Name := EditName.Text;
  ElZadanie.Grupp := EditGrupp.Text;
  ElZadanie.FNVar := FileNameEdit1.Text;
  ElZadanie.NomVar := Round(RxSpinEdit1.Value);
  if RxSpinEdit1.MaxValue = 0 then
    begin
      MyMessageDlg('Предупреждение', 'Вы не выбрали вариант задания.',
                 mtWarning, [mbOk]);
      Exit;
    end;
  if (ElZadanie.NomVar = 0) or (ElZadanie.NomVar > RxSpinEdit1.MaxValue) then
    MyMessageDlg('Предупреждение',
                 'Допустимый номер варианта от 1 до ' +
                 IntToStr(Round(RxSpinEdit1.MaxValue)) + '.',
                 mtWarning, [mbOk])
  else
    if ElProt.Zadanie.NomVar <> 0 then
      if ElZadanie.NomVar = ElProt.Zadanie.NomVar then
        CheckNameAndGrupp
      else
        case MyMessageDlg('Предупреждение', 'При изменении варианта эксперимент' +
                          ' придется начинать заново. Согласны?', mtConfirmation,
                          mbYesNoCancel)of
          mrYes:
            if I12 in ElProt.MItemsEn then
              case MyMessageDlg('Сохранение данных',
                                'Сохранить имеющиеся данные?',
                                mtConfirmation, mbYesNoCancel) of
                mrYes:
                  begin
                    MainForm.FileSaveItemClick(Sender);
                    NewWork;
                  end;
                mrNo: NewWork;
                mrCancel: Close;
              end
            else
              NewWork;
          mrNo: CheckNameAndGrupp;
          mrCancel: Close;
        end
    else
      NewWork;
end;

procedure TFormZadanie.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MainForm.StatusBar.Panels[1].Text := VarMsg + IntToStr(ElProt.Zadanie.NomVar);
  if (ElProt.Zadanie.NomVar <> 0) and New then
    begin
      ElProt.MItemsEn := ElProt.MItemsEn + [I2];
      FormDanVar.Show;
    end;
end;

procedure TFormZadanie.FormCreate(Sender: TObject);
begin
  ElZadanie.FNVar := '*.dat';
  New := false;
end;

function ReadMaxKolVar: word;
begin
  AssignFile(FVar, ElZadanie.FNVar);
  Reset(FVar);
  ReadMaxKolVar := FileSize(FVar);
  CloseFile(FVar);
end;

procedure TFormZadanie.EditNomVarClick(Sender: TObject);
begin
  ElZadanie.FNVar := FileNameEdit1.Text;
  if (Pos('*', ElZadanie.FNVar) = 0) and FileExists(ElZadanie.FNVar) then
    begin
      RxSpinEdit1.MaxValue := ReadMaxKolVar;
      RxSpinEdit1.MinValue := 1;
      RxSpinEdit1.Enabled := true;
      RxSpinEdit1.Value := 1;
    end
  else
    begin
      MyMessageDlg('Предупреждение', 'Файл вариантов ' + ElZadanie.FNVar +
                   ' не найден.', mtInformation, [mbOk]);
      FileNameEdit1.SetFocus;
    end;
end;

procedure TFormZadanie.FilenameEdit1AfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
  if Action then
    begin
      ElZadanie.FNVar := Name;
      RxSpinEdit1.MaxValue := ReadMaxKolVar;
      RxSpinEdit1.MinValue := 1;
      RxSpinEdit1.Value := 1;
      RxSpinEdit1.Enabled := true;
    end;

end;

end.
