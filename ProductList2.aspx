<%@ Page Title="Product List" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="ProductList2.aspx.cs" Inherits="w2.ProductList2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #1e1e1e; /* Dark background for a techy look */
            color: #e0e0e0; /* Light text color for contrast */
            margin: 0;
            padding: 0;
        }

        /* Container Styles */
        .container {
            width: 90%;
            margin: 20px auto;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        /* Product Card Styles */
        .product-card {
            background-color: #2d2d2d; /* Darker background for techy feel */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin: 15px;
            width: calc(33.33% - 30px);
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: box-shadow 0.3s ease, transform 0.3s ease;
            position: relative;
            overflow: hidden; /* Hide overflowing content for animation */
        }

        /* Hover Effect for Product Card */
        .product-card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
            transform: scale(1.03); /* Slight zoom effect */
        }

        /* Product Image Styles */
        .product-card img {
            max-width: 100%;
            border-radius: 8px;
            object-fit: cover;
            transition: opacity 0.3s ease;
        }

        /* Hover Effect for Product Image */
        .product-card img:hover {
            opacity: 0.8; /* Slightly dim image on hover */
        }

        /* Product Details Styles */
        .product-details {
            padding: 10px 0;
        }

        /* Product Details Heading Styles */
        .product-details h3 {
            margin: 0 0 10px;
            font-size: 1.5em;
            color: #4caf50; /* Techy green color */
            font-weight: 600;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }

        /* Product Details Paragraph Styles */
        .product-details p {
            margin: 5px 0;
            color: #bbb; /* Light grey color for text */
            line-height: 1.5;
        }

        /* Price Styles */
        .price {
            font-size: 1.2em;
            color: #4CAF50; /* Techy green color */
            font-weight: bold;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .product-card {
                width: calc(50% - 30px);
            }
        }

        @media (max-width: 480px) {
            .product-card {
                width: 100%;
            }
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
    /* Button styling */
.button-link {
    display: inline-block;
    padding: 12px 24px;
    font-size: 16px;
    font-weight: bold;
    color: #ffffff;
    background-color: #007bff; /* Blue color for a modern look */
    border: none;
    border-radius: 5px;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
    border: 2px solid transparent; /* Adds a border that changes color on hover */
}

/* Button hover effect */
.button-link:hover {
    background-color: #0056b3; /* Darker blue for hover */
    border-color: #004085; /* Darker border color on hover */
    transform: scale(1.05); /* Slightly enlarge the button */
}

/* Button active effect */
.button-link:active {
    background-color: #004085; /* Even darker blue for active state */
    border-color: #003366; /* Even darker border color on active */
    transform: scale(0.98); /* Slightly shrink the button */
}

/* Button focus effect */
.button-link:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(38, 143, 255, 0.5); /* Focus ring with a blue tint */
}

    </style>
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Particles.js container -->
    <div id="particles-js"></div>
    <div class="container">
        <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
            <ItemTemplate>
                <div class="product-card">
                    <img src='<%# ResolveUrl(Eval("ImageUrl").ToString()) %>' alt="Product Image" />
                    <div class="product-details">
                        <h3><%# Eval("ProductName") %></h3>
                        <p><strong>Category:</strong> <%# Eval("Category") %></p>
                        <p><strong>Brand:</strong> <%# Eval("Brand") %></p>
                        <p><strong>RAM:</strong> <%# Eval("RAMCapacity") %> GB</p>
                        <p><strong>ROM:</strong> <%# Eval("ROMCapacity") %> GB</p>
                        <p class="price">Price: <%# Eval("Price", "{0:C}") %></p>
                        <p><strong>Description:</strong> <%# Eval("Description") %></p>
                        <p><strong>Quantity in stock:</strong> <%# Eval("QuantityInStock") %></p>
                         
                        <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%# Eval("ProductID2") %>' CssClass="button-link" />

                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Particles.js script -->
    
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
