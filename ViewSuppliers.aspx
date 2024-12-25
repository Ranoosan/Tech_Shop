<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="ViewSuppliers.aspx.cs" Inherits="w2.ViewSuppliers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #1e1e1e; /* Dark theme background */
    color: #e0e0e0; /* Light text for contrast */
    margin: 0;
    padding: 0;
}

/* Container styles for suppliers */
.suppliers-container {
    margin: 20px auto;
    max-width: 1200px;
    background: linear-gradient(135deg, #1e1e1e, #2c2c2c); /* Dark gradient */
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.7);
    text-align: center;
}

.suppliers-container h2 {
    color: #1f8ef1;
    text-transform: uppercase;
    margin-bottom: 30px;
    font-size: 28px;
    letter-spacing: 2px;
    background: linear-gradient(135deg, #1f8ef1, #3b3b3b); /* Gradient text */
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* Supplier card styles */
.supplier-card {
    background: #2d2d2d;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.6);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.supplier-card:hover {
    transform: translateY(-5px); /* Lift on hover */
    box-shadow: 0 8px 18px rgba(0, 0, 0, 0.8);
}

/* Supplier details text */
.supplier-details h3 {
    color: #1f8ef1;
    font-size: 22px;
    margin-bottom: 15px;
    text-transform: uppercase;
    letter-spacing: 1.5px;
}

.supplier-details p {
    margin: 5px 0;
    color: #e0e0e0;
}

.supplier-details strong {
    color: #1f8ef1;
}

/* Responsive styles */
@media (max-width: 768px) {
    .suppliers-container {
        width: 95%;
    }

    .supplier-details h3 {
        font-size: 20px;
    }

    .supplier-card {
        padding: 15px;
    }
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

    <div class="suppliers-container">
        <h2>Our Computer Shop Suppliers</h2>

        <!-- Supplier 1 -->
        <div class="supplier-card">
            <div class="supplier-details">
                <h3>Supplier 1: Tech Innovators</h3>
                <p><strong>Contact Person:</strong> John Doe</p>
                <p><strong>Address:</strong> 1234 Silicon Avenue, Tech City, 56789</p>
                <p><strong>Phone:</strong> +1 (123) 456-7890</p>
                <p><strong>Email:</strong> john@techinnovators.com</p>
                <p><strong>Specialty:</strong> High-performance PCs, gaming components, peripherals</p>
            </div>
        </div>

        <!-- Supplier 2 -->
        <div class="supplier-card">
            <div class="supplier-details">
                <h3>Supplier 2: FutureTech Supplies</h3>
                <p><strong>Contact Person:</strong> Jane Smith</p>
                <p><strong>Address:</strong> 9876 Future Blvd, Innovation Park, 12345</p>
                <p><strong>Phone:</strong> +1 (987) 654-3210</p>
                <p><strong>Email:</strong> jane@futuretech.com</p>
                <p><strong>Specialty:</strong> Laptops, tablets, mobile devices, accessories</p>
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
