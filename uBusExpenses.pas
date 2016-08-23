unit uBusExpenses;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmBusExpenses = class(TForm)
    Label4: TLabel;
    Image5: TImage;
    LinkLabel6: TLinkLabel;
    btnCancel: TBitBtn;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtAm: TEdit;
    txtDOD: TDateTimePicker;
    btnSave: TBitBtn;
    txtCat: TComboBox;
    FDQuerySave: TFDQuery;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBusExpenses: TfrmBusExpenses;

implementation

{$R *.dfm}
uses uConn;
procedure TfrmBusExpenses.btnSaveClick(Sender: TObject);
var Add: String;
var dtAdd: TDateTime;
begin
  dtAdd := txtDOD.DateTime;
  DateTimeToString(Add,'yyyy-MM-dd',dtAdd);

  FDQuerySave.SQL.Clear;
  FDQuerySave.SQL.Add('INSERT INTO bus_expenses (category, amount, _date) VALUES(:CAT, :AMT, :DT)');
  FDQuerySave.ParamByName('CAT').Value := frmBusExpenses.txtCat.Text;
  FDQuerySave.ParamByName('AMT').Value := frmBusExpenses.txtAm.Text;
  FDQuerySave.ParamByName('DT').Value := Add;
  FDQuerySave.ExecSQL;

  if FDQuerySave.RowsAffected > 0 then
  begin
    Application.MessageBox('Record added successfully','Kitchen Information System',MB_ICONINFORMATION);
  end;
end;

procedure TfrmBusExpenses.btnCancelClick(Sender: TObject);
begin
  frmBusExpenses.Close;
end;

end.
