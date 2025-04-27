<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentDashboard.Master" AutoEventWireup="true" CodeBehind="SProfile.aspx.cs" Inherits="Online_Exam_System.Student.SProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">Manage Profile</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var img = document.getElementById('<%= imgProfileEdit.ClientID %>');
                img.src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <div class="card shadow-lg rounded-4">
            <div class="card-header bg-gradient-primary text-white d-flex justify-content-between align-items-center" style="background: linear-gradient(45deg, #007bff, #00c6ff);">
                <h4 class="mb-0">👤 My Profile</h4>
                       
                <asp:Image ID="imgProfile" runat="server" CssClass="rounded-circle" Width="60px" Height="60px" Style="border: 2px solid white;" />
            </div>

            <div class="card-body">
                <div class="row mb-4">
                    <div class="col-md-3 fw-bold">🆔 Username:</div>
                    <div class="col-md-9">
                        <asp:Label ID="Username" runat="server" CssClass="text-primary fw-semibold" /></div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-3 fw-bold">📛 Name:</div>
                    <div class="col-md-9">
                        <asp:Label ID="lblName" runat="server" CssClass="text-dark fw-semibold" /></div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-3 fw-bold">📧 Email:</div>
                    <div class="col-md-9">
                        <asp:Label ID="lblEmail" runat="server" CssClass="text-dark fw-semibold" /></div>
                </div>

                <div class="d-flex justify-content-center gap-3">
                    <button type="button" class="btn btn-outline-warning rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#editModal">
                        ✏️ Edit Profile
                    </button>
                    <button type="button" class="btn btn-outline-danger rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#resetModal">
                        🔒 Reset Password
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- 🟡 Edit Profile Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow-lg">
                <div class="modal-header bg-warning rounded-top-4">
                    <h5 class="modal-title">✏️ Edit Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div class="text-center mb-4">
                        <asp:Image ID="imgProfileEdit" runat="server" CssClass="rounded-circle" Width="100px" Height="100px" Style="border: 2px solid #ffc107;" />
                        <div class="mt-2">
                            <asp:FileUpload ID="fuProfilePic" runat="server" CssClass="form-control" onchange="previewImage(this);"/>
                        </div>
                    </div>
                    <div class="mb-3">
                        <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtUser" Display="Dynamic" ForeColor="Red" ErrorMessage="User Name Is Taken.. Please Try With Different Email.!!!" OnServerValidate="cvCustom_ServerValidate1"    EnableClientScript="true" ></asp:CustomValidator>
                        <label class="fw-semibold">👤 Username</label>
                        <asp:TextBox ID="txtuser" runat="server" CssClass="form-control rounded-3" />
                    </div>
                    <div class="mb-3">
                        <label class="fw-semibold">👤 Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control rounded-3" />
                    </div>

                    <div class="mb-3">
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ErrorMessage="Email Is Already Used Please Try With Different Email.!!!" OnServerValidate="cvCustom_ServerValidate"    EnableClientScript="true" ></asp:CustomValidator>

                        <label class="fw-semibold">📧 Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control rounded-3" />
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="btnSave" runat="server" Text="💾 Save Changes" CssClass="btn btn-success rounded-pill px-4" OnClick="btnSave_Click" CausesValidation="true" />
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 🔴 Reset Password Modal -->
    <div class="modal fade" id="resetModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 shadow-lg">
                <div class="modal-header bg-danger text-white rounded-top-4">
                    <h5 class="modal-title">🔒 Reset Password</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div class="mb-3">
                        <label class="fw-semibold">🛡 New Password</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control rounded-3" TextMode="Password" />
                    </div>

                    <div class="mb-3">
                        <label class="fw-semibold">🛡 Confirm Password</label>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match!" ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmPassword" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control rounded-3" TextMode="Password" />
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="btnUpdatePassword" runat="server" Text="🔐 Update Password" CssClass="btn btn-light rounded-pill px-4" OnClick="btnUpdatePassword_Click" />
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
