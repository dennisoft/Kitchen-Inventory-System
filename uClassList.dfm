object frmClassList: TfrmClassList
  Left = 0
  Top = 0
  Caption = 'Class Lists'
  ClientHeight = 161
  ClientWidth = 435
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
  object Label4: TLabel
    Left = 85
    Top = 77
    Width = 96
    Height = 18
    Alignment = taRightJustify
    Caption = 'Select Class:'
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
    Left = 96
    Top = 124
    Width = 241
    Height = 29
    Caption = 'Student List'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnGenerateClick
  end
  object txtClass: TComboBoxEx
    Left = 187
    Top = 75
    Width = 158
    Height = 22
    Hint = 'Class'
    AutoCompleteOptions = [acoAutoSuggest, acoAutoAppend]
    ItemsEx = <
      item
        Caption = 'Nursery 1'
      end
      item
        Caption = 'Nursery 2'
      end
      item
        Caption = 'Nursery 3'
      end
      item
        Caption = '1'
      end
      item
        Caption = '2'
      end
      item
        Caption = '3'
      end
      item
        Caption = '4'
      end
      item
        Caption = '5'
      end
      item
        Caption = '6'
      end
      item
        Caption = '7'
      end
      item
        Caption = '8'
      end>
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object LinkLabel6: TLinkLabel
    Left = 18
    Top = 47
    Width = 409
    Height = 22
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Caption = 
      'Use this section to generate the current class list for any clas' +
      's'
    Color = 4605510
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
  end
  object LinkLabel1: TLinkLabel
    Left = 114
    Top = -3
    Width = 196
    Height = 44
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Caption = 'CLASS LIST'
    Color = 4605510
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -33
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 3
  end
  object FDQueryClass: TFDQuery
    Connection = ConnSQL.FDConnection1
    Left = 384
    Top = 88
  end
  object frxDBDatasetList: TfrxDBDataset
    UserName = 'frxDBDatasetList'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 48
    Top = 80
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
    ReportOptions.LastChange = 42292.719984664350000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 360
    Top = 64
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
          Left = 64.252010000000000000
          Top = 11.338590000000000000
          Width = 661.417750000000000000
          Height = 56.692950000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -47
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'THIKA MEMORIAL SCHOOL')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          Left = 15.118120000000000000
          Top = 4.535433070000000000
          Width = 151.181200000000000000
          Height = 132.283550000000000000
          DataField = 'photo'
          DataSetName = 'frxDBDatasetPhoto'
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo33: TfrxMemoView
          Left = 253.228510000000000000
          Top = 71.811070000000000000
          Width = 279.685220000000000000
          Height = 34.015770000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -27
          Font.Name = 'Constantia'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Inspire to Excel')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 274.015925000000000000
          Top = 132.283550000000000000
          Width = 238.110390000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -40
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLASS LIST')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 359.055350000000000000
        Width = 786.142240000000000000
        DataSet = frxDBDatasetList
        DataSetName = 'frxDBDatasetList'
        RowCount = 60
        object Memo4: TfrxMemoView
          Left = 15.118120000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBDatasetList."adm_no"]')
        end
        object Memo115: TfrxMemoView
          Left = 215.433210000000000000
          Width = 185.196952910000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            
              '[frxDBDatasetList."sname"] [frxDBDatasetList."fname"] [frxDBData' +
              'setList."lname"]')
        end
        object Memo5: TfrxMemoView
          Left = 445.984540000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBDatasetList."gender"]')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 222.992270000000000000
        Width = 786.142240000000000000
        object Memo1: TfrxMemoView
          Left = 15.118120000000000000
          Top = 83.149660000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Admission Number')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 215.433210000000000000
          Top = 83.149660000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Full Names')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 445.984540000000000000
          Top = 83.149660000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Gender')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 455.433365000000000000
          Top = 45.354360000000000000
          Width = 275.905690000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -20
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Term [frxDBDatasetList."current_term"] [frxDBDatasetList."curren' +
              't_year"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Line2: TfrxLineView
          Left = -22.677180000000000000
          Top = 75.590600000000000000
          Width = 816.378480000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 3.000000000000000000
        end
        object Line1: TfrxLineView
          Left = -7.559060000000000000
          Top = 109.606370000000000000
          Width = 816.378480000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 3.000000000000000000
        end
        object Memo7: TfrxMemoView
          Left = 113.385900000000000000
          Top = 45.354360000000000000
          Width = 226.771800000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -20
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Class: [frxDBDatasetList."current_class"] ')
          ParentFont = False
        end
      end
      object Line3: TfrxLineView
        Left = -26.456710000000000000
        Top = 177.637910000000000000
        Width = 816.378480000000000000
        Color = clBlack
        Frame.Typ = [ftTop]
      end
    end
  end
end
