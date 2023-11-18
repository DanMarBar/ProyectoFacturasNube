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
        <asp:Label ID="estadoLabel" runat="server" Text="Estado de factura: " class="m-2 p-2" ></asp:Label>
        <asp:DropDownList ID="listaEstados" runat="server" class="m-2">
            <asp:ListItem Value="">Seleccionar un Estado</asp:ListItem>
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
        <asp:TextBox ID="importeMin" runat="server"  class="m-2 text-end"></asp:TextBox>
        <asp:Label ID="importeMaxLabel" runat="server" Text=" Importe Máximo: " class="m-2 p-2"></asp:Label>
        <asp:TextBox ID="importeMax" runat="server"  class="m-2 text-end"></asp:TextBox>
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
                            <asp:TextBox ID="txt_nombre" runat="server" Text='<%#Eval("nombre") %>'></asp:TextBox>  
                        </EditItemTemplate>  
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Apellidos de Cliente">  
                        <ItemStyle HorizontalAlign="left" />
                        <ItemTemplate>  
                            <asp:Label ID="apellidos" runat="server" Text='<%#Eval("apellidos") %>'></asp:Label>  
                        </ItemTemplate>  
                        <EditItemTemplate>  
                            <asp:TextBox ID="txt_apellidos" runat="server" Text='<%#Eval("apellidos") %>'></asp:TextBox>  
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
                            <asp:TextBox ID="txt_cif" runat="server" Text='<%#Eval("CIFCliente") %>'></asp:TextBox>  
                        </EditItemTemplate>  
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText="Direccion">  
                        <ItemStyle HorizontalAlign="left" />
                        <ItemTemplate>  
                            <asp:Label ID="direccion" runat="server" Text='<%#Eval("direccion") %>'></asp:Label>  
                        </ItemTemplate>  
                        <EditItemTemplate>  
                            <asp:TextBox ID="txt_direccion" runat="server" Text='<%#Eval("direccion") %>'></asp:TextBox>  
                        </EditItemTemplate>  
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText="Ciudad">  
                        <ItemStyle HorizontalAlign="left" />
                        <ItemTemplate>  
                            <asp:Label ID="ciudad" runat="server" Text='<%#Eval("ciudad") %>'></asp:Label>  
                        </ItemTemplate>  
                        <EditItemTemplate>  
                            <asp:TextBox ID="txt_ciudad" runat="server" Text='<%#Eval("ciudad") %>'></asp:TextBox>  
                        </EditItemTemplate>  
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cod. Postal">  
                        <ItemStyle HorizontalAlign="right" />
                        <ItemTemplate>  
                            <asp:Label ID="codPostal" runat="server" Text='<%#Eval("codPostal") %>'></asp:Label>  
                        </ItemTemplate>  
                        <EditItemTemplate>  
                            <asp:TextBox ID="txt_codPostal" runat="server" Text='<%#Eval("codPostal") %>'></asp:TextBox>  
                        </EditItemTemplate>  
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Importe de Factura">  
                        <ItemStyle HorizontalAlign="right" />
                        <ItemTemplate>  
                            <asp:Label ID="importe" runat="server" Text='<%#Eval("importe") %>'></asp:Label>  
                        </ItemTemplate>  
                        <EditItemTemplate>  
                            <asp:TextBox ID="txt_importe" runat="server" Text='<%#Eval("importe") %>'></asp:TextBox>  
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
                            <asp:DropDownList ID="txt_estados" runat="server">
                                <asp:ListItem Value="">Seleccionar un Estado</asp:ListItem>
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
                        </EditItemTemplate>  
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fecha cobro de Factura">
                        <ItemStyle HorizontalAlign="center"/> 
                        <ItemTemplate>  
                            <asp:Label ID="fechaCobro" runat="server" Text='<%# Bind("fechaCobro", "{0:dd/MM/yyyy}") %>'></asp:Label>  
                        </ItemTemplate>
                        <EditItemTemplate>  
                            <asp:TextBox ID="txt_fechaCobro" runat="server" Text='<%# Bind("fechaCobro", "{0:dd/MM/yyyy}") %>'></asp:TextBox>  
                        </EditItemTemplate>
                    </asp:TemplateField>
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
        </div>
    </form>
</body>
</html>
