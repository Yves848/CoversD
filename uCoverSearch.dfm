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
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
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
    object seArtist: TsEdit
      Left = 49
      Top = 16
      Width = 255
      Height = 21
      TabOrder = 0
      BoundLabel.Active = True
      BoundLabel.Caption = 'Artist'
    end
    object seTitle: TsEdit
      Left = 359
      Top = 16
      Width = 255
      Height = 21
      TabOrder = 1
      BoundLabel.Active = True
      BoundLabel.Caption = 'Title'
    end
    object sButton1: TsButton
      Left = 620
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = sButton1Click
    end
    object sButton2: TsButton
      Left = 952
      Top = 1
      Width = 99
      Height = 41
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 3
      OnClick = sButton2Click
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
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = bsApplyClick
    end
  end
  object sPanel2: TsPanel
    Left = 736
    Top = 65
    Width = 316
    Height = 629
    Align = alRight
    TabOrder = 2
    object Image1: TsImage
      Left = 1
      Top = 1
      Width = 314
      Height = 300
      Align = alTop
      Picture.Data = {07544269746D617000000000}
      Stretch = True
      ExplicitLeft = 6
      ExplicitTop = 5
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
  object sSBCovers: TsScrollBox
    Left = 50
    Top = 65
    Width = 636
    Height = 629
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 3
    ExplicitLeft = 0
    ExplicitWidth = 736
    object sPNRow0: TsPanel
      Left = 0
      Top = 0
      Width = 636
      Height = 209
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = -6
      ExplicitWidth = 686
    end
    object sPnRow1: TsPanel
      Left = 0
      Top = 209
      Width = 636
      Height = 209
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = -6
      ExplicitTop = 215
    end
    object sPnRow2: TsPanel
      Left = 0
      Top = 418
      Width = 636
      Height = 209
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitLeft = -6
      ExplicitTop = 417
      ExplicitWidth = 736
    end
  end
  object sBtnNext: TsButton
    Left = 686
    Top = 65
    Width = 50
    Height = 629
    Align = alRight
    Caption = '&Next 10'
    TabOrder = 4
    OnClick = sBtnNextClick
    ExplicitLeft = 681
  end
  object sBtnPrev: TsButton
    Left = 0
    Top = 65
    Width = 50
    Height = 629
    Align = alLeft
    Caption = '&Prev 10'
    TabOrder = 5
    OnClick = sBtnPrevClick
    ExplicitLeft = 8
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
  object IdHTTP1: TIdHTTP
    OnWork = IdHTTP1Work
    OnWorkBegin = IdHTTP1WorkBegin
    OnWorkEnd = IdHTTP1WorkEnd
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 616
    Top = 417
  end
end
