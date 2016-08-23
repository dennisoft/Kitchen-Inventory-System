unit uPaymentReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls,
  Vcl.ComCtrls, frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmPayments = class(TForm)
    btnGenerate: TBitBtn;
    LinkLabel6: TLinkLabel;
    FDQueryClass: TFDQuery;
    frxDBDatasetList: TfrxDBDataset;
    frxReport1: TfrxReport;
    LinkLabel1: TLinkLabel;
    txtDOB: TDateTimePicker;
    Label1: TLabel;
    txtDOE: TDateTimePicker;
    Label2: TLabel;
    FDQueryName: TFDQuery;
    frxDBDatasetName: TfrxDBDataset;
    procedure btnGenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPayments: TfrmPayments;

implementation

{$R *.dfm}
uses uConn;
procedure TfrmPayments.btnGenerateClick(Sender: TObject);
var Beg, Endd: String;
var dtBeg, dtEnd: TDateTime;
begin
  if (txtDOB.ToString = '') then
  begin
    Application.MessageBox('Please input the Beginning Date','Kitchen Information System',MB_ICONERROR);
  end
    else
      if (txtDOE.ToString  = '') then
      begin
        Application.MessageBox('Please input the Ending Date','Kitchen Information System',MB_ICONERROR);
      end
        else
          begin
            dtBeg := txtDOB.DateTime;
            DateTimeToString(Beg,'yyyy-MM-dd',dtBeg);
            dtEnd := txtDOE.DateTime;
            DateTimeToString(Endd,'yyyy-MM-dd',dtEnd);

            FDQueryClass.SQL.Clear;
            FDQueryClass.SQL.Add('SELECT payment.`adm_no`, payment.`amount_paid`, payment.`receipt_no`, payment.`date_of_pay`, CONCAT(register.`sname`,'' '',register.`fname`,'' '',register.`lname`) AS `full_name`' +
                    ' FROM payment JOIN register ON payment.`adm_no` = register.`adm_no`' +
                    ' WHERE payment.`date_of_pay` BETWEEN :BEG and :END');
            FDQueryClass.ParamByName('BEG').Value := Beg;
            FDQueryClass.ParamByName('END').Value := Endd;
            FDQueryClass.Open;
            frxDBDatasetList.DataSet := FDQueryClass;

            if (FDQueryClass.RowsAffected = 0) then
            begin
              Application.MessageBox('This report has no data to display','Kitchen Inventory System',MB_ICONWARNING);
            end
            else
              begin
                frxReport1.ShowReport;
              end;
          end;
end;

end.
