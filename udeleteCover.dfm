object fDeleteCover: TfDeleteCover
  Left = 0
  Top = 0
  Caption = 'fDeleteCover'
  ClientHeight = 501
  ClientWidth = 1026
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sButton1: TsButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'sButton1'
    TabOrder = 0
    OnClick = sButton1Click
  end
  object sSB1: TsScrollBox
    Left = 105
    Top = 8
    Width = 865
    Height = 485
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Style = ssHotTrack
    VertScrollBar.Tracking = True
    AutoMouseWheel = True
    TabOrder = 1
  end
  object sButton2: TsButton
    Left = 24
    Top = 39
    Width = 75
    Height = 25
    Caption = 'sButton2'
    TabOrder = 2
    OnClick = sButton2Click
  end
end
