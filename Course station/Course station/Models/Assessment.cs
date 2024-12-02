using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Assessment")]
public partial class Assessment
{
    [Key]
    [Column("Assessment_ID")]
    public int AssessmentId { get; set; }

    [Column("Module_ID")]
    public int? ModuleId { get; set; }

    [Column("Course_ID")]
    public int? CourseId { get; set; }

    [Column("type")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Type { get; set; }

    [Column("totalMarks")]
    public int? TotalMarks { get; set; }

    [Column("passingMarks")]
    public int? PassingMarks { get; set; }

    [Column("criteria")]
    [StringLength(255)]
    [Unicode(false)]
    public string? Criteria { get; set; }

    [Column("weightage")]
    public int? Weightage { get; set; }

    [Column("description")]
    [StringLength(255)]
    [Unicode(false)]
    public string? Description { get; set; }

    [Column("title")]
    [StringLength(100)]
    [Unicode(false)]
    public string? Title { get; set; }

    [ForeignKey("ModuleId, CourseId")]
    [InverseProperty("Assessments")]
    public virtual Module? Module { get; set; }

    [InverseProperty("Assessment")]
    public virtual ICollection<TakenAssessment> TakenAssessments { get; set; } = new List<TakenAssessment>();
}
