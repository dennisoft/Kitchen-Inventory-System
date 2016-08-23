unit uMakePayment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.GIFImg,
  Vcl.ComCtrls;

type
  TfrmPayment = class(TForm)
    FDQuerySelect: TFDQuery;
    btnPay: TBitBtn;
    btnCancel: TBitBtn;
    FDQuerySave: TFDQuery;
    Image1: TImage;
    Label4: TLabel;
    Image5: TImage;
    txtAdm: TEdit;
    Label5: TLabel;
    txtAmt: TEdit;
    Label2: TLabel;
    FDQueryChange: TFDQuery;
    FDQueryBal: TFDQuery;
    FDQueryClass: TFDQuery;
    FDQueryCat: TFDQuery;
    FDQueryPayable: TFDQuery;
    FDQueryCheckBal: TFDQuery;
    FDQueryRecent: TFDQuery;
    FDQueryDateRecent: TFDQuery;
    Label3: TLabel;
    txtDOP: TDateTimePicker;
    FDQueryUpdateBal: TFDQuery;
    FDQueryCheckRecord: TFDQuery;
    LinkLabel6: TLinkLabel;
    LinkLabel1: TLinkLabel;
    txtNamee: TLabel;
    txtBala: TLabel;
    procedure txtAdmNoChange(Sender: TObject);
    procedure btnPayClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure txtAdmChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPayment: TfrmPayment;

implementation

{$R *.dfm}
uses uConn, uMenu;
procedure TfrmPayment.btnCancelClick(Sender: TObject);
begin
  frmPayment.Close;
end;

procedure TfrmPayment.btnPayClick(Sender: TObject);
var Payment: String;
var bala: Integer;
var balaNew: Integer;
var temp: Integer;
var tempp: Integer;
var dtPay: TDateTime;
var year1, year2, term1, term2: Integer;
begin
if (txtAdm.Text = '') then
    begin
      Application.MessageBox('Please input the admission number','Kitchen Information System',MB_ICONERROR);
    end
      else
        if (txtDOP.ToString = '') then
          begin
            Application.MessageBox('Please input the Date of Pay','Kitchen Information System',MB_ICONERROR);
          end
            else
              if (txtAmt.Text = '') then
                begin
                  Application.MessageBox('Please input the amount to pay','Kitchen Information System',MB_ICONERROR);
                end
                else
                  begin
                    bala := 0;
                    balaNew := 0;
                    temp := 0;
                    tempp := 0;

                    dtPay := txtDOP.DateTime;
                    DateTimeToString(Payment,'yyyy-MM-dd',dtPay);

                    FDQueryClass.SQL.Clear;
                    FDQueryClass.SQL.Add('SELECT current_class, current_year, current_term from register WHERE adm_no =:Adm');
                    FDQueryClass.ParamByName('Adm').Value := frmPayment.txtAdm.Text;
                    FDQueryClass.Open;
                    //showMessage('Details Selected');

                    FDQueryCat.SQL.Clear;
                    FDQueryCat.SQL.Add('Select category from classes where class =:Cls');
                    FDQueryCat.ParamByName('Cls').Value := FDQueryClass.FieldByName('current_class').Value;
                    FDQueryCat.Open;
                    //showMessage('Category Selected');

                    FDQueryPayable.SQL.Clear;
                    FDQueryPayable.SQL.Add('SELECT amount_payable from payable where category =:Cat');
                    FDQueryPayable.ParamByName('Cat').Value := FDQueryCat.FieldByName('category').Text;
                    FDQueryPayable.Open;
                    //showMessage('Amount Payable Selected');

                    FDQueryCheckBal.SQL.Clear;
                    FDQueryCheckBal.SQL.Add('SELECT bal FROM balance WHERE adm_no =:Adm');
                    FDQueryCheckBal.ParamByName('Adm').Value := frmPayment.txtAdm.Text;
                    FDQueryCheckBal.Open;
                    //showMessage('Balance checked');

                    FDQueryCheckRecord.SQL.Clear;
                    FDQueryCheckRecord.SQL.Add('SELECT receipt_no FROM payment WHERE adm_no =:Adm');
                    FDQueryCheckRecord.ParamByName('Adm').Value := frmPayment.txtAdm.Text;
                    FDQueryCheckRecord.Open;

                    if (FDQueryCheckRecord.RowsAffected = 0) then
                    begin
                      bala := FDQueryPayable.FieldByName('amount_payable').Value;

                      FDQuerySave.SQL.Clear;
                      FDQuerySave.SQL.Add('INSERT INTO payment (adm_no, amount_paid, date_of_pay) VALUES (:Adm, :Amt, :DOPA)');
                      FDQuerySave.ParamByName('Adm').Value := frmPayment.txtAdm.Text;
                      FDQuerySave.ParamByName('Amt').Value := frmPayment.txtAmt.Text;
                      FDQuerySave.ParamByName('DOPA').Value := Payment;
                      FDQuerySave.ExecSQL;

                      temp :=  StrToInt(txtAmt.Text);
                      balaNew :=  (bala - temp);

                      FDQueryUpdateBal.SQL.Clear;
                      FDQueryUpdateBal.SQL.Add('UPDATE balance SET bal =:Bal WHERE adm_no =:Adm');
                      FDQueryUpdateBal.ParamByName('Adm').Value := txtAdm.Text;
                      FDQueryUpdateBal.ParamByName('Bal').Value := balaNew;
                      FDQueryUpdateBal.ExecSQL;

                      Application.MessageBox('Payment made successfully!','Kitchen System',MB_ICONINFORMATION);
                    end
                    else
                      begin
                        FDQueryRecent.SQL.Clear;
                        FDQueryRecent.SQL.Add('SELECT adm_no, MAX(date_of_pay) FROM payment WHERE adm_no =:Adm GROUP BY adm_no');
                        FDQueryRecent.ParamByName('Adm').Value := frmPayment.txtAdm.Text;
                        FDQueryRecent.Open;
                        //showMessage('Recent Transaction Derived');

                        FDQueryDateRecent.SQL.Clear;
                        FDQueryDateRecent.SQL.Add('SELECT term, _year FROM termdates WHERE :DOP BETWEEN opening AND closing');
                        FDQueryDateRecent.ParamByName('DOP').Value := FDQueryRecent.FieldByName('MAX(date_of_pay)').Value;
                        FDQueryDateRecent.Open;
                        //showMessage(FDQueryDateRecent.FieldByName('term').Value);
                        //showMessage('Recent term and year Derived');

                        year1 := StrToInt(FDQueryClass.FieldByName('current_year').Value);
                        year2 := StrToInt(FDQueryDateRecent.FieldByName('_year').Value);
                        term1 := StrToInt(FDQueryClass.FieldByName('current_term').Value);
                        term2 := StrToInt(FDQueryDateRecent.FieldByName('term').Value);


                        if ((year1 = year2) AND (term1 = term2)) then
                        begin
                          //showMessage('Decided we dont need payable');
                          //Query ya kulipa bila payable
                          bala := FDQueryCheckBal.FieldByName('bal').Value;

                          FDQuerySave.SQL.Clear;
                          FDQuerySave.SQL.Add('INSERT INTO payment (adm_no, amount_paid, date_of_pay) VALUES (:Adm, :Amt, :DOPE)');
                          FDQuerySave.ParamByName('Adm').Value := frmPayment.txtAdm.Text;
                          FDQuerySave.ParamByName('Amt').Value := frmPayment.txtAmt.Text;
                          FDQuerySave.ParamByName('DOPE').Value := Payment;
                          FDQuerySave.ExecSQL;


                           tempp :=  StrToInt(frmPayment.txtAmt.Text);
                           balaNew :=  (bala - tempp);

                          FDQueryUpdateBal.SQL.Clear;
                          FDQueryUpdateBal.SQL.Add('UPDATE balance SET bal =:Bal WHERE adm_no =:Adm');
                          FDQueryUpdateBal.ParamByName('Adm').Value := frmPayment.txtAdm.Text;
                          FDQueryUpdateBal.ParamByName('Bal').Value := balaNew;
                          FDQueryUpdateBal.ExecSQL;

                          Application.MessageBox('Payment made successfully!','Kitchen System',MB_ICONINFORMATION);
                          //showMessage('Query bila Payable');
                        end
                        else
                          begin
                             //showMessage('Decided we need payable');
                             if (FDQueryCheckBal.FieldByName('bal').Value > 0) then
                              begin
                                bala := FDQueryPayable.FieldByName('amount_payable').Value + FDQueryCheckBal.FieldByName('bal').Value;
                              end
                              else
                                if (FDQueryCheckBal.FieldByName('bal').Value < 0) then
                                begin
                                  bala := FDQueryPayable.FieldByName('amount_payable').Value - FDQueryCheckBal.FieldByName('bal').Value;
                                end
                                else
                                begin
                                  bala := FDQueryPayable.FieldByName('amount_payable').Value;
                                end;

                              FDQuerySave.SQL.Clear;
                              FDQuerySave.SQL.Add('INSERT INTO payment (adm_no, amount_paid, date_of_pay) VALUES (:Adm, :Amt, :DOPA)');
                              FDQuerySave.ParamByName('Adm').Value := frmPayment.txtAdm.Text;
                              FDQuerySave.ParamByName('Amt').Value := frmPayment.txtAmt.Text;
                              FDQuerySave.ParamByName('DOPA').Value := Payment;
                              FDQuerySave.ExecSQL;

                              temp :=  StrToInt(txtAmt.Text);
                              balaNew :=  (bala - temp);

                              FDQueryUpdateBal.SQL.Clear;
                              FDQueryUpdateBal.SQL.Add('UPDATE balance SET bal =:Bal WHERE adm_no =:Adm');
                              FDQueryUpdateBal.ParamByName('Adm').Value := txtAdm.Text;
                              FDQueryUpdateBal.ParamByName('Bal').Value := balaNew;
                              FDQueryUpdateBal.ExecSQL;

                              Application.MessageBox('Payment made successfully!','Kitchen System',MB_ICONINFORMATION);
                              //showMessage('Query Payable');
                          end;
                      end;
                  end;
end;


procedure TfrmPayment.txtAdmChange(Sender: TObject);
begin
  FDQueryChange.SQL.Clear;
  FDqueryChange.SQL.Add('SELECT adm_no, current_term, current_class, current_year, fname, lname, sname FROM register WHERE adm_no =:ADM');
  FDQueryChange.ParamByName('ADM').Text := txtAdm.Text;
  FDQueryChange.Open;

  if (FDQueryChange.RowsAffected = 1) then
  begin
    txtNamee.Caption := FDQueryChange.FieldByName('sname').Text+' '+FDQueryChange.FieldByName('fname').Text+' '+FDQueryChange.FieldByName('lname').Text+' Class '+FDQueryChange.FieldByName('current_class').Text+' Term '+FDQueryChange.FieldByName('current_term').Text+', '+FDQueryChange.FieldByName('current_year').Text;
    txtNamee.Font.Color := clGreen;
  end
  else
    begin
      txtNamee.Caption := 'This Student does not Exist!';
      txtNamee.Font.Color := clRed;
    end;

    FDQueryBal.SQL.Clear;
    FDqueryBal.SQL.Add('SELECT bal FROM balance WHERE adm_no =:AAA');
    FDQueryBal.ParamByName('AAA').Text := txtAdm.Text;
    FDQueryBal.Open;


    if (FDQueryBal.FieldByName('bal').Value > 0) then
      begin
        txtBala.Caption := 'Balance of Kshs.'+FDQueryBal.FieldByName('bal').Text;
        txtBala.Font.Color := clRed;
      end
        else
          begin
              txtBala.Caption := 'No Balance';
              txtBala.Font.Color := clGreen;
          end;
end;

procedure TfrmPayment.txtAdmNoChange(Sender: TObject);
var checkNull:Boolean;
begin
  FDQuerySelect.SQL.Clear;
  FDQuerySelect.SQL.Add('SELECT  adm_no, full_name, current_class FROM passports_view' +
          ' WHERE adm_no=:Adm');
  if (frmMenu.txtAdmSearch.Text = '') then
  begin
    //FDQuerySelect.ParamByName('Adm').Value := txtAdm.Text;
    txtNamee.Caption := 'Please input the Admission Number to get balance information.';
    txtNamee.Font.Color := clGreen;
  end
  else
    begin
      //if you search
      FDQuerySelect.ParamByName('Adm').Value := frmMenu.FDQuerySearch.FieldByName('adm_no').Text;
      FDQuerySelect.Open;
    end;

  if (txtAdm.Text = '')then
  begin
    CheckNull := true;
  end
  else
    CheckNull := false;

  if (FDQuerySelect.RecordCount = 1) then
        begin
           txtNamee.Visible := true;
           txtNamee.Caption := FDQuerySelect.FieldByName('full_name').Value + ', Class '+ FDQuerySelect.FieldByName('current_class').Value;
           txtNamee.Font.Color := clBlue;
        end;

  if ((CheckNull = true) and (FDQuerySelect.RecordCount = 0)) then
    begin
              txtNamee.Visible := true;
              txtNamee.Caption := 'Please input the Admission Number to get balance information.';
              txtNamee.Font.Color := clGreen;
    end;

   if ((CheckNull = false) and (FDQuerySelect.RecordCount = 0)) then
        begin
          if txtNamee.Visible = false then
            begin
                txtNamee.Visible := true;
            end;
            txtNamee.Caption := 'This Student Does Not Exist!!';
            txtNamee.Font.Color := clRed;
        end;

  FDQueryBal.SQL.Clear;
  FDqueryBal.SQL.Add('SELECT bal FROM balance WHERE adm_no =:AAA');
  FDQueryBal.ParamByName('AAA').Text := txtAdm.Text;
  FDQueryBal.Open;


  if (FDQueryBal.FieldByName('bal').Value > 0) then
    begin
      txtBala.Caption := 'Balance of Kshs.'+FDQueryBal.FieldByName('bal').Text;
      txtBala.Font.Color := clRed;
    end
    else
    begin
        txtBala.Caption := 'No Balance';
        txtBala.Font.Color := clGreen;
    end;
end;

end.
