using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("InstructorId", "PathId")]
[Table("pathreview")]
public partial class Pathreview
{
    [Key]
    [Column("Instructor_ID")]
    public int InstructorId { get; set; }

    [Key]
    [Column("Path_ID")]
    public int PathId { get; set; }

    [Column("feedback")]
    [StringLength(255)]
    [Unicode(false)]
    public string? Feedback { get; set; }

    [ForeignKey("InstructorId")]
    [InverseProperty("Pathreviews")]
    public virtual Instructor Instructor { get; set; } = null!;

    [ForeignKey("PathId")]
    [InverseProperty("Pathreviews")]
    public virtual LearningPath Path { get; set; } = null!;
}
