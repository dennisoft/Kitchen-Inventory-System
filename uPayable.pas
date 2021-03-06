unit uPayable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmPayable = class(TForm)
    DBGridPayable: TDBGrid;
    FDQueryShow: TFDQuery;
    DataSource1: TDataSource;
    btnAdd: TBitBtn;
    btnCancel: TBitBtn;
    FDQuerySave: TFDQuery;
    LinkLabel6: TLinkLabel;
    Label4: TLabel;
    Image1: TImage;
    LinkLabel2: TLinkLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtPayable: TEdit;
    txtCategory: TComboBoxEx;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPayable: TfrmPayable;

implementation

{$R *.dfm}

procedure TfrmPayable.btnAddClick(Sender: TObject);
begin
  if (txtPayable.Text = '') then
    begin
      Application.MessageBox('Please input the amount payable','Kitchen Information System',MB_ICONERROR);
    end
      else
        if (txtCategory.Text = '') then
          begin
            Application.MessageBox('Please input the category whose amount you want to change','Kitchen Information System',MB_ICONERROR);
          end
            else
              begin
                FDQuerySave.SQL.Clear;
                FDQuerySave.SQL.Add('UPDATE payable SET category =:Cat, amount_payable =:Amt WHERE category =:Cat');
                FDQuerySave.ParamByName('Amt').Value := frmPayable.txtPayable.Text;
                FDQuerySave.ParamByName('Cat').Value := frmPayable.txtCategory.Text;
                FDQuerySave.ExecSQL;
                Application.MessageBox('Record Updated successfully!','Kitchen System',MB_ICONINFORMATION);
                FormShow(Sender);
              end;
end;

procedure TfrmPayable.btnCancelClick(Sender: TObject);
begin
  frmPayable.Close;
end;

procedure TfrmPayable.FormShow(Sender: TObject);
begin
   FDQueryShow.SQL.Clear;
   FDQueryShow.SQL.Add('Select * from payable');
   FDQueryShow.Open;
   FDQueryShow.Active := true;

   DBGridPayable.Columns[0].FieldName := 'category';
   DBGridPayable.Columns[1].FieldName := 'amount_payable';
   DBGridPayable.DataSource := DataSource1;
   ShowScrollBar(DBGridPayable.Handle,SB_VERT,FALSE);
end;

end.
