object frmDeduct: TfrmDeduct
  Left = 0
  Top = 0
  Caption = 'Deductions Report Generator'
  ClientHeight = 190
  ClientWidth = 523
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 283
    Top = 99
    Width = 95
    Height = 18
    Alignment = taRightJustify
    Caption = 'Ending Date:'
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 12
    Top = 99
    Width = 117
    Height = 18
    Alignment = taRightJustify
    Caption = 'Beginning Date:'
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object btnGenerate: TBitBtn
    Left = 160
    Top = 147
    Width = 241
    Height = 29
    Caption = 'Generate Report'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnGenerateClick
  end
  object LinkLabel6: TLinkLabel
    Left = 42
    Top = 58
    Width = 449
    Height = 22
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Caption = 
      'Use this section to generate a report for daily deductions from ' +
      'stock'
    Color = 4605510
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 1
  end
  object LinkLabel1: TLinkLabel
    Left = 98
    Top = 8
    Width = 342
    Height = 44
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Caption = 'DAILY DEDUCTIONS'
    Color = 4605510
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -33
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 2
  end
  object txtDOB: TDateTimePicker
    Left = 135
    Top = 99
    Width = 130
    Height = 21
    Date = 42004.000000000000000000
    Time = 42004.000000000000000000
    Color = cl3DLight
    TabOrder = 3
  end
  object txtDOE: TDateTimePicker
    Left = 381
    Top = 99
    Width = 124
    Height = 21
    Date = 42004.000000000000000000
    Time = 42004.000000000000000000
    Color = cl3DLight
    TabOrder = 4
  end
  object FDQueryClass: TFDQuery
    Connection = ConnSQL.FDConnection1
    Left = 405
    Top = 35
  end
  object frxDBDatasetList: TfrxDBDataset
    UserName = 'frxDBDatasetList'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 48
    Top = 27
  end
  object frxReport1: TfrxReport
    Version = '5.1.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41822.879663206000000000
    ReportOptions.LastChange = 42272.754086423610000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 493
    Top = 11
    Datasets = <
      item
        DataSet = frxDBDatasetList
        DataSetName = 'frxDBDatasetList'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 1.000000000000000000
      RightMargin = 1.000000000000000000
      TopMargin = 1.000000000000000000
      BottomMargin = 1.000000000000000000
      Frame.Width = 2.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 143.622047240000000000
        Top = 18.897650000000000000
        Width = 786.142240000000000000
        object Memo34: TfrxMemoView
          Left = 154.960730000000000000
          Top = 11.338590000000000000
          Width = 449.764070000000000000
          Height = 41.574830000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -32
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'THIKA MEMORIAL SCHOOL')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 234.330860000000000000
          Top = 52.913420000000000000
          Width = 279.685220000000000000
          Height = 22.677180000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -19
          Font.Name = 'Constantia'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Inspire to Excel')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Align = baCenter
          Left = 241.889920000000000000
          Top = 139.842610000000000000
          Width = 302.362400000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -40
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DEDUCTIONS')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 336.378170000000000000
        Width = 786.142240000000000000
        DataSet = frxDBDatasetList
        DataSetName = 'frxDBDatasetList'
        RowCount = 60
        object Memo4: TfrxMemoView
          Left = 35.905535000000000000
          Top = 3.779530000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBDatasetList."product_id"]')
        end
        object Memo115: TfrxMemoView
          Left = 215.433210000000000000
          Top = 3.779530000000000000
          Width = 173.858362910000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBDatasetList."product_name"]')
        end
        object Memo5: TfrxMemoView
          Left = 430.866420000000000000
          Top = 3.779530000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBDatasetList."quantity_deducted"]')
        end
        object Memo7: TfrxMemoView
          Left = 600.945270000000000000
          Top = 3.779530000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBDatasetList."_date"]')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 90.708720000000000000
        Top = 222.992270000000000000
        Width = 786.142240000000000000
        object Memo1: TfrxMemoView
          Left = 37.795300000000000000
          Top = 60.472480000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Product ID')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 215.433210000000000000
          Top = 60.472480000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Product Name')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 86.929190000000000000
          Width = 801.260360000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 3.000000000000000000
        end
        object Memo3: TfrxMemoView
          Left = 430.866420000000000000
          Top = 60.472480000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Units Deducted')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Top = 52.913420000000000000
          Width = 842.835190000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 3.000000000000000000
        end
        object Memo8: TfrxMemoView
          Left = 600.945270000000000000
          Top = 60.472480000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Date')
          ParentFont = False
        end
      end
    end
  end
  object FDQueryName: TFDQuery
    Connection = ConnSQL.FDConnection1
    Left = 461
    Top = 115
  end
  object frxDBDatasetName: TfrxDBDataset
    UserName = 'frxDBDatasetName'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 80
    Top = 123
  end
end
