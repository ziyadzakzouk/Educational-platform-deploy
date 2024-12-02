using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("CourseId", "Prerequisite")]
public partial class CoursePrerequisite
{
    [Key]
    [Column("Course_ID")]
    public int CourseId { get; set; }

    [Key]
    [Column("prerequisite")]
    [StringLength(250)]
    [Unicode(false)]
    public string Prerequisite { get; set; } = null!;

    [ForeignKey("CourseId")]
    [InverseProperty("CoursePrerequisites")]
    public virtual Course Course { get; set; } = null!;
}
