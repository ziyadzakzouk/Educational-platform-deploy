using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("AssessmentId", "LearnerId")]
[Table("TakenAssessment")]
public partial class TakenAssessment
{
    [Key]
    [Column("Assessment_ID")]
    public int AssessmentId { get; set; }

    [Key]
    [Column("Learner_ID")]
    public int LearnerId { get; set; }

    public int? ScoredPoint { get; set; }

    [ForeignKey("AssessmentId")]
    [InverseProperty("TakenAssessments")]
    public virtual Assessment Assessment { get; set; } = null!;

    [ForeignKey("LearnerId")]
    [InverseProperty("TakenAssessments")]
    public virtual Learner Learner { get; set; } = null!;
}
