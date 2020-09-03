object fCoverSearch: TfCoverSearch
  Left = 0
  Top = 0
  Caption = 'Cover Search'
  ClientHeight = 411
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object sRollOutPanel1: TsRollOutPanel
    Left = 0
    Top = 0
    Width = 852
    Height = 65
    Align = alTop
    Caption = 'Infos'
    TabOrder = 0
    ExplicitLeft = 320
    ExplicitTop = 136
    ExplicitWidth = 265
    object sLabel1: TsLabel
      Left = 16
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Artiste'
    end
    object sLabel2: TsLabel
      Left = 336
      Top = 16
      Width = 22
      Height = 13
      Caption = 'Titre'
    end
    object sEdit1: TsEdit
      Left = 66
      Top = 13
      Width = 255
      Height = 21
      TabOrder = 0
      Text = 'sEdit1'
    end
    object sEdit2: TsEdit
      Left = 386
      Top = 13
      Width = 255
      Height = 21
      TabOrder = 1
      Text = 'sEdit1'
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 370
    Width = 852
    Height = 41
    Align = alBottom
    Caption = 'sPanel1'
    TabOrder = 1
    ExplicitLeft = 344
    ExplicitTop = 208
    ExplicitWidth = 185
  end
  object sg1: TJvStringGrid
    Left = 0
    Top = 65
    Width = 852
    Height = 305
    Align = alClient
    Color = 3355443
    ColCount = 3
    DefaultColWidth = 128
    DefaultRowHeight = 128
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedRowDefAlign]
    TabOrder = 2
    OnDrawCell = sg1DrawCell
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = []
    ExplicitTop = 71
  end
  object thGetImages: TJvThread
    Exclusive = True
    MaxCount = 0
    RunOnCreate = True
    FreeOnTerminate = True
    ThreadName = 'GetImages'
    OnExecute = thGetImagesExecute
    Left = 240
    Top = 88
  end
end
