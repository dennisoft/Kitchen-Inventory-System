unit uRegStudent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, System.Actions, Vcl.ActnList, Vcl.ImgList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls,
  Vcl.Ribbon, Vcl.RibbonLunaStyleActnCtrls, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, Vcl.ExtDlgs, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI;
type
  TfrmRegStudent = class(TForm)
    lblUser: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    txtAdmNo: TEdit;
    txtFirstName: TEdit;
    txtSurname: TEdit;
    txtLastName: TEdit;
    txtGender: TComboBoxEx;
    txtDOB: TDateTimePicker;
    txtTermAdm: TEdit;
    Label11: TLabel;
    txtAdmClass: TEdit;
    Label6: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    txtContact1: TEdit;
    txtContact2: TEdit;
    imgPassport: TImage;
    btnOpenPassport: TBitBtn;
    btnSave: TBitBtn;
    btnClear: TBitBtn;
    Image2: TImage;
    Image6: TImage;
    Image1: TImage;
    Image3: TImage;
    Image5: TImage;
    OpenPictureDialog: TOpenPictureDialog;
    FDQueryPhoto: TFDQuery;
    Label5: TLabel;
    txtYear: TEdit;
    FDQuerySavePhoto: TFDQuery;
    FDQuery2: TFDQuery;
    FDTable1: TFDTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuerySaveStudents: TFDQuery;
    ckSpecial: TCheckBox;
    FDQuerySpecial: TFDQuery;
    FDQueryBal: TFDQuery;
    procedure btnOpenPassportClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegStudent: TfrmRegStudent;

implementation

{$R *.dfm}
uses uConn;
procedure TfrmRegStudent.btnOpenPassportClick(Sender: TObject);
begin
  openPictureDialog.Execute();
  imgPassport.Picture.LoadFromFile(openPictureDialog.FileName);
end;

procedure TfrmRegStudent.btnSaveClick(Sender: TObject);
var Birth: String;
var dtBirth: TDateTime;
var AStream : TMemoryStream;
var check :Boolean;
begin
  if (txtAdmNo.Text = '') then
    begin
      Application.MessageBox('Please input the admission number','Kitchen Information System',MB_ICONERROR);
    end
      else
        if (txtSurName.Text = '') then
          begin
            Application.MessageBox('Please input the Surname','Kitchen Information System',MB_ICONERROR);
          end
            else
              if (txtFirstName.Text = '') then
                begin
                  Application.MessageBox('Please input the First Name','Kitchen Information System',MB_ICONERROR);
                end
                  else
                    if (txtLastName.Text = '') then
                      begin
                        Application.MessageBox('Please input the Last Name','Kitchen Information System',MB_ICONERROR);
                      end
                        else
                          if (txtGender.Text = '') then
                            begin
                              Application.MessageBox('Please input the Gender','Kitchen Information System',MB_ICONERROR);
                            end
                              else
                                if (txtDOB.ToString = '') then
                                  begin
                                    Application.MessageBox('Please input the date of birth','Kitchen Information System',MB_ICONERROR);
                                  end
                                    else
                                      if (txtAdmClass.Text = '') then
                                        begin
                                          Application.MessageBox('Please input the class of Admission','Kitchen Information System',MB_ICONERROR);
                                        end
                                          else
                                            if (txtTermAdm.Text = '') then
                                              begin
                                                Application.MessageBox('Please input the term of admission','Kitchen Information System',MB_ICONERROR);
                                              end
                                                else
                                                  begin
                                                    if (txtYear.Text = '') then
                                                      begin
                                                        Application.MessageBox('Please input the year of Admission','Kitchen Information System',MB_ICONERROR);
                                                      end
                                                        else
                                                          if (txtContact1.Text = '') then
                                                            begin
                                                              Application.MessageBox('Please input the contact line','Kitchen Information System',MB_ICONERROR);
                                                            end
                                                              else
                                                                if (txtContact2.Text = '') then
                                                                  begin
                                                                    Application.MessageBox('Please input an alternative contact','Kitchen Information System',MB_ICONERROR);
                                                                  end
                                                                    else
                                                                      begin
                                                                         dtBirth := txtDOB.DateTime;
                                                                          DateTimeToString(Birth,'yyyy-MM-dd',dtBirth);

                                                                          if txtAdmNo.Text = '' then
                                                                          begin
                                                                            Application.MessageBox('Error! Admission Number Required!','Student Information System',MB_ICONERROR);
                                                                          end;

                                                                          if frmRegStudent.txtSurname.Text = '' then
                                                                          begin
                                                                            Application.MessageBox('Error! Surname Required!','Student Information System',MB_ICONERROR);
                                                                          end;


                                                                          if connSQL.FDConnection1.Connected then
                                                                            begin
                                                                                FDQuerySaveStudents.SQL.Clear;
                                                                                FDQuerySaveStudents.SQL.Add('INSERT INTO `kitchen`.`register`'+
                                                                                  '(`adm_no`,`sname`,`fname`,`lname`,`gender`,`dob`,'+
                                                                                  '`class_admitted`,`term_admitted`,`year_admitted`,`current_class`,`current_term`,'+
                                                                                  '`current_year`,`number1`,`number2`)');
                                                                                FDQuerySaveStudents.SQL.Add('VALUES ('''+frmRegStudent.txtAdmNo.Text+''', '''+frmRegStudent.txtSurname.Text+''', '''+frmRegStudent.txtFirstName.Text+''', '''+frmRegStudent.txtLastName.Text+''', '''+frmRegStudent.txtGender.Text+''', '''+Birth+''', '''+frmRegStudent.txtAdmClass.Text+''', '''+frmRegStudent.txtTermAdm.Text+''', '''+frmRegStudent.txtYear.Text+''', '''+frmRegStudent.txtAdmClass.Text+''', '''+frmRegStudent.txtTermAdm.Text+''', '''+frmRegStudent.txtYear.Text+''', '''+frmRegStudent.txtContact1.Text+''', '''+frmRegStudent.txtContact2.Text+''')');
                                                                                FDQuerySaveStudents.ExecSQL;

                                                                                FDQueryPhoto.SQL.Clear;
                                                                                FDQueryPhoto.SQL.Add('SELECT path FROM passports_folder_path_table');
                                                                                FDQueryPhoto.Open;

                                                                                FDQuery2.SQL.Clear;
                                                                                FDQuery2.SQL.Add('DROP TABLE IF EXISTS tempp');
                                                                                FDQuery2.ExecSQL;
                                                                                FDQuery2.SQL.Clear;
                                                                                FDQuery2.SQL.Add('CREATE TABLE `tempp` (`image` LONGBLOB)');
                                                                                FDQuery2.ExecSQL;

                                                                                FDTable1.TableName := 'kitchen.tempp';
                                                                                FDTable1.Active := true;
                                                                                AStream := TMemoryStream.Create;
                                                                                try
                                                                                  imgPassport.Picture.Graphic.SaveToStream(AStream);
                                                                                  AStream.Position := 0;
                                                                                  if FDTable1.Active then
                                                                                  begin
                                                                                    FDTable1.Edit;
                                                                                    TBlobField(FDTable1.FieldByName('image')).LoadFromStream(AStream);
                                                                                    FDTable1.Post;
                                                                                  end;
                                                                                finally
                                                                                  AStream.Free;
                                                                                  FDTable1.Active:= false;
                                                                                end;

                                                                                if ckSpecial.Checked then
                                                                                  begin
                                                                                    check := true;
                                                                                  end
                                                                                  else
                                                                                    begin
                                                                                      check := false;
                                                                                    end;


                                                                                FDQuerySpecial.SQL.Clear;
                                                                                FDQuerySpecial.SQL.Add('UPDATE `kitchen`.`register` SET `special_diet` =:CH WHERE `adm_no` = :Adm');
                                                                                FDQuerySpecial.ParamByName('Adm').Value := frmRegStudent.txtAdmNo.Text;
                                                                                FDQuerySpecial.ParamByName('CH').Value := check;
                                                                                FDQuerySpecial.ExecSQL;

                                                                                FDQueryBal.SQL.Clear;
                                                                                FDQueryBal.SQL.Add('INSERT INTO balance (adm_no, bal) VALUES (:Adm, :Val)');
                                                                                FDQueryBal.ParamByName('Adm').Value := frmRegStudent.txtAdmNo.Text;
                                                                                FDQueryBal.ParamByName('Val').Value := 0;
                                                                                FDQueryBal.ExecSQL;

                                                                                FDQuerySavePhoto.SQL.Clear;
                                                                                FDQuerySavePhoto.SQL.Add('UPDATE `kitchen`.`register` SET `photo` = (SELECT image FROM tempp) WHERE `adm_no` = :Adm');
                                                                                FDQuerySavePhoto.ParamByName('Adm').Value := frmRegStudent.txtAdmNo.Text;
                                                                                FDQuerySavePhoto.ExecSQL;
                                                                                Application.MessageBox('Records added successfully!','Kitchen System',MB_ICONINFORMATION);
                                                                            end
                                                                          else
                                                                            begin
                                                                                showMessage('Database not Connected. Please check Database Settings.');
                                                                            end;
                                                                      end;
                                                  end;


end;

procedure TfrmRegStudent.FormActivate(Sender: TObject);
begin
    FDQueryPhoto.SQL.Clear;
    FDQueryPhoto.SQL.Add('SELECT path FROM passports_folder_path_table');
    FDQueryPhoto.Open;
    frmRegStudent.imgPassport.Picture.LoadFromFile(FDQueryPhoto.FieldByName('path').Value +'none.jpg');
end;

end.