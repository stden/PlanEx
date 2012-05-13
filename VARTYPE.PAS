unit VarType;

interface

type
  myTExper = (None, PFE, DFE, OCKP, RCKP, UCKP);
  myTArrOblPlan = array [1..5, 1..2] of real;
  myTBazFunc = (F0, F1, F2, F12, F3, F13, F23, F123, F4, F14, F24, F124,
                F34, F134, F234, F1234, F5, F15, F25, F125, F35, F135,
                F235, F1235, F45, F145, F245, F1245, F345, F1345, F2345,
                F12345, F11, F22, F33, F44, F55);
  myTParamObj = array [myTBazFunc] of real;
  myTSetBazFunc = set of myTBazFunc;
  myTVariant = record
                 KolFakt: byte;
                 OblPlan: myTArrOblPlan;
                 TypeExper: MyTExper;
                 P: byte;
                 Obj: myTParamObj;
                 Model: myTSetBazFunc;
               end;
  myTFVar = file of myTVariant;
  myTArrBF = array [2..5, 1..37] of byte;

  const
    ArrBF: myTArrBF = (( 0, 1, 2, 3,32,33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0),
                       ( 0, 1, 2, 4, 3, 5, 6, 7,32,33,34, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0),
                       ( 0, 1, 2, 4, 8, 3, 5, 6, 9,10,12, 7,11,13,14,15,
                        32,33,34,35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0),
                       ( 0, 1, 2, 4, 8,16, 3, 5, 6, 9,10,12,17,18,20,24,
                         7,11,13,14,19,21,22,25,26,28,15,23,27,29,30,31,
                         32,33,34,35,36));
var
  ElVariant, BufVariant, ClipVar: myTVariant;
  FVar, BufFVar: myTFVar;
  Change: boolean;

implementation

end.
