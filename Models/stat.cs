using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Online_Exam_System.Models
{
    public class stat
    {
        
        
            public int TotalCandidates { get; set; }
            public int AttendedCandidates { get; set; }
            public int AbsentCandidates { get; set; }
            public int TotalQuestions { get; set; }
            public int MaxMarks { get; set; }
            public int PassingMarks { get; set; }
        
    }
}