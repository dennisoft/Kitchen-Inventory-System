unit uConn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Dialogs, Data.FMTBcd, Data.DB, Data.SqlExpr, Vcl.forms,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef;

type
  TConnSQL = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConnSQL: TConnSQL;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
uses uLogin;
procedure TConnSQL.DataModuleCreate(Sender: TObject);
var Adv: String;
var Pas: String;
begin
   with FDConnection1.Params do
   begin
     Clear;
     Add('Server=localhost');
     Add('Database=kitchen');
     Add('User_Name=root');
     Add('Password=root');
     Add('DriverID=MySQL');
   end;
   try
     FDConnection1.Connected := true;
     Application.ProcessMessages;
     //showMessage('Connection Successful!');
   except
     Application.MessageBox('Database initialization failed! Please press the OK '+#13#10+'button to manually modify connection parameters.','Kitchen System',MB_ICONERROR);
     //showMessage('ConnectionFailed!');
     repeat
      adv := InputBox('Remote Database Connection', 'MySQL Server IP Adress:', '');
     until adv <> '';
     repeat
      pas := InputBox('Remote Database Connection', 'Root Account Password:', '');
     until pas <> '';
     with connSQL.FDConnection1.Params do begin
      Clear;
         Add('Server='+adv);
         Add('Database=student_system');
         Add('User_Name=root');
         Add('Password='+pas);
         Add('DriverID=MySQL');
     end;
     try
       connSQL.FDConnection1.Connected := true;
       //Animate1.Visible := false;
     except
        //Animate1.Visible := false;
        Application.MessageBox('Failed to connect to the Kitchen Database. Please make sure'+#13#10+'the database exists or contact the System Administrator for more help.','Kitchen System Database Initialization',MB_ICONERROR);
       frmLogin.Destroy;
     end;
   end;
end;

end.
