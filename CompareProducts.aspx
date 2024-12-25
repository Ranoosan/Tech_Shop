<%@ Page Title="Compare Products" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CompareProducts.aspx.cs" Inherits="w2.CompareProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212;
            color: #e0e0e0;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background: #1e1e1e;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #e0e0e0;
        }

        .filter-group {
            margin-bottom: 20px;
            padding: 10px;
            background-color: #2c2c2c;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .filter-group label {
            margin-right: 10px;
            font-weight: 600;
            color: #e0e0e0;
        }

        .filter-group select {
            padding: 8px;
            border: 1px solid #444;
            border-radius: 4px;
            background-color: #333;
            color: #e0e0e0;
        }

        .product-comparison {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .product-column {
            flex: 1;
            padding: 10px;
            background-color: #1e1e1e;
            border: 1px solid #333;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .product-column h3 {
            font-size: 18px;
            margin-bottom: 10px;
            color: #e0e0e0;
        }

        .product-card {
            border: 1px solid #333;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #2c2c2c;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
            transition: transform 0.2s ease;
        }

        .product-card img {
    max-width: 250px; /* Increased to 250px for a larger image display */
    display: block;
    margin: 0 auto 20px; /* Centered the image and added more space below */
    transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition for hover effects */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); /* Subtle shadow for image visibility */
}

.product-card img:hover {
    transform: scale(1.3); /* Larger scale on hover for clearer visibility */
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.7); /* Enhanced shadow on hover for a bold effect */
}



        .product-card h4 {
            font-size: 16px;
            margin: 0 0 10px;
            color: #e0e0e0;
        }

        .product-card p {
            margin: 0;
            font-size: 14px;
            color: #b0b0b0;
        }

        .price {
            color: #00ff00; /* A bright green to stand out */
            font-weight: bold;
            font-size: 16px;
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
        <div class="filter-group">
            <label for="ddlCategory">Category:</label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="FilterProducts">
                <asp:ListItem Text="All Categories" Value="" />
                <asp:ListItem Text="PC" Value="PC" />
                <asp:ListItem Text="Laptop" Value="Laptop" />
                <asp:ListItem Text="Mobile" Value="Mobile" />
            </asp:DropDownList>
            <label for="ddlBrand">Brand:</label>
            <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="FilterProducts">
                <asp:ListItem Text="All Brands" Value="" />
                <asp:ListItem Text="Dell" Value="Dell" />
                <asp:ListItem Text="HP" Value="HP" />
                <asp:ListItem Text="Acer" Value="Acer" />
                <asp:ListItem Text="MSI" Value="MSI" />
                <asp:ListItem Text="Samsung" Value="Samsung" />
                <asp:ListItem Text="Apple" Value="Apple" />
                <asp:ListItem Text="OnePlus" Value="OnePlus" />
                <asp:ListItem Text="Xiaomi" Value="Xiaomi" />
            </asp:DropDownList>

            <asp:DropDownList ID="ddlRAMCapacity" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="FilterProducts">
                <asp:ListItem Text="All RAM Capacities" Value="" />
                <asp:ListItem Text="8 GB" Value="8" />
                <asp:ListItem Text="12 GB" Value="12" />
                <asp:ListItem Text="32 GB" Value="32" />
            </asp:DropDownList>

            <asp:DropDownList ID="ddlROMCapacity" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="FilterProducts">
                <asp:ListItem Text="All ROM Capacities" Value="" />
                <asp:ListItem Text="512 GB" Value="512" />
                <asp:ListItem Text="1 TB" Value="1000" />
                <asp:ListItem Text="2 TB" Value="2000" />
            </asp:DropDownList>

        </div>

        <div class="product-comparison">
            <div class="product-column">
                <h3>Supplier 1 Products</h3>
                <asp:PlaceHolder ID="Supplier1Products" runat="server"></asp:PlaceHolder>
            </div>
            <div class="product-column">
                <h3>Supplier 2 Products</h3>
                <asp:PlaceHolder ID="Supplier2Products" runat="server"></asp:PlaceHolder>
            </div>
        </div>
   

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
