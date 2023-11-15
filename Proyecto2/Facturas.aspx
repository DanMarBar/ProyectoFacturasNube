<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Facturas.aspx.cs" Inherits="Facturas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Proyecto</title>
    <link href="StyleMain.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        #informacion th{
            border: 2px solid white;    
        }
        #informacion td{
            border: 0.5px solid black;    
        }
    </style>
</head>
<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Estado de factura: " class="m-2 p-2" ></asp:Label>
        <asp:DropDownList ID="listaEstados" runat="server" class="m-2">
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
        <asp:Label ID="nombreLabel" runat="server" Text="Nombre: " class="m-2 p-2"></asp:Label>
        <asp:TextBox ID="filtrarNombre" runat="server" type="text" class="m-2"></asp:TextBox><br />
        <asp:Label ID="importeMinLabel" runat="server" Text=" Importe Mínimo: " class="m-2 p-2"></asp:Label>
        <asp:TextBox ID="importeMin" runat="server"  class="m-2"><ItemStyle HorizontalAlign="right" /></asp:TextBox>
        <asp:Label ID="importeMaxLabel" runat="server" Text=" Importe Máximo: " class="m-2 p-2"></asp:Label>
        <asp:TextBox ID="importeMax" runat="server"  class="m-2"><ItemStyle HorizontalAlign="right" /></asp:TextBox>
        <asp:Button ID="filtrar" runat="server" Text="Filtrar" OnClick="btnFiltrar" class="m-2"/>
        <asp:Button ID="restablecer" runat="server" Text="Restablecer" OnClick="Reload_Table" class="m-2" />
        <div>
            <asp:GridView ID="informacion" runat="server" AutoGenerateColumns="False" Class = "m-2 border border-1 border-black"
                        OnRowEditing="informacion_RowEditing"         
                        OnRowCancelingEdit="informacion_RowCancelingEdit" 
                        OnRowUpdating="informacion_RowUpdating" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
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
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle CssClass="header-row" BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:Button ID="commit" runat="server" OnClick="btnCommit" Text="Commit a BBDD"/>
        </div>
    </form>
</body>
</html>
