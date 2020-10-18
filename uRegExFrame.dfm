object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 687
  Height = 82
  Align = alTop
  AutoScroll = True
  DoubleBuffered = True
  ParentDoubleBuffered = False
  TabOrder = 0
  object sCB1: TsComboBox
    Left = 11
    Top = 13
    Width = 121
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 15724527
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    BoundLabel.Caption = 'sComboBox1'
    Style = csDropDownList
    ItemIndex = -1
    TabOrder = 0
  end
  object ckRegEx01: TsCheckBox
    Left = 3
    Top = 43
    Width = 60
    Height = 17
    Caption = 'Pattern'
    TabOrder = 1
  end
  object sEP01: TsComboBox
    Left = 138
    Top = 16
    Width = 372
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 15724527
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ItemIndex = -1
    TabOrder = 2
  end
  object sCKReplace01: TsCheckBox
    Left = 147
    Top = 46
    Width = 62
    Height = 17
    Caption = 'Replace'
    TabOrder = 3
  end
  object sPNReplace01: TsPanel
    Left = 224
    Top = 40
    Width = 293
    Height = 31
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object sLabel2: TsLabel
      Left = 58
      Top = 7
      Width = 20
      Height = 13
      Caption = 'with'
    end
    object sETO01: TsEdit
      Left = 88
      Top = 6
      Width = 40
      Height = 21
      TabOrder = 0
    end
    object sEFROM01: TsEdit
      Left = 9
      Top = 4
      Width = 40
      Height = 21
      TabOrder = 1
    end
    object sComboBox2: TsComboBox
      Left = 177
      Top = 4
      Width = 109
      Height = 21
      BoundLabel.Active = True
      BoundLabel.Caption = 'Case'
      ItemIndex = 0
      TabOrder = 2
      Text = 'Unchanged'
      Visible = False
      Items.Strings = (
        'Unchanged'
        'Lowercase'
        'Uppercase'
        'First Letter Uppercase')
    end
  end
  object sBB1: TsBadgeBtn
    Left = 1
    Top = 3
    UseEllipsis = False
    SkinData.CustomColor = True
    TabStop = False
    WordWrap = False
    Caption = '1'
    PaintOptions.BevelWidth = 0
    PaintOptions.DataActive.Color1 = clBlue
    PaintOptions.DataActive.Color2 = clHighlight
    PaintOptions.DataActive.FontColor = clWhite
    PaintOptions.DataActive.BorderColor = clYellow
    PaintOptions.DataNormal.Color1 = clBlue
    PaintOptions.DataNormal.Color2 = clHighlight
    PaintOptions.DataNormal.FontColor = clWhite
    PaintOptions.DataNormal.BorderColor = clYellow
    PaintOptions.DataPressed.Color1 = clBlue
    PaintOptions.DataPressed.Color2 = clHighlight
    PaintOptions.DataPressed.FontColor = clWhite
    PaintOptions.DataPressed.BorderColor = clYellow
    AlignTo = baTopLeft
    AttachTo = sCB1
  end
  object sFrameAdapter1: TsFrameAdapter
    Left = 584
    Top = 16
  end
end
