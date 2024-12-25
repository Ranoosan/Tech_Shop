<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="supplier1.aspx.cs" Inherits="w2.supplier1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212; /* Dark theme background */
            margin: 0;
            padding: 0;
            color: #f1f1f1; /* Light text for dark theme */
        }

        /* Dashboard Container */
        .dashboard-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            gap: 25px;
        }

        /* Dashboard Item */
        .dashboard-item {
            width: 100%;
            max-width: 400px;
            padding: 25px;
            display: flex;
            justify-content: center;
        }

        /* Button Styles */
        .dashboard-button {
            display: inline-block;
            padding: 15px 40px;
            font-size: 18px;
            font-weight: bold;
            text-transform: uppercase;
            color: #fff;
            background-color: #1f8ef1; /* Blue for Supplier 1 */
            text-decoration: none;
            border-radius: 8px;
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.3);
            transition: all 0.4s ease;
        }

        /* Hover Effects */
        .dashboard-button:hover {
            background-color: #0d6efd;
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.5);
        }

        /* Active Effects */
        .dashboard-button:active {
            background-color: #094dbe;
            transform: translateY(2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        /* Advanced Button Effects */
        .dashboard-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 8px;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            opacity: 0;
            transition: opacity 0.4s ease;
        }

        .dashboard-button:hover::before {
            opacity: 1;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
            }
            .dashboard-item {
                width: 90%;
            }
        }
          .dashboard-heading {
      font-size: 2.5em;
      color: #00bfae; /* Tech blue */
      text-shadow: 0 2px 4px rgba(0,0,0,0.5);
      margin-bottom: 30px;
      text-align: center;
      letter-spacing: 1px;
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

    <div class="dashboard-container">
        <div class="dashboard-heading">Welcome Tech Innovators</div>
        <div class="dashboard-item">
            <a href="AddProduct.aspx" class="dashboard-button">Add Products</a>
        </div>
        <div class="dashboard-item">
            <a href="ProductList1.aspx" class="dashboard-button">View Products</a>
        </div>
         <div class="dashboard-item">
     <a href="ViewSupplier1Orders.aspx" class="dashboard-button">Manage Orders</a>
 </div>
                <div class="dashboard-item">
    <a href="InventoryManagement.aspx" class="dashboard-button">Inventory</a>
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
