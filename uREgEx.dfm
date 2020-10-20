object fRegEx: TfRegEx
  Left = 0
  Top = 0
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'RegEx'
  ClientHeight = 138
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 367
    Height = 138
    Align = alClient
    DoubleBuffered = True
    ParentDoubleBuffered = False
    SideShadow.Mode = ssmInternal
    SideShadow.Side = asBottom
    TabOrder = 0
    ExplicitWidth = 387
    ExplicitHeight = 171
    object sBtnFields: TsSpeedButton
      Left = 327
      Top = 33
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = sBtnFieldsClick
    end
    object sBtnSeparators: TsSpeedButton
      Left = 327
      Top = 65
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = sBtnSeparatorsClick
    end
    object sBtnCounters: TsSpeedButton
      Left = 327
      Top = 93
      Width = 23
      Height = 22
      Caption = '+'
      OnClick = sBtnCountersClick
    end
    object sCBField: TsComboBox
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
    object sCBSeperators: TsComboBox
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
    object sCBCounters: TsComboBox
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
  end
end
