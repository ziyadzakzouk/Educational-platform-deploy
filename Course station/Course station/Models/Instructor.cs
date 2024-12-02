using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Instructor")]
public partial class Instructor
{
    [Key]
    [Column("Instructor_ID")]
    public int InstructorId { get; set; }

    [Column("Instructor_name")]
    [StringLength(20)]
    [Unicode(false)]
    public string? InstructorName { get; set; }

    [Column("latest_qualification")]
    [StringLength(20)]
    [Unicode(false)]
    public string? LatestQualification { get; set; }

    [Column("expertise_area")]
    [StringLength(50)]
    [Unicode(false)]
    public string? ExpertiseArea { get; set; }

    [Column("email")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Email { get; set; }

    [InverseProperty("Instructor")]
    public virtual ICollection<EmotionalfeedbackReview> EmotionalfeedbackReviews { get; set; } = new List<EmotionalfeedbackReview>();

    [InverseProperty("Instructor")]
    public virtual ICollection<Pathreview> Pathreviews { get; set; } = new List<Pathreview>();

    [ForeignKey("InstructorId")]
    [InverseProperty("Instructors")]
    public virtual ICollection<Course> Courses { get; set; } = new List<Course>();
}
