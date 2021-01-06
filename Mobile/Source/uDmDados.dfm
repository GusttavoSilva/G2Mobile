object DmDados: TDmDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 391
  Width = 597
  object memProdutoInfo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 233
    Top = 328
    object memProdutoInfocod_prod: TIntegerField
      FieldName = 'cod_prod'
    end
    object memProdutoInfodesc_rel: TStringField
      FieldName = 'desc_rel'
      Size = 60
    end
    object memProdutoInfoclassific_fiscal: TStringField
      FieldName = 'classific_fiscal'
      Size = 10
    end
    object memProdutoInfoncm: TStringField
      FieldName = 'ncm'
    end
    object memProdutoInfocest: TStringField
      FieldName = 'cest'
      Size = 25
    end
    object memProdutoInfosexo: TStringField
      FieldName = 'sexo'
      Size = 2
    end
    object memProdutoInfovalor_prod: TFloatField
      FieldName = 'valor_prod'
    end
    object memProdutoInfovalidade: TIntegerField
      FieldName = 'validade'
    end
    object memProdutoInfodesc_fat: TStringField
      FieldName = 'desc_fat'
      Size = 60
    end
    object memProdutoInfogrupo_com: TIntegerField
      FieldName = 'grupo_com'
    end
    object memProdutoInfoicms: TFloatField
      FieldName = 'icms'
    end
    object memProdutoInfopis_cofins: TIntegerField
      FieldName = 'pis_cofins'
    end
    object memProdutoInfounid_med: TStringField
      FieldName = 'unid_med'
      Size = 10
    end
    object memProdutoInfoaliq_pis: TFloatField
      FieldName = 'aliq_pis'
    end
    object memProdutoInfocst_pis: TStringField
      FieldName = 'cst_pis'
      Size = 2
    end
    object memProdutoInfoaliq_cofins: TFloatField
      FieldName = 'aliq_cofins'
    end
    object memProdutoInfocst_cofins: TStringField
      FieldName = 'cst_cofins'
      Size = 2
    end
    object memProdutoInfocst_ext: TStringField
      FieldName = 'cst_ext'
      Size = 3
    end
    object memProdutoInfotara_emb_pri: TFloatField
      FieldName = 'tara_emb_pri'
    end
    object memProdutoInfotara_emp_sec: TFloatField
      FieldName = 'tara_emp_sec'
    end
    object memProdutoInfovalor_min: TFloatField
      FieldName = 'valor_min'
    end
    object memProdutoInfodesc_ind: TStringField
      FieldName = 'desc_ind'
      Size = 255
    end
    object memProdutoInfopeso_padrao: TFloatField
      FieldName = 'peso_padrao'
    end
  end
  object memVendasProd: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 233
    Top = 184
    object memVendasProdcod_nota: TIntegerField
      FieldName = 'cod_nota'
    end
    object memVendasProdcod_prod: TIntegerField
      FieldName = 'cod_prod'
    end
    object memVendasProddescricao: TStringField
      FieldName = 'descricao'
      Size = 60
    end
    object memVendasProdncm: TStringField
      FieldName = 'ncm'
      Size = 8
    end
    object memVendasProdquant: TFloatField
      FieldName = 'quant'
    end
    object memVendasProdvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object memVendasProdvalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object memVendasProddata_emissao: TSQLTimeStampField
      FieldName = 'data_emissao'
    end
  end
  object memVendas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 137
    Top = 232
    object memVendascod_nota: TIntegerField
      FieldName = 'cod_nota'
    end
    object memVendaspedido: TStringField
      FieldName = 'pedido'
      Size = 60
    end
    object memVendasnfeaprovada: TStringField
      FieldName = 'nfeaprovada'
      Size = 3
    end
    object memVendasforma_pgto: TIntegerField
      FieldName = 'forma_pgto'
    end
    object memVendasvr_total_nota: TFloatField
      FieldName = 'vr_total_nota'
    end
    object memVendasdata_emissao: TSQLTimeStampField
      FieldName = 'data_emissao'
    end
    object memVendascod_pessoa: TIntegerField
      FieldName = 'cod_pessoa'
    end
  end
  object memFichaFinanceira: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 33
    Top = 184
    object memFichaFinanceiranum_ped: TIntegerField
      FieldName = 'num_ped'
    end
    object memFichaFinanceiradata_venc: TSQLTimeStampField
      FieldName = 'data_venc'
    end
    object memFichaFinanceiranum_parc: TIntegerField
      FieldName = 'num_parc'
    end
    object memFichaFinanceiraparcela: TIntegerField
      FieldName = 'parcela'
    end
    object memFichaFinanceirastatus: TStringField
      FieldName = 'status'
      Size = 2
    end
    object memFichaFinanceiradata_emis: TSQLTimeStampField
      FieldName = 'data_emis'
    end
    object memFichaFinanceiravlr_tit: TFloatField
      FieldName = 'vlr_tit'
    end
    object memFichaFinanceirastatus1: TStringField
      FieldName = 'status1'
      Size = 255
    end
  end
  object memNfeInfo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 33
    Top = 232
    object memNfeInfodescricao: TStringField
      FieldName = 'descricao'
      Size = 60
    end
    object memNfeInfoquant: TFloatField
      FieldName = 'quant'
    end
    object memNfeInfovalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object memNfeInfodata_emissao: TSQLTimeStampField
      FieldName = 'data_emissao'
    end
    object memNfeInfocod_nota: TIntegerField
      FieldName = 'cod_nota'
    end
    object memNfeInfovalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object memNfeInfoncm: TStringField
      FieldName = 'ncm'
      Size = 8
    end
    object memNfeInfocfop: TStringField
      FieldName = 'cfop'
      Size = 6
    end
    object memNfeInfovalor_icms: TFloatField
      FieldName = 'valor_icms'
    end
    object memNfeInfovalor_ipi: TFloatField
      FieldName = 'valor_ipi'
    end
  end
  object memClienteSincold: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 280
    object memClienteSincoldcod_pessoa: TIntegerField
      FieldName = 'cod_pessoa'
    end
    object memClienteSincoldnome_razao: TStringField
      FieldName = 'nome_razao'
      Size = 80
    end
    object memClienteSincoldnome_fant: TStringField
      FieldName = 'nome_fant'
      Size = 80
    end
    object memClienteSincoldendereco: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object memClienteSincoldbairro: TStringField
      FieldName = 'bairro'
      Size = 30
    end
    object memClienteSincoldmunicipio: TStringField
      FieldName = 'municipio'
    end
    object memClienteSincoldtelefone: TStringField
      FieldName = 'telefone'
      Size = 15
    end
    object memClienteSincoldcpf_cnpj: TStringField
      FieldName = 'cpf_cnpj'
      Size = 14
    end
    object memClienteSincoldemail: TStringField
      FieldName = 'email'
      Size = 120
    end
    object memClienteSincoldcod_vend: TIntegerField
      FieldName = 'cod_vend'
    end
    object memClienteSincoldcredito: TIntegerField
      FieldName = 'credito'
    end
    object memClienteSincoldatraso: TIntegerField
      FieldName = 'atraso'
    end
    object memClienteSincoldcod_doc: TIntegerField
      FieldName = 'cod_doc'
    end
    object memClienteSincolddt_visitar: TDateField
      FieldName = 'dt_visitar'
    end
    object memClienteSincoldcrd_permitido: TFloatField
      FieldName = 'crd_permitido'
    end
    object memClienteSincoldVlr_Pagar: TFloatField
      FieldName = 'Vlr_Pagar'
    end
    object memClienteSincoldcdr_disponivel: TFloatField
      FieldName = 'cdr_disponivel'
    end
    object memClienteSincoldcomissao: TIntegerField
      FieldName = 'comissao'
    end
  end
  object memResumo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 328
    object memResumodsc_anm: TStringField
      FieldName = 'dsc_anm'
      Size = 15
    end
    object memResumotot_qtd: TIntegerField
      FieldName = 'tot_qtd'
    end
    object memResumotot_kgs: TFloatField
      FieldName = 'tot_kgs'
    end
    object memResumotot_arb: TFloatField
      FieldName = 'tot_arb'
    end
    object memResumomed_arb: TFloatField
      FieldName = 'med_arb'
    end
    object memResumocls_pes: TStringField
      FieldName = 'cls_pes'
      Size = 25
    end
  end
  object memProdutoB: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 232
    Top = 280
    object IntegerField3: TIntegerField
      FieldName = 'cod_prod'
    end
    object StringField7: TStringField
      FieldName = 'desc_ind'
      Size = 80
    end
    object FloatField1: TFloatField
      FieldName = 'valor_prod'
    end
    object StringField8: TStringField
      FieldName = 'unid_med'
      Size = 10
    end
  end
  object memPedFinalizado: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 136
    Top = 280
    object memPedFinalizadocod_pedcar_mobile: TIntegerField
      FieldName = 'cod_pedcar_mobile'
    end
    object memPedFinalizadostatus: TIntegerField
      FieldName = 'status'
    end
    object memPedFinalizadovalor_final: TFloatField
      FieldName = 'valor_final'
    end
    object memPedFinalizadochave: TStringField
      FieldName = 'chave'
      Size = 255
    end
    object memPedFinalizadocod_pedcar: TStringField
      FieldName = 'cod_pedcar'
      Size = 255
    end
    object memPedFinalizadomotivo: TStringField
      FieldName = 'motivo'
      Size = 255
    end
  end
  object memVendasCP: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 136
    Top = 184
    object memVendasCPcontroleinterno: TIntegerField
      FieldName = 'controleinterno'
    end
    object memVendasCPvendedor: TStringField
      FieldName = 'vendedor'
    end
    object memVendasCPtotal: TFMTBCDField
      FieldName = 'total'
      Size = 0
    end
    object memVendasCPnome_fant: TStringField
      FieldName = 'nome_fant'
    end
    object memVendasCPcod_vendedor: TIntegerField
      FieldName = 'cod_vendedor'
    end
    object memVendasCPemissao: TWideStringField
      FieldName = 'emissao'
      Size = 0
    end
  end
  object memItemFinalizadoPed: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 136
    Top = 328
    object StringField9: TStringField
      FieldName = 'chave'
      Size = 255
    end
    object memItemFinalizadoPedtotal: TFloatField
      FieldName = 'total'
    end
    object memItemFinalizadoPedcod_prod: TIntegerField
      FieldName = 'cod_prod'
    end
  end
  object memClienteInf: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 232
    Top = 232
    object IntegerField9: TIntegerField
      FieldName = 'cod_pessoa'
    end
    object StringField19: TStringField
      FieldName = 'nome_razao'
      Size = 80
    end
    object StringField20: TStringField
      FieldName = 'nome_fant'
      Size = 80
    end
    object StringField21: TStringField
      FieldName = 'endereco'
      Size = 100
    end
    object StringField22: TStringField
      FieldName = 'bairro'
      Size = 30
    end
    object StringField23: TStringField
      FieldName = 'telefone'
      Size = 15
    end
    object StringField24: TStringField
      FieldName = 'cpf_cnpj'
      Size = 14
    end
    object StringField25: TStringField
      FieldName = 'email'
      Size = 120
    end
    object IntegerField10: TIntegerField
      FieldName = 'cod_vend'
    end
    object IntegerField11: TIntegerField
      FieldName = 'situacao'
    end
    object IntegerField12: TIntegerField
      FieldName = 'credito'
    end
    object IntegerField13: TIntegerField
      FieldName = 'atraso'
    end
    object IntegerField14: TIntegerField
      FieldName = 'cod_doc'
    end
    object StringField26: TStringField
      FieldName = 'municipio'
    end
    object StringField27: TStringField
      FieldName = 'cfop'
      Size = 5
    end
    object DateField2: TDateField
      FieldName = 'dt_visitar'
    end
    object FloatField5: TFloatField
      FieldName = 'crd_permitido'
    end
    object FloatField6: TFloatField
      FieldName = 'Vlr_Pagar'
    end
    object FloatField7: TFloatField
      FieldName = 'cdr_disponivel'
    end
  end
  object ConexaoInterna: TFDConnection
    Params.Strings = (
      'Database=C:\Users\BOOS\pictures\g2mobile.db'
      'LockingMode=Normal'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 136
    Top = 24
  end
  object qryAux: TFDQuery
    Connection = ConexaoInterna
    Left = 136
    Top = 80
  end
  object RESTDWDataBase1: TRESTDWDataBase
    Active = False
    Compression = True
    CriptOptions.Use = False
    CriptOptions.Key = 'RDWBASEKEY256'
    AuthenticationOptions.AuthorizationOption = rdwAOBasic
    AuthenticationOptions.OptionParams.AuthDialog = True
    AuthenticationOptions.OptionParams.CustomDialogAuthMessage = 'Protected Space...'
    AuthenticationOptions.OptionParams.Custom404TitleMessage = '(404) The address you are looking for does not exist'
    AuthenticationOptions.OptionParams.Custom404BodyMessage = '404'
    AuthenticationOptions.OptionParams.Custom404FooterMessage = 'Take me back to <a href="./">Home REST Dataware'
    AuthenticationOptions.OptionParams.Username = 'testserver'
    AuthenticationOptions.OptionParams.Password = 'testserver'
    Proxy = False
    ProxyOptions.Port = 8888
    PoolerService = '186.192.127.130'
    PoolerPort = 8099
    PoolerName = 'TServerMethodDM.RESTDWPoolerFD'
    StateConnection.AutoCheck = False
    StateConnection.InTime = 1000
    RequestTimeOut = 100000
    EncodeStrings = True
    Encoding = esUtf8
    StrsTrim = False
    StrsEmpty2Null = False
    StrsTrim2Len = False
    HandleRedirects = True
    RedirectMaximum = 2
    ParamCreate = False
    FailOver = True
    FailOverConnections = <>
    FailOverReplaceDefaults = True
    ClientConnectionDefs.Active = False
    UserAgent = 
      'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, l' +
      'ike Gecko) Chrome/41.0.2227.0 Safari/537.36'
    Left = 30
    Top = 63
  end
  object RESTClientPooler1: TRESTClientPooler
    DataCompression = True
    Encoding = esUtf8
    hEncodeStrings = True
    Host = 'localhost'
    AuthenticationOptions.AuthorizationOption = rdwAONone
    ProxyOptions.BasicAuthentication = False
    ProxyOptions.ProxyPort = 0
    RequestTimeOut = 10000
    ThreadRequest = False
    AllowCookies = False
    RedirectMaximum = 0
    HandleRedirects = False
    FailOver = False
    FailOverConnections = <>
    FailOverReplaceDefaults = False
    BinaryRequest = False
    CriptOptions.Use = False
    CriptOptions.Key = 'RDWBASEKEY256'
    UserAgent = 
      'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, l' +
      'ike Gecko) Chrome/41.0.2227.0 Safari/537.36'
    Left = 32
    Top = 16
  end
  object rdwSQL: TRESTDWClientSQL
    Active = False
    Filtered = False
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    BinaryCompatibleMode = False
    MasterCascadeDelete = True
    BinaryRequest = True
    Datapacks = -1
    DataCache = False
    MassiveType = mtMassiveCache
    Params = <>
    DataBase = RESTDWDataBase1
    CacheUpdateRecords = True
    AutoCommitData = False
    AutoRefreshAfterCommit = False
    RaiseErrors = True
    ActionCursor = crSQLWait
    ReflectChanges = False
    Left = 271
    Top = 72
  end
  object ImportFoto: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'cod_prod'
        DataType = ftInteger
      end
      item
        Name = 'foto'
        DataType = ftBlob
      end
      item
        Name = 'nome_arq'
        DataType = ftString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 288
    Top = 336
    object ImportFotoid: TIntegerField
      FieldName = 'id'
    end
    object ImportFotocod_prod: TIntegerField
      FieldName = 'cod_prod'
    end
    object ImportFotofoto: TBlobField
      FieldName = 'foto'
    end
    object ImportFotonome_arq: TStringField
      FieldName = 'nome_arq'
      Size = 255
    end
  end
  object FDLocalSQL1: TFDLocalSQL
    Active = True
    Left = 280
    Top = 288
  end
  object QImport: TFDQuery
    Connection = ConexaoInterna
    Left = 288
    Top = 256
  end
  object FDTransaction1: TFDTransaction
    Connection = ConexaoInterna
    Left = 184
    Top = 24
  end
end
