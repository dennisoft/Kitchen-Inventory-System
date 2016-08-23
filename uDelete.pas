unit uDelete;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmDelete = class(TForm)
    DBGridStudents: TDBGrid;
    FDQueryShow: TFDQuery;
    DataSource1: TDataSource;
    lblUser: TLabel;
    txtAdmNo: TEdit;
    txtName: TLabel;
    FDQuerySelect: TFDQuery;
    btnDelete: TBitBtn;
    Label1: TLabel;
    FDQueryDelete: TFDQuery;
    Image1: TImage;
    Label2: TLabel;
    btnCancel: TBitBtn;
    Image5: TImage;
    procedure FormShow(Sender: TObject);
    procedure txtAdmNoChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDelete: TfrmDelete;

implementation

{$R *.dfm}
uses uConn;
procedure TfrmDelete.btnCancelClick(Sender: TObject);
begin
  frmDelete.Close;
end;

procedure TfrmDelete.btnDeleteClick(Sender: TObject);
begin
  if (txtAdmNo.Text = '') then
    begin
      Application.MessageBox('Please input the admission number','Kitchen Information System',MB_ICONERROR);
    end
    else
      begin
        if (Application.MessageBox('Are you sure that you want to delete this record?','Confirm Delete  ',MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = IDYES) then
        begin
          FDQueryDelete.SQL.Clear;
          FDQueryDelete.SQL.Add('DELETE FROM register WHERE adm_no =:Adm');
          FDQueryDelete.ParamByName('Adm').Value := DBGridStudents.SelectedField.Value;
          FDQueryDelete.ExecSQL;
          showMessage('Record deleted successfully!');

           FDQueryShow.SQL.Clear;
           FDQueryShow.SQL.Add('Select * from register');
           FDQueryShow.Open;
           FDQueryShow.Active := true;

           DBGridStudents.Columns[0].FieldName := 'adm_no';
           DBGridStudents.Columns[1].FieldName := 'sname';
           DBGridStudents.Columns[2].FieldName := 'fname';
           DBGridStudents.Columns[3].FieldName := 'lname';
           DBGridStudents.Columns[4].FieldName := 'current_class';
           DBGridStudents.Columns[5].FieldName := 'gender';
           DBGridStudents.Columns[6].FieldName := 'dob';
           DBGridStudents.DataSource := DataSource1;
           ShowScrollBar(DBGridStudents.Handle,SB_VERT,FALSE);
        end;
      end;
end;

procedure TfrmDelete.FormShow(Sender: TObject);
begin
   FDQueryShow.SQL.Clear;
   FDQueryShow.SQL.Add('Select * from register');
   FDQueryShow.Open;
   FDQueryShow.Active := true;

   DBGridStudents.Columns[0].FieldName := 'adm_no';
   DBGridStudents.Columns[1].FieldName := 'sname';
   DBGridStudents.Columns[2].FieldName := 'fname';
   DBGridStudents.Columns[3].FieldName := 'lname';
   DBGridStudents.Columns[4].FieldName := 'current_class';
   DBGridStudents.Columns[5].FieldName := 'gender';
   DBGridStudents.Columns[6].FieldName := 'dob';
   DBGridStudents.DataSource := DataSource1;
   ShowScrollBar(DBGridStudents.Handle,SB_VERT,FALSE);
end;

procedure TfrmDelete.txtAdmNoChange(Sender: TObject);
var checkNull:Boolean;
begin
  FDQuerySelect.SQL.Clear;
  FDQuerySelect.SQL.Add('SELECT  * FROM register' +
          ' WHERE adm_no=:Adm');
  FDQuerySelect.ParamByName('Adm').Value := txtAdmNo.Text;
  FDQuerySelect.Open;
  if (txtAdmNo.Text = '')then
  begin
    CheckNull := true;
  end
  else
    CheckNull := false;

  if (FDQuerySelect.RecordCount > 0) then
        begin
           txtName.Visible := true;
           txtName.Caption := 'Found 1 Result';
           txtName.Font.Color := clBlack;

           FDQueryShow.SQL.Clear;
           FDQueryShow.SQL.Add('SELECT  * FROM register' +
                ' WHERE adm_no=:Adm');
           FDQueryShow.ParamByName('Adm').Value := txtAdmNo.Text;
           FDQueryShow.Open;
           FDQueryShow.Active := true;

           DBGridStudents.Columns[0].FieldName := 'adm_no';
           DBGridStudents.Columns[1].FieldName := 'sname';
           DBGridStudents.Columns[2].FieldName := 'fname';
           DBGridStudents.Columns[3].FieldName := 'lname';
           DBGridStudents.Columns[4].FieldName := 'current_class';
           DBGridStudents.Columns[5].FieldName := 'gender';
           DBGridStudents.Columns[6].FieldName := 'dob';
           DBGridStudents.DataSource := DataSource1;
           ShowScrollBar(DBGridStudents.Handle,SB_VERT,FALSE);

           //Label1.Caption := FDQueryShow.FieldByName('adm_no').Text
           //Label1.Caption := DBGridStudents.SelectedField.Text;
        end;

  if ((CheckNull = true) and (FDQuerySelect.RecordCount = 0)) then
    begin
      txtName.Visible := true;
      txtName.Caption := 'Please input the Admission Number.';
      txtName.Font.Color := clGreen;

      FDQueryShow.SQL.Clear;
       FDQueryShow.SQL.Add('Select * from register');
       FDQueryShow.Open;
       FDQueryShow.Active := true;

       DBGridStudents.Columns[0].FieldName := 'adm_no';
       DBGridStudents.Columns[1].FieldName := 'sname';
       DBGridStudents.Columns[2].FieldName := 'fname';
       DBGridStudents.Columns[3].FieldName := 'lname';
       DBGridStudents.Columns[4].FieldName := 'current_class';
       DBGridStudents.Columns[5].FieldName := 'gender';
       DBGridStudents.Columns[6].FieldName := 'dob';
       DBGridStudents.DataSource := DataSource1;
       ShowScrollBar(DBGridStudents.Handle,SB_VERT,FALSE);
    end;

   if ((CheckNull = false) and (FDQuerySelect.RecordCount = 0)) then
        begin
          if txtName.Visible = false then
            begin
                txtName.Visible := true;
            end;
            txtName.Caption := 'This Student Does Not Exist!!';
            txtName.Font.Color := clRed;

            FDQueryShow.SQL.Clear;
             FDQueryShow.SQL.Add('Select * from register');
             FDQueryShow.Open;
             FDQueryShow.Active := true;

             DBGridStudents.Columns[0].FieldName := 'adm_no';
             DBGridStudents.Columns[1].FieldName := 'sname';
             DBGridStudents.Columns[2].FieldName := 'fname';
             DBGridStudents.Columns[3].FieldName := 'lname';
             DBGridStudents.Columns[4].FieldName := 'current_class';
             DBGridStudents.Columns[5].FieldName := 'gender';
             DBGridStudents.Columns[6].FieldName := 'dob';
             DBGridStudents.DataSource := DataSource1;
             ShowScrollBar(DBGridStudents.Handle,SB_VERT,FALSE);
        end;
end;

end.
