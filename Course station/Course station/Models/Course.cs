using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Course")]
public partial class Course
{
    [Key]
    [Column("Course_ID")]
    public int CourseId { get; set; }

    [Column("title")]
    [StringLength(100)]
    [Unicode(false)]
    public string? Title { get; set; }

    [Column("description")]
    [StringLength(255)]
    [Unicode(false)]
    public string? Description { get; set; }

    [Column("diff_level")]
    [StringLength(8)]
    [Unicode(false)]
    public string? DiffLevel { get; set; }

    [Column("credit_point")]
    public int? CreditPoint { get; set; }

    [Column("learning_objective")]
    [StringLength(255)]
    [Unicode(false)]
    public string? LearningObjective { get; set; }

    [InverseProperty("Course")]
    public virtual ICollection<CourseEnrollment> CourseEnrollments { get; set; } = new List<CourseEnrollment>();

    [InverseProperty("Course")]
    public virtual ICollection<CoursePrerequisite> CoursePrerequisites { get; set; } = new List<CoursePrerequisite>();

    [InverseProperty("Course")]
    public virtual ICollection<Module> Modules { get; set; } = new List<Module>();

    [InverseProperty("Course")]
    public virtual ICollection<Ranking> Rankings { get; set; } = new List<Ranking>();

    [ForeignKey("CourseId")]
    [InverseProperty("Courses")]
    public virtual ICollection<Instructor> Instructors { get; set; } = new List<Instructor>();
}
