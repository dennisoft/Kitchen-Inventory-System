unit uChange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmChanges = class(TForm)
    Label2: TLabel;
    txtPass: TEdit;
    Label3: TLabel;
    txtRptPass: TEdit;
    txtUser: TLabel;
    txtAccount: TLabel;
    FDQueryUser: TFDQuery;
    Image2: TImage;
    Label1: TLabel;
    btnAdd: TBitBtn;
    btnCancel: TBitBtn;
    Label4: TLabel;
    txtOldPass: TEdit;
    FDQuerySave: TFDQuery;
    FDQueryCompare: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChanges: TfrmChanges;

implementation

{$R *.dfm}
uses uConn, uLogin;
procedure TfrmChanges.btnAddClick(Sender: TObject);
begin
  if (txtOldPass.Text = '') then
    begin
      Application.MessageBox('Please input your old password','Kitchen Information System',MB_ICONERROR);
    end
    else
      if (txtPass.Text = '') then
        begin
          Application.MessageBox('Please choose a new password','Kitchen Information System',MB_ICONERROR);
        end
        else
          if (txtRptPass.Text = '') then
            begin
              Application.MessageBox('Please repeat the chosen password','Kitchen Information System',MB_ICONERROR);
            end
            else
              begin
                FDQueryCompare.SQL.Clear;
                FDQueryCompare.SQL.Add('SELECT password FROM auth WHERE username=:Usrr');
                FDQueryCompare.ParamByName('Usrr').Value := frmLogin.txtUser.Text;
                FDQueryCompare.Open;

                if ((frmChanges.txtRptPass.Text = frmChanges.txtPass.Text) and (frmChanges.txtOldPass.Text = FDQueryCompare.FieldByName('password').Text)) then
                  begin
                    FDQuerySave.SQL.Clear;
                    FDQuerySave.SQL.Add('UPDATE auth SET password=:Pwd WHERE username=:Usr');
                    FDQuerySave.ParamByName('Pwd').Value := frmChanges.txtPass.Text;
                    FDQuerySave.ParamByName('Usr').Value := frmLogin.txtUser.Text;
                    FDQuerySave.ExecSQL;
                    Application.MessageBox('Password Changed!','Kitchen System',MB_ICONINFORMATION);
                  end
                  else
                    begin
                      Application.MessageBox('Passwords do not match!','Confirmation Error',MB_ICONERROR);
                    end;
              end;
end;

procedure TfrmChanges.btnCancelClick(Sender: TObject);
begin
  frmChanges.Close;
end;

procedure TfrmChanges.FormShow(Sender: TObject);
begin
 FDQueryUser.SQL.Clear;
    FDQueryUser.SQL.Add('SELECT * FROM auth' +
        ' WHERE username=:User AND password=:Pass');
    FDQueryUser.ParamByName('User').Value := frmLogin.txtUser.Text;
    FDQueryUser.ParamByName('Pass').Value := frmLogin.txtPass.Text;
    FDQueryUser.Open;
    frmChanges.txtUser.Caption := FDQueryUser.FieldByName('fname').Value + ' ' + FDQueryUser.FieldByName('lname').Value;
    frmChanges.txtAccount.Caption := FDQueryUser.FieldByName('account_type').Value + ' Account';
end;

end.
