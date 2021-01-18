object fEditTags: TfEditTags
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Tags Edit'
  ClientHeight = 744
  ClientWidth = 1372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    1372
    744)
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel3: TsPanel
    Left = 0
    Top = 703
    Width = 1372
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 6
    ExplicitTop = 709
  end
  object sScrollBox2: TsScrollBox
    Tag = 1
    Left = 0
    Top = 41
    Width = 1372
    Height = 662
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 1
    ExplicitLeft = 6
    ExplicitTop = 35
  end
  object sScrollBox3: TsScrollBox
    Left = 0
    Top = 0
    Width = 1372
    Height = 41
    Align = alTop
    TabOrder = 2
    object sSpeedButton3: TsSpeedButton
      Left = 1248
      Top = 0
      Width = 120
      Height = 37
      Align = alRight
      Caption = 'Player'
      ExplicitLeft = 1257
    end
    object sSpeedButton2: TsSpeedButton
      Tag = 1
      Left = 120
      Top = 0
      Width = 120
      Height = 37
      Align = alLeft
      Caption = 'Playlist Editor'
      OnClick = sSpeedButton4Click
      ExplicitLeft = 126
      ExplicitTop = -4
    end
    object sSpeedButton4: TsSpeedButton
      Left = 0
      Top = 0
      Width = 120
      Height = 37
      Align = alLeft
      Caption = 'Tags Editor'
      OnClick = sSpeedButton4Click
      ExplicitLeft = -6
      ExplicitTop = 3
    end
  end
  object sSplitView1: TsSplitView
    Left = 0
    Top = 0
    Width = 0
    Height = 744
    DisplayMode = svmaOverlay
    Opened = False
    OpenedSize = 500
    Placement = svpaLeft
    TabOrder = 3
    object sShellTreeView1: TsShellTreeView
      Left = 1
      Top = 1
      Width = 497
      Height = 742
      Align = alClient
      Indent = 19
      TabOrder = 0
      ObjectTypes = [otFolders]
      Root = 'rfDesktop'
      UseShellImages = True
      AutoRefresh = False
      ShowExt = seSystem
      ExplicitLeft = 0
      ExplicitTop = 2
      ExplicitWidth = 358
    end
  end
  object sSkinManager1: TsSkinManager
    ButtonsOptions.OldGlyphsMode = False
    InternalSkins = <>
    SkinDirectory = 
      'C:\Users\yvesg\Documents\Embarcadero\Studio\21.0\CatalogReposito' +
      'ry\acnt_regdx10sydney\Skins'
    SkinName = 'WMP11'
    SkinInfo = '15'
    ThirdParty.ThirdEdits = ' '
    ThirdParty.ThirdButtons = 'TButton'
    ThirdParty.ThirdBitBtns = ' '
    ThirdParty.ThirdCheckBoxes = ' '
    ThirdParty.ThirdGroupBoxes = ' '
    ThirdParty.ThirdListViews = ' '
    ThirdParty.ThirdPanels = ' '
    ThirdParty.ThirdGrids = ' '
    ThirdParty.ThirdTreeViews = ' '
    ThirdParty.ThirdComboBoxes = ' '
    ThirdParty.ThirdWWEdits = ' '
    ThirdParty.ThirdVirtualTrees = ' '
    ThirdParty.ThirdGridEh = ' '
    ThirdParty.ThirdPageControl = ' '
    ThirdParty.ThirdTabControl = ' '
    ThirdParty.ThirdToolBar = ' '
    ThirdParty.ThirdStatusBar = ' '
    ThirdParty.ThirdSpeedButton = ' '
    ThirdParty.ThirdScrollControl = ' '
    ThirdParty.ThirdUpDown = ' '
    ThirdParty.ThirdScrollBar = ' '
    ThirdParty.ThirdStaticText = ' '
    ThirdParty.ThirdNativePaint = ' '
    Left = 881
    Top = 505
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 801
    Top = 369
  end
end
