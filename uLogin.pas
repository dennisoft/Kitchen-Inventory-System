unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Imaging.GIFImg;

type
  TfrmLogin = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    btnLogin: TBitBtn;
    FDQueryLogin: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Image3: TImage;
    btnCancel: TBitBtn;
    txtPass: TEdit;
    txtUser: TEdit;
    LinkLabel2: TLinkLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
implementation

{$R *.dfm}
uses uMenu, uConn;
procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var checkNull:Boolean;
var checkNullPass:Boolean;
var checkNullUser:Boolean;
begin
  checkNull := false;
  checkNullPass := false;
  checkNullUser := false;
  try
  if connSQL.FDConnection1.Connected then
    begin
      FDQueryLogin.SQL.Clear;
      FDQueryLogin.SQL.Add('SELECT * FROM auth' +
          ' WHERE username=:User AND password=:Pass');
      FDQueryLogin.ParamByName('User').Value := frmLogin.txtUser.Text;
      FDQueryLogin.ParamByName('Pass').Value := frmLogin.txtPass.Text;
      FDQueryLogin.Open;

      if txtUser.Text='' then
        begin
           checkNull:=true;
           checkNullUser:=true;
        end;

      if txtPass.Text='' then
        begin
         checkNull:=true;
         checkNullPass:=true;
        end;

      if ((checkNullUser=true) and (checkNullPass=false)) then
      begin
        Application.MessageBox('Error! Username Required!','Student Information System',MB_ICONERROR);
        txtPass.Clear;
      end
      else
        if ((checkNullPass=true) and (checkNullUser=false))then
        begin
           Application.MessageBox('Error! Password Required!','Student Information System',MB_ICONERROR);
        end
        else
          if ((checkNullPass=true) and (checkNullUser=true))then
          begin
            Application.MessageBox('Both Username and Password Required!','Student Information System',MB_ICONERROR);
          end
          else
            if (FDQueryLogin.RecordCount = 1) then
              begin
                frmLogin.Hide;
                frmMenu.Show;
              end
              else
                if ((FDQueryLogin.RecordCount = 0) and (checkNull = false)) then
                  begin
                    Application.MessageBox('Warning! This User does not Exist!','Student Information System',MB_ICONWARNING);
                    txtPass.Clear;
                    txtUser.Clear;
                  end;
    end;
  except
     Application.MessageBox('Database Error! The Database may be empty or non-complete '+#13#10+'Please contact System Administrator for Help.','Student Information System',MB_ICONERROR);
  end;

end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  FDQueryLogin.Connection := connSQL.FDConnection1;
end;

end.
