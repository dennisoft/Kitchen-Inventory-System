unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MetropolisUI.Tile, Vcl.Ribbon,
  Vcl.RibbonLunaStyleActnCtrls, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.StdCtrls, Vcl.CategoryButtons, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Imaging.jpeg, Vcl.ImgList;

type
  TfrmMenu = class(TForm)
    Image1: TImage;
    Label7: TLabel;
    Label3: TLabel;
    Label26: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    txtUser: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    txtAccount: TLabel;
    Image2: TImage;
    txtTime: TLabel;
    txtDate: TLabel;
    CategoryButtons1: TCategoryButtons;
    LinkLabel6: TLinkLabel;
    LinkLabel1: TLinkLabel;
    LinkLabel2: TLinkLabel;
    LinkLabel3: TLinkLabel;
    txtAdmSearch: TEdit;
    btnSearch: TBitBtn;
    plSearch: TPanel;
    txtAdm: TLabel;
    txtName: TLabel;
    txtBal: TLabel;
    txtClass: TLabel;
    txtErr: TLabel;
    line: TImage;
    btnPay: TBitBtn;
    btnClearBal: TBitBtn;
    ActionManager1: TActionManager;
    openRgStudents: TAction;
    deleteStudent: TAction;
    openPhoto: TAction;
    openPayment: TAction;
    openPayable: TAction;
    addUser: TAction;
    changeUser: TAction;
    addCategory: TAction;
    FDQueryUser: TFDQuery;
    Timer1: TTimer;
    FDQuerySearch: TFDQuery;
    FDQueryBal: TFDQuery;
    addDelivery: TAction;
    openReport: TAction;
    Image3: TImage;
    moveStudents: TAction;
    updateStock: TAction;
    Image4: TImage;
    Image6: TImage;
    ImageList2: TImageList;
    incomeForm: TAction;
    expenseForm: TAction;
    procedure btnCancelClick(Sender: TObject);
    procedure openRgStudentsExecute(Sender: TObject);
    procedure deleteStudentExecute(Sender: TObject);
    procedure openPhotoExecute(Sender: TObject);
    procedure openPaymentExecute(Sender: TObject);
    procedure openPayableExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure addUserExecute(Sender: TObject);
    procedure changeUserExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure txtAdmSearchChange(Sender: TObject);
    procedure addCategoryExecute(Sender: TObject);
    procedure addDeliveryExecute(Sender: TObject);
    procedure openReportExecute(Sender: TObject);
    procedure moveStudentsExecute(Sender: TObject);
    procedure updateStockExecute(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure incomeFormExecute(Sender: TObject);
    procedure expenseFormExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}
uses uConn, uReports, uExpenses, uIncome, uMove, uUpdateStock, uAddProduct, uAddDelivery, uLogin, uRegStudent, uDelete, uViewPassports, uMakePayment, uPayable, uAddUser, uChange;
procedure TfrmMenu.openPhotoExecute(Sender: TObject);
begin
  frmPassports.ShowModal;
end;

procedure TfrmMenu.openReportExecute(Sender: TObject);
begin
  frmReports.showModal;
end;

procedure TfrmMenu.openRgStudentsExecute(Sender: TObject);
begin
  frmRegStudent.ShowModal;
end;

procedure TfrmMenu.Timer1Timer(Sender: TObject);
begin
  txtTime.Caption := TimetoStr(System.SysUtils.Time);
  //frmInterface.txtTime.Repaint;
  txtTime.Transparent := false;
end;

procedure TfrmMenu.txtAdmSearchChange(Sender: TObject);
begin
  btnSearchClick(Sender);
end;

procedure TfrmMenu.updateStockExecute(Sender: TObject);
begin
 frmUpdate.ShowModal;
end;

procedure TfrmMenu.deleteStudentExecute(Sender: TObject);
begin
  frmDelete.showModal;
end;

procedure TfrmMenu.expenseFormExecute(Sender: TObject);
begin
  frmExpenses.ShowModal;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  FDQueryUser.SQL.Clear;
    FDQueryUser.SQL.Add('SELECT * FROM auth' +
        ' WHERE username=:User AND password=:Pass');
    FDQueryUser.ParamByName('User').Value := frmLogin.txtUser.Text;
    FDQueryUser.ParamByName('Pass').Value := frmLogin.txtPass.Text;
    FDQueryUser.Open;
    frmMenu.txtUser.Caption := 'Welcome, ' + FDQueryUser.FieldByName('fname').Value + ' ' + FDQueryUser.FieldByName('lname').Value;
    frmMenu.txtAccount.Caption := FDQueryUser.FieldByName('account_type').Value + ' Account';

    txtDate.Caption := FormatDateTime('dddd d of mmmm yyyy',System.SysUtils.Date);

    if frmMenu.btnPay.Visible = true then
      frmMenu.btnPay.Visible := false;
end;

procedure TfrmMenu.Image6Click(Sender: TObject);
begin
  if (Application.MessageBox('Are you sure that you want to exit?','Kitchen Information System',MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = IDYES) then
  begin
    Application.Terminate;
  end;
end;

procedure TfrmMenu.moveStudentsExecute(Sender: TObject);
begin
   frmMove.showModal;
end;

procedure TfrmMenu.openPayableExecute(Sender: TObject);
begin
  frmPayable.showModal;
end;

procedure TfrmMenu.openPaymentExecute(Sender: TObject);
begin
  frmPayment.showModal;
end;

procedure TfrmMenu.incomeFormExecute(Sender: TObject);
begin
  frmIncome.ShowModal;
end;

procedure TfrmMenu.addCategoryExecute(Sender: TObject);
begin
  frmAddProduct.ShowModal;
end;

procedure TfrmMenu.addDeliveryExecute(Sender: TObject);
begin
  frmAddDelivery.showModal;
end;

procedure TfrmMenu.addUserExecute(Sender: TObject);
begin
  frmAddUser.ShowModal;
end;

procedure TfrmMenu.btnSearchClick(Sender: TObject);
begin
  FDQuerySearch.SQL.Clear;
  FDquerySearch.SQL.Add('SELECT adm_no, current_term, current_class, current_year, fname, lname, sname FROM register WHERE adm_no =:ADM');
  FDQuerySearch.ParamByName('ADM').Text := frmMenu.txtAdmSearch.Text;
  FDQuerySearch.Open;

  FDQueryBal.SQL.Clear;
  FDqueryBal.SQL.Add('SELECT bal FROM balance WHERE adm_no =:AAA');
  FDQueryBal.ParamByName('AAA').Text := frmMenu.txtAdmSearch.Text;
  FDQueryBal.Open;

  if (FDQuerySearch.RowsAffected = 1) then
  begin
   if (txtErr.Visible = true) then
    txtErr.Visible := false;
   if (txtAdm.Visible = false) then
    txtAdm.Visible := true;
   {if (txtName.Visible = false) then
    txtName.Visible := true;
   if (txtClass.Visible = false) then
    txtClass.Visible := true; }
   if (btnClearBal.Visible = true) then
    btnClearBal.Visible := false;
   if (btnPay.Visible = false) then
    btnPay.Visible := true;
   if (line.Visible = false) then
      line.Visible := true;

    txtAdm.Caption := FDQuerySearch.FieldByName('adm_no').Text+'    '+FDQuerySearch.FieldByName('sname').Text+' '+FDQuerySearch.FieldByName('fname').Text+' '+FDQuerySearch.FieldByName('lname').Text+'    '+'Class '+FDQuerySearch.FieldByName('current_class').Text+' Term '+FDQuerySearch.FieldByName('current_term').Text+', '+FDQuerySearch.FieldByName('current_year').Text;
    //txtName.Caption := FDQuerySearch.FieldByName('sname').Text+' '+FDQuerySearch.FieldByName('fname').Text+' '+FDQuerySearch.FieldByName('lname').Text;
    //txtClass.Caption := 'Class '+FDQuerySearch.FieldByName('current_class').Text+' Term '+FDQuerySearch.FieldByName('current_term').Text+', '+FDQuerySearch.FieldByName('current_year').Text;

    if (FDQueryBal.FieldByName('bal').Value > 0) then
    begin
      if (txtBal.Visible = false) then
        txtBal.Visible := true;
      if (btnClearBal.Visible = false) then
        btnClearBal.Visible := true;
      txtBal.Caption := 'Balance of Kshs.'+FDQueryBal.FieldByName('bal').Text;
      txtBal.Font.Color := clRed;
       btnPay.Left := 56;
    end
    else
    begin
      if (btnClearBal.Visible = true) then
        btnClearBal.Visible := false;
      if (btnPay.Visible = false) then
        btnPay.Visible := true;
      if (txtBal.Visible = false) then
        txtBal.Visible := true;
        txtBal.Caption := 'No Balance';
        txtBal.Font.Color := clGreen;
        btnPay.Left := 140;
    end;

  end
  else
  begin
    if (txtErr.Visible = false) then
      txtErr.Visible := true;
    if (txtAdm.Visible = true) then
      txtAdm.Visible := false;
    if (txtName.Visible = true) then
      txtName.Visible := false;
    if (txtClass.Visible = true) then
      txtClass.Visible := false;
    if (txtBal.Visible = true) then
      txtBal.Visible := false;
    if (line.Visible = true) then
      line.Visible := false;
    if (btnClearBal.Visible = true) then
      btnClearBal.Visible := false;
    if (btnPay.Visible = true) then
      btnPay.Visible := false;

    txtErr.Caption := 'This Student does not Exist!';
    txtErr.Font.Color := clRed;
  end;
end;

procedure TfrmMenu.btnCancelClick(Sender: TObject);
begin
  if (Application.MessageBox('Are you sure that you want to exit?','Kitchen Information System',MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = IDYES) then
  begin
    Application.Terminate;
  end;
end;

procedure TfrmMenu.changeUserExecute(Sender: TObject);
begin
  frmChanges.showModal;
end;

end.
