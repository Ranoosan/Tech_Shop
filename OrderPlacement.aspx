<%@ Page Title="Place Order" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="OrderPlacement.aspx.cs" Inherits="w2.OrderPlacement" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #1e1e1e; /* Dark background for a techy look */
            color: #e0e0e0; /* Light text color for contrast */
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background: #121212;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.6);
            color: #e0e0e0;
        }

        h2 {
            font-size: 26px;
            margin-bottom: 20px;
            color: #00bfae; /* Tech-inspired color */
            border-bottom: 2px solid #00bfae;
            padding-bottom: 10px;
        }

        .form-group {
            margin-bottom: 20px;
            border: 1px solid #333;
            border-radius: 6px;
            padding: 15px;
            background: #1e1e1e;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #e0e0e0;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #444;
            border-radius: 6px;
            background-color: #2a2a2a;
            color: #e0e0e0;
            transition: background-color 0.3s, border-color 0.3s;
        }

        input:focus, select:focus {
            background-color: #333;
            border-color: #00bfae;
            outline: none;
        }

        .btn {
            background-color: #00bfae;
            border: none;
            padding: 10px 20px;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
            border-radius: 6px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn:hover {
            background-color: #009d92;
            transform: scale(1.05);
        }

        .btn:active {
            background-color: #00887a;
            transform: scale(0.98);
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
    <div class="container">
        <h2>Place Your Order</h2>

        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>

        <div class="form-group">
            <label for="ddlProduct">Select Product</label>
            <asp:DropDownList ID="ddlProduct" runat="server" AutoPostBack="True" OnSelectedIndexChanged="LoadProductDetails">
           
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label for="txtQuantity">Quantity</label>
            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" Required="True"></asp:TextBox>
        </div>

       <asp:DropDownList ID="ddlSupplier" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSupplier_SelectedIndexChanged">
    <asp:ListItem Value="Supplier1">Supplier 1</asp:ListItem>
    <asp:ListItem Value="Supplier2">Supplier 2</asp:ListItem>
</asp:DropDownList>


        <div class="form-group">
            <label for="txtCustomerName">Customer Name</label>
            <asp:TextBox ID="txtCustomerName" runat="server" Required="True"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtCustomerEmail">Customer Email</label>
            <asp:TextBox ID="txtCustomerEmail" runat="server" TextMode="Email" Required="True"></asp:TextBox>
        </div>

        <asp:Button ID="btnSubmit" runat="server" Text="Place Order" CssClass="btn" OnClick="PlaceOrder" />
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
