unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Imaging.pngimage;

type
  TfrmWelcome = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWelcome: TfrmWelcome;

implementation

{$R *.dfm}
uses uLogin;
procedure TfrmWelcome.Timer1Timer(Sender: TObject);
begin
    ProgressBar1.StepIt;
    if ProgressBar1.Position = 1 then
      label1.Caption := 'Initializing...';
    if ProgressBar1.Position = 2 then
      label1.Caption := 'Connecting to Database Server.';
    if ProgressBar1.Position = 4 then
      label1.Caption := 'Preparing Graphics Engine.';
    if ProgressBar1.Position = 5 then
      label1.Caption := 'Preparing Graphics Engine...';
    if ProgressBar1.Position = 6 then
      label1.Caption := 'Loading Dependencies.';
    if ProgressBar1.Position = 7 then
      label1.Caption := 'Loading Dependencies...';
    if ProgressBar1.Position = 8 then
      label1.Caption := 'Loading Modules.';
    if ProgressBar1.Position = 9 then
      label1.Caption := 'Loading Modules...';
    if ProgressBar1.Position = 10 then
      label1.Caption := 'Initializing Login....';
    if ProgressBar1.Position = 3 then
      label1.Caption := 'Connecting to Database Server...';

    if ProgressBar1.Position = ProgressBar1.Max then
      begin
        Timer1.Destroy;
        frmWelcome.Hide;
        frmLogin.ShowModal;
      end;
end;

end.
