object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 683
  ClientWidth = 1356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 650
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object pb1: TProgressBar
    Left = 89
    Top = 658
    Width = 464
    Height = 17
    TabOrder = 1
  end
  object tv1: TsTreeView
    Left = 8
    Top = 8
    Width = 305
    Height = 636
    Indent = 19
    TabOrder = 2
    OnChange = tv1Change
    OnExpanding = tv1Expanding
  end
  object sMemo1: TsMemo
    Left = 352
    Top = 48
    Width = 841
    Height = 449
    Lines.Strings = (
      'sMemo1')
    TabOrder = 3
    Text = 'sMemo1'
  end
  object sButton1: TsButton
    Left = 496
    Top = 576
    Width = 75
    Height = 25
    Caption = 'sButton1'
    TabOrder = 4
    OnClick = sButton1Click
  end
  object thListMP3: TJvThread
    Exclusive = True
    MaxCount = 0
    RunOnCreate = True
    FreeOnTerminate = True
    ThreadName = 'listMP3'
    OnExecute = thListMP3Execute
    Left = 704
    Top = 512
  end
  object JvThreadSimpleDialog1: TJvThreadSimpleDialog
    DialogOptions.FormStyle = fsNormal
    DialogOptions.ShowDialog = True
    DialogOptions.CancelButtonCaption = 'Cancel'
    DialogOptions.Caption = 'Liste des MP3'
    DialogOptions.InfoText = 'test'
    DialogOptions.ShowProgressBar = True
    OnPressCancel = JvThreadSimpleDialog1PressCancel
    ChangeThreadDialogOptions = JvThreadSimpleDialog1ChangeThreadDialogOptions
    Left = 800
    Top = 544
  end
  object sOpenDialog1: TsOpenDialog
    Left = 936
    Top = 552
  end
end
