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
    
    public partial class Question
    {
        public int QuestionID { get; set; }
        public Nullable<int> ExamID { get; set; }
        public string QuestionText { get; set; }
        public string OptionA { get; set; }
        public string OptionB { get; set; }
        public string OptionC { get; set; }
        public string OptionD { get; set; }
        public string CorrectOption { get; set; }
    
        public virtual Exam Exam { get; set; }
    }
}
