unit MyType;

interface

uses
  SysUtils, VarType, MySystProc;

const
  NameP = 'Безымянный.pro';
  VarMsg = 'Вариант: ';
  ProtMsg = 'Протокол: ';

type
  myTMItems = (I11, I12, I2, I21, I22, I221, I23, I24, I241, I242, I3, I4, I41,
               I411, I412, I413, I414, I4141, I4142, I4143, I4144, I42, I421,
               I422, I423, I43, I431, I432, I44, I61, I63, I64, I65);
  myTSetItems = set of myTMItems;
  myTZadanie = record
                 Name: string[25];
                 Grupp: string[10];
                 FNVar: string[50];
                 NomVar: Word;
               end;
  MyTGS = record
            X: byte;
            GS: myTBazFunc;
          end;
  myTOOK = array [1..4] of myTBazFunc;        
  myTSPlan = array [1..5, 1..32] of ShortInt;
  myTNorm = array [1..5, 1..2] of real;
  myTPlan = record
              Norm: myTNorm;
              TypePlan: myTExper;
              StDrobn: byte;
              GS1, GS2: MyTGS;
              N, M: byte;
              Alfa: real;
              SPlan: myTSPlan;
            end;
  myTRezExperim = array [1..32, 1..6] of real;
  myTRezObrab = record
                  UrZnVospr, UrZnParam, UrZnAdecv: real;
                  KrZnV, KrZnP, KrZnA: real;
                end;
  myTProt = record
              Zadanie: myTZadanie;
              Variant: myTVariant;
              MItemsEn, WorkItems: myTSetItems;
              Plan: myTPlan;
              Experim: myTRezExperim;
              RezObrab: myTRezObrab;
            end;
  myTFVar = file of myTVariant;
  myTFProt = file of myTProt;
  myTTablKohr = array [0..6, 0..15] of real;
  myTFileKohr = file of myTTablKohr;
  myTTablStud = array [0..8, 0..29] of real;
  myTFileStud = file of myTTablStud;
  myTTablFish = array [0..18, 0..33] of real;
  myTFileFish = file of myTTablFish;

var
  FProt: myTFProt;
  ElProt: myTProt;
  ElZadanie: myTZadanie;
  NameProt: string[50];
  ShowedExp, rShow: boolean;

procedure IniPlan(var Plan: MyTPlan);
procedure IniExperim(var Experim: MyTRezExperim);
procedure Inicial;
procedure ProtSaveAs(FName: string);
procedure ProtOpen(FName: string);
procedure ChangeWorkItems(AddWI, SubstWI, AddMI, SubstMI: myTSetItems);

implementation

uses Main;

procedure IniPlan(var Plan: MyTPlan);
var I, J: byte;
begin
  with Plan do
    begin
      for I := 1 to 5 do
        for J := 1 to 2 do
          Norm[I, J] := 0;
      TypePlan := None;
      StDrobn := 0;
      GS1.X := 0;
      GS2.X := 0;
      GS1.GS := F0;
      GS2.GS := F0;
      M := 1;
      N := 0;
      Alfa := 0;
      for I := 1 to 5 do
        for J := 1 to 32 do
          SPlan[I, J] := - 100;
    end;
end;

procedure IniExperim(var Experim: MyTRezExperim);
var I, J: byte;
begin
  ElProt.MItemsEn := ElProt.MItemsEn - [I4..I44, I64, I65];
  ElProt.WorkItems := ElProt.WorkItems - [I4..I44];
  for I := 1 to 32 do
    for J := 1 to 6 do
      Experim[I, J] := 0;
  ElProt.RezObrab.UrZnAdecv := 0;
  ElProt.RezObrab.UrZnParam := 0;
  ElProt.RezObrab.UrZnVospr := 0;
  ElProt.RezObrab.KrZnA := 0;
  ElProt.RezObrab.KrZnP := 0;
  ElProt.RezObrab.KrZnV := 0;
end;

procedure Inicial;

  procedure IniProt;
  var I, J: byte;
  begin
    ShowedExp := false;
    NameProt := NameP;
    with ElProt do
      begin
        Zadanie.Name := '';
        Zadanie.Grupp := '';
        Zadanie.NomVar := 0;
        Zadanie.FNVar := '*.dat';
        Variant.KolFakt := 0;
        WorkItems := [];
        MItemsEn := [];
        for I := 1 to 5 do
          for J := 1 to 2 do
            Variant.OblPlan[I, J] := 0;
        IniPlan(Plan);
        IniExperim(Experim);
      end;
  end;

begin
  IniProt;
  MainForm.StatusBar.Panels[2].Text := ProtMsg + NameP;
  MainForm.StatusBar.Panels[1].Text := VarMsg + IntToStr(ElProt.Zadanie.NomVar);
end;

procedure ProtSaveAs(FName: string);
begin
  ElProt.MItemsEn := ElProt.MItemsEn - [I12];
  NameProt := FName;
  AssignFile(FProt, FName);
  Rewrite(FProt);
  Write(FProt, ElProt);
  CloseFile(FProt);
  MainForm.StatusBar.Panels[2].Text := ProtMsg + NameProt;
end;

procedure ProtOpen(FName: string);

begin
  ElProt.MItemsEn := ElProt.MItemsEn + [I11, I2, I21];
  NameProt := FName;
  AssignFile(FProt, FName);
  Reset(FProt);
  Read(FProt, ElProt);
  CloseFile(FProt);
  MainForm.StatusBar.Panels[2].Text := ProtMsg + NameProt;
  MainForm.StatusBar.Panels[1].Text := VarMsg + IntToStr(ElProt.Zadanie.NomVar);
end;

procedure ChangeWorkItems(AddWI, SubstWI, AddMI, SubstMI: myTSetItems);
begin
  ElProt.WorkItems := ElProt.WorkItems + AddWI;
  ElProt.MItemsEn := ElProt.MItemsEn + AddMI;
  ElProt.WorkItems := ElProt.WorkItems - SubstWI;
  ElProt.MItemsEn := ElProt.MItemsEn - SubstMI;
end;

end.
