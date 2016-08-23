unit uBusHire;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmBusHire = class(TForm)
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
    FDQuerySave: TFDQuery;
    txtDesc: TMemo;
    txtCustomer: TEdit;
    Label2: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBusHire: TfrmBusHire;

implementation

{$R *.dfm}

procedure TfrmBusHire.btnCancelClick(Sender: TObject);
begin
  frmBusHire.Close;
end;

procedure TfrmBusHire.btnSaveClick(Sender: TObject);
var Add: String;
var dtAdd: TDateTime;
begin
  dtAdd := txtDOD.DateTime;
  DateTimeToString(Add,'yyyy-MM-dd',dtAdd);

  FDQuerySave.SQL.Clear;
  FDQuerySave.SQL.Add('INSERT INTO bus_hire (customer, amount, _date, description) VALUES(:CAT, :AMT, :DT, :DESC)');
  FDQuerySave.ParamByName('CAT').Value := frmBusHire.txtCustomer.Text;
  FDQuerySave.ParamByName('AMT').Value := frmBusHire.txtAm.Text;
  FDQuerySave.ParamByName('DT').Value := Add;
  FDQuerySave.ParamByName('DESC').Value := frmBusHire.txtDesc.Text;
  FDQuerySave.ExecSQL;

  if FDQuerySave.RowsAffected > 0 then
  begin
    Application.MessageBox('Record added successfully','Kitchen Information System',MB_ICONINFORMATION);
  end;
end;

end.
