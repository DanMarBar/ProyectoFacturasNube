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
        <asp:Button ID="restablecer" runat="server" Text="Restablecer" OnClick="Reload_Table"  />
        <div>
            <asp:GridView ID="informacion" runat="server" AutoGenerateColumns="False"
                        OnRowEditing="informacion_RowEditing"         
                        OnRowCancelingEdit="informacion_RowCancelingEdit" 
                        OnRowUpdating="informacion_RowUpdating"
                        >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="numeroFactura" HeaderText="Cod. Factura" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="fechaFactura" HeaderText="Fecha Factura" DataFormatString="{0:dd/MM/yyyy}"><ItemStyle HorizontalAlign="center" /> </asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Nombre de Cliente" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="apellidos" HeaderText="Apellidos de Cliente" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="servicio" HeaderText="Servicio" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="CIFCliente" HeaderText="CIF de Cliente" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="direccion" HeaderText="Direccion" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="ciudad" HeaderText="Ciudad" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="codPostal" HeaderText="Cod. Postal" ><ItemStyle HorizontalAlign="right" /> </asp:BoundField>
                    <asp:BoundField DataField="importe" HeaderText="Importe de Factura" ><ItemStyle HorizontalAlign="right" /> </asp:BoundField>
                    <asp:BoundField DataField="importeIVA" HeaderText="ImporteIVA de Factura" ><ItemStyle HorizontalAlign="right" /> </asp:BoundField>
                    <asp:BoundField DataField="moneda" HeaderText="Moneda" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="estado" HeaderText="Estado de Factura" ><ItemStyle HorizontalAlign="left" /> </asp:BoundField>
                    <asp:BoundField DataField="fechaCobro" HeaderText="Fecha cobro de Factura" DataFormatString="{0:dd/MM/yyyy}" ><ItemStyle HorizontalAlign="center" /> </asp:BoundField>
                    <asp:CommandField ShowEditButton="True"/>                
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle CssClass="header-row" BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:Button ID="commit" runat="server" OnClick="btnCommit" Text="Commit a BBDD"/>
        </div>
    </form>
</body>
</html>
