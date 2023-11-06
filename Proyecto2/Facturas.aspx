<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Facturas.aspx.cs" Inherits="Facturas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Proyecto</title>
    <link href="StyleMain.css" rel="stylesheet" type="text/css" />
    <script></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Estado de factura: "></asp:Label>
        <asp:DropDownList ID="listaEstados" runat="server">
            <asp:ListItem Value=""></asp:ListItem>
            <asp:ListItem Value="Rechazada">Rechazada</asp:ListItem>
            <asp:ListItem Value="Registrada">Registrada</asp:ListItem>
            <asp:ListItem Value="Cobrada">Cobrada</asp:ListItem>
            <asp:ListItem Value="Emitida">Emitida</asp:ListItem>
            <asp:ListItem Value="Anulada">Anulada</asp:ListItem>
            <asp:ListItem Value="Aceptada">Aceptada</asp:ListItem>
            <asp:ListItem Value="Reenviada">Reenviada</asp:ListItem>
            <asp:ListItem Value="Anulación aceptada">Anulación aceptada</asp:ListItem>
            <asp:ListItem Value="Solicitada anulación">Solicitada anulación</asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="nombreLabel" runat="server" Text="Nombre: "></asp:Label>
        <asp:TextBox ID="filtrarNombre" runat="server" type="text"></asp:TextBox>
        <asp:Button ID="filtrar" runat="server" Text="Filtrar"/>
        <asp:Button ID="restablecer" runat="server" Text="Restablecer"  />
        <div>
            <asp:GridView ID="informacion" runat="server" AutoGenerateColumns="False"
                        AutoGenerateEditButton="True" 
                        OnRowEditing="informacion_RowEditing"         
                        OnRowCancelingEdit="informacion_RowCancelingEdit" 
                        OnRowUpdating="informacion_RowUpdating"
                        OnPageIndexChanging="informacion_PageIndexChanging">
                <HeaderStyle CssClass="header-row" />
                <Columns>
                    <asp:BoundField DataField="numeroFactura" HeaderText="Nº Factura" SortExpression="numeroFactura"/>
                    <asp:BoundField DataField="fechaFactura" HeaderText="Fecha" SortExpression="fechaFactura" />
                    <asp:BoundField DataField="nombre" HeaderText="Nombre Cliente" SortExpression="nombre" />
                    <asp:BoundField DataField="apellidos" HeaderText="Apellidos de Cliente" SortExpression="apellidos" />
                    <asp:BoundField DataField="servicio" HeaderText="Servicio" SortExpression="servicio" />
                    <asp:BoundField DataField="CIFCliente" HeaderText="CIFCliente" SortExpression="CIFCliente" />
                    <asp:BoundField DataField="importe" HeaderText="Importe" SortExpression="importe" />
                    <asp:BoundField DataField="importeIVA" HeaderText="IVA" SortExpression="importeIVA" />
                    <asp:BoundField DataField="moneda" HeaderText="Moneda" SortExpression="moneda" />
                    <asp:BoundField DataField="estado" HeaderText="Estado" SortExpression="estado" />
                    <asp:BoundField DataField="fechaCobro" HeaderText="Fecha de Cobro" SortExpression="fechaCobro" />
                    <asp:TemplateField HeaderText="Edición">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" Text="Editar" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditNombre" runat="server" Text='<%# Bind("nombre") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Button ID="commit" runat="server" OnClick="btnCommit" Text="Commit a BBDD"/>
        </div>
    </form>
</body>
</html>
