object fSelectDirectory: TfSelectDirectory
  Left = 0
  Top = 0
  Caption = 'fSelectDirectory'
  ClientHeight = 501
  ClientWidth = 1026
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object tv1: TsShellTreeView
    Left = 0
    Top = 0
    Width = 281
    Height = 501
    Align = alLeft
    BevelInner = bvNone
    Indent = 19
    RowSelect = False
    TabOrder = 0
    ObjectTypes = [otFolders, otNonFolders]
    Root = 'rfMyComputer'
    UseShellImages = True
    AutoRefresh = False
    ShowExt = seSystem
  end
  object sPanel1: TsPanel
    Left = 281
    Top = 0
    Width = 745
    Height = 501
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 287
    object sButton1: TsButton
      Left = 6
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Browse'
      TabOrder = 0
      OnClick = sButton1Click
    end
    object Memo1: TAdvMemo
      Left = 6
      Top = 96
      Width = 723
      Height = 377
      Cursor = crIBeam
      ActiveLineSettings.ShowActiveLine = False
      ActiveLineSettings.ShowActiveLineIndicator = False
      AutoCompletion.Font.Charset = DEFAULT_CHARSET
      AutoCompletion.Font.Color = clWindowText
      AutoCompletion.Font.Height = -11
      AutoCompletion.Font.Name = 'Tahoma'
      AutoCompletion.Font.Style = []
      AutoCompletion.StartToken = '(.'
      AutoCorrect.Active = True
      AutoHintParameterPosition = hpBelowCode
      BookmarkGlyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFD25252525
        2525252525252525FDFDFD2E25FFFFFFFFFFFFFFFFFFFF25FDFDFD2525252525
        2525252525252525FDFD9A9AB7B7B7B7B7B7B7B7B7B72525FDFDFD25B7B7B7B7
        B7B7B7B7B7B72525FDFD9A9AB7B7B7B7B7B7B7B7B7B72525FDFDFD25BFB7BFBF
        B7B7B7B7B7B72525FDFD9A9ABFBFBFB7BFBFB7B7B7B72525FDFDFD25BFBFBFBF
        BFB7BFBFB7B72525FDFD9A9ABFBFBFB7BFBFBFB7BFB72525FDFDFD25BFBFBFBF
        BFBFBFBFBFB72525FDFD9A9ABFBFBFBFBFB7BFBFB7B72525FDFDFD25BFBFBFBF
        BFBFBFBFBFB72525FDFD9A9ABFBFBFBFBFBFBFBFBFB725FDFDFDFD2525252525
        25252525252525FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
      BorderColor = 15987699
      BorderStyle = bsSingle
      ClipboardFormats = [cfText]
      CodeFolding.Enabled = False
      CodeFolding.LineColor = clGray
      Ctl3D = False
      DelErase = True
      EnhancedHomeKey = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -13
      Gutter.Font.Name = 'Courier New'
      Gutter.Font.Style = []
      Gutter.BorderColor = 15987699
      Gutter.GutterColor = clWhite
      Gutter.GutterColorTo = clNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'COURIER NEW'
      Font.Style = []
      HiddenCaret = False
      Lines.Strings = (
        '')
      MarkerList.UseDefaultMarkerImageIndex = False
      MarkerList.DefaultMarkerImageIndex = -1
      MarkerList.ImageTransparentColor = 33554432
      OleDropTarget = []
      PrintOptions.MarginLeft = 0
      PrintOptions.MarginRight = 0
      PrintOptions.MarginTop = 0
      PrintOptions.MarginBottom = 0
      PrintOptions.PageNr = False
      PrintOptions.PrintLineNumbers = False
      RightMarginColor = 14869218
      ScrollHint = False
      SelColor = clBlack
      SelBkColor = clNavy
      ShowRightMargin = True
      SmartTabs = False
      TabOrder = 1
      TabStop = True
      TrimTrailingSpaces = False
      UILanguage.ScrollHint = 'Row'
      UILanguage.Undo = 'Undo'
      UILanguage.Redo = 'Redo'
      UILanguage.Copy = 'Copy'
      UILanguage.Cut = 'Cut'
      UILanguage.Paste = 'Paste'
      UILanguage.Delete = 'Delete'
      UILanguage.SelectAll = 'Select All'
      UrlStyle.TextColor = clBlue
      UrlStyle.BkColor = clWhite
      UrlStyle.Style = [fsUnderline]
      UseStyler = True
      Version = '3.6.6.0'
      WordWrap = wwNone
    end
    object sButton2: TsButton
      Left = 111
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Tags'
      TabOrder = 2
      OnClick = sButton2Click
    end
    object pb1: TsProgressBar
      Left = 6
      Top = 64
      Width = 723
      Height = 17
      TabOrder = 3
    end
  end
  object FDConnection1: TFDConnection
    ConnectionName = 'postgres'
    Params.Strings = (
      'DriverID=SQLite'
      'Server=localhost'
      'Database=C:\Git\CoversD\Medias.db'
      'LockingMode=Normal')
    Connected = True
    LoginPrompt = False
    Left = 832
    Top = 56
  end
  object tMedias: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'MediasFiles'
    TableName = 'MediasFiles'
    Left = 832
    Top = 120
  end
  object qMedias: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from MediasFiles')
    Left = 801
    Top = 272
  end
  object qTags: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'insert into Tags (MediaId, Artist, Title, Album) values (:MediaI' +
        'd, :Artist, :Title, :Album)')
    Left = 849
    Top = 248
    ParamData = <
      item
        Name = 'MediaId'
        DataType = ftInteger
        FDDataType = dtInt16
        ParamType = ptInput
      end
      item
        Name = 'ARTIST'
        ParamType = ptInput
      end
      item
        Name = 'TITLE'
        ParamType = ptInput
      end
      item
        Name = 'ALBUM'
        ParamType = ptInput
      end>
  end
end
