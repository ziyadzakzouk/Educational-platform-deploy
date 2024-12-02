using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("ModuleId", "CourseId", "ContetntType")]
[Table("ModuleContent")]
public partial class ModuleContent
{
    [Key]
    [Column("Module_ID")]
    public int ModuleId { get; set; }

    [Key]
    [Column("Course_ID")]
    public int CourseId { get; set; }

    [Key]
    [Column("contetntType")]
    [StringLength(50)]
    [Unicode(false)]
    public string ContetntType { get; set; } = null!;

    [ForeignKey("ModuleId, CourseId")]
    [InverseProperty("ModuleContents")]
    public virtual Module Module { get; set; } = null!;
}
