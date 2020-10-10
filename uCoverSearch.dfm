object fCoverSearch: TfCoverSearch
  Left = 0
  Top = 0
  Caption = 'Cover Search'
  ClientHeight = 735
  ClientWidth = 1052
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sRollOutPanel1: TsRollOutPanel
    Left = 0
    Top = 0
    Width = 1052
    Height = 65
    Align = alTop
    Caption = 'Infos'
    TabOrder = 0
    object sLabel1: TsLabel
      Left = 16
      Top = 16
      Width = 26
      Height = 13
      Caption = 'Artist'
    end
    object sLabel2: TsLabel
      Left = 327
      Top = 16
      Width = 20
      Height = 13
      Caption = 'Title'
    end
    object seArtist: TsEdit
      Left = 50
      Top = 13
      Width = 255
      Height = 21
      TabOrder = 0
    end
    object seTitle: TsEdit
      Left = 354
      Top = 13
      Width = 255
      Height = 21
      TabOrder = 1
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 694
    Width = 1052
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bsApply: TsButton
      Left = 1
      Top = 1
      Width = 1050
      Height = 39
      Align = alClient
      Caption = 'Apply'
      TabOrder = 0
    end
  end
  object sg1: TJvStringGrid
    Left = 0
    Top = 65
    Width = 750
    Height = 629
    Align = alLeft
    Color = 3355443
    ColCount = 3
    DefaultColWidth = 200
    DefaultRowHeight = 200
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedRowDefAlign]
    TabOrder = 2
    OnDrawCell = sg1DrawCell
    OnSelectCell = sg1SelectCell
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = []
    ExplicitLeft = -5
    ExplicitTop = 62
  end
  object sPanel2: TsPanel
    Left = 750
    Top = 65
    Width = 302
    Height = 629
    Align = alClient
    TabOrder = 3
    ExplicitLeft = 756
    ExplicitTop = 71
    object Image1: TsImage
      Left = 1
      Top = 1
      Width = 300
      Height = 300
      Align = alTop
      Picture.Data = {07544269746D617000000000}
      Stretch = True
      ExplicitLeft = 6
      ExplicitTop = 6
    end
    object Memo1: TMemo
      Left = 16
      Top = 368
      Width = 281
      Height = 241
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
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
