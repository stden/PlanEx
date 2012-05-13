unit Common1;

interface

uses
  MyType, VarType, mySystProc, SysUtils, Classes;

type
  TAVSp = ^TVSp;
  TAGSp = ^TGSp;
  TVSp = record
           N, LG: word;
           AGSp: TAGSp;
           AVSp: TAVSp;
         end;
  TGSp = record
           N: word;
           AGSp: TAGSp;
         end;

function TypeExpToStr(TypeExper: myTExper): string;
function BazFuncToStr(BF: myTBazFunc): string;
function IntToBazFunc(NumCell: byte): myTBazFunc;
function MakeOK(GenS: myTGS): myTBazFunc;
procedure MakeOOK(var OOK: myTOOK);
procedure MakeArr(var Beg: TAVSp;
                  NRow, NCol: word);
procedure DelArr(var Beg: TAVSp);
procedure RandomRC(var Beg: TAVSp;
                   var Row, Col, LenV: word);
function SPToStr(X, G: byte): string;
function Srednee(ArrStr: TStrings;
                 N: byte): real;
function Dispersia(ArrStr: TStrings;
                   N: byte): real;

implementation

function TypeExpToStr(TypeExper: myTExper): string;
begin
  case TypeExper of
    None: TypeExpToStr := '';
    PFE: TypeExpToStr := 'œ‘›';
    DFE: TypeExpToStr := 'ƒ‘›';
    OCKP: TypeExpToStr := 'Œ÷ œ';
    UCKP: TypeExpToStr := '”÷ œ';
    RCKP: TypeExpToStr := '–÷ œ';
  end;
end;

function BazFuncToStr(BF: myTBazFunc): string;
var I: byte;
    S: string[5];
begin
  S := '';
  if BF = F0 then
    S := '0'
  else
    if BF in [F1..F12345] then
      for I := 0 to ElProt.Variant.KolFakt - 1 do
        if EdRazr(Ord(BF), I) then
          S := S + IntToStr(I + 1)
        else
     else
       S := IntToStr(Ord(BF) - 31) + IntToStr(Ord(BF) - 31);
  BazFuncToStr := S;
end;

function IntToBazFunc(NumCell: byte): myTBazFunc;
begin
  IntToBazFunc := myTBazFunc(ArrBF[ElProt.Variant.KolFakt, NumCell]);
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

procedure MakeArr(var Beg: TAVSp;
                  NRow, NCol: word);
var
  TekV, BufV: TAVSp;
  TekG, BufG: TAGSp;
  I, J: word;
begin
  TekV := nil;
  TekG := nil;
  BufV := nil;
  BufG := nil;
  for I := 1 to NRow do
    begin
      New(TekV);
      if I = 1 then
        Beg := TekV
      else
        BufV^.AVSp := TekV;
      TekV^.N := I - 1;
      TekV^.LG := NCol;
      BufV := TekV;
      for J := 1 to NCol do
        begin
          New(TekG);
          if J = 1 then
            TekV^.AGSp := TekG
          else
            BufG^.AGSp := TekG;
          TekG^.N := J - 1;
          BufG := TekG;
        end;
      TekG^.AGSp := nil;
    end;
  TekV^.AVSp := nil;
end;

procedure DelArr(var Beg: TAVSp);
var Buf: TAVSp;

  procedure DelGSp(var Beg: TAGSp);
  var Buf: TAGSp;
  begin
    while Beg <> nil do
      begin
        Buf := Beg^.AGSp;
        Dispose(Beg);
        Beg := Buf;
      end;
  end;

begin
  while Beg <> nil do
    begin
      DelGSp(Beg^.AGSp);
      Buf := Beg^.AVSp;
      Dispose(Beg);
      Beg := Buf;
    end;
end;

procedure RandomRC(var Beg: TAVSp;
                   var Row, Col, LenV: word);
var
  VEl, VPred: TAVSp;
  GEl, GPred: TAGSp;
  NRow, NCol: word;

  function GetV(Beg: TAVSp;
                var Pred: TAVSp;
                N: word): TAVSp;
  var I: word;
  begin
    Pred := nil;
    I := 0;
    while I < N do
      begin
        Pred := Beg;
        Beg := Beg^.AVSp;
        Inc(I);
      end;
    GetV := Beg;
  end;

  function GetG(Beg: TAGSp;
                var Pred: TAGSp;
                N: word): TAGSp;
  var I: word;
  begin
    Pred := nil;
    I := 0;
    while I < N do
      begin
        Pred := Beg;
        Beg := Beg^.AGSp;
        Inc(I);
      end;
    GetG := Beg;
  end;

  procedure DelGEl(var VEl: TAVSp;
                   GEl, Pred: TAGSp);
  begin
    if Pred <> nil then
      Pred^.AGSp := GEl^.AGSp
    else
      VEl^.AGSp := GEl^.AGSp;
    Dec(VEl^.LG);
    Dispose(GEl);
  end;

  procedure DelVEl(VEl, Pred: TAVSp;
                   var LenV: word);
  begin
    if Pred <> nil then
      Pred^.AVSp := VEl^.AVSp;
    Dec(LenV);
    Dispose(VEl);
  end;

begin
  NRow := Random(LenV);
  VEl := GetV(Beg, VPred, NRow);
  Row := VEl^.N;
  NCol := {Random(VEl^.LG)} 0;
  GEl := GetG(VEl^.AGSp, GPred, NCol);
  Col := GEl^.N;
  DelGEl(VEl, GEl, GPred);
  if VEl^.LG = 0 then
    begin
      if NRow = 0 then
        Beg := VEl^.AVSp;
      DelVEl(VEl, VPred, LenV);
    end;
  if LenV = 0 then
    Beg := nil;
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

function Srednee(ArrStr: TStrings;
                 N: byte): real;
var I: byte;
    R: real;
begin
  R := 0;
  for I := 1 to N do
    R := R + StrToReal(ArrStr[I]);
  if Abs(R) < 0.000001 then
    Srednee := 0
  else
    Srednee := R / N;
end;

function Dispersia(ArrStr: TStrings;
                   N: byte): real;
var I: byte;
    R, Sred: real;
begin
  Sred := Srednee(ArrStr, N);
  R := 0;
  for I := 1 to N do
    R := R + Sqr(Abs(StrToReal(ArrStr[I])- Sred));
  if R < 0.000001 then
    Dispersia := 0
  else
    Dispersia := R / (N - 1);
end;


end.
