<%@ Page Title="Update Order Status" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="ViewSupplier2Orders.aspx.cs" Inherits="w2.ViewSupplier2Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
      /* Body styles */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #1e1e1e; /* Dark background for a techy look */
    color: #e0e0e0; /* Light text color for contrast */
    margin: 0;
    padding: 0;
}

/* Container styles */
.gridview-container {
    margin: 20px auto;
    max-width: 1200px;
    background: linear-gradient(135deg, #1e1e1e, #2c2c2c); /* Dark gradient background */
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.7);
    overflow: hidden;
}

/* Title styles */
.gridview-container h2 {
    text-align: center;
    color: #e0e0e0;
    margin-bottom: 30px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    text-transform: uppercase;
    letter-spacing: 2px;
    background: linear-gradient(135deg, #1f8ef1, #3b3b3b); /* Gradient text effect */
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* Table styles */
table {
    width: 100%;
    border-collapse: collapse;
    background-color: #2d2d2d;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.5);
    animation: fadeIn 1s ease-in-out;
}

th, td {
    padding: 15px;
    border: 1px solid #444;
    text-align: left;
    color: #e0e0e0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    transition: background-color 0.3s ease;
}

th {
    background-color: #333;
    color: #1f8ef1;
    position: relative;
    text-transform: uppercase;
    letter-spacing: 1px;
    font-weight: bold;
}

th::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 3px;
    background-color: #1f8ef1;
    transform: scaleX(0);
    transform-origin: right;
    transition: transform 0.4s ease-in-out;
}

th:hover::after {
    transform: scaleX(1);
    transform-origin: left;
}

tr:nth-child(even) {
    background-color: #242424;
}

tr:hover {
    background-color: #1f1f1f;
    cursor: pointer;
}

td {
    position: relative;
}

td::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    width: 5px;
    background-color: #1f8ef1;
    transform: scaleY(0);
    transform-origin: bottom;
    transition: transform 0.3s ease;
}

tr:hover td::before {
    transform: scaleY(1);
}

/* Fade-in animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive Design */
@media (max-width: 768px) {
    .gridview-container {
        width: 95%;
        padding: 20px;
    }

    th, td {
        padding: 10px;
    }

}
        .update-button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .update-button:hover {
            background-color: #0056b3;
        }
            /* Particle background styling */
    #particles-js {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 0; /* Behind the form */
    }

    </style>
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="particles-js"></div>
    <div class="gridview-container">
        <h2>Update Order Status for Supplier2</h2>
        <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" ForeColor="#fff" OnRowCommand="GridViewOrders_RowCommand">
            <Columns>
                <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                <asp:BoundField DataField="ProductID" HeaderText="Product ID" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" />
                <asp:BoundField DataField="CustomerEmail" HeaderText="Customer Email" />
                <asp:BoundField DataField="OrderDate" HeaderText="Order Date" />
                <asp:BoundField DataField="Status" HeaderText="Status" />

              
                <asp:TemplateField HeaderText="Update Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server">
                            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                            <asp:ListItem Text="Confirmed" Value="Confirmed"></asp:ListItem>
                            <asp:ListItem Text="Canceled" Value="Canceled"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" CommandName="UpdateStatus" CommandArgument='<%# Eval("OrderID") %>' CssClass="update-button" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
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
