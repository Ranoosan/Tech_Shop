<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="w2.AdminPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212; /* Dark background */
            color: #e0e0e0; /* Light text color */
            margin: 0;
            padding: 0;
            overflow-x: hidden; /* Hide horizontal overflow */
        }

        /* Dashboard Container */
        .dashboard-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            gap: 20px;
            padding: 20px;
            background: linear-gradient(135deg, #1e1e1e, #2c2c2c); /* Dark gradient background */
        }

        /* Heading Styles */
        .dashboard-heading {
            font-size: 2.5em;
            color: #00bfae; /* Tech blue */
            text-shadow: 0 2px 4px rgba(0,0,0,0.5);
            margin-bottom: 30px;
            text-align: center;
            letter-spacing: 1px;
        }

        /* Dashboard Item */
        .dashboard-item {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background: #2d2d2d; /* Dark container background */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
            position: relative;
            overflow: hidden; /* Hide overflow for animations */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        /* Button Styles */
        .dashboard-button {
            display: inline-block;
            padding: 15px 30px;
            font-size: 16px;
            color: #fff;
            background-color: #1f8ef1; /* Tech blue */
            text-decoration: none;
            border-radius: 6px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            overflow: hidden;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
            z-index: 1;
        }

        /* Button Hover Effects */
        .dashboard-button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 300%;
            height: 300%;
            background: rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease;
            transform: translate(-50%, -50%) scale(0);
            border-radius: 50%;
            z-index: 0;
        }

        .dashboard-button:hover {
            background-color: #00bfae; /* Darker blue */
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        .dashboard-button:hover::before {
            transform: translate(-50%, -50%) scale(1);
        }

        .dashboard-button:active {
            background-color: #005bb5; /* Even darker blue */
            transform: scale(1);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
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
    <div class="dashboard-container">
        <div class="dashboard-heading">Welcome Techex Admin</div>
        <div class="dashboard-item">
            <a href="manageorders.aspx" class="dashboard-button">Manage Orders</a>
        </div>
        
        <div class="dashboard-item">
            <a href="CompareProducts.aspx" class="dashboard-button">Compare Products</a>
        </div>
        <div class="dashboard-item">
            <a href="ViewSuppliers.aspx" class="dashboard-button">View Suppliers</a>
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
