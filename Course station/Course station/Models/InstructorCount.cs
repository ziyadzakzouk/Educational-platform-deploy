using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Keyless]
public partial class InstructorCount
{
    [Column("Course_ID")]
    public int CourseId { get; set; }

    [Column("title")]
    [StringLength(100)]
    [Unicode(false)]
    public string? Title { get; set; }

    [Column("InstructorCount")]
    public int? InstructorCount1 { get; set; }
}
