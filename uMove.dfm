object frmMove: TfrmMove
  Left = 0
  Top = 0
  Caption = 'Move Students'
  ClientHeight = 166
  ClientWidth = 555
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
    Left = 77
    Top = 8
    Width = 424
    Height = 71
    Alignment = taCenter
    AutoSize = False
    Caption = 'MOVE STUDENTS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -60
    Font.Name = 'Mistral'
    Font.Style = []
    ParentFont = False
  end
  object LinkLabel6: TLinkLabel
    Left = 132
    Top = 65
    Width = 322
    Height = 22
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Caption = 'Use this section to move all students to the next'
    Color = 4605510
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
  end
  object btnMove: TBitBtn
    Left = 92
    Top = 113
    Width = 389
    Height = 38
    Caption = 'Move Students to Next Term'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnMoveClick
  end
  object LinkLabel1: TLinkLabel
    Left = 132
    Top = 85
    Width = 250
    Height = 22
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Caption = 'term of study with a click of a button.'
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
  object FDQueryMove: TFDQuery
    Connection = ConnSQL.FDConnection1
    Left = 504
    Top = 80
  end
  object FDQueryGo: TFDQuery
    Connection = ConnSQL.FDConnection1
    Left = 520
    Top = 40
  end
  object FDQueryClass: TFDQuery
    Connection = ConnSQL.FDConnection1
    Left = 39
    Top = 40
  end
end
