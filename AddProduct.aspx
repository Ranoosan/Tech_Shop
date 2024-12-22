<%@ Page Title="Add Product" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="w2.AddProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #1e1e1e; /* Dark background for a techy look */
            color: #e0e0e0; /* Light text color for contrast */
            margin: 0;
            padding: 0;
            overflow: hidden; /* Hide overflow for animation */
        }

        .form-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background: #2d2d2d; /* Darker container background */
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
            border: 1px solid #444; /* Slight border for depth */
            position: relative;
            overflow: hidden; /* Hide overflowing content for animation */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        /* Hover effect for form */
        .form-container:hover {
            transform: scale(1.02); /* Slight scale on hover */
            box-shadow: 0 15px 30px rgba(0,0,0,0.5); /* Deeper shadow */
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(255,255,255,0.05), rgba(0,0,0,0.1));
            opacity: 0.3;
            animation: pulse 3s infinite;
            z-index: 0;
        }

        @keyframes pulse {
            0% {
                opacity: 0.3;
            }
            50% {
                opacity: 0.6;
            }
            100% {
                opacity: 0.3;
            }
        }

        .form-container > * {
            position: relative;
            z-index: 1; /* Ensure all content is above the animation */
        }

        h2 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #4caf50; /* Techy green color */
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #bbb; /* Light grey label color */
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="file"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #555; /* Darker border for input fields */
            border-radius: 6px;
            box-sizing: border-box;
            background-color: #333; /* Dark input background */
            color: #e0e0e0; /* Light text color */
            transition: background-color 0.3s ease, border-color 0.3s ease;
        }

        .form-group input[type="text"]:hover,
        .form-group input[type="number"]:hover,
        .form-group input[type="file"]:hover,
        .form-group textarea:hover,
        .form-group select:hover {
            background-color: #444; /* Slightly lighter background on hover */
            border-color: #4caf50; /* Highlight border color on hover */
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-group button {
            background-color: #4caf50; /* Techy green button */
            color: white;
            border: none;
            padding: 12px 24px;
            text-align: center;
            font-size: 16px;
            margin: 6px 0;
            cursor: pointer;
            border-radius: 6px;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .form-group button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 300%;
            height: 300%;
            background: rgba(255, 255, 255, 0.3);
            transition: transform 0.3s ease;
            transform: translate(-50%, -50%) scale(0);
            border-radius: 50%;
            z-index: 0;
        }

        .form-group button:hover::before {
            transform: translate(-50%, -50%) scale(1);
        }

        .form-group button:hover {
            background-color: #388e3c; /* Darker green on hover */
            transform: scale(1.05);
            box-shadow: 0 8px 15px rgba(0,0,0,0.3);
        }

        .form-group button:focus {
            outline: none;
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
        <h2>Add Product</h2>
        <div class="form-group">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                <asp:ListItem Text="Select Category" Value="" />
                <asp:ListItem Text="PC" Value="PC" />
                <asp:ListItem Text="Laptop" Value="Laptop" />
                <asp:ListItem Text="Mobile" Value="Mobile" />
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control">
                <asp:ListItem Text="Select Brand" Value="" />
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="ddlRAMCapacity" runat="server" CssClass="form-control">
                <asp:ListItem Text="Select RAM Capacity" Value="" />
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="ddlROMCapacity" runat="server" CssClass="form-control">
                <asp:ListItem Text="Select ROM Capacity" Value="" />
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="Product Name"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Price" TextMode="Number"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Description"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
        </div>
        <div class="form-group">
            <asp:Button ID="btnSubmit" runat="server" Text="Add Product" CssClass="btn" OnClick="btnSubmit_Click" />
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
