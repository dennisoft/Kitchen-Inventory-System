unit uAddUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmAddUser = class(TForm)
    lblUser: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    txtFName: TEdit;
    txtUser: TEdit;
    txtLName: TEdit;
    txtAccount: TComboBoxEx;
    txtPass: TEdit;
    Label3: TLabel;
    txtRptPass: TEdit;
    btnAdd: TBitBtn;
    btnCancel: TBitBtn;
    FDQuerySave: TFDQuery;
    Image1: TImage;
    Label5: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddUser: TfrmAddUser;

implementation

{$R *.dfm}
uses uConn;
procedure TfrmAddUser.btnAddClick(Sender: TObject);
begin
  if (txtFName.Text = '') then
  begin
    Application.MessageBox('Please input the first name','Kitchen Information System',MB_ICONERROR);
  end
  else
    if (txtLname.Text = '') then
    begin
      Application.MessageBox('Please input the last name','Kitchen Information System',MB_ICONERROR);
    end
    else
      if (txtUser.Text = '') then
        begin
          Application.MessageBox('Please input the Username','Kitchen Information System',MB_ICONERROR);
        end
          else
          if (txtPass.Text = '') then
            begin
              Application.MessageBox('Please input the Password','Kitchen Information System',MB_ICONERROR);
            end
          else
            if (txtRptPass.Text = '') then
              begin
                Application.MessageBox('Please repeat the password','Kitchen Information System',MB_ICONERROR);
              end
              else
                if (txtAccount.Text = '') then
                  begin
                    Application.MessageBox('Please choose the account type','Kitchen Information System',MB_ICONERROR);
                  end
                  else
                    begin
                      if txtRptPass.Text = txtPass.Text then
                        begin
                          FDQuerySave.SQL.Clear;
                          FDQuerySave.SQL.Add('INSERT INTO auth (fname, lname, username, password, account_type) VALUES (:FNme, :LNme, :Usr, :Pwd, :Act)');
                          FDQuerySave.ParamByName('FNme').Value := frmAddUser.txtFName.Text;
                          FDQuerySave.ParamByName('LNme').Value := frmAddUser.txtLName.Text;
                          FDQuerySave.ParamByName('Usr').Value := frmAddUser.txtUser.Text;
                          FDQuerySave.ParamByName('Pwd').Value := frmAddUser.txtPass.Text;
                          FDQuerySave.ParamByName('Act').Value := frmAddUser.txtAccount.Text;
                          FDQuerySave.ExecSQL;
                          Application.MessageBox('User added successfully!','Kitchen System',MB_ICONINFORMATION);
                        end
                      else
                        begin
                          Application.MessageBox('Passwords do not match!','Confirmation Error',MB_ICONERROR);
                        end;
                    end;
end;

procedure TfrmAddUser.btnCancelClick(Sender: TObject);
begin
  frmAddUser.Close;
end;

end.
