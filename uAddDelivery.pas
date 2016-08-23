unit uAddDelivery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.DBCtrls;

type
  TfrmAddDelivery = class(TForm)
    DBGridDelivery: TDBGrid;
    FDQueryShow: TFDQuery;
    DataSource1: TDataSource;
    DataSourceGrid: TDataSource;
    FDQueryGrid: TFDQuery;
    DBGridProduct: TDBGrid;
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    txtPrice: TEdit;
    Label4: TLabel;
    txtQt: TEdit;
    btnAdd: TBitBtn;
    txtDOD: TDateTimePicker;
    FDQueryAdd: TFDQuery;
    Image1: TImage;
    Label1: TLabel;
    LinkLabel6: TLinkLabel;
    LinkLabel2: TLinkLabel;
    FDQueryChange: TFDQuery;
    txtID: TDBLookupComboBox;
    DataSourceCat: TDataSource;
    FDQueryCategory: TFDQuery;
    FDQueryPr: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure FDQueryGridUpdateRecord(ASender: TDataSet;
      ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
      AOptions: TFDUpdateRowOptions);
    procedure btnAddClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddDelivery: TfrmAddDelivery;

implementation

{$R *.dfm}

uses uUpdateStock;

procedure TfrmAddDelivery.btnAddClick(Sender: TObject);
var cost, newStock, stock, total: Integer;
var Add: String;
var dtAdd: TDateTime;
begin
if (txtID.Text = '') then
  begin
    Application.MessageBox('Please input the Product ID','Kitchen Information System',MB_ICONERROR);
  end
    else
      if (txtDOD.ToString  = '') then
        begin
          Application.MessageBox('Please choose the date of delivery','Kitchen Information System',MB_ICONERROR);
        end
        else
          if (txtQt.Text = '') then
          begin
            Application.MessageBox('Please input the Quantity','Kitchen Information System',MB_ICONERROR);
          end
          else
            if (txtPrice.Text = '') then
            begin
              Application.MessageBox('Please input the Unit Price','Kitchen Information System',MB_ICONERROR);
            end
              else
                begin
                  dtAdd := txtDOD.DateTime;
                  DateTimeToString(Add,'yyyy-MM-dd',dtAdd);

                  FDQueryPr.SQL.Clear;
                  FDQueryPr.SQL.Add('SELECT category_name from stock_products WHERE product_name =:PD');
                  FDQueryPr.ParamByName('PD').Value := frmAddDelivery.txtID.Text;
                  FDQueryPr.Open;

                  FDQueryAdd.SQL.Clear;
                  FDQueryAdd.SQL.Add('INSERT INTO stock(category_name, product_name, date_of_delivery, quantity_delivered, price_per_unit, cost) VALUES (:CAT, :ID, :DT, :QT, :PR, :CS)');
                  FDQueryAdd.ParamByName('CAT').Value := FDQueryPr.FieldByName('category_name').Value;
                  FDQueryAdd.ParamByName('ID').Value := frmAddDelivery.txtID.Text;
                  FDQueryAdd.ParamByName('DT').Value := Add;
                  FDQueryAdd.ParamByName('QT').Value := frmAddDelivery.txtQt.Text;
                  FDQueryAdd.ParamByName('PR').Value := frmAddDelivery.txtPrice.Text;
                  cost := (StrToInt(txtQt.Text)) * (StrToInt(txtPrice.Text));
                  FDQueryAdd.ParamByName('CS').Value := IntToStr(cost);
                  FDQueryAdd.ExecSQL;

                  stock := StrToInt(FDQueryShow.FieldByName('quantity_in_stock').Text);
                  newStock := StrToInt(frmAddDelivery.txtQt.Text);
                  total := stock + newStock;

                  FDQueryChange.SQL.Clear;
                  FDQueryChange.SQL.Add('UPDATE stock_products SET quantity_in_stock =:ST WHERE product_name =:PD AND category_name =:CAT');
                  FDQueryChange.ParamByName('PD').Value := frmAddDelivery.txtID.Text;
                  FDQueryChange.ParamByName('CAT').Value := FDQueryPr.FieldByName('category_name').Value;
                  FDQueryChange.ParamByName('ST').Value := IntToStr(total);
                  FDQueryChange.ExecSQL;

                  Application.MessageBox('Record added successfully','Kitchen Information System',MB_ICONINFORMATION);

                  ShowScrollBar(DBGridDelivery.Handle,SB_VERT,FALSE);
                  FormShow(Sender);
                end;
end;

procedure TfrmAddDelivery.FDQueryGridUpdateRecord(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  FDQueryGrid.FieldByName('cost').Value :=  FDQueryGrid.FieldByName('quantity_delivered').Value * FDQueryGrid.FieldByName('price_per_unit').Value;
  FDQueryGrid.UpdateRecord;
  ShowScrollBar(DBGridDelivery.Handle,SB_VERT,FALSE);
end;

procedure TfrmAddDelivery.FormActivate(Sender: TObject);
begin
  FDQueryCategory.Open;
end;

procedure TfrmAddDelivery.FormShow(Sender: TObject);
begin
   FDQueryShow.SQL.Clear;
   FDQueryShow.SQL.Add('Select * from stock_products');
   FDQueryShow.Open;
   FDQueryShow.Active := true;

   DBGridProduct.Columns[0].FieldName := 'product_name';
   DBGridProduct.Columns[1].FieldName := 'category_name';
   DBGridProduct.DataSource := DataSource1;
   ShowScrollBar(DBGridProduct.Handle,SB_VERT,FALSE);

   FDQueryGrid.SQL.Clear;
    FDQueryGrid.SQL.Add('SELECT * FROM stock');
    FDQueryGrid.Open;

    DatasourceGrid.DataSet := FDQueryGrid;
    DBGridDelivery.DataSource := DatasourceGrid;

    DBGridDelivery.Columns[0].FieldName := 'product_name';
    DBGridDelivery.Columns[1].FieldName := 'category_name';
    DBGridDelivery.Columns[2].FieldName := 'date_of_delivery';
    DBGridDelivery.Columns[3].FieldName := 'quantity_delivered';
    DBGridDelivery.Columns[4].FieldName := 'price_per_unit';
    DBGridDelivery.Columns[5].FieldName := 'cost';

    ShowScrollBar(DBGridDelivery.Handle,SB_VERT,FALSE);
end;

end.
