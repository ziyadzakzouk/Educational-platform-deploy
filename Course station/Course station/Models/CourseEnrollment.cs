using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Course_Enrollment")]
public partial class CourseEnrollment
{
    [Key]
    [Column("Enrollment_ID")]
    public int EnrollmentId { get; set; }

    [Column("Learner_ID")]
    public int? LearnerId { get; set; }

    [Column("Course_ID")]
    public int? CourseId { get; set; }

    [Column("enrollment_date")]
    public DateOnly? EnrollmentDate { get; set; }

    [Column("completion_date")]
    public DateOnly? CompletionDate { get; set; }

    [Column("status")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Status { get; set; }

    [ForeignKey("CourseId")]
    [InverseProperty("CourseEnrollments")]
    public virtual Course? Course { get; set; }

    [ForeignKey("LearnerId")]
    [InverseProperty("CourseEnrollments")]
    public virtual Learner? Learner { get; set; }
}
