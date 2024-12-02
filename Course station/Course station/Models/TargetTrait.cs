using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("ModuleId", "CourseId", "Trait")]
public partial class TargetTrait
{
    [Key]
    [Column("Module_ID")]
    public int ModuleId { get; set; }

    [Key]
    [Column("Course_ID")]
    public int CourseId { get; set; }

    [Key]
    [Column("trait")]
    [StringLength(50)]
    [Unicode(false)]
    public string Trait { get; set; } = null!;

    [ForeignKey("ModuleId, CourseId")]
    [InverseProperty("TargetTraits")]
    public virtual Module Module { get; set; } = null!;
}
