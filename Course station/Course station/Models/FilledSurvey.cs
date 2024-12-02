using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("SurveyId", "Question", "LearnerId")]
[Table("FilledSurvey")]
public partial class FilledSurvey
{
    [Key]
    [Column("SurveyID")]
    public int SurveyId { get; set; }

    [Key]
    [StringLength(255)]
    [Unicode(false)]
    public string Question { get; set; } = null!;

    [Key]
    [Column("LearnerID")]
    public int LearnerId { get; set; }

    [Column(TypeName = "text")]
    public string Answer { get; set; } = null!;

    [ForeignKey("LearnerId")]
    [InverseProperty("FilledSurveys")]
    public virtual Learner Learner { get; set; } = null!;

    [ForeignKey("SurveyId, Question")]
    [InverseProperty("FilledSurveys")]
    public virtual SurveyQuestion SurveyQuestion { get; set; } = null!;
}
