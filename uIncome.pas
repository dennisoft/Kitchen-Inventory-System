unit uIncome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmIncome = class(TForm)
    Label4: TLabel;
    LinkLabel6: TLinkLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    LinkLabel1: TLinkLabel;
    btnCancel: TBitBtn;
    Image5: TImage;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIncome: TfrmIncome;

implementation

{$R *.dfm}

procedure TfrmIncome.btnCancelClick(Sender: TObject);
begin
  frmIncome.Close;
end;

end.
