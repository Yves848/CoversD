object FrameCover: TFrameCover
  Left = 0
  Top = 0
  Width = 217
  Height = 217
  Align = alLeft
  TabOrder = 0
  object sPnCCoverSearch: TsPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 217
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitLeft = 96
    ExplicitTop = 56
    ExplicitWidth = 185
    ExplicitHeight = 41
    object sImage1: TsImage
      Left = 1
      Top = 1
      Width = 215
      Height = 198
      Align = alClient
      Picture.Data = {07544269746D617000000000}
      Stretch = True
      ExplicitTop = -5
    end
    object sLabel1: TKryptoGlowLabel
      Left = 24
      Top = 18
      Width = 25
      Height = 39
      AutoSize = False
      Caption = '1'
      Color = 8454143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      GlowSize = 1
      ParentColor = False
      ParentFont = False
      Transparent = True
      GlowColor = clBlack
      Glowing = True
    end
    object sPB1: TsProgressBar
      Left = 1
      Top = 199
      Width = 215
      Height = 17
      Align = alBottom
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 205
      ExplicitWidth = 198
    end
  end
  object sFrameAdapter1: TsFrameAdapter
    Left = 104
    Top = 88
  end
end
