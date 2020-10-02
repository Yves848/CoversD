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
    object sImage1: TsImage
      Left = 32
      Top = 192
      Width = 217
      Height = 209
      Picture.Data = {07544269746D617000000000}
    end
    object sButton1: TsButton
      Left = 6
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Browse'
      TabOrder = 0
      OnClick = sButton1Click
    end
    object sButton2: TsButton
      Left = 111
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Tags'
      TabOrder = 1
      OnClick = sButton2Click
    end
    object pb1: TsProgressBar
      Left = 6
      Top = 64
      Width = 723
      Height = 17
      TabOrder = 2
    end
    object sButton3: TsButton
      Left = 216
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Search'
      TabOrder = 3
      OnClick = sButton3Click
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
    UpdateOptions.UpdateTableName = 'MediaFile'
    TableName = 'MediaFile'
    Left = 832
    Top = 120
  end
  object qMedias: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from MediaFile')
    Left = 801
    Top = 272
  end
  object qTags: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'insert into Covers (MediaId, cover) values (:MediaId, :cover)')
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
        Name = 'COVER'
        ParamType = ptInput
      end>
  end
  object qSearchTag: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select cover from tags where mediaId = :Id')
    Left = 889
    Top = 336
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
end
