unit uClassList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Buttons, frxClass, frxDBSet;

type
  TfrmClassList = class(TForm)
    btnGenerate: TBitBtn;
    Label4: TLabel;
    txtClass: TComboBoxEx;
    LinkLabel6: TLinkLabel;
    FDQueryClass: TFDQuery;
    frxDBDatasetList: TfrxDBDataset;
    frxReport1: TfrxReport;
    LinkLabel1: TLinkLabel;
    procedure btnGenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClassList: TfrmClassList;

implementation

{$R *.dfm}
uses uConn;
procedure TfrmClassList.btnGenerateClick(Sender: TObject);
begin
  if (txtClass.Text = '') then
    begin
      Application.MessageBox('Please select a class.','Kitchen Information System',MB_ICONERROR);
    end
    else
      begin
        FDQueryClass.SQL.Clear;
        FDQueryClass.SQL.Add('Select * from register where current_class =:CLS');
        FDQueryClass.ParamByName('CLS').Value := frmClassList.txtClass.Text;
        FDQueryClass.Open;
        frxDBDatasetList.DataSet := FDQueryClass;

        if (FDQueryClass.RowsAffected = 0) then
        begin
          Application.MessageBox('There are no students in this class.','Kitchen Inventory System',MB_ICONWARNING);
        end
        else
          begin
            frxReport1.ShowReport;
          end;
      end;
end;

end.
