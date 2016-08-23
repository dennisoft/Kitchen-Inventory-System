unit uUpdateStock;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TfrmUpdate = class(TForm)
    DBGridProduct: TDBGrid;
    DataSourceProduct: TDataSource;
    FDQueryShow: TFDQuery;
    Image1: TImage;
    Label4: TLabel;
    LinkLabel6: TLinkLabel;
    LinkLabel2: TLinkLabel;
    Label5: TLabel;
    btnChange: TBitBtn;
    btnCancel: TBitBtn;
    txtDeduct: TEdit;
    FDQueryChange: TFDQuery;
    FDQueryAdd: TFDQuery;
    FDQueryNew: TFDQuery;
    FDQueryCheck: TFDQuery;
    FDQueryCategory: TFDQuery;
    DataSourceCat: TDataSource;
    txtID: TDBLookupComboBox;
    txtProduct: TDBLookupComboBox;
    FDQueryProduct: TFDQuery;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure txtProductEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

implementation

{$R *.dfm}

procedure TfrmUpdate.btnCancelClick(Sender: TObject);
begin
  frmUpdate.Close;
end;

procedure TfrmUpdate.btnChangeClick(Sender: TObject);
var stock, deduct, value :Integer;
var Add: String;
var dtAdd: TDateTime;
begin
if (txtDeduct.Text  = '') then
  begin
    Application.MessageBox('Please input the quantity to deduct','Kitchen Information System',MB_ICONERROR);
  end
    else
      if (txtID.Text  = '') then
      begin
        Application.MessageBox('Please input the category of the product to deduct','Kitchen Information System',MB_ICONERROR);
      end
        else
          begin
            FDQueryCheck.SQL.Clear;
            FDQueryCheck.SQL.Add('SELECT * FROM stock_products WHERE product_name =:PDS AND category_name =:CAT');
            FDQueryCheck.ParamByName('CAT').Value := frmUpdate.txtID.Text;
            FDQueryCheck.ParamByName('PDS').Value := frmUpdate.txtProduct.Text;
            FDQueryCheck.Open;

            if (FDQueryCheck.RowsAffected = 0) then
            begin
              Application.MessageBox('This product does not exist.'+#13#10+'Please counter check the category ID.','Kitchen Information System',MB_ICONERROR);
            end
              else
                begin
                  FDQueryNew.SQL.Clear;
                  FDQueryNew.SQL.Add('SELECT quantity_in_stock FROM stock_products WHERE product_name =:PDS AND category_name =:CAT');
                  FDQueryNew.ParamByName('PDS').Value := frmUpdate.txtProduct.Text;
                  FDQueryNew.ParamByName('CAT').Value := frmUpdate.txtID.Text;
                  FDQueryNew.Open;

                  stock := StrToInt(FDQueryNew.FieldByName('quantity_in_stock').Text);
                  deduct := StrToInt(frmUpdate.txtDeduct.Text);
                  value := stock - deduct;
                  dtAdd := System.SysUtils.Date;
                  DateTimeToString(Add,'yyyy-MM-dd',dtAdd);

                  if (FDQueryNew.FieldByName('quantity_in_stock').Value < deduct) then
                  begin
                    Application.MessageBox('The amount in stock is less than the amount you want to deduct.'+#13#10+'Please use a lower value.','Kitchen Information System',MB_ICONERROR);
                  end
                    else
                      begin
                          FDQueryChange.SQL.Clear;
                          FDQueryChange.SQL.Add('UPDATE stock_products SET quantity_in_stock =:ST WHERE product_name =:PD AND category_name =:CAT');
                          FDQueryChange.ParamByName('PD').Value := frmUpdate.txtProduct.Text;
                          FDQueryChange.ParamByName('CAT').Value := frmUpdate.txtID.Text;
                          FDQueryChange.ParamByName('ST').Value := IntToStr(value);
                          FDQueryChange.ExecSQL;

                          FDQueryAdd.SQL.Clear;
                          FDQueryAdd.SQL.Add('INSERT into deduct(category_name, product_name, quantity_deducted, _date) VALUES (:CAT, :PDA, :QT, :DT)');
                          FDQueryAdd.ParamByName('PDA').Value := frmUpdate.txtProduct.Text;
                          FDQueryAdd.ParamByName('CAT').Value := frmUpdate.txtID.Text;
                          FDQueryAdd.ParamByName('QT').Value := frmUpdate.txtDeduct.Text;
                          FDQueryAdd.ParamByName('DT').Value := Add;
                          FDQueryAdd.ExecSQL;

                          Application.MessageBox('Changes successful','Kitchen Information System',MB_ICONINFORMATION);
                          FormShow(Sender);
                      end;
                end;
          end;
end;

procedure TfrmUpdate.txtProductEnter(Sender: TObject);
begin
  FDQueryProduct.SQL.Clear;
  FDQueryProduct.SQL.Add('SELECT product_name from stock_products WHERE category_name =:CAT');
  FDQueryProduct.ParamByName('CAT').Value := txtID.Text;
  FDQueryProduct.Open;
end;

procedure TfrmUpdate.FormActivate(Sender: TObject);
begin
  FDQueryCategory.Open;
end;

procedure TfrmUpdate.FormShow(Sender: TObject);
begin
  FDQueryShow.SQL.Clear;
  FDQueryCategory.Open;
  FDQueryCategory.Active := true;
   FDQueryShow.SQL.Add('Select * from stock_products');
   FDQueryShow.Open;
   FDQueryShow.Active := true;

   DBGridProduct.Columns[0].FieldName := 'category_name';
   DBGridProduct.Columns[1].FieldName := 'product_name';
   DBGridProduct.Columns[2].FieldName := 'quantity_in_stock';
   DBGridProduct.DataSource := DataSource1;
   ShowScrollBar(DBGridProduct.Handle,SB_VERT,FALSE);
end;

end.
