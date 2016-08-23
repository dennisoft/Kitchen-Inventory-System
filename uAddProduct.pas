unit uAddProduct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.DBCtrls;

type
  TfrmAddProduct = class(TForm)
    DBGridProduct: TDBGrid;
    btnAdd: TBitBtn;
    btnCancel: TBitBtn;
    FDQueryShow: TFDQuery;
    DataSource1: TDataSource;
    Label4: TLabel;
    LinkLabel6: TLinkLabel;
    LinkLabel2: TLinkLabel;
    Image1: TImage;
    Label2: TLabel;
    txtID: TDBLookupComboBox;
    Label1: TLabel;
    DataSourceCat: TDataSource;
    FDQueryProduct: TFDQuery;
    DataSourceProduct: TDataSource;
    FDQueryCategory: TFDQuery;
    LinkLabel1: TLinkLabel;
    btnAddCat: TBitBtn;
    FDQueryCatt: TFDQuery;
    txtProduct: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnAddCatClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddProduct: TfrmAddProduct;

implementation

{$R *.dfm}
uses uConn;
procedure TfrmAddProduct.btnAddCatClick(Sender: TObject);
var adv :String;
begin
  adv := InputBox('Product Category', 'Input the new Product Category:', '');
  if adv = '' then
    begin
      Application.MessageBox('Category update terminated','Kitchen Inventory System',MB_ICONINFORMATION);
    end
    else
      begin
        FDQueryCatt.SQL.Clear;
        FDQueryCatt.SQL.Add('Insert into product_category(category_name) values (:ADV)');
        FDQueryCatt.ParamByName('ADV').Value := adv;
        FDQueryCatt.ExecSQL;
        Application.MessageBox('New product category added successfully!','Kitchen System',MB_ICONINFORMATION);
      end;
end;

procedure TfrmAddProduct.btnAddClick(Sender: TObject);
begin
  if (txtID.Text = '') then
    begin
      Application.MessageBox('Please input the Product ID','Kitchen Information System',MB_ICONERROR);
    end
    else
      if (txtProduct.Text = '') then
        begin
          Application.MessageBox('Please input the Product Name','Kitchen Information System',MB_ICONERROR);
        end
        else
          begin
            FDQueryShow.SQL.Clear;
            FDQueryShow.SQL.Add('INSERT into stock_products (category_name, product_name) Values (:ID, :NME)');
            FDQueryShow.ParamByName('ID').Value := txtID.Text;
            FDQueryShow.ParamByName('NME').Value := txtProduct.Text;
            FDQueryShow.ExecSQL;
            Application.MessageBox('Product Added successfully!','Kitchen System',MB_ICONINFORMATION);
            FormShow(Sender);
          end;
end;

procedure TfrmAddProduct.btnCancelClick(Sender: TObject);
begin
  frmAddProduct.Close;
end;

procedure TfrmAddProduct.FormActivate(Sender: TObject);
begin
  FDQueryCategory.Open;
end;

procedure TfrmAddProduct.FormShow(Sender: TObject);
begin
   FDQueryShow.SQL.Clear;
   FDQueryShow.SQL.Add('Select * from stock_products');
   FDQueryShow.Open;
   FDQueryShow.Active := true;

   DBGridProduct.Columns[0].FieldName := 'category_name';
   DBGridProduct.Columns[1].FieldName := 'product_name';
   DBGridProduct.DataSource := DataSource1;
   ShowScrollBar(DBGridProduct.Handle,SB_VERT,FALSE);
end;

end.
