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
    ExplicitLeft = -1
    ExplicitTop = -5
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
      Top = 9
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
  object sg1: TAdvStringGrid
    Left = 0
    Top = 65
    Width = 736
    Height = 629
    Cursor = crDefault
    Align = alClient
    Color = clWhite
    ColCount = 3
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect, goFixedRowDefAlign]
    ScrollBars = ssBoth
    TabOrder = 3
    GridLineColor = 15987699
    GridFixedLineColor = 15987699
    HoverRowCells = [hcNormal, hcSelected]
    OnCellChanging = sg1CellChanging
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDown.TextChecked = 'Checked'
    FilterDropDown.TextUnChecked = 'Unchecked'
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Larger than'
      'Smaller than'
      'Clear')
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.ColorTo = clWhite
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SearchFooter.ResultFormat = '(%d of %d)'
    SortSettings.DefaultFormat = ssAutomatic
    Version = '8.4.7.0'
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
