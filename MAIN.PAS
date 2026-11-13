unit Main;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, MyType,
  MyReadStr, RXSpin, RXCtrls, RXClock;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    Utilits: TMenuItem;
    Calculator: TMenuItem;
    SpeedPanel: TPanel;
    OpenBtn: TSpeedButton;
    SaveBtn: TSpeedButton;
    ExitBtn: TSpeedButton;
    StatusBar: TStatusBar;
    PodgotExp: TMenuItem;
    Experiment: TMenuItem;
    Obrabotka: TMenuItem;
    Manual: TMenuItem;
    AboutWork: TMenuItem;
    N4: TMenuItem;
    PlanInf: TMenuItem;
    ExperInf: TMenuItem;
    RezultInf: TMenuItem;
    CalcBtn: TSpeedButton;
    SaveDialog1: TSaveDialog;
    ZadanieInf: TMenuItem;
    ManualButton1: TSpeedButton;
    PopupMenu1: TPopupMenu;
    PopUp1_Save: TMenuItem;
    PopUp1_SaveAs: TMenuItem;
    PopUp1_Open: TMenuItem;
    PopUp1_New: TMenuItem;
    N3: TMenuItem;
    PopUp1_Help: TMenuItem;
    PopUp1_Calc: TMenuItem;
    AboutButton: TSpeedButton;
    RxClock1: TRxClock;
    Panel1: TPanel;
    RxLabel1: TRxLabel;
    RxSpinEdit1: TRxSpinEdit;
    RxSpinEdit2: TRxSpinEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FileNewItemClick(Sender: TObject);
    procedure UpdateMenuItems(Sender: TObject);
    procedure FileCloseItemClick(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure FileSaveItemClick(Sender: TObject);
    procedure FileSaveAsItemClick(Sender: TObject);
    procedure CalculatorClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VariantClick(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure HelpAboutItemClick(Sender: TObject);
    procedure ManualButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZadanieInfClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PodgotExpClick(Sender: TObject);
    procedure PlanInfClick(Sender: TObject);
    procedure ExperimentClick(Sender: TObject);
    procedure RxClock1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RxClock1Alarm(Sender: TObject);
    procedure ExperInfClick(Sender: TObject);
    procedure ObrabotkaClick(Sender: TObject);
    procedure RezultInfClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure ShowHint(Sender: TObject);
    procedure ExitWork(Sender: TObject;
                       MsgStr: string;
                       var Rezult: word);
public
    { Public declarations }
  end;
procedure UpdateMenuAndButtons;

var
  MainForm: TMainForm;
  Rezult: word;

implementation

{$R *.DFM}

uses About, Zadanie, VarDan, MySystProc, PrepExp, ShowPlan, Experim, ShowExperim,
  Obrabotka;

procedure UpdateMenuAndButtons;
begin
  with MainForm do
    begin
      FileCloseItem.Enabled := I11 in ElProt.MItemsEn;
      FileSaveItem.Enabled := I12 in ElProt.MItemsEn;
      FileSaveAsItem.Enabled := I11 in ElProt.MItemsEn;
      SaveBtn.Enabled := I12 in ElProt.MItemsEn;
      PodgotExp.Enabled := I2 in ElProt.MItemsEn;
{      GipotAdecv.Enabled := I432 in ElProt.MItemsEn;}
      AboutWork.Enabled := I61 in ElProt.MItemsEn;
{      Adekvatnost.Enabled := I43 in ElProt.MItemsEn;}
{      DispAdecv.Enabled := I431 in ElProt.MItemsEn;}
{      Dispers.Enabled := I412 in ElProt.MItemsEn;}
      ExperInf.Enabled := I64 in ElProt.MItemsEn;
{      Korrection.Enabled := I423 in ElProt.MItemsEn;}
{      Model.Enabled := I42 in ElProt.MItemsEn;}
{      Noise.Enabled := I413 in ElProt.MItemsEn;}
{      Parametr.Enabled := I421 in ElProt.MItemsEn;}
      PlanInf.Enabled := I63 in ElProt.MItemsEn;
      RezultInf.Enabled := I65 in ElProt.MItemsEn;
{      Sravnenie.Enabled := I44 in ElProt.MItemsEn;}
{      Srednee.Enabled := I411 in ElProt.MItemsEn;}
{      Vosproizv.Enabled := I41 in ElProt.MItemsEn;}
      ZadanieInf.Enabled := I21 in ElProt.MItemsEn;
{      Znachimost.Enabled := I422 in ElProt.MItemsEn;}
{      GipVospr.Enabled := I414 in ElProt.MItemsEn;}
      Experiment.Enabled := I3 in ElProt.MItemsEn;
      Obrabotka.Enabled := I4 in ElProt.MItemsEn;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Inicial; {In MyType}
  Application.OnHint := ShowHint;
  Screen.OnActiveFormChange := UpdateMenuItems;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure HideForms;
begin
  FormPrepExp.Hide;
  FormExperim.Hide;
  FormPlan.Hide;
  FormShowExperim.Hide;
  FormObrabotka.Hide;
end;

procedure TMainForm.FileNewItemClick(Sender: TObject);
begin
  FileCloseItemClick(Sender);
  if Rezult <> mrCancel then
    begin
      FormZadanie.Show;
      UpdateMenuItems(Sender);
      StatusBar.Panels[1].Text := VarMsg + IntToStr(ElProt.Zadanie.NomVar);
    end;
end;

procedure TMainForm.FileOpenItemClick(Sender: TObject);
begin
  Rezult := mrYes;
  ExitWork(Sender, 'Открытие другого протокола', Rezult);
  if Rezult in [mrYes, mrNo] then
    begin
      Inicial;
      HideForms;
    end;
  if (Rezult <> mrCancel) and OpenDialog.Execute then
    ProtOpen(OpenDialog.FileName);
  UpdateMenuAndButtons;
end;

procedure TMainForm.FileCloseItemClick(Sender: TObject);
begin
  Rezult := mrYes;
  ExitWork(Sender, 'Закрытие сеанса работы', Rezult);
  if Rezult <> mrCancel then
    begin
      Inicial;
      HideForms;
    end;
  UpdateMenuAndButtons;
end;

procedure TMainForm.FileSaveItemClick(Sender: TObject);
begin
  if NameProt <> NameP then
    ProtSaveAs(NameProt) {In MyType}
  else
    FileSaveAsItemClick(Sender);
  UpdateMenuItems(Sender);
end;

procedure TMainForm.FileSaveAsItemClick(Sender: TObject);
begin
  SaveDialog1.FileName := NameProt;
  if SaveDialog1.Execute then
    ProtSaveAs(SaveDialog1.FileName); {In MyType}
  UpdateMenuItems(Sender);
end;

procedure TMainForm.ExitWork(Sender: TObject;
                             MsgStr: string;
                             var Rezult: word);
begin
  Rezult := mrYes;
  Application.HelpCommand(HELP_QUIT, 0);
  if I12 in ElProt.MItemsEn then
    begin
      Rezult := MyMessageDlg(MsgStr, 'Сохранить имеющиеся данные?', mtConfirmation,
                    mbYesNoCancel);
      if Rezult = mrYes then
        FileSaveItemClick(Sender);
    end;
end;

procedure TMainForm.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.CalculatorClick(Sender: TObject);
begin
  WinExec('CALC.EXE', SW_SHOWNORMAL);
end;

procedure TMainForm.UpdateMenuItems(Sender: TObject);
begin
  UpdateMenuAndButtons;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
end;

procedure TMainForm.VariantClick(Sender: TObject);
begin
  FormDanVar.Show;
end;

procedure TMainForm.HelpAboutItemClick(Sender: TObject);
begin
  Application.HelpFile := 'ABOUT.HLP';
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TMainForm.ManualButton1Click(Sender: TObject);
begin
  Application.HelpFile := 'PLAN.HLP';
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ExitWork(Sender, 'Окончание работы', Rezult);
  if Rezult = mrCancel then
    Action := caNone
  else
    Action := caFree;
end;

procedure TMainForm.ZadanieInfClick(Sender: TObject);
begin
  VariantClick(Sender);
end;

procedure TMainForm.PopupMenu1Popup(Sender: TObject);
begin
  PopUp1_Save.Enabled := I12 in ElProt.MItemsEn;
  PopUp1_SaveAs.Enabled := I11 in ElProt.MItemsEn;
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.PodgotExpClick(Sender: TObject);
begin
  Rezult := mrYes;
  if I3 in ElProt.WorkItems then
    Rezult := MyMessageDlg('Предупреждение', 'Если Вы измените план, ' +
                   'то эксперимент и обработку его результатов придется ваполнять заново. ' +
                   'Согласны?', mtConfirmation, [mbYes, mbNo]);
  if Rezult = mrYes then
    FormPrepExp.Show;
end;

procedure TMainForm.PlanInfClick(Sender: TObject);
begin
  FormPlan.Show;
end;

procedure TMainForm.ExperimentClick(Sender: TObject);
begin
  Rezult := mrYes;
  if I3 in ElProt.WorkItems then
      Rezult := MyMessageDlg('Предупреждение', 'Вы уже провели эксперимент. ' +
                   'Проведение нового эксперимента потребует начать заново ' +
                   'обработку его результатов. Будете начинать новый эксперимент?',
                   mtConfirmation, [mbYes, mbNo]);
  if Rezult = mrYes then
    FormExperim.Show;
end;

procedure TMainForm.RxClock1Click(Sender: TObject);
var H, M, W: word;
begin
  DecodeTime(Time, H, M, W, W);
  RxSpinEdit1.Value := H;
  RxSpinEdit2.Value := M;
  Panel1.Show;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  RxClock1.AlarmHour := Round(RxSpinEdit1.Value);
  RxClock1.AlarmMinute := Round(RxSpinEdit2.Value);
  RxClock1.Color := clFuchsia;
  RxClock1.AlarmEnabled := true;
  RxClock1.Refresh;
  Panel1.Hide;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  RxClock1.Color := clLime;
  RxClock1.AlarmEnabled := false;
  RxClock1.Refresh;
  Panel1.Hide;
end;

procedure TMainForm.RxClock1Alarm(Sender: TObject);
begin
  Button2Click(Sender);
  MyMessageDlg('Будильник', 'Указанное Вами время истекло.',
                   mtError, [mbOk]);
end;

procedure TMainForm.ExperInfClick(Sender: TObject);
begin
  FormShowExperim.Show;
end;

procedure TMainForm.ObrabotkaClick(Sender: TObject);
begin
  rShow := false;
  FormObrabotka.Show;
end;

procedure TMainForm.RezultInfClick(Sender: TObject);
begin
  rShow := true;
  FormObrabotka.Show;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  UpdateMenuItems(Sender);
end;

end.
