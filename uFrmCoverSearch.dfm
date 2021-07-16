object frmCoverSearch: TfrmCoverSearch
  Left = 0
  Top = 0
  Width = 629
  Height = 888
  TabOrder = 0
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 225
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Image1: TsImage
      Left = 404
      Top = 0
      Width = 225
      Height = 225
      Align = alRight
      Picture.Data = {07544269746D617000000000}
      Stretch = True
      ExplicitTop = -6
    end
    object seArtist: TsEdit
      Left = 50
      Top = 16
      Width = 255
      Height = 21
      TabOrder = 0
      BoundLabel.Active = True
      BoundLabel.Caption = 'Artist'
    end
    object seTitle: TsEdit
      Left = 50
      Top = 43
      Width = 255
      Height = 21
      TabOrder = 1
      BoundLabel.Active = True
      BoundLabel.Caption = 'Title'
    end
    object sButton1: TsButton
      Left = 230
      Top = 70
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = sButton1Click
    end
    object Edit1: TEdit
      Left = 50
      Top = 101
      Width = 503
      Height = 21
      TabOrder = 3
      Text = 'Edit1'
    end
    object sButton2: TsButton
      Left = 50
      Top = 70
      Width = 75
      Height = 25
      Caption = 'sButton2'
      TabOrder = 4
      OnClick = sButton2Click
    end
  end
  object sSBCovers: TsScrollBox
    Left = 0
    Top = 225
    Width = 629
    Height = 663
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 1
    object sPNRow0: TsPanel
      Left = 0
      Top = 0
      Width = 629
      Height = 209
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
    end
    object sPnRow1: TsPanel
      Left = 0
      Top = 209
      Width = 629
      Height = 209
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object sPnRow2: TsPanel
      Left = 0
      Top = 418
      Width = 629
      Height = 209
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object WebBrowser1: TWebBrowser
    Left = -312
    Top = 0
    Width = 201
    Height = 150
    TabOrder = 2
    SelectedEngine = EdgeIfAvailable
    OnDocumentComplete = WebBrowser1DocumentComplete
    ControlData = {
      4C000000C6140000810F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object IdHTTP1: TIdHTTP
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
