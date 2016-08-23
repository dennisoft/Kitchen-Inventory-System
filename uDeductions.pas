unit uDeductions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, frxClass, frxDBSet,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmDeduct = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnGenerate: TBitBtn;
    LinkLabel6: TLinkLabel;
    LinkLabel1: TLinkLabel;
    txtDOB: TDateTimePicker;
    txtDOE: TDateTimePicker;
    FDQueryClass: TFDQuery;
    frxDBDatasetList: TfrxDBDataset;
    frxReport1: TfrxReport;
    FDQueryName: TFDQuery;
    frxDBDatasetName: TfrxDBDataset;
    procedure btnGenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDeduct: TfrmDeduct;

implementation

{$R *.dfm}

procedure TfrmDeduct.btnGenerateClick(Sender: TObject);
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
            FDQueryClass.SQL.Add('SELECT stock_products.`product_id`, stock_products.`product_name`, deduct.`quantity_deducted`, deduct.`_date`' +
                    ' FROM stock_products JOIN deduct ON stock_products.`product_id` = deduct.`product_id`' +
                    ' WHERE deduct.`_date` BETWEEN :BEG and :END');
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
