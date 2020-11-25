object DMDati: TDMDati
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 239
  Width = 293
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=C:\Users\nicola.chinea\Documents\Nibbler.sdb'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = FDConnectionBeforeConnect
    Left = 128
    Top = 104
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 80
    Top = 32
  end
  object FDScript: TFDScript
    SQLScripts = <
      item
        Name = 'init'
        SQL.Strings = (
          'CREATE TABLE  IF NOT EXISTS A_HIGHSCORE ('
          '  ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
          '  NOME VARCHAR(100), '
          '  DATA DATE,'
          '  PUNTI INTEGER, '
          '  LIVELLO INTEGER);'
          ''
          'CREATE TABLE  IF NOT EXISTS A_LIVELLI ('
          '  ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
          '  ID_HIGH INTEGER, '
          '  CUORI INTEGER, '
          '  PERLE INTEGER, '
          '  TEMPO VARCHAR(50), '
          '  PUNTI INTEGER, '
          '  LIVELLO INTEGER, '
          '  MALUS INTEGER, '
          '  MURA INTEGER);')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 64
    Top = 104
  end
  object T_Livelli: TFDTable
    IndexFieldNames = 'ID_HIGH'
    MasterSource = D_HIGHSCORE
    MasterFields = 'ID'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'A_LIVELLI'
    TableName = 'A_LIVELLI'
    Left = 192
    Top = 160
    object T_LivelliID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object T_LivelliID_HIGH: TIntegerField
      FieldName = 'ID_HIGH'
      Origin = 'ID_HIGH'
    end
    object T_LivelliCUORI: TIntegerField
      FieldName = 'CUORI'
      Origin = 'CUORI'
    end
    object T_LivelliPERLE: TIntegerField
      FieldName = 'PERLE'
      Origin = 'PERLE'
    end
    object T_LivelliTEMPO: TStringField
      FieldName = 'TEMPO'
      Origin = 'TEMPO'
      Size = 50
    end
    object T_LivelliPUNTI: TIntegerField
      FieldName = 'PUNTI'
      Origin = 'PUNTI'
    end
    object T_LivelliLIVELLO: TIntegerField
      FieldName = 'LIVELLO'
      Origin = 'LIVELLO'
    end
    object T_LivelliMALUS: TIntegerField
      FieldName = 'MALUS'
      Origin = 'MALUS'
    end
    object T_LivelliMURA: TIntegerField
      FieldName = 'MURA'
      Origin = 'MURA'
    end
  end
  object T_HIGHSCORE: TFDTable
    IndexFieldNames = 'ID'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'A_HIGHSCORE'
    TableName = 'A_HIGHSCORE'
    Left = 216
    Top = 80
    object T_HIGHSCOREID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object T_HIGHSCOREDATA: TDateField
      FieldName = 'DATA'
      Origin = 'DATA'
    end
    object T_HIGHSCORENOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object T_HIGHSCOREPUNTI: TIntegerField
      FieldName = 'PUNTI'
      Origin = 'PUNTI'
    end
    object T_HIGHSCORELIVELLO: TIntegerField
      FieldName = 'LIVELLO'
      Origin = 'LIVELLO'
    end
  end
  object Q_HallFame: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select * from A_HIGHSCORE order by punti Desc')
    Left = 128
    Top = 176
  end
  object D_HIGHSCORE: TDataSource
    DataSet = T_HIGHSCORE
    Left = 216
    Top = 32
  end
end
