program Mdiapp;

uses
  Forms,
  Main in 'MAIN.PAS' {MainForm},
  Zadanie in 'Zadanie.pas' {FormZadanie},
  VarDan in 'VarDan.pas' {FormDanVar},
  MyType in 'MyType.pas',
  MySystProc in 'MySystProc.pas' {Form1},
  VarType in 'VarType.pas',
  About in 'About.pas' {AboutBox},
  PrepExp in 'PrepExp.pas' {FormPrepExp},
  ShowPlan in 'ShowPlan.pas' {FormPlan},
  Common1 in 'Common1.pas',
  Experim in 'Experim.pas' {FormExperim},
  ShowExperim in 'ShowExperim.pas' {FormShowExperim},
  Obrabotka in 'Obrabotka.pas' {FormObrabotka};

{$R *.RES}

begin
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormZadanie, FormZadanie);
  Application.CreateForm(TFormDanVar, FormDanVar);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TFormPrepExp, FormPrepExp);
  Application.CreateForm(TFormPlan, FormPlan);
  Application.CreateForm(TFormExperim, FormExperim);
  Application.CreateForm(TFormShowExperim, FormShowExperim);
  Application.CreateForm(TFormObrabotka, FormObrabotka);
  Application.Run;
end.
