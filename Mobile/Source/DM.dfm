object DMExp: TDMExp
  OldCreateOrder = False
  Height = 407
  Width = 354
  object RESTClientPooler1: TRESTClientPooler
    DataCompression = True
    Encoding = esUtf8
    hEncodeStrings = True
    Host = 'srvlenovo.ddns.net'
    UserName = 'testserver'
    Password = 'testserver'
    ProxyOptions.BasicAuthentication = False
    ProxyOptions.ProxyPort = 0
    RequestTimeOut = 300000
    ThreadRequest = False
    AllowCookies = False
    HandleRedirects = False
    Left = 32
    Top = 80
  end
  object DWClientEvents1: TDWClientEvents
    ServerEventName = 'TDmDados.DWServerEvents1'
    RESTClientPooler = RESTClientPooler1
    Events = <
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetClienteInfoSinc'
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
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
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetPedidoAttSinc'
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'Result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'GetPedidoItemAttSinc'
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'Pedidos'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'SetPedidos'
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'PedidosItem'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'SetPedidosItem'
      end>
    Left = 32
    Top = 128
  end
  object RESTDWDataBase1: TRESTDWDataBase
    Active = False
    Compression = True
    Login = 'testserver'
    Password = 'testserver'
    Proxy = False
    ProxyOptions.Port = 8888
    PoolerService = 'srvlenovo.ddns.net'
    PoolerPort = 8082
    PoolerName = 'TDmDados.RESTDWPoolerDB'
    StateConnection.AutoCheck = False
    StateConnection.InTime = 1000
    RequestTimeOut = 300000
    EncodeStrings = True
    Encoding = esUtf8
    StrsTrim = False
    StrsEmpty2Null = False
    StrsTrim2Len = True
    ParamCreate = True
    ClientConnectionDefs.Active = False
    Left = 32
    Top = 32
  end
end
