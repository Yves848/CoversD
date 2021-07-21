object fTestGrid: TfTestGrid
  Left = 0
  Top = 0
  Caption = 'fTestGrid'
  ClientHeight = 623
  ClientWidth = 1167
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object sScrollBox1: TsScrollBox
    Left = 481
    Top = 0
    Width = 686
    Height = 623
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 486
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 623
    Align = alLeft
    TabOrder = 1
    ExplicitLeft = -4
    object sButton1: TsButton
      Left = 24
      Top = 24
      Width = 145
      Height = 73
      Caption = 'sButton1'
      TabOrder = 0
      OnClick = sButton1Click
    end
    object sMemo1: TsMemo
      Left = 1
      Top = 352
      Width = 479
      Height = 270
      Align = alBottom
      TabOrder = 1
      ExplicitLeft = -4
      ExplicitTop = 353
    end
    object sButton2: TsButton
      Left = 24
      Top = 103
      Width = 145
      Height = 36
      Caption = 'sButton2'
      TabOrder = 2
      OnClick = sButton2Click
    end
  end
end
