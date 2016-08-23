unit uMove;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TfrmMove = class(TForm)
    Label4: TLabel;
    LinkLabel6: TLinkLabel;
    btnMove: TBitBtn;
    LinkLabel1: TLinkLabel;
    FDQueryMove: TFDQuery;
    FDQueryGo: TFDQuery;
    FDQueryClass: TFDQuery;
    procedure btnMoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMove: TfrmMove;

implementation

{$R *.dfm}
uses uConn;
procedure TfrmMove.btnMoveClick(Sender: TObject);
var term, _class :String;
var _year, ID :Integer;
begin
  if (Application.MessageBox('Are you sure that you want to move students?','Kitchen Information System  ',MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = IDYES) then
  begin
    FDQueryMove.SQL.Clear;
    FDQueryMove.SQL.Add('SELECT adm_no, current_term, current_year, current_class FROM register');
    FDQueryMove.Open;

    if (FDQueryMove.FieldByName('current_term').Value = 1) then
    begin
      term := '2';
      FDQueryGo.SQL.Clear;
      FDQueryGo.SQL.Add('UPDATE register SET current_term =:TR WHERE adm_no =:ADM');
      FDQueryGo.ParamByName('TR').Value := term;
      FDQueryGo.ParamByName('ADM').Value := FDQueryMove.FieldByName('adm_no').Value;
      FDQueryGo.ExecSQL;
    end
    else
      if (FDQueryMove.FieldByName('current_term').Value = 2) then
      begin
        term := '3';
        FDQueryGo.SQL.Clear;
        FDQueryGo.SQL.Add('UPDATE register SET current_term =:TR WHERE adm_no =:ADM');
        FDQueryGo.ParamByName('TR').Value := term;
        FDQueryGo.ParamByName('ADM').Value := FDQueryMove.FieldByName('adm_no').Value;
        FDQueryGo.ExecSQL;
      end
      else
        if (FDQueryMove.FieldByName('current_term').Value = 3) then
        begin
          term := '1';
          _year := (FDQueryMove.FieldByName('current_year').Value + 1);
          FDQueryClass.SQL.Clear;
          FDQueryClass.SQL.Add('SELECT class_id from classes where class = :CLS');
          FDQueryClass.ParamByName('CLS').Value := FDQueryMove.FieldByName('current_class').Value;
          FDQueryClass.Open;

          ID := FDQueryClass.FieldByName('class_id').Value + 1;

          FDQueryClass.SQL.Clear;
          FDQueryClass.SQL.Add('SELECT class from classes where class_id = :CL');
          FDQueryClass.ParamByName('CL').Value := ID;
          FDQueryClass.Open;

          _class := FDQueryClass.FieldByName('class').Text;

          FDQueryGo.SQL.Clear;
          FDQueryGo.SQL.Add('UPDATE register SET current_term =:TR, current_year =:YR, current_class =:CL WHERE adm_no =:ADM');
          FDQueryGo.ParamByName('TR').Value := term;
          FDQueryGo.ParamByName('YR').Value := _year;
          FDQueryGo.ParamByName('CL').Value := _class;
          FDQueryGo.ParamByName('ADM').Value := FDQueryMove.FieldByName('adm_no').Value;
          FDQueryGo.ExecSQL;
        end;

        while (FDQueryMove.FindNext) do
        begin
          if (FDQueryMove.FieldByName('current_term').Value = 1) then
          begin
            term := '2';
            FDQueryGo.SQL.Clear;
            FDQueryGo.SQL.Add('UPDATE register SET current_term =:TR WHERE adm_no =:ADM');
            FDQueryGo.ParamByName('TR').Value := term;
            FDQueryGo.ParamByName('ADM').Value := FDQueryMove.FieldByName('adm_no').Value;
            FDQueryGo.ExecSQL;
          end
          else
            if (FDQueryMove.FieldByName('current_term').Value = 2) then
            begin
              term := '3';
              FDQueryGo.SQL.Clear;
              FDQueryGo.SQL.Add('UPDATE register SET current_term =:TR WHERE adm_no =:ADM');
              FDQueryGo.ParamByName('TR').Value := term;
              FDQueryGo.ParamByName('ADM').Value := FDQueryMove.FieldByName('adm_no').Value;
              FDQueryGo.ExecSQL;
            end
            else
              if (FDQueryMove.FieldByName('current_term').Value = 3) then
              begin
                term := '1';
                _year := (FDQueryMove.FieldByName('current_year').Value + 1);
                FDQueryClass.SQL.Clear;
                FDQueryClass.SQL.Add('SELECT class_id from classes where class = :CLS');
                FDQueryClass.ParamByName('CLS').Value := FDQueryMove.FieldByName('current_class').Value;
                FDQueryClass.Open;

                ID := FDQueryClass.FieldByName('class_id').Value + 1;

                FDQueryClass.SQL.Clear;
                FDQueryClass.SQL.Add('SELECT class from classes where class_id = :CL');
                FDQueryClass.ParamByName('CL').Value := ID;
                FDQueryClass.Open;

                _class := FDQueryClass.FieldByName('class').Text;

                FDQueryGo.SQL.Clear;
                FDQueryGo.SQL.Add('UPDATE register SET current_term =:TR, current_year =:YR, current_class =:CL WHERE adm_no =:ADM');
                FDQueryGo.ParamByName('TR').Value := term;
                FDQueryGo.ParamByName('YR').Value := _year;
                FDQueryGo.ParamByName('CL').Value := _class;
                FDQueryGo.ParamByName('ADM').Value := FDQueryMove.FieldByName('adm_no').Value;
                FDQueryGo.ExecSQL;
              end;
        end;
    end;
end;

end.
