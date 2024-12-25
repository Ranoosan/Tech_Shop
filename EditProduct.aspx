<%@ Page Title="Edit Product" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="EditProduct.aspx.cs" Inherits="EditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* General Styles */
/* General Styles */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #1e1e1e; /* Dark background for a techy look */
    color: #e0e0e0; /* Light text color for contrast */
    margin: 0;
    padding: 0;
}

/* Form Container */
.form-container {
    width: 80%;
    max-width: 900px;
    margin: 20px auto;
    padding: 30px;
    background-color: #2d2d2d; /* Darker background for form */
    border-radius: 12px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
    position: relative;
}

/* Form Heading */
.form-container h2 {
    color: #4caf50; /* Techy green color */
    margin-bottom: 20px;
    font-size: 2em;
    text-align: center;
    text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
}

/* Form Group Styles */
.form-group {
    margin-bottom: 20px;
}

/* Labels */
.form-group label {
    display: block;
    color: #ccc; /* Light grey for labels */
    margin-bottom: 8px;
    font-weight: bold;
    font-size: 1.1em;
}

/* TextBoxes */
.form-group input[type="text"],
.form-group input[type="number"],
.form-group textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #555; /* Border color */
    border-radius: 6px;
    background-color: #3a3a3a; /* Slightly lighter background */
    color: #e0e0e0; /* Text color */
    font-size: 1em;
    transition: border-color 0.3s ease;
}

.form-group input[type="text"]:focus,
.form-group input[type="number"]:focus,
.form-group textarea:focus {
    border-color: #4caf50; /* Green border on focus */
    outline: none; /* Remove default outline */
}

/* File Upload */
.form-group input[type="file"] {
    background-color: #3a3a3a; /* Background color for file upload */
    border: 1px solid #555;
    border-radius: 6px;
    padding: 8px;
    color: #e0e0e0;
}

/* Image */
.form-group img {
    display: block;
    margin: 20px auto;
    border-radius: 12px;
    border: 2px solid #4caf50; /* Techy green border */
}

/* Buttons */
.form-group input[type="submit"] {
    background-color: #4caf50; /* Techy green background */
    border: none;
    color: #fff; /* White text */
    padding: 12px 24px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 1.1em;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

.form-group input[type="submit"]:hover {
    background-color: #45a049; /* Darker green on hover */
    transform: scale(1.05); /* Slight zoom effect */
}

/* Error Message */
#lblMessage {
    font-weight: bold;
    margin-bottom: 15px;
    color: #f44336; /* Red color for error messages */
    font-size: 1.1em;
}

/* Responsive Styles */
@media (max-width: 768px) {
    .form-container {
        width: 95%;
        padding: 20px;
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

    <div class="form-container">
        <h2>Edit Product</h2>
        <asp:Panel ID="pnlEdit" runat="server">
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <div class="form-group">
                <label for="txtProductName">Product Name</label>
                <asp:TextBox ID="txtProductName" runat="server" />
            </div>

            <div class="form-group">
                <label for="txtCategory">Category</label>
                <asp:TextBox ID="txtCategory" runat="server" />
            </div>

            <div class="form-group">
                <label for="txtBrand">Brand</label>
                <asp:TextBox ID="txtBrand" runat="server" />
            </div>

            <div class="form-group">
                <label for="txtRAMCapacity">RAM Capacity</label>
                <asp:TextBox ID="txtRAMCapacity" runat="server" />
            </div>

            <div class="form-group">
                <label for="txtROMCapacity">ROM Capacity</label>
                <asp:TextBox ID="txtROMCapacity" runat="server" />
            </div>

            <div class="form-group">
                <label for="txtPrice">Price</label>
                <asp:TextBox ID="txtPrice" runat="server" TextMode="Number" />
            </div>
              <div class="form-group">
       <label for="txtQuantity">Qunatity</label>
        <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" />
  </div>

            <div class="form-group">
                <label for="txtDescription">Description</label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="5" />
            </div>
          

            <div class="form-group">
                <label>Current Product Image</label>
                <asp:Image ID="imgProduct" runat="server" Width="200px" Height="200px" />
            </div>

            <div class="form-group">
                <label for="fileUpload">Change Image</label>
                <asp:FileUpload ID="fileUpload" runat="server" />
            </div>

            <div class="form-group">
                <asp:Button ID="btnUpdate" runat="server" Text="Update Product" OnClick="btnUpdate_Click" />
            </div>
        </asp:Panel>
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
