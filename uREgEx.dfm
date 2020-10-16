object fRegEx: TfRegEx
  Left = 0
  Top = 0
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'RegEx'
  ClientHeight = 498
  ClientWidth = 961
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
    Width = 961
    Height = 498
    Align = alClient
    DoubleBuffered = True
    ParentDoubleBuffered = False
    SideShadow.Mode = ssmInternal
    SideShadow.Side = asBottom
    TabOrder = 0
    object sSpeedButton1: TsSpeedButton
      Left = 327
      Top = 32
      Width = 23
      Height = 22
      Caption = '+'
    end
    object sSpeedButton2: TsSpeedButton
      Left = 327
      Top = 63
      Width = 23
      Height = 22
      Caption = '+'
    end
    object sSpeedButton3: TsSpeedButton
      Left = 326
      Top = 93
      Width = 23
      Height = 22
      Caption = '+'
    end
    object sSpeedButton4: TsSpeedButton
      Left = 326
      Top = 124
      Width = 23
      Height = 22
      Caption = '+'
    end
    object sLResult: TsLabelFX
      Left = 71
      Top = 190
      Width = 402
      Height = 15
      AutoSize = False
      Caption = 'sLResult'
      Angle = 0
      Shadow.OffsetKeeper.LeftTop = 0
      Shadow.OffsetKeeper.RightBottom = 2
    end
    object sComboBox1: TsComboBox
      Left = 72
      Top = 32
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
      Left = 71
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
    object seSource: TsEdit
      Left = 71
      Top = 163
      Width = 402
      Height = 21
      TabOrder = 4
      Text = 
        '208-george_michael_and_elton_john-dont_let_the_sun_go_down_on_me' +
        '.mp3'
    end
    object seFrom: TsEdit
      Left = 72
      Top = 211
      Width = 130
      Height = 21
      TabOrder = 5
      Text = '_'
    end
    object seTo: TsEdit
      Left = 219
      Top = 211
      Width = 130
      Height = 21
      TabOrder = 6
      Text = '*'
    end
    object sButton1: TsButton
      Left = 72
      Top = 248
      Width = 75
      Height = 25
      Caption = 'sButton1'
      TabOrder = 7
      OnClick = sButton1Click
    end
  end
end
