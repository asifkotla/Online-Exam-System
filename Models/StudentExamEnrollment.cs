//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Online_Exam_System.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class StudentExamEnrollment
    {
        public int EnrollmentID { get; set; }
        public int StudentID { get; set; }
        public int ExamID { get; set; }
        public Nullable<System.DateTime> EnrollmentDate { get; set; }
        public Nullable<bool> IsExamCompleted { get; set; }
    
        public virtual Exam Exam { get; set; }
        public virtual Student Student { get; set; }
    }
}
