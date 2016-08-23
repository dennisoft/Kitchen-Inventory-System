object ConnSQL: TConnSQL
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 193
  Width = 182
  object FDConnection1: TFDConnection
    Left = 64
    Top = 40
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Windows\SysWow64\libmysql.dll'
    Left = 80
    Top = 128
  end
end
