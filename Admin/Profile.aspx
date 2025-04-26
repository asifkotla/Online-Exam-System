    <%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPanel.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Online_Exam_System.Admin.Profile" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
        Profile
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container mt-5">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Admin Profile</h4>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-3"><strong>Name:</strong></div>
                    <div class="col-md-9"><asp:Label ID="lblName" runat="server" /></div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-3"><strong>Email:</strong></div>
                    <div class="col-md-9"><asp:Label ID="lblEmail" runat="server" /></div>
                </div>
               
                <hr />

                <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editModal">
                    ✏️ Edit Profile
                </button>
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#resetModal">
                    🔒 Reset Password
                </button>
            </div>
        </div>
    </div>

    <!-- 🟡 Edit Modal -->

    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-warning">
                    <h5 class="modal-title">Edit Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label>Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label>Email</label>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ErrorMessage="Email Is Already Used Please GTry With Different Email.!!!" OnServerValidate="cvCustom_ServerValidate"    EnableClientScript="false" ></asp:CustomValidator>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSave" runat="server" Text="💾 Save" CssClass="btn btn-success" OnClick="btnSave_Click" CausesValidation="true"  />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 🔴 Reset Password Modal -->
    <div class="modal fade" id="resetModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Reset Password</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label>New Password</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>
                    <div class="mb-3">
                        <label>Confirm Password</label>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="New Password And Confrimed Password Are Not Matched !!!" ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmPassword" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control"  ControlToValidate="txtConfirmPassword" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnUpdatePassword" runat="server" Text="🔐 Update" CssClass="btn btn-light" OnClick="btnUpdatePassword_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    </asp:Content>
