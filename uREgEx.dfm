object fRegEx: TfRegEx
  Left = 0
  Top = 0
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'RegEx'
  ClientHeight = 166
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 370
    Height = 166
    Align = alClient
    DoubleBuffered = True
    ParentDoubleBuffered = False
    SideShadow.Mode = ssmInternal
    SideShadow.Side = asBottom
    TabOrder = 0
    ExplicitWidth = 387
    ExplicitHeight = 171
    object sSpeedButton1: TsSpeedButton
      Left = 327
      Top = 33
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = sSpeedButton1Click
    end
    object sSpeedButton2: TsSpeedButton
      Left = 327
      Top = 65
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = sSpeedButton2Click
    end
    object sSpeedButton3: TsSpeedButton
      Left = 327
      Top = 93
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = sSpeedButton3Click
    end
    object sSpeedButton4: TsSpeedButton
      Left = 326
      Top = 124
      Width = 23
      Height = 22
      Caption = '+'
    end
    object sComboBox1: TsComboBox
      Left = 72
      Top = 33
      Width = 249
      Height = 21
      BoundLabel.Active = True
      BoundLabel.Caption = 'Field : '
      ItemIndex = 0
      TabOrder = 0
      Text = '[ARTIST]'
      Items.Strings = (
        '[ARTIST]'
        '[TITLE]'
        '[ALBUM]')
    end
    object sComboBox2: TsComboBox
      Left = 72
      Top = 63
      Width = 249
      Height = 21
      BoundLabel.Active = True
      BoundLabel.Caption = 'Separator : '
      ItemIndex = 0
      TabOrder = 1
      Text = '[-]'
      Items.Strings = (
        '[-]')
    end
    object sComboBox3: TsComboBox
      Left = 72
      Top = 93
      Width = 249
      Height = 21
      BoundLabel.Active = True
      BoundLabel.Caption = 'Counter : '
      ItemIndex = 0
      TabOrder = 2
      Text = '[0-00]'
      Items.Strings = (
        '[0-00]'
        '[0-000]')
    end
    object sComboBox4: TsComboBox
      Left = 71
      Top = 124
      Width = 249
      Height = 21
      BoundLabel.Active = True
      BoundLabel.Caption = 'Free : '
      ItemIndex = -1
      TabOrder = 3
    end
  end
end
