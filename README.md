# QuizNest 🎓 – Online Exam System

**QuizNest** is a comprehensive and secure online examination platform built using **ASP.NET Web Forms (.NET Framework)**, **SQL Server**,**Entity FrameWork**, **HTML**, **CSS**, **JavaScript**, and **Bootstrap**.

It provides role-based access for **Admin** and **Students**, allowing smooth exam management, insightful analytics, secure exam-taking, and PDF result generation.

---

## 🚀 Features

### 👤 Roles
- **Admin**
- **Student**

---

### 🔐 Admin Panel
- Manage Students and Exams
- Add Exams via Excel file upload
- Edit/Delete exams and student records
- Respond to student feedback
- **Exam Analytics**:
  - Total candidates enrolled
  - Total present and absent
  - Pass/Fail breakdown
  - Average scores

---

### 🧑‍🎓 Student Dashboard
- View **Total Enrolled**, **Completed**, and **Pending** Exams
- **Available Exams** tab:
  - List of all active exams
  - Enroll in upcoming exams
- **My Exams** tab:
  - Shows enrolled exams with date/time
  - Start exam only when allowed
  - Wait screen shown if attempted early
- **After Submission**:
  - Download auto-generated PDF containing:
    - Questions
    - Chosen options
    - Answer keys

---

## 🛡️ Exam Page Security

- ❌ Page Resize Disabled  
- ❌ Copy / Paste Disabled  
- ❌ Right Click Disabled  
- ❌ Browser Navigation (Back/Forward) Disabled  
- ❌ Alt + Tab / Windows Key Detection  
- 🔒 Window focus monitoring  
- ✅ Fullscreen Mode Option  

---

## ☁️ Deployment (AWS)

- Deployed to **AWS EC2** instance using **IIS**
- **Database** hosted on **AWS RDS (SQL Server)**
- Hosted link is **not secured (HTTP)**. If you want to access: https://3.111.108.33/QuizNest/
  - Click **Advanced**
  - Select **"Proceed anyway / unsafe"**

---

## 💻 Tech Stack

| Technology       | Description                          |
|------------------|--------------------------------------|
| ASP.NET WebForms | Backend framework                    |
| .NET Framework   | Windows platform runtime              |
| SQL Server       | Relational database system            |
| HTML/CSS         | Structure and styling                 |
| Bootstrap        | Responsive UI components              |
| JavaScript/jQuery| Client-side interactivity & security  |
| AWS EC2          | App Hosting (Windows Server + IIS)    |
| AWS RDS          | SQL Server database hosting           |

---

## 📦 Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/QuizNest.git
