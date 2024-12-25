<%@ Page Title="Inventory Management" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="InventoryManagement.aspx.cs" Inherits="w2.InventoryManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       body {
    background-color: #121212;
    color: #ffffff;
    font-family: 'Arial', sans-serif;
}

.container {
    margin: 20px;
}

h2 {
    color: #00bcd4;
    text-align: center;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 12px;
    text-align: left;
    border: 1px solid #333;
    transition: background-color 0.3s; /* Smooth transition */
}

th {
    background-color: #1e1e1e;
}

tr:nth-child(even) {
    background-color: #252525;
}

tr:hover {
    background-color: #333; /* Hover effect for rows */
}

img {
    max-width: 80px; /* Adjust as needed */
    border-radius: 5px;
}

.button-link {
    background-color: #00bcd4;
    color: #ffffff;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    text-decoration: none;
    cursor: pointer;
    transition: background-color 0.3s; /* Smooth transition */
}

.button-link:hover {
    background-color: #0097a7; /* Hover effect for buttons */
}

.btn {
    background-color: #e0e0e0; /* New button color */
    color: #121212; /* Contrast text color */
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s; /* Smooth transition */
}

.btn:hover {
    background-color: #d0d0d0; /* Darker shade on hover */
    transform: scale(1.05); /* Slight scaling effect on hover */
}

.form-group {
    margin-bottom: 15px;
}

.form-control {
    background-color: #1e1e1e;
    border: 1px solid #00bcd4;
    color: #ffffff;
    border-radius: 5px;
    padding: 10px;
}

.form-control:focus {
    background-color: #252525;
    border-color: #00bcd4;
    outline: none;
}
.navbar {
    background-color: #1e1e1e;
    padding: 10px 0;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
    position: sticky;
    top: 0; /* Stick to the top */
    z-index: 1000; /* Ensure it's above other elements */
}

.navbar .container {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 20px; /* Space between links */
}

.nav-links li {
    position: relative;
}

.nav-links a {
    color: #00bcd4; /* Link color */
    text-decoration: none;
    padding: 8px 16px;
    transition: color 0.3s, background-color 0.3s;
    border-radius: 5px; /* Rounded corners for links */
}

.nav-links a:hover {
    background-color: #00bcd4; /* Background color on hover */
    color: #ffffff; /* Text color on hover */
}
.navbar-title {
    color: #00bcd4; /* Title color */
    font-size: 24px; /* Adjust font size as needed */
    font-weight: bold; /* Make the title bold */
    margin-right: auto; /* Push the nav links to the right */
}

.navbar-title h1 {
    margin: 0; /* Remove default margin */
    font-family: 'Arial', sans-serif; /* Change to your preferred font */
}
 /* Particle background styling */
    #particles-js {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: -1; /* Behind the form */
    }

    </style>
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div id="particles-js"></div>
    <nav class="navbar">
    <div class="container">
          <div class="navbar-title">
                <h1>Tech Innovators</h1> <!-- Change "MyApp" to your desired title -->
            </div>
        <ul class="nav-links">
            <li><a href="supplier1.aspx">Home</a></li>
            <li><a href="InventoryManagement.aspx">Inventory</a></li>
            <li><a href="ViewSupplier1Orders.aspx">Orders</a></li>
        </ul>
    </div>
</nav>

    <div class="container">
        <h2>Inventory Management</h2>

        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>

        <table>
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Brand</th>
                    <th>RAM (GB)</th>
                    <th>ROM (GB)</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Quantity in Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td><img src='<%# ResolveUrl(Eval("ImageUrl").ToString()) %>' alt="Product Image" /></td>
                            <td><%# Eval("ProductName") %></td>
                            <td><%# Eval("Category") %></td>
                            <td><%# Eval("Brand") %></td>
                            <td><%# Eval("RAMCapacity") %></td>
                            <td><%# Eval("ROMCapacity") %></td>
                            <td><%# Eval("Price", "{0:C}") %></td>
                            <td><%# Eval("Description") %></td>
                            <td><%# Eval("QuantityInStock") %></td>
                            <td>
                               <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" OnClick="btnAddProduct_Click" CssClass="btn" />

                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("ProductID") %>' CssClass="button-link" OnClientClick="return confirm('Are you sure you want to delete this product?');" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <div class="form-group">
            <label for="ddlProduct">Select Product</label>
            <asp:DropDownList ID="ddlProduct" runat="server" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
        </div>

        <div class="form-group">
            <label for="txtQuantity">Quantity to Send</label>
            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" Required="True"></asp:TextBox>
        </div>

        <asp:Button ID="btnSendQuantity" runat="server" Text="Send Quantity" OnClick="SendQuantity" CssClass="btn" />
    </div>
    <script>
    particlesJS('particles-js', {
        "particles": {
            "number": {
                "value": 80,
                "density": {
                    "enable": true,
                    "value_area": 800
                }
            },
            "color": {
                "value": "#ffffff"
            },
            "shape": {
                "type": "circle",
                "stroke": {
                    "width": 0,
                    "color": "#000000"
                }
            },
            "opacity": {
                "value": 0.5,
                "random": false,
                "anim": {
                    "enable": false,
                    "speed": 1,
                    "opacity_min": 0.1,
                    "sync": false
                }
            },
            "size": {
                "value": 3,
                "random": true,
                "anim": {
                    "enable": false,
                    "speed": 40,
                    "size_min": 0.1,
                    "sync": false
                }
            },
            "line_linked": {
                "enable": true,
                "distance": 150,
                "color": "#ffffff",
                "opacity": 0.4,
                "width": 1
            },
            "move": {
                "enable": true,
                "speed": 6,
                "direction": "none",
                "random": false,
                "straight": false,
                "out_mode": "out",
                "bounce": false,
                "attract": {
                    "enable": false,
                    "rotateX": 600,
                    "rotateY": 1200
                }
            }
        },
        "interactivity": {
            "detect_on": "canvas",
            "events": {
                "onhover": {
                    "enable": true,
                    "mode": "repulse"
                },
                "onclick": {
                    "enable": true,
                    "mode": "push"
                },
                "resize": true
            },
            "modes": {
                "grab": {
                    "distance": 100,
                    "line_linked": {
                        "opacity": 1
                    }
                },
                "bubble": {
                    "distance": 100,
                    "size": 40,
                    "duration": 2,
                    "opacity": 8,
                    "speed": 3
                },
                "repulse": {
                    "distance": 200,
                    "duration": 0.4
                },
                "push": {
                    "particles_nb": 4
                },
                "remove": {
                    "particles_nb": 2
                }
            }
        },
        "retina_detect": true
    });
    </script>
</asp:Content>
