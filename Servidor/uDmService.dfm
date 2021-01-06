object ServerMethodDM: TServerMethodDM
  OldCreateOrder = False
  Encoding = esUtf8
  OnReplyEvent = ServerMethodDataModuleReplyEvent
  Height = 276
  Width = 483
  object RESTDWPoolerDB1: TRESTDWPoolerDB
    RESTDriver = RESTDWDriverFD1
    Compression = True
    Encoding = esUtf8
    StrsTrim = False
    StrsEmpty2Null = False
    StrsTrim2Len = True
    Active = False
    PoolerOffMessage = 'RESTPooler not active.'
    ParamCreate = True
    Left = 72
    Top = 88
  end
  object Server_FDConnection: TFDConnection
    Params.Strings = (
      'Database=g2bomcorte'
      'User_Name=sa'
      'Password=Express123'
      'Server=srv-lenovo'
      'DriverID=MSSQL')
    FetchOptions.AssignedValues = [evCursorKind]
    FetchOptions.CursorKind = ckDefault
    UpdateOptions.AssignedValues = [uvCountUpdatedRecords]
    TxOptions.AutoStop = False
    TxOptions.DisconnectAction = xdRollback
    ConnectedStoredUsage = []
    LoginPrompt = False
    Transaction = FDTransaction1
    BeforeConnect = Server_FDConnectionBeforeConnect
    Left = 70
    Top = 18
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 374
    Top = 19
  end
  object FDTransaction1: TFDTransaction
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = Server_FDConnection
    Left = 232
    Top = 16
  end
  object QAux: TFDQuery
    Connection = Server_FDConnection
    Left = 232
    Top = 88
  end
  object memVendaSinc: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 232
    Top = 144
    object memVendaSinccontroleinterno: TIntegerField
      FieldName = 'controleinterno'
    end
    object memVendaSinccpf_cnpj: TStringField
      FieldName = 'cpf_cnpj'
      Size = 14
    end
    object memVendaSincformapagto: TIntegerField
      FieldName = 'formapagto'
    end
    object memVendaSincvendedor: TStringField
      FieldName = 'vendedor'
    end
    object memVendaSincemissao: TDateField
      FieldName = 'emissao'
    end
    object memVendaSincvalor: TFloatField
      FieldName = 'valor'
    end
    object memVendaSincdesconto: TFloatField
      FieldName = 'desconto'
    end
    object memVendaSinctotal: TFloatField
      FieldName = 'total'
    end
    object memVendaSincsituacao: TStringField
      FieldName = 'situacao'
      Size = 15
    end
  end
  object memVendaItemSinc: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 232
    Top = 200
    object memVendaItemSinccontroleinterno: TIntegerField
      FieldName = 'controleinterno'
    end
    object memVendaItemSinccod_prod: TIntegerField
      FieldName = 'cod_prod'
    end
    object memVendaItemSinccod_venda: TIntegerField
      FieldName = 'cod_venda'
    end
    object memVendaItemSincnomeproduto: TStringField
      FieldName = 'nomeproduto'
      Size = 80
    end
    object memVendaItemSincquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object memVendaItemSincvalor: TFloatField
      FieldName = 'valor'
    end
    object memVendaItemSincdesconto: TFloatField
      FieldName = 'desconto'
    end
    object memVendaItemSinctotal: TFloatField
      FieldName = 'total'
    end
    object memVendaItemSincunidade: TStringField
      FieldName = 'unidade'
      Size = 10
    end
    object memVendaItemSincsituacao: TStringField
      FieldName = 'situacao'
      Size = 15
    end
    object memVendaItemSinccomplemento: TStringField
      FieldName = 'complemento'
      Size = 50
    end
  end
  object DWServerEvents1: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Entrada'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'Validar'
        EventName = 'Validar'
        OnlyPreDefinedParams = False
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Get'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetClientes'
        EventName = 'GetClientes'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetClientesReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Get'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetProdutos'
        EventName = 'GetProdutos'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetProdutosReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Cliente'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetClienteInfo'
        EventName = 'GetClienteInfo'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetClienteInfoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Produto'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetProdutoInfo'
        EventName = 'GetProdutoInfo'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetProdutoInfoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'VendasProd'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetVendasProd'
        EventName = 'GetVendasProd'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetVendasProdReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendas'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetVendas'
        EventName = 'GetVendas'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetVendasReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'GetFicha'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Situacao'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetFichaFinanceira'
        EventName = 'GetFichaFinanceira'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetFichaFinanceiraReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'CodCliente'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'CodNota'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetNfeInfo'
        EventName = 'GetNfeInfo'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetNfeInfoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetProdutoInfoSinc'
        EventName = 'GetProdutoInfoSinc'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetProdutoInfoSincReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Cod'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetClienteInfoSinc'
        EventName = 'GetClienteInfoSinc'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetClienteInfoSincReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetFormapagtoSinc'
        EventName = 'GetFormapagtoSinc'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetFormapagtoSincReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetUsuariosSinc'
        EventName = 'GetUsuariosSinc'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetUsuariosSincReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetPedidoAttSinc'
        EventName = 'GetPedidoAttSinc'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetPedidoAttSincReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Cod'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetPedidoItemAttSinc'
        EventName = 'GetPedidoItemAttSinc'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetPedidoItemAttSincReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Pedidos'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Cod'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'SetPedidos'
        EventName = 'SetPedidos'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsSetPedidosReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'PedidosItem'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'SetPedidosItem'
        EventName = 'SetPedidosItem'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsSetPedidosItemReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Situacao'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetPedido'
        EventName = 'GetPedido'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetPedidoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Pedido'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetItensPedido'
        EventName = 'GetItensPedido'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetItensPedidoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Situacao'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Complemento'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'CI'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'UpdateItem'
        EventName = 'UpdateItem'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsUpdateItemReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Situacao'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'CI'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'UpdatePedido'
        EventName = 'UpdatePedido'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsUpdatePedidoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Situacao'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'NomeVendedor'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'PedidoRelatorio'
        EventName = 'PedidoRelatorio'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsPedidoRelatorioReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Situacao'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'NomeVendedor'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'ItensRelatorio'
        EventName = 'ItensRelatorio'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsItensRelatorioReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Situacao'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'PedidoItensRelatorio'
        EventName = 'PedidoItensRelatorio'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsPedidoItensRelatorioReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetIdVenda'
        EventName = 'GetIdVenda'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetIdVendaReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Data'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'ResumoAbate'
        EventName = 'ResumoAbate'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsResumoAbateReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Venda'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetLatLong'
        EventName = 'GetLatLong'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetLatLongReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Vendedor'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Data'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetRotas'
        EventName = 'GetRotas'
        OnlyPreDefinedParams = False
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'DataA'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'DataB'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Opcao'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetRelatorioVendedor'
        EventName = 'GetRelatorioVendedor'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetRelatorioVendedorReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'pFirst'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'pShow'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Cod'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Fotos'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovInteger
            ParamName = 'pResultCount'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetFotoProduto'
        EventName = 'GetFotoProduto'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetFotoProdutoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetPedidoFinalizado'
        EventName = 'GetPedidoFinalizado'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetPedidoFinalizadoReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetUsuarioCP'
        EventName = 'GetUsuarioCP'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetUsuarioCPReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Usuario'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'DataA'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'DataB'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'GetVendasCP'
        EventName = 'GetVendasCP'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsGetVendasCPReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'PreCad'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Cod'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'SetPreCad'
        EventName = 'SetPreCad'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsSetPreCadReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Codigo'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Foto'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'SetFotoPrecad'
        EventName = 'SetFotoPrecad'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsgetFotoPrecadReplyEvent
      end>
    Left = 72
    Top = 144
  end
  object RESTDWDataBase1: TRESTDWDataBase
    Active = False
    Compression = True
    CriptOptions.Use = False
    CriptOptions.Key = 'RDWBASEKEY256'
    AuthenticationOptions.AuthorizationOption = rdwAONone
    Proxy = False
    ProxyOptions.Port = 8888
    PoolerService = '127.0.0.1'
    PoolerPort = 8082
    PoolerName = 'TServerMethodDM.RESTDWPoolerDB1'
    StateConnection.AutoCheck = False
    StateConnection.InTime = 1000
    RequestTimeOut = 10000
    EncodeStrings = True
    Encoding = esUtf8
    StrsTrim = False
    StrsEmpty2Null = False
    StrsTrim2Len = True
    HandleRedirects = False
    RedirectMaximum = 0
    ParamCreate = True
    FailOver = False
    FailOverConnections = <>
    FailOverReplaceDefaults = False
    ClientConnectionDefs.Active = False
    UserAgent = 
      'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, l' +
      'ike Gecko) Chrome/41.0.2227.0 Safari/537.36'
    Left = 72
    Top = 200
  end
  object RESTDWDriverFD1: TRESTDWDriverFD
    CommitRecords = 100
    Connection = Server_FDConnection
    Left = 160
    Top = 64
  end
end
