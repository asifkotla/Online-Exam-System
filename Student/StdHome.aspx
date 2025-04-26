<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentDashboard.Master" AutoEventWireup="true" CodeBehind="StdHome.aspx.cs" Inherits="Online_Exam_System.Student.StdHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
    Student Home
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .card-box {
            border-radius: 10px;
            color: white;
            padding: 20px;
            min-height: 200px; /* Set this to desired height */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        body, html {
    height: 100%;
    margin: 0;
    padding: 0;
}
        .card-blue {
            background-color: #4B7BEC;
        }

        .card-green {
            background-color: #2ECC71;
        }

        .card-yellow {
            background-color:#F7B731;
        }

        .btnadd {
            height: 40px;
            width: auto;
        }
        .quotes-list {
    animation: scroll-up 20s linear infinite;
    display: flex;
    flex-direction: column;
}

@keyframes scroll-up {
    0% {
        transform: translateY(100%);
    }
    100% {
        transform: translateY(-100%);
    }
}

.quotes-list p {
    margin: 0 0 1rem;
    font-style: italic;
}
    </style>
 
<script>
    // Ensure the DOM is loaded before executing the script
    window.onload = function () {
        function updateTime() {
            const currentTime = new Date();
            const hours = currentTime.getHours().toString().padStart(2, '0');
            const minutes = currentTime.getMinutes().toString().padStart(2, '0');
            const seconds = currentTime.getSeconds().toString().padStart(2, '0');
            const date = currentTime.toLocaleDateString();

            // Updating the content of the div with the current date and time
            document.getElementById('current-time').innerHTML = `${date} ${hours}:${minutes}:${seconds}`;
        }

        // Update time every second
        setInterval(updateTime, 1000);

        // Initial call to set time immediately
        updateTime();
    };
</script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var ticker = document.getElementById('newsTicker');
            var position = ticker.parentElement.offsetWidth;

            function scrollTicker() {
                position--;
                if (position < -ticker.offsetWidth) {
                    position = ticker.parentElement.offsetWidth;
                }
                ticker.style.left = position + 'px';
            }

            setInterval(scrollTicker, 20); // Speed of scrolling
        });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     
<div class="d-flex justify-content-between aling-items-center mb-3">
    <h2 class="mb-0">Home</h2>
   
    <div id="current-time" class=" badge  bg-dark text-center justify-content-center align-content-center"> </div>
</div>
     
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="card-box card-blue text-center">
            <h6>Total Exam Enrolled</h6>
            <h1>
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></h1>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card-box card-green text-center">
            <h6>Completed Exams</h6>
            <h1>
                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></h1>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card-box card-yellow text-center">
            <h6>Pending Exams</h6>
            <h1>
                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label></h1>
        </div>
    </div>
</div>
    <div class="row g-2 mb-2">
    <div class="col-md-6">
    <div class="card p-3 shadow-sm h-100">
       <h5 class="mb-3">📅 Upcoming Exams</h5>
        <asp:Label ID="lblNoExamMessage" runat="server" 
    Text="You have not enrolled in any upcoming exams." 
    CssClass="text-danger" 
    Visible="false">
</asp:Label>
<asp:Repeater ID="rptUpcomingExams" runat="server">
    <ItemTemplate>
        <div class="mb-3 border-bottom pb-2">
            <h6><%# Eval("Title") %></h6>
            <p class="mb-1 text-muted">Date: <%# DateTime.Now.ToString("dd MMM yyyy") %></p>
            <p class="mb-2 text-muted">Time: <%# TimeSpan.Parse(Eval("StartTime").ToString()).ToString(@"hh\:mm") %></p>

            <asp:Button ID="btnStart" runat="server" Text="Start" 
                CssClass="btn btn-sm btn-primary" 
              Enabled='<%# DateTime.Now.AddMinutes(15).TimeOfDay >= TimeSpan.Parse(Eval("StartTime").ToString()) %>'
                CommandArgument='<%# Eval("ExamID") %>'
                OnCommand="StartExam_Click" />
        </div>

    </ItemTemplate>
</asp:Repeater>
        </div>
    </div>
        <div class="col-md-6">
            <div class="card p-3 shadow-sm h-100 bg-light">
                <h5 class="mb-3">💡 Motivational Quotes</h5>
                <div class="quote-marquee" style="height: 250px; overflow: hidden; position: relative;">
                    <div class="quotes-list">
                        <p>"Push yourself, because no one else is going to do it for you."</p>
                        <p>"Success doesn’t just find you. You have to go out and get it."</p>
                        <p>"The harder you work for something, the greater you’ll feel when you achieve it."</p>
                        <p>"Dream it. Wish it. Do it."</p>
                        <p>"Sometimes later becomes never. Do it now."</p>
                        <p>"Great things never come from comfort zones."</p>
                        <p>"Success is not for the lazy."</p>
                        <p>"Little things make big days."</p>
                        <p>"Don't watch the clock; do what it does. Keep going."</p>
                        <p>"Push harder than yesterday if you want a different tomorrow."</p>
                        <p>"Cheating only cheats yourself."</p>
                        <p>"Integrity is doing the right thing, even when no one is watching." – C.S. Lewis</p>
                        <p>"You might pass the exam by cheating, but you’ll fail in life." – Unknown</p>
                        <p>"Honesty is the first chapter in the book of wisdom." – Thomas Jefferson</p>
                        <p>"Shortcuts make long delays." – J.R.R. Tolkien</p>
                        <p>"The real test is not what you do when everyone is watching — it's what you do when no one is."</p>
                        <p>"A clear conscience is more valuable than a perfect score."</p>
                        <p>"Your character is worth more than a few extra marks."</p>
                        <p>"It’s not about passing the exam, it’s about earning the knowledge."</p>
                        <p>"The easiest path may seem tempting, but it leads to the weakest results."</p>
                    </div>
                </div>
            </div>
        </div>
 
        <div class="card p-3 shadow-sm mb-4">
    <h5 class="mb-3">🔥 Announcements</h5>
    <div class="alert alert-info overflow-hidden" role="alert" style="height: 40px; position: relative;">
        <div id="newsTicker" style="position: absolute; white-space: nowrap;">
            📢 Python Exam scheduled tomorrow 9 AM. &nbsp;&nbsp;&nbsp; 📢 Results for C# Exam will be declared soon. &nbsp;&nbsp;&nbsp; 📢 Java Exam enrollment closing tonight!
        </div>
    </div>
</div>
        </div>
</asp:Content>
