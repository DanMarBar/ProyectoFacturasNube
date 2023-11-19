<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Facturas.aspx.cs" Inherits="Facturas" MaintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Proyecto</title>
    <link href="Content/stylesheet.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        #informacion th{
            border: 0.5px solid white;    
        }
        #informacion td{
            border: 0.1px solid gray;    
        }
        .header-row {
            background-color: #66CDAA;
            color: white; 
        }
        .row-style {
            background-color: white; 
        }
        .alternate-row-style {
            background-color: #66CDAA; 
        }
    </style>
</head>
<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
    <div class="container-fluid row g-0 bg-dark justify-content-center mainDiv">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Proyecto facturas</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Inicio</a
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Sobre nosotros</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Facturas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Acerca de</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Proyectos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Contactos</a>
                    </li>
                </ul>
            </div>
            </div>
        </nav>
        <div class="my-3">
        </div> 
        <div style="height: 50px;"></div> 
        <form id="form1" runat="server" class="col-11 bg-light rounded-3">
            <div class="text-center my-4">
                <h1>Proyecto Facturas</h1>
            </div> 
            <div class="row m-2">
                <div class="col-auto">
                    <asp:Label ID="nombreLabel" runat="server" Text="Nombre: " class="p-2"></asp:Label>
                    <asp:TextBox ID="filtrarNombre" runat="server" type="text" class="form-control d-inline-block align-middle" style="width: auto; vertical-align: top;"></asp:TextBox>
                </div>
                <div class="col-auto">
                    <asp:Label ID="importeMinLabel" runat="server" Text=" Importe Mínimo: " class="p-2"></asp:Label>
                    <asp:TextBox ID="importeMin" runat="server" class="form-control d-inline-block align-middle" style="width: auto; vertical-align: top;"></asp:TextBox>
                </div>
                <div class="col-auto">
                    <asp:Label ID="importeMaxLabel" runat="server" Text=" Importe Máximo: " class="p-2"></asp:Label>
                    <asp:TextBox ID="importeMax" runat="server" class="form-control d-inline-block align-middle" style="width: auto; vertical-align: top;"></asp:TextBox>
                </div>
                <div class="col-auto">
                    <asp:Label ID="estadoLabel" runat="server" Text="Estado factura: " class="p-2" ></asp:Label>
                    <asp:DropDownList ID="listaEstados" runat="server" class="form-control d-inline-block align-middle" style="width: auto; vertical-align: top;" >
                        <asp:ListItem Value="">Seleccionar un Estado</asp:ListItem>
                        <asp:ListItem Value="Rechazada">Rechazada</asp:ListItem>
                        <asp:ListItem Value="Registrada">Registrada</asp:ListItem>
                        <asp:ListItem Value="Pendiente">Pendiente</asp:ListItem>
                        <asp:ListItem Value="Cobrada">Cobrada</asp:ListItem>
                        <asp:ListItem Value="Emitida">Emitida</asp:ListItem>
                        <asp:ListItem Value="Anulada">Anulada</asp:ListItem>
                        <asp:ListItem Value="Aceptada">Aceptada</asp:ListItem>
                        <asp:ListItem Value="Reenviada">Reenviada</asp:ListItem>
                        <asp:ListItem Value="Anulación aceptada">Anulación aceptada</asp:ListItem>
                        <asp:ListItem Value="Solicitada anulación">Solicitada anulación</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="my-2">
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="true" CssClass="p-2"></asp:Label>
            </div> 
                <div style="height: 2px;">
                </div> 
            <div class="row m-2">
                <div class="col-12 row g-0">
                    <asp:Button ID="filtrar" runat="server" Text="Filtrar" OnClick="btnFiltrar" class="btn btn-success col-6"/>
                    <asp:Button ID="añadir" runat="server" Text="Restablecer" OnClick="Reload_Table" class="btn btn-danger col-6"/>
                </div>
            </div>
            <div>
                <asp:GridView ID="informacion" runat="server" AutoGenerateColumns="False" OnRowDataBound="informacion_RowDataBound"
                              CssClass="m-2 border border-1 border-black"
                              OnRowEditing="informacion_RowEditing"         
                              OnRowCancelingEdit="informacion_RowCancelingEdit" 
                              OnRowUpdating="informacion_RowUpdating"
                              BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" 
                              BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical">

                    <AlternatingRowStyle CssClass="alternate-row-style" />
                    <HeaderStyle CssClass="header-row text-center"/>
                    <RowStyle CssClass="row-style" />
                    <Columns>
                        <asp:TemplateField HeaderText="Cod. Factura">  
                            <ItemStyle HorizontalAlign="left"/>
                            <ItemTemplate>  
                                <asp:Label ID="numeroFactura" runat="server" Text='<%#Eval("numeroFactura") %>'></asp:Label> 
                            </ItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fecha Factura">
                            <ItemStyle HorizontalAlign="center"/> 
                            <ItemTemplate>  
                                <asp:Label ID="fechaFactura" runat="server" Text='<%# Bind("fechaFactura", "{0:dd/MM/yyyy}") %>'></asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nombre de Cliente"> 
                            <ItemStyle HorizontalAlign="left" />
                            <ItemTemplate>  
                                <asp:Label ID="nombre" runat="server" Text='<%#Eval("nombre") %>'></asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_nombre" runat="server" Text='<%# Bind("nombre") %>' CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Apellidos de Cliente">  
                            <ItemStyle HorizontalAlign="left" />
                            <ItemTemplate>  
                                <asp:Label ID="apellidos" runat="server" Text='<%#Eval("apellidos") %>'></asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="txt_apellidos" runat="server" Text='<%#Eval("apellidos") %>' CssClass="form-control"></asp:TextBox>  
                            </EditItemTemplate>  
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Servicio">
                            <ItemStyle HorizontalAlign="left" />
                            <ItemTemplate>  
                                <asp:Label ID="servicio" runat="server" Text='<%#Eval("servicio") %>'></asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CIF de Cliente">  
                            <ItemStyle HorizontalAlign="left" />
                            <ItemTemplate>  
                                <asp:Label ID="CIFCliente" runat="server" Text='<%#Eval("CIFCliente") %>'></asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="txt_cif" runat="server" Text='<%#Eval("CIFCliente") %>' CssClass="form-control"></asp:TextBox>  
                            </EditItemTemplate>  
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Direccion">  
                            <ItemStyle HorizontalAlign="left" />
                            <ItemTemplate>  
                                <asp:Label ID="direccion" runat="server" Text='<%#Eval("direccion") %>'></asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="txt_direccion" runat="server" Text='<%#Eval("direccion") %>' CssClass="form-control"></asp:TextBox>  
                            </EditItemTemplate>  
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Ciudad">  
                            <ItemStyle HorizontalAlign="left" />
                            <ItemTemplate>  
                                <asp:Label ID="ciudad" runat="server" Text='<%#Eval("ciudad") %>'></asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="txt_ciudad" runat="server" Text='<%#Eval("ciudad") %>' CssClass="form-control"></asp:TextBox>  
                            </EditItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cod. Postal">  
                            <ItemStyle HorizontalAlign="right" />
                            <ItemTemplate>  
                                <asp:Label ID="codPostal" runat="server" Text='<%#Eval("codPostal") %>'></asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="txt_codPostal" runat="server" Text='<%#Eval("codPostal") %>' CssClass="form-control"></asp:TextBox>  
                            </EditItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Importe de Factura">  
                            <ItemStyle HorizontalAlign="right" />
                            <ItemTemplate>  
                                <asp:Label ID="importe" runat="server" Text='<%# Bind("importe", "{0:N2}") %>'></asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:TextBox ID="txt_importe" runat="server" Text='<%# Bind("importe", "{0:N2}") %>' CssClass="form-control"></asp:TextBox>  
                            </EditItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ImporteIVA de Factura">  
                            <ItemStyle HorizontalAlign="right" />
                            <ItemTemplate>  
                                <asp:Label ID="importeIVA" runat="server" Text='<%#Eval("importeIVA") %>'></asp:Label>  
                            </ItemTemplate> 
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Moneda">  
                            <ItemStyle HorizontalAlign="left" />
                            <ItemTemplate>  
                                <asp:Label ID="moneda" runat="server" Text='<%#Eval("moneda") %>'></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Estado de Factura">  
                            <ItemStyle HorizontalAlign="left" />
                            <ItemTemplate>  
                                <asp:Label ID="estado" runat="server" Text='<%#Eval("estado") %>'></asp:Label>  
                            </ItemTemplate>  
                            <EditItemTemplate>  
                                <asp:DropDownList ID="txt_estados" runat="server"  CssClass="form-control">
                                    <asp:ListItem Value="Rechazada">Rechazada</asp:ListItem>
                                    <asp:ListItem Value="Registrada">Registrada</asp:ListItem>
                                    <asp:ListItem Value="Pendiente">Pendiente</asp:ListItem>
                                    <asp:ListItem Value="Cobrada">Cobrada</asp:ListItem>
                                    <asp:ListItem Value="Emitida">Emitida</asp:ListItem>
                                    <asp:ListItem Value="Anulada">Anulada</asp:ListItem>
                                    <asp:ListItem Value="Aceptada">Aceptada</asp:ListItem>
                                    <asp:ListItem Value="Reenviada">Reenviada</asp:ListItem>
                                    <asp:ListItem Value="Anulación aceptada">Anulación aceptada</asp:ListItem>
                                    <asp:ListItem Value="Solicitada anulación">Solicitada anulación</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fecha cobro de Factura">
                            <ItemStyle HorizontalAlign="center"/> 
                            <ItemTemplate>  
                                <asp:Label ID="fechaCobro" runat="server" Text='<%# Bind("fechaCobro", "{0:dd/MM/yyyy}") %>'></asp:Label>  
                            </ItemTemplate>
                            <EditItemTemplate>  
                                <asp:TextBox ID="txt_fechaCobro" runat="server" Text='<%# Bind("fechaCobro", "{0:dd/MM/yyyy}") %>' CssClass="form-control"></asp:TextBox>  
                            </EditItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" CssClass="fa fa-pen-to-square fa-lg" ToolTip="Editar"></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" CssClass="fa fa-save fa-lg" Style="color: green;" ToolTip="Actualizar"></asp:LinkButton>
                                <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" CssClass="fa fa-ban fa-lg" Style="color: red;" ToolTip="Cancelar"></asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>               
                    </Columns>

                </asp:GridView>
            </div>
        </form>
    </div>
</body>
</html>
