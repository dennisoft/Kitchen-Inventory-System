unit uReports;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmReports = class(TForm)
    btnInventory: TBitBtn;
    btnBalances: TBitBtn;
    btnTotal: TBitBtn;
    btnStudentList: TBitBtn;
    btnPayments: TBitBtn;
    Image1: TImage;
    Label4: TLabel;
    LinkLabel2: TLinkLabel;
    FDQueryBal: TFDQuery;
    frxReportBalance: TfrxReport;
    frxDBDataBalance: TfrxDBDataset;
    FDQueryInv: TFDQuery;
    frxReportInv: TfrxReport;
    frxDBDatasetInv: TfrxDBDataset;
    btnDeductions: TBitBtn;
    btnExit: TBitBtn;
    procedure btnStudentListClick(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);
    procedure btnBalancesClick(Sender: TObject);
    procedure btnTotalClick(Sender: TObject);
    procedure btnInventoryClick(Sender: TObject);
    procedure btnDeductionsClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReports: TfrmReports;

implementation

{$R *.dfm}
uses uClassList, uConn, uTotal, uPaymentReport, uDeductions;
procedure TfrmReports.btnBalancesClick(Sender: TObject);
begin
  FDQueryBal.SQL.Clear;
  FDQueryBal.SQL.Add('SELECT balance.`adm_no`, balance.`bal`, CONCAT(register.`sname`,'' '',register.`fname`,'' '',register.`lname`) AS `full_name`'+
    'FROM balance JOIN register ON balance.`adm_no` = register.`adm_no` WHERE bal > 0');
  FDQueryBal.Open;
  frxDBDataBalance.DataSet := FDQueryBal;
  if (FDQueryBal.RowsAffected = 0) then
  begin
    Application.MessageBox('This report has no data to display','Kitchen Inventory System',MB_ICONWARNING);
  end
  else
    begin
      frxReportBalance.ShowReport;
    end;
end;

procedure TfrmReports.btnDeductionsClick(Sender: TObject);
begin
  frmDeduct.ShowModal;
end;

procedure TfrmReports.btnExitClick(Sender: TObject);
begin
  frmReports.Close;
end;

procedure TfrmReports.btnInventoryClick(Sender: TObject);
begin
  FDQueryinv.SQL.Clear;
  FDQueryInv.SQL.Add('SELECT stock_products.`product_name`, stock.`product_id`,stock.`date_of_delivery`,stock.`quantity_delivered`,stock.`price_per_unit`,stock.`cost`'+
    'FROM stock JOIN stock_products ON stock.`product_id` = stock_products.`product_id`');
  FDQueryInv.Open;
  frxDBDatasetInv.DataSet := FDQueryInv;
  if (FDQueryInv.RowsAffected = 0) then
  begin
    Application.MessageBox('This report has no data to display','Kitchen Inventory System',MB_ICONWARNING);
  end
  else
    begin
      frxReportInv.ShowReport;
    end;
end;

procedure TfrmReports.btnPaymentsClick(Sender: TObject);
begin
  frmPayments.ShowModal;
end;

procedure TfrmReports.btnStudentListClick(Sender: TObject);
begin
  frmClassList.ShowModal;
end;

procedure TfrmReports.btnTotalClick(Sender: TObject);
begin
  frmTotal.showModal;
end;

end.
