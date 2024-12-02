using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("SurveyId", "Question")]
public partial class SurveyQuestion
{
    [Key]
    [Column("SurveyID")]
    public int SurveyId { get; set; }

    [Key]
    [StringLength(255)]
    [Unicode(false)]
    public string Question { get; set; } = null!;

    [InverseProperty("SurveyQuestion")]
    public virtual ICollection<FilledSurvey> FilledSurveys { get; set; } = new List<FilledSurvey>();

    [ForeignKey("SurveyId")]
    [InverseProperty("SurveyQuestions")]
    public virtual Survey Survey { get; set; } = null!;
}
