object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 830
  ClientWidth = 1266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sSplitter1: TsSplitter
    Left = 793
    Top = 65
    Height = 765
    OnResize = sSplitter1Resize
    ExplicitLeft = 789
    ExplicitTop = 71
  end
  object sg1: TAdvStringGrid
    Left = 0
    Top = 65
    Width = 793
    Height = 765
    Cursor = crDefault
    Align = alLeft
    Color = clWhite
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 2
    Options = [goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedRowDefAlign]
    ScrollBars = ssBoth
    TabOrder = 0
    GridLineColor = 15987699
    GridFixedLineColor = 15987699
    HoverRowCells = [hcNormal, hcSelected]
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDown.TextChecked = 'Checked'
    FilterDropDown.TextUnChecked = 'Unchecked'
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Larger than'
      'Smaller than'
      'Clear')
    FixedColWidth = 233
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    GridImages = sAlphaImageList1
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.ColorTo = clWhite
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SearchFooter.ResultFormat = '(%d of %d)'
    ShowDesignHelper = False
    SortSettings.DefaultFormat = ssAutomatic
    Version = '8.4.7.0'
    ColWidths = (
      233
      234
      231
      198
      90)
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1266
    Height = 65
    Align = alTop
    Caption = 'sPanel1'
    TabOrder = 1
    object btSearch: TsButton
      Left = 136
      Top = 7
      Width = 122
      Height = 42
      Caption = 'Launch Search'
      TabOrder = 0
      OnClick = btSearchClick
    end
    object sButton1: TsButton
      Left = 8
      Top = 7
      Width = 122
      Height = 42
      Caption = 'FillList'
      TabOrder = 1
      OnClick = sButton1Click
    end
  end
  object btnLoadResults: TsButton
    Left = 264
    Top = 8
    Width = 106
    Height = 42
    Caption = 'Load Results'
    TabOrder = 2
    OnClick = btnLoadResultsClick
  end
  object sPanel2: TsPanel
    Left = 799
    Top = 65
    Width = 467
    Height = 765
    Align = alClient
    Caption = 'sPanel2'
    TabOrder = 3
    object sPnVariable: TsPanel
      Left = 1
      Top = 1
      Width = 465
      Height = 763
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 447
      object sgImg: TAdvStringGrid
        Left = 1
        Top = 1
        Width = 463
        Height = 671
        Cursor = crDefault
        Align = alClient
        Color = clWhite
        ColCount = 3
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goVertLine, goHorzLine, goRangeSelect, goFixedRowDefAlign]
        ScrollBars = ssBoth
        TabOrder = 0
        GridLineColor = 15987699
        GridFixedLineColor = 15987699
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.ColorTo = clWhite
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SearchFooter.ResultFormat = '(%d of %d)'
        ShowDesignHelper = False
        SortSettings.DefaultFormat = ssAutomatic
        Version = '8.4.7.0'
        ExplicitHeight = 445
      end
      object pnOptionsImages: TsPanel
        Left = 1
        Top = 672
        Width = 463
        Height = 90
        Align = alBottom
        TabOrder = 1
        object sButton2: TsButton
          Left = 1
          Top = 1
          Width = 112
          Height = 88
          Align = alLeft
          Caption = 'Previous'
          TabOrder = 0
          ExplicitLeft = 4
          ExplicitTop = 6
        end
        object sButton3: TsButton
          Left = 350
          Top = 1
          Width = 112
          Height = 88
          Align = alRight
          Caption = 'Next'
          TabOrder = 1
          OnClick = sButton3Click
          ExplicitTop = 6
        end
      end
    end
  end
  object sSkinManager1: TsSkinManager
    ButtonsOptions.OldGlyphsMode = False
    InternalSkins = <>
    SkinDirectory = 'C:\Users\yvesg\git\Components\acnt_regdx10sydney\Skins'
    SkinName = 'Black Box'
    SkinInfo = '15'
    ThirdParty.ThirdEdits = ' '
    ThirdParty.ThirdButtons = 'TButton'
    ThirdParty.ThirdBitBtns = ' '
    ThirdParty.ThirdCheckBoxes = ' '
    ThirdParty.ThirdGroupBoxes = ' '
    ThirdParty.ThirdListViews = ' '
    ThirdParty.ThirdPanels = ' '
    ThirdParty.ThirdGrids = ' '
    ThirdParty.ThirdTreeViews = ' '
    ThirdParty.ThirdComboBoxes = ' '
    ThirdParty.ThirdWWEdits = ' '
    ThirdParty.ThirdVirtualTrees = ' '
    ThirdParty.ThirdGridEh = ' '
    ThirdParty.ThirdPageControl = ' '
    ThirdParty.ThirdTabControl = ' '
    ThirdParty.ThirdToolBar = ' '
    ThirdParty.ThirdStatusBar = ' '
    ThirdParty.ThirdSpeedButton = ' '
    ThirdParty.ThirdScrollControl = ' '
    ThirdParty.ThirdUpDown = ' '
    ThirdParty.ThirdScrollBar = ' '
    ThirdParty.ThirdStaticText = ' '
    ThirdParty.ThirdNativePaint = ' '
    Left = 1184
    Top = 512
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 1192
    Top = 576
  end
  object sPathDialog1: TsPathDialog
    Root = 'rfDesktop'
    Left = 824
    Top = 465
  end
  object sAlphaImageList1: TsAlphaImageList
    Height = 24
    Width = 24
    Items = <
      item
        ImageFormat = ifPNG
        ImageName = 'check'
        ImgData = {
          89504E470D0A1A0A0000000D4948445200000018000000180803000000D7A9CD
          CA0000000373424954080808DBE14FE00000000970485973000000A6000000A6
          01DD7DFF380000001974455874536F667477617265007777772E696E6B736361
          70652E6F72679BEE3C1A00000069504C5445FFFFFFAAFF55AAEE779FEF80A5F0
          78A3EA78A5EA75A8EB79A3EB76A6EC7993D3719CDF71A4EC7996D56CA6EC77A4
          EA79A6EB7796D66CA5EB78A2E67596D46C94D46BA5EB79A5EB79A5EB78A5EB77
          A6EB78A5EB78A5EB78A4EB7895D56C96D66DA1E575A2E776A5EB78C12C56AC00
          00001F74524E5300030F1011242526272834485F6178878FA0A4A5A7B2C9CBCC
          CDE4E5E6E7FC5245403E0000006D4944415428CFB5D1470E80300C4451D33BA1
          F73AF73F242220A104B3C4CBF737B64CF4EB3899C1FB80822BEE00A03478DFD7
          EAE5A3F425D1DC533C36794FD15897FB93EA406BF10E74B6EE2464406F07B3B6
          CF5DE4A87B8A0F7FCAFB2EF1E157E1FC2C1BEB44519D877F3DFE00F5BE131CFF
          B492110000000049454E44AE426082}
      end
      item
        ImageFormat = ifPNG
        ImageName = 'effective'
        ImgData = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000473424954080808087C086488000000097048597300000093000000
          93012BFBAB900000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A000004864944415448898D96696C545514C77FE7BE
          F7A6C31418028804182112A06A4440400401E392B02B2811252286488C46B19A
          20A81FF083043796403456A21283214410644B208110210AD4B22B8540D8318D
          6C2D6D67DE728F1F3AD3CE940AFCBF9DE5FECFFF9CFBEEBB57B805C66D38D7D5
          783245E14954EE0392D95035CA6160A76782956B47F5B8945B33B3BCDC2B1B38
          30C8D9D212F1E8CDE7BBB9C27C90A980B99508201291952EFE9C10B74495DE1B
          4677FB2617BC69F1842D1727B9227F83BC7C07E4008EAA4E0BD43BA62A1B41C2
          FCA0FBF8BC1DEE8D765D67800D13491EACBF76759A885831F84E513CE6C48AEE
          A006006D012E9FBAD237DF29000316560E37C266A0752E509CB42712EDDD5E6E
          5102A016D80D7A1A2444E985F018D0AA7995B3E567AEC68ADBBFBEEFDD92D500
          2E8067BCE39106517EA2B58025A3E807C62FFAF6D767EEAAC98F4FDE51D53A9D
          0ECA80170B4B18A322CBFB2F3DB66BFF5B25175D80C8065F24624ED2AA920E2D
          00912F75A13061CBE86E5B5B9A47269DB9174C09C8DEBA7F6B8BEA6B32AD6C18
          1AB029A0C884F209F0AAF45F7AAC8B13CAD9D6458E13582513D81CC79EF2D23E
          43F24975D3805200195BB128DF3FE0B33F8783B705638A8D18300E40A44429D7
          89CCD4B82B4EC273A8BAE1E7766615AABD1B48077586A014E400E8470DBEFEFF
          80F6C30FCB64E2919315B31FFE6DD0A2E3F314FD3CAFAE2398175C5447B6897B
          8456733AEBEABDE8B5E2B4DBB3C10E4A4166379BD04FF8D560FD91C01000E348
          5914D98F411279794F18A06FDC75A86BDAE35D47DF7CE0C6DEF7FA1CCCB67320
          5BB806980BCC2553EDE35F03645FE33CDFEE558DCAEF853AE47E03DAC173208C
          343B1D73B271E61B07BC032CC926CF97B1FB17C8D8FD0BC0DF0940947E437F4E
          FDD2C4C7490A71B70191FC1F868A6DF1F7019A9FA52DE7DC046B80AA2004D791
          1C4FCF4641E32A1603B300C8D4CCD335A96DBA26B59530FD34004EFC2B79FEDC
          C4A6BA34AECDDA975D94A317AEA7BBDB265143877D7AACCDEEF74BB2074BFBE1
          5F87E07A0C78AA59578300067F59F99017EAA98C6118F9BD09878CC2765BD871
          71DA93998D961F9661833DB8C5CB10A38851DCE265B8893D68F1CC8639E87799
          2229438937EB6067EEA09D030C36C2AA056B6B236B471D9CD36F5741FEDAD43A
          009974EED97CFFC045957F008F1476472841981280418B2A7F507825A8B9E2C7
          93F1338EE769ABB6B1BA44C7D619543D63EDF4F5635387690163D61F1F71ED82
          5DE267A45FBE5F60C5BED23ED35D0057F930109E132351A7DE9D7A3549561456
          69183FDD9C78F2B693C9FA303E53A3609E1B4B9FF73305E11A4B34375BA80183
          17564EF46BAF2C4F0DBCA77D0B42EB15760B9C018D407A028F02098D226AAA6A
          4FD45E374DC2D03A0BE32B4A4BB6177CF343BFFE6B71871EC9592D8DE2FFA0D6
          12D4D6F8D69206C2FA3AF363BA9AC36AF1DA545F5AEEE62777EC9E3CA4500784
          646FA8DB418C21D626190332A8CCD836A5CBBAFC78C19DABA21EAAE323EBF501
          59912D743B4428DF8B13956C1853480ECD5E15CD9F1C6336557536C67F499011
          405FA05D56CA55458E1891ED2EFEEAFC674B73FC07484AE8DAE486869D000000
          0049454E44AE426082}
      end
      item
        ImageFormat = ifPNG
        ImageName = 'search'
        ImgData = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000473424954080808087C0864880000000970485973000000A6000000
          A601DD7DFF380000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A0000039C494441544889ADD44D4C5C551407F0FFB9
          F7CDCC6398E08CD06987049136864A958F46AB0BD9F8D105D345CBC2C4B43576
          A14997C6A42BB7C618BB302E6C88D18D1B6214A3495DE8424D2D2A3269340428
          155A8614284E81C29BC77BEF7E1C170822EA0CADFC972FEFDCDF3937F75E6266
          6CCD6871B14D82DFB4C0FE489B6C39D20E030580872DD1C5EED6C6CBB88BD056
          607CA6745E1B3E5B8E74D253EC8F95F4DC8A62F3488393A977690F0026C2052F
          94E78EB6EF2DDF15305EBC5DF0953EFCDB62343F3011D40829EA5C47523C2660
          2CC31A5E6AABA7D92773B143004F59D64F753FDC3C570D7000607CBAF4B6A7CC
          E12F27D7264616D4816CDA9599640C49470000EE4406A1E1CC4C80CCEDA21DEA
          79403C2628FE3E8063D500315A5C6CD3C0D9A9A5687E64411D68CEA6644BDA45
          B6C6412A26908A092424AD8F4BC09A1547AE94F812C0F9C1ABB367AA0292F88D
          D540D50E4C0435D9B42BF7251DC42581012C0606C5558595C8FEADE8BA474F78
          0A33CCF46A55405B6EF135FB428ABA7432B6B9F8CDB2C27264A0B79D320060C0
          2DFA7403E0B642612E59113096F78D95F49CEB48AA91EB7BBE141844E69F0B6F
          CD2D9F1980F453DC5511F042155B516CE231B1F9D153B642C97A948563991145
          AAB322C040A1BDC1C918CBB81319FCBEA6FF755BB6A73EC12AD2066C31581100
          7838E3D21EB6585496B1BA83EE0120574B6963D97BB6A3F94A45C0125D04C087
          1AC4CD1D340E00484A1ECAB9DCC19627AAFD2BBA5B1B2F13E1C291BDF2D1A4C3
          3F552B20A0F474233DE887DA33E0DEAA000078A13C07F0544F133DBE3FC5DF11
          10FC57E7F92658363AEB9583D59EAE9699AA0D6DBC4597C6A673EBD79FF39EC2
          4CD1A71BB77C6665E1D42758E56A299D73B9C30FB5E79583D5D272399710F6E7
          CC27A73E9C77521FBCD237AC2A021B19BC3A7B66FD86721B0069991169036DB8
          0CB6D70C70BCA7ABA5F8F9D73FBEC3DFBC75A2CEBBDAE4AFF1B710B5F9637DC3
          7E55602385C25CD24F715714A94EB618DC7E5A065E6A7D4D299C771CC2FDF709
          ACF8FC83138FE5F3EFFDBAB423A05A3E7AB1A3D651C1B4D15C1F4F1012AE0080
          1123E9686FDFE8E6337ECF00007CD6DB910DE2C1A4319CDA825C67A99F3BDE77
          6D12F8F314DD6B4E0CFCB220603B854018858C30B000D042C6F9FE8B970FB6FF
          EF0936F2E90B0F7585460C5966E7AF497859477C72570000E83FD5FA8C51FC15
          5B880D240C7962D70000F8F8F4C1E75568FB99414212046165570100E83FD97A
          DA6A7E9788A48CD3EB7F00D049F113C8FB96B10000000049454E44AE426082}
      end>
    Left = 736
    Top = 193
    Bitmap = {}
  end
end
