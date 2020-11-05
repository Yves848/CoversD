object frmLog: TfrmLog
  Left = 0
  Top = 0
  Width = 471
  Height = 703
  Align = alClient
  AutoSize = True
  TabOrder = 0
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 471
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 240
    ExplicitTop = 224
    ExplicitWidth = 185
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 662
    Width = 471
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 8
    object sbbClear: TsBitBtn
      Left = 1
      Top = 1
      Width = 75
      Height = 39
      Align = alLeft
      Caption = 'Clear'
      ImageIndex = 0
      Images = sCharImageList1
      TabOrder = 0
      OnClick = sbbClearClick
      ExplicitLeft = 56
      ExplicitTop = 24
      ExplicitHeight = 25
    end
  end
  object sPanel3: TsPanel
    Left = 0
    Top = 41
    Width = 471
    Height = 621
    Align = alClient
    TabOrder = 2
    ExplicitTop = 35
    object mLog: TsMemo
      Left = 1
      Top = 1
      Width = 469
      Height = 619
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 6
    end
  end
  object sFrameAdapter1: TsFrameAdapter
    Left = 336
    Top = 248
  end
  object sCharImageList1: TsCharImageList
    EmbeddedFonts = <
      item
        FontName = 'FontAwesome'
        FontData = {}
      end>
    Items = <
      item
        DrawContour = True
        Char = 61809
      end>
    Left = 296
    Top = 369
    Bitmap = {}
  end
end
